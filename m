Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVCAWHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVCAWHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVCAWHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:07:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:34498 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262105AbVCAWGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:06:41 -0500
Subject: Re: [PATCH] ppc32: uninorth-agp suspend support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20050301212347.GB2129@elf.ucw.cz>
References: <1109651140.7669.17.camel@gaston>
	 <20050301212347.GB2129@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 09:04:12 +1100
Message-Id: <1109714652.5611.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 22:23 +0100, Pavel Machek wrote:
> Hi!
> 
> > (This is for -mm, to be merged along with the aty128fb and radeonfb
> > related patches).
> > 
> > This patch adds suspend/resume support to the Apple UniNorth AGP bridge
> > to make sure AGP is properly disabled when the machine goes to sleep.
> > Without this, the r300 based laptops will fail to wakeup from sleep when
> > using the new experimental r300 DRI driver. It should also improve
> > reliablility in general with other chips.
> 
> > --- linux-work.orig/drivers/char/agp/uninorth-agp.c	2005-03-01 13:53:32.000000000 +1100
> > +++ linux-work/drivers/char/agp/uninorth-agp.c	2005-03-01 14:36:54.000000000 +1100
> > @@ -155,6 +161,56 @@
> >  	uninorth_tlbflush(NULL);
> >  }
> >  
> > +#ifdef CONFIG_PM
> > +static int agp_uninorth_suspend(struct pci_dev *pdev, u32 state)
> 
> pm_message_t state, please.

Oops :) 

>From paulus@samba.org Mon Feb 28 18:49:35 2005
Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45]) by gate.crashing.org
	(8.12.8/8.12.8) with ESMTP id j210nZgJ030407 for
	<benh@kernel.crashing.org>; Mon, 28 Feb 2005 18:49:35 -0600
Received: by ozlabs.org (Postfix, from userid 1003) id 0B4B767A75; Tue,  1
	Mar 2005 11:50:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16931.48662.891571.16324@cargo.ozlabs.ibm.com>
Date: Tue, 1 Mar 2005 11:57:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org
Subject: agp sleep patch
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Spam-Checker-Version: SpamAssassin 3.0.1 (2004-10-22) on gate.crashing.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.0.1
Status:   
X-Evolution-Source: pop://benh@localhost:10110
Content-Transfer-Encoding: 8bit

Index: linux-work/drivers/char/agp/uninorth-agp.c
===================================================================
--- linux-work.orig/drivers/char/agp/uninorth-agp.c	2005-03-01 13:53:32.000000000 +1100
+++ linux-work/drivers/char/agp/uninorth-agp.c	2005-03-02 09:01:00.000000000 +1100
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/agp_backend.h>
+#include <linux/delay.h>
 #include <asm/uninorth.h>
 #include <asm/pci-bridge.h>
 #include "agp.h"
@@ -51,6 +52,11 @@
 
 static void uninorth_cleanup(void)
 {
+	u32 tmp;
+
+	pci_read_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL, &tmp);
+	if (!(tmp & UNI_N_CFG_GART_ENABLE))
+		return;
 	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
 			UNI_N_CFG_GART_ENABLE | UNI_N_CFG_GART_INVAL);
 	pci_write_config_dword(agp_bridge->dev, UNI_N_CFG_GART_CTRL,
@@ -155,6 +161,59 @@
 	uninorth_tlbflush(NULL);
 }
 
+#ifdef CONFIG_PM
+static int agp_uninorth_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	u32 cmd;
+	u8 agp;
+	struct pci_dev *device = NULL;
+
+	if (state != PMSG_SUSPEND)
+		return 0;
+
+	/* turn off AGP on the video chip, if it was enabled */
+	for_each_pci_dev(device) {
+		/* Don't touch the bridge yet, device first */
+		if (device == pdev)
+			continue;
+		/* Only deal with devices on the same bus here, no Mac has a P2P
+		 * bridge on the AGP port, and mucking around the entire PCI tree
+		 * is source of problems on some machines because of a bug in
+		 * some versions of pci_find_capability() when hitting a dead device
+		 */
+		if (device->bus != pdev->bus)
+			continue;
+		agp = pci_find_capability(device, PCI_CAP_ID_AGP);
+		if (!agp)
+			continue;
+		pci_read_config_dword(device, agp + PCI_AGP_COMMAND, &cmd);
+		if (!(cmd & PCI_AGP_COMMAND_AGP))
+			continue;
+		printk("uninorth-agp: disabling AGP on device %s\n", pci_name(device));
+		cmd &= ~PCI_AGP_COMMAND_AGP;
+		pci_write_config_dword(device, agp + PCI_AGP_COMMAND, cmd);
+	}
+	
+	/* turn off AGP on the bridge */
+	agp = pci_find_capability(pdev, PCI_CAP_ID_AGP);
+	pci_read_config_dword(pdev, agp + PCI_AGP_COMMAND, &cmd);
+	if (cmd & PCI_AGP_COMMAND_AGP) {
+		printk("uninorth-agp: disabling AGP on bridge %s\n", pci_name(pdev));
+		cmd &= ~PCI_AGP_COMMAND_AGP;
+		pci_write_config_dword(pdev, agp + PCI_AGP_COMMAND, cmd);
+	}
+	/* turn off the GART */
+	uninorth_cleanup();
+
+	return 0;
+}
+
+static int agp_uninorth_resume(struct pci_dev *pdev)
+{
+	return 0;
+}
+#endif
+
 static int uninorth_create_gatt_table(void)
 {
 	char *table;
@@ -369,6 +428,10 @@
 	.id_table	= agp_uninorth_pci_table,
 	.probe		= agp_uninorth_probe,
 	.remove		= agp_uninorth_remove,
+#ifdef CONFIG_PM
+	.suspend	= agp_uninorth_suspend,
+	.resume		= agp_uninorth_resume,
+#endif
 };
 
 static int __init agp_uninorth_init(void)


