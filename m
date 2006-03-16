Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbWCPSTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbWCPSTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWCPSTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:19:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44193 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932701AbWCPSTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:19:45 -0500
Date: Thu, 16 Mar 2006 12:19:34 -0600
From: Mark Maule <maule@sgi.com>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       shaohua.li@intel.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
Message-ID: <20060316181934.GM13666@sgi.com>
References: <44172F0E.6070708@ce.jp.nec.com> <20060314134535.72eb7243.akpm@osdl.org> <44176502.9050109@ce.jp.nec.com> <20060315235544.GA6504@suse.de> <44198210.6090109@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44198210.6090109@ce.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 10:19:44AM -0500, Jun'ichi Nomura wrote:
> Greg KH wrote:
> >No, we don't need a linux/msi.h, these are core pci things that no one
> >else should care about.  The other arches handle this just fine, let's
> >not mess everything up just because ia64 can't get it right :)
> 
> Hmm, it sounds asm/msi.h shouldn't be included from common headers. :<
> I think the attached patch might be better. How about this?
> 
> Default msi_arch_init() looks sufficient for most ia64 platforms
> except for SGI SN2, which seems to need its special version.
> gregkh-pci-msi-vector-targeting-abstractions.patch used machvec
> to switch the functions between platforms.
> For that, it included asm/msi.h from asm/machvec.h and
> caused the warnings flood.
> The attached patch separates machvec function and the original
> inline function. So that we don't need to include asm/msi.h from
> common headers.
> 
> 
> There is another problem that CONFIG_IA64_GENERIC still doesn't
> build due to error in SGI SN specific code.
> It needs additional fix.
> 
> Thanks,
> -- 
> Jun'ichi Nomura, NEC Solutions (America), Inc.

Ok, looking back at some of my original patches, it seems like the
declaration of msi_ops got moved from pci.h to and some forward declarations
in ia64/msi.h were removed.  This patch corrects the build problems.

The reason for putting struct msi_ops in pci.h is so that msi code that
resides outside of drivers/pci can use the declaration without having to
reach down into drivers/pci.

If there's objectins to having struct msi_ops declared in pci.h, then I guess
we need to come up with another solution.

The following patch should correct the build problems on ia64.  I have not
yet checked other platforms.


Index: linux-2.6.16-rc6/include/asm-ia64/msi.h
===================================================================
--- linux-2.6.16-rc6.orig/include/asm-ia64/msi.h	2006-03-16 10:20:09.000000000 -0600
+++ linux-2.6.16-rc6/include/asm-ia64/msi.h	2006-03-16 12:18:23.615928436 -0600
@@ -16,6 +16,10 @@
 
 extern struct msi_ops msi_apic_ops;
 
+/* Ugly defs to avoid having to include pci.h in machvec.h */
+struct msi_ops;
+extern int msi_register(struct msi_ops *);
+
 /* default ia64 msi init routine */
 static inline int ia64_msi_init(void)
 {
Index: linux-2.6.16-rc6/drivers/pci/msi.h
===================================================================
--- linux-2.6.16-rc6.orig/drivers/pci/msi.h	2006-03-16 10:20:07.000000000 -0600
+++ linux-2.6.16-rc6/drivers/pci/msi.h	2006-03-16 12:02:33.276296521 -0600
@@ -83,61 +83,4 @@
 	struct pci_dev *dev;
 };
 
-/*
- * MSI operation vector.  Used by the msi core code (drivers/pci/msi.c)
- * to abstract platform-specific tasks relating to MSI address generation
- * and resource management.
- */
-struct msi_ops {
-	/**
-	 * setup - generate an MSI bus address and data for a given vector
-	 * @pdev: PCI device context (in)
-	 * @vector: vector allocated by the msi core (in)
-	 * @addr_hi: upper 32 bits of PCI bus MSI address (out)
-	 * @addr_lo: lower 32 bits of PCI bus MSI address (out)
-	 * @data: MSI data payload (out)
-	 *
-	 * Description: The setup op is used to generate a PCI bus addres and
-	 * data which the msi core will program into the card MSI capability
-	 * registers.  The setup routine is responsible for picking an initial
-	 * cpu to target the MSI at.  The setup routine is responsible for
-	 * examining pdev to determine the MSI capabilities of the card and
-	 * generating a suitable address/data.  The setup routine is
-	 * responsible for allocating and tracking any system resources it
-	 * needs to route the MSI to the cpu it picks, and for associating
-	 * those resources with the passed in vector.
-	 *
-	 * Returns 0 if the MSI address/data was successfully setup.
-	 */
-	int	(*setup)    (struct pci_dev *pdev, unsigned int vector,
-			     u32 *addr_hi, u32 *addr_lo, u32 *data);
-
-	/**
-	 * teardown - release resources allocated by setup
-	 * @vector: vector context for resources (in)
-	 *
-	 * Description:  The teardown op is used to release any resources
-	 * that were allocated in the setup routine associated with the passed
-	 * in vector.
-	 */
-	void	(*teardown) (unsigned int vector);
-
-	/**
-	 * target - retarget an MSI at a different cpu
-	 * @vector: vector context for resources (in)
-	 * @cpu:  new cpu to direct vector at (in)
-	 * @addr_hi: new value of PCI bus upper 32 bits (in/out)
-	 * @addr_lo: new value of PCI bus lower 32 bits (in/out)
-	 *
-	 * Description:  The target op is used to redirect an MSI vector
-	 * at a different cpu.  addr_hi/addr_lo coming in are the existing
-	 * values that the MSI core has programmed into the card.  The
-	 * target code is responsible for freeing any resources (if any)
-	 * associated with the old address, and generating a new PCI bus
-	 * addr_hi/addr_lo that will redirect the vector at the indicated cpu.
-	 */
-	void	(*target)   (unsigned int vector, unsigned int cpu,
-			     u32 *addr_hi, u32 *addr_lo);
-};
-
 #endif /* MSI_H */
Index: linux-2.6.16-rc6/include/linux/pci.h
===================================================================
--- linux-2.6.16-rc6.orig/include/linux/pci.h	2006-03-16 10:20:10.000000000 -0600
+++ linux-2.6.16-rc6/include/linux/pci.h	2006-03-16 12:03:20.646663409 -0600
@@ -583,6 +583,63 @@
 	u16	entry;	/* driver uses to specify entry, OS writes */
 };
 
+/*
+ * MSI operation vector.  Used by the msi core code (drivers/pci/msi.c)
+ * to abstract platform-specific tasks relating to MSI address generation
+ * and resource management.
+ */
+struct msi_ops {
+	/**
+	 * setup - generate an MSI bus address and data for a given vector
+	 * @pdev: PCI device context (in)
+	 * @vector: vector allocated by the msi core (in)
+	 * @addr_hi: upper 32 bits of PCI bus MSI address (out)
+	 * @addr_lo: lower 32 bits of PCI bus MSI address (out)
+	 * @data: MSI data payload (out)
+	 *
+	 * Description: The setup op is used to generate a PCI bus addres and
+	 * data which the msi core will program into the card MSI capability
+	 * registers.  The setup routine is responsible for picking an initial
+	 * cpu to target the MSI at.  The setup routine is responsible for
+	 * examining pdev to determine the MSI capabilities of the card and
+	 * generating a suitable address/data.  The setup routine is
+	 * responsible for allocating and tracking any system resources it
+	 * needs to route the MSI to the cpu it picks, and for associating
+	 * those resources with the passed in vector.
+	 *
+	 * Returns 0 if the MSI address/data was successfully setup.
+	 */
+	int	(*setup)    (struct pci_dev *pdev, unsigned int vector,
+			     u32 *addr_hi, u32 *addr_lo, u32 *data);
+
+	/**
+	 * teardown - release resources allocated by setup
+	 * @vector: vector context for resources (in)
+	 *
+	 * Description:  The teardown op is used to release any resources
+	 * that were allocated in the setup routine associated with the passed
+	 * in vector.
+	 */
+	void	(*teardown) (unsigned int vector);
+
+	/**
+	 * target - retarget an MSI at a different cpu
+	 * @vector: vector context for resources (in)
+	 * @cpu:  new cpu to direct vector at (in)
+	 * @addr_hi: new value of PCI bus upper 32 bits (in/out)
+	 * @addr_lo: new value of PCI bus lower 32 bits (in/out)
+	 *
+	 * Description:  The target op is used to redirect an MSI vector
+	 * at a different cpu.  addr_hi/addr_lo coming in are the existing
+	 * values that the MSI core has programmed into the card.  The
+	 * target code is responsible for freeing any resources (if any)
+	 * associated with the old address, and generating a new PCI bus
+	 * addr_hi/addr_lo that will redirect the vector at the indicated cpu.
+	 */
+	void	(*target)   (unsigned int vector, unsigned int cpu,
+			     u32 *addr_hi, u32 *addr_lo);
+};
+
 #ifndef CONFIG_PCI_MSI
 static inline void pci_scan_msi_device(struct pci_dev *dev) {}
 static inline int pci_enable_msi(struct pci_dev *dev) {return -1;}
