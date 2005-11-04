Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVKDWOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVKDWOG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVKDWOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:14:06 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:25265 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751038AbVKDWOF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:14:05 -0500
Date: Fri, 4 Nov 2005 16:14:00 -0600
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41/42]: ppc64: Save device BARS much earlier in the boot sequence
Message-ID: <20051104221400.GS19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005519.GA27189@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104005519.GA27189@mail.gnucash.org>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 03, 2005 at 06:55:19PM -0600, Linas Vepstas was heard to remark:
> Save the PCI device bars *before* any PCI probing is done. 

After a tiny bit of extra testing, I found one of those forehead
slapping bugs in this patch.  Here it is again, with the bug fixed.

(So far, all the other tests look good; I've survived 24 hours of 
several thousand artifical pci errors injected onto ethernet and scsi
intermingled with hundreds of pci slot adds/removes.)

------------

241-eeh-save-bars-earlier.patch

Save the PCI device bars *before* any PCI probing is done. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

--
Index: linux-2.6.14-git6/arch/ppc64/kernel/rtas_pci.c
===================================================================
--- linux-2.6.14-git6.orig/arch/ppc64/kernel/rtas_pci.c	2005-11-03 14:46:40.000000000 -0600
+++ linux-2.6.14-git6/arch/ppc64/kernel/rtas_pci.c	2005-11-03 14:50:22.000000000 -0600
@@ -72,7 +72,7 @@
         return 0;
 }
 
-static int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
+int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 {
 	int returnval = -1;
 	unsigned long buid, addr;
Index: linux-2.6.14-git6/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-2.6.14-git6.orig/include/asm-powerpc/ppc-pci.h	2005-11-03 14:50:21.000000000 -0600
+++ linux-2.6.14-git6/include/asm-powerpc/ppc-pci.h	2005-11-03 14:50:22.000000000 -0600
@@ -59,8 +59,6 @@
 void pci_addr_cache_build(void);
 struct pci_dev *pci_get_device_by_addr(unsigned long addr);
 
-void eeh_save_bars(struct pci_dev * pdev, struct pci_dn *pdn);
-
 /**
  * eeh_slot_error_detail -- record and EEH error condition to the log
  * @severity: 1 if temporary, 2 if permanent failure.
@@ -104,6 +102,7 @@
 void rtas_configure_bridge(struct pci_dn *);
 
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
+int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 
 /**
  * mark and clear slots: find "partition endpoint" PE and set or 
Index: linux-2.6.14-git6/include/asm-ppc64/pci-bridge.h
===================================================================
--- linux-2.6.14-git6.orig/include/asm-ppc64/pci-bridge.h	2005-11-03 14:50:15.000000000 -0600
+++ linux-2.6.14-git6/include/asm-ppc64/pci-bridge.h	2005-11-03 14:50:22.000000000 -0600
@@ -58,15 +58,15 @@
 struct iommu_table;
 
 struct pci_dn {
-	int	busno;			/* for pci devices */
-	int	bussubno;		/* for pci devices */
-	int	devfn;			/* for pci devices */
+	int	busno;			/* pci bus number */
+	int	bussubno;		/* pci subordinate bus number */
+	int	devfn;			/* pci device and function number */
+	int	class_code;		/* pci device class */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
 	int	eeh_pe_config_addr; /* new-style partition endpoint address */
 	int 	eeh_check_count;	/* # times driver ignored error */
 	int 	eeh_freeze_count;	/* # times this device froze up. */
-	int	eeh_is_bridge;		/* device is pci-to-pci bridge */
 
 	int	pci_ext_config_space;	/* for pci devices */
 	struct  pci_controller *phb;	/* for pci devices */
Index: linux-2.6.14-git6/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git6.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-03 14:50:21.000000000 -0600
+++ linux-2.6.14-git6/arch/powerpc/platforms/pseries/eeh.c	2005-11-04 16:07:29.596059751 -0600
@@ -106,6 +106,8 @@
 static DEFINE_PER_CPU(unsigned long, ignored_failures);
 static DEFINE_PER_CPU(unsigned long, slot_resets);
 
+#define IS_BRIDGE(class_code) (((class_code)<<16) == PCI_BASE_CLASS_BRIDGE)
+
 /* --------------------------------------------------------------- */
 /* Below lies the EEH event infrastructure */
 
@@ -620,7 +622,7 @@
 	if (!pdn) 
 		return;
 	
-	if ((pdn->eeh_mode & EEH_MODE_SUPPORTED) && (!pdn->eeh_is_bridge))
+	if ((pdn->eeh_mode & EEH_MODE_SUPPORTED) && !IS_BRIDGE(pdn->class_code))
 		__restore_bars (pdn);
 
 	dn = pdn->node->child;
@@ -638,18 +640,15 @@
  * PCI devices are added individuallly; but, for the restore,
  * an entire slot is reset at a time.
  */
-void eeh_save_bars(struct pci_dev * pdev, struct pci_dn *pdn)
+static void eeh_save_bars(struct pci_dn *pdn)
 {
 	int i;
 
-	if (!pdev || !pdn )
+	if (!pdn )
 		return;
 	
 	for (i = 0; i < 16; i++)
-		pci_read_config_dword(pdev, i * 4, &pdn->config_space[i]);
-
-	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-		pdn->eeh_is_bridge = 1;
+		rtas_read_config(pdn, i * 4, 4, &pdn->config_space[i]);
 }
 
 void
@@ -703,6 +702,9 @@
 	pdn->eeh_check_count = 0;
 	pdn->eeh_freeze_count = 0;
 
+	if (class_code)
+		pdn->class_code = *class_code;
+	
 	if (status && strcmp(status, "ok") != 0)
 		return NULL;	/* ignore devices with bad status */
 
@@ -781,6 +783,7 @@
 		       dn->full_name);
 	}
 
+	eeh_save_bars(pdn);
 	return NULL;
 }
 
@@ -915,7 +918,6 @@
 	pdn->pcidev = dev;
 
 	pci_addr_cache_insert_device (dev);
-	eeh_save_bars(dev, pdn);
 }
 EXPORT_SYMBOL_GPL(eeh_add_device_late);
 
Index: linux-2.6.14-git6/arch/powerpc/platforms/pseries/eeh_cache.c
===================================================================
--- linux-2.6.14-git6.orig/arch/powerpc/platforms/pseries/eeh_cache.c	2005-11-03 14:50:19.000000000 -0600
+++ linux-2.6.14-git6/arch/powerpc/platforms/pseries/eeh_cache.c	2005-11-04 10:22:51.000000000 -0600
@@ -304,10 +304,7 @@
 
 		pci_addr_cache_insert_device(dev);
 
-		/* Save the BAR's; firmware doesn't restore these after EEH reset */
 		dn = pci_device_to_OF_node(dev);
-		eeh_save_bars(dev, PCI_DN(dn));
-
 		pci_dev_get (dev);  /* matching put is in eeh_remove_device() */
 		PCI_DN(dn)->pcidev = dev;
 	}


