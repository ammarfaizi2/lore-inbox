Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131851AbRBKC5c>; Sat, 10 Feb 2001 21:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131850AbRBKC5W>; Sat, 10 Feb 2001 21:57:22 -0500
Received: from carbon.btinternet.com ([194.73.73.92]:5824 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S131851AbRBKC5H>; Sat, 10 Feb 2001 21:57:07 -0500
Date: Sun, 11 Feb 2001 02:56:24 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] More network pci_enable cleanups.
Message-ID: <Pine.LNX.4.31.0102110253410.4383-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Alan/Jeff,
 Here are the remaining network driver fixups for pci_enable_device()
(Except starfire, which Jeff has a newer driver for which already has
this fix).

regards.

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/defxx.c linux-dj/drivers/net/defxx.c
--- linux/drivers/net/defxx.c	Sat Feb 10 02:49:43 2001
+++ linux-dj/drivers/net/defxx.c	Sat Feb 10 03:05:03 2001
@@ -196,6 +196,7 @@
  *		Jul 2000	tjeerd		Much cleanup and some bug fixes
  *		Sep 2000	tjeerd		Fix leak on unload, cosmetic code cleanup
  *		Feb 2001			Skb allocation fixes
+ *		Feb 2001	davej		PCI enable cleanups.
  */

 /* Include files */
@@ -414,6 +415,7 @@
 	struct net_device *dev;
 	DFX_board_t	  *bp;			/* board pointer */
 	static int version_disp;
+	int err;

 	if (!version_disp)					/* display version info if adapter is found */
 	{
@@ -429,8 +431,8 @@

 	/* Enable PCI device. */
 	if (pdev != NULL) {
-		if (pci_enable_device (pdev))
-			goto err_out;
+		err = pci_enable_device (pdev);
+		if (err) return err;
 		ioaddr = pci_resource_start (pdev, 1);
 	}

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/dgrs.c linux-dj/drivers/net/dgrs.c
--- linux/drivers/net/dgrs.c	Sat Feb 10 02:49:43 2001
+++ linux-dj/drivers/net/dgrs.c	Sat Feb 10 03:05:09 2001
@@ -78,6 +78,9 @@
  *	one of the devices can't be allocated. Fix SET_MODULE_OWNER
  *	on the loop to use devN instead of repeated calls to dev.
  *
+ *	davej <davej@suse.de> - 9/2/2001
+ *	- Enable PCI device before reading ioaddr/irq
+ *
  */

 static char *version = "$Id: dgrs.c,v 1.13 2000/06/06 04:07:00 rick Exp $";
@@ -1352,7 +1355,7 @@

 static int __init  dgrs_scan(void)
 {
-	int	cards_found = 0;
+	int	cards_found;
 	uint	io;
 	uint	mem;
 	uint	irq;
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/eepro.c linux-dj/drivers/net/eepro.c
--- linux/drivers/net/eepro.c	Sat Feb 10 02:49:43 2001
+++ linux-dj/drivers/net/eepro.c	Sat Feb 10 03:05:05 2001
@@ -1098,7 +1098,7 @@
 	printk (KERN_ERR "%s: transmit timed out, %s?\n", dev->name,
 		"network cable problem");
 	/* This is not a duplicate. One message for the console,
-	   one for the the log file  */
+	   one for the log file  */
 	printk (KERN_DEBUG "%s: transmit timed out, %s?\n", dev->name,
 		"network cable problem");
 	eepro_complete_selreset(ioaddr);
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/eepro100.c linux-dj/drivers/net/eepro100.c
--- linux/drivers/net/eepro100.c	Sat Feb 10 02:49:43 2001
+++ linux-dj/drivers/net/eepro100.c	Sat Feb 10 03:05:06 2001
@@ -25,6 +25,8 @@
 		Disabled FC and ER, to avoid lockups when when we get FCP interrupts.
 	2000 Jul 17 Goutham Rao <goutham.rao@intel.com>
 		PCI DMA API fixes, adding pci_dma_sync_single calls where neccesary
+	2000 Feb 9 Dave Jones <davej@suse.de>
+		PCI enable cleanups
 */

 static const char *version =
@@ -550,10 +552,10 @@
 {
 	unsigned long ioaddr;
 	int irq, i;
-	int acpi_idle_state = 0, pm;
-	static int cards_found /* = 0 */;
+	int acpi_idle_state, pm;
+	static int cards_found;
+	static int did_version;		/* Already printed version info. */

-	static int did_version /* = 0 */;		/* Already printed version info. */
 	if (speedo_debug > 0  &&  did_version++ == 0)
 		printk(version);

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/macsonic.c linux-dj/drivers/net/macsonic.c
--- linux/drivers/net/macsonic.c	Sat Feb 10 02:49:44 2001
+++ linux-dj/drivers/net/macsonic.c	Sat Feb 10 03:05:07 2001
@@ -135,7 +135,7 @@
 		unsigned long desc_base, desc_top;
 		if ((lp->sonic_desc =
 		     kmalloc(SIZEOF_SONIC_DESC
-			     * SONIC_BUS_SCALE(lp->dma_bitmode), GFP_DMA)) == NULL) {
+			     * SONIC_BUS_SCALE(lp->dma_bitmode), GFP_KERNEL | GFP_DMA)) == NULL) {
 			printk(KERN_ERR "%s: couldn't allocate descriptor buffers\n", dev->name);
 		}
 		desc_base = (unsigned long) lp->sonic_desc;
@@ -165,7 +165,7 @@

 	/* FIXME, maybe we should use skbs */
 	if ((lp->rba = (char *)
-	     kmalloc(SONIC_NUM_RRS * SONIC_RBSIZE, GFP_DMA)) == NULL) {
+	     kmalloc(SONIC_NUM_RRS * SONIC_RBSIZE, GFP_KERNEL | GFP_DMA)) == NULL) {
 		printk(KERN_ERR "%s: couldn't allocate receive buffers\n", dev->name);
 		kfree(lp->sonic_desc);
 		lp->sonic_desc = NULL;
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/natsemi.c linux-dj/drivers/net/natsemi.c
--- linux/drivers/net/natsemi.c	Sat Feb 10 02:49:44 2001
+++ linux-dj/drivers/net/natsemi.c	Sat Feb 10 03:05:04 2001
@@ -31,6 +31,7 @@
 		- Call netif_start_queue from dev->tx_timeout
 		- wmb() in start_tx() to flush data
 		- Update Tx locking
+		- Clean up PCI enable (davej)

 */

@@ -378,8 +379,8 @@
 		printk(KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
 			version1, version2, version3);

-	if (pci_enable_device(pdev))
-		return -EIO;
+	i = pci_enable_device(pdev);
+	if (i) return i;

 	find_cnt++;
 	option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/ncr885e.c linux-dj/drivers/net/ncr885e.c
--- linux/drivers/net/ncr885e.c	Sat Feb 10 02:49:44 2001
+++ linux-dj/drivers/net/ncr885e.c	Sat Feb 10 03:05:05 2001
@@ -1163,7 +1163,7 @@
 }

 /*  Since the NCR 53C885 is a multi-function chip, I'm not worrying about
- *  trying to get the the device(s) in slot order.  For our (Synergy's)
+ *  trying to get the device(s) in slot order.  For our (Synergy's)
  *  purpose, there's just a single 53C885 on the board and we don't
  *  worry about the rest.
  */
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/pcnet32.c linux-dj/drivers/net/pcnet32.c
--- linux/drivers/net/pcnet32.c	Sat Feb 10 02:49:45 2001
+++ linux-dj/drivers/net/pcnet32.c	Sat Feb 10 03:05:09 2001
@@ -478,10 +478,17 @@
 {
     static int card_idx;
     long ioaddr;
-    int err = 0;
+    int err;

     printk(KERN_INFO "pcnet32_probe_pci: found device %#08x.%#08x\n", ent->vendor, ent->device);

+    if ((err = pci_enable_device(pdev)) < 0) {
+	printk(KERN_ERR "pcnet32.c: failed to enable device -- err=%d\n", err);
+	return err;
+    }
+
+    pci_set_master(pdev);
+
     ioaddr = pci_resource_start (pdev, 0);
     printk(KERN_INFO "    ioaddr=%#08lx  resource_flags=%#08lx\n", ioaddr, pci_resource_flags (pdev, 0));
     if (!ioaddr) {
@@ -494,13 +501,7 @@
 	return -ENODEV;
     }

-    if ((err = pci_enable_device(pdev)) < 0) {
-	printk(KERN_ERR "pcnet32.c: failed to enable device -- err=%d\n", err);
-	return err;
-    }
-
-    pci_set_master(pdev);
-
+
     return pcnet32_probe1(ioaddr, pdev->irq, 1, card_idx, pdev);
 }

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/sis900.c linux-dj/drivers/net/sis900.c
--- linux/drivers/net/sis900.c	Sat Feb 10 02:49:45 2001
+++ linux-dj/drivers/net/sis900.c	Sat Feb 10 03:05:06 2001
@@ -18,6 +18,7 @@
    preliminary Rev. 1.0 Jan. 18, 1998
    http://www.sis.com.tw/support/databook.htm

+   Rev 1.07.09 Feb.  9 2001 Dave Jones <davej@suse.de> PCI enable cleanup
    Rev 1.07.08 Jan.  8 2001 Lei-Chun Chang added RTL8201 PHY support
    Rev 1.07.07 Nov. 29 2000 Lei-Chun Chang added kernel-doc extractable documentation and 630 workaround fix
    Rev 1.07.06 Nov.  7 2000 Jeff Garzik <jgarzik@mandrakesoft.com> some bug fix and cleaning
@@ -60,7 +61,7 @@
 #include "sis900.h"

 static const char *version =
-"sis900.c: v1.07.08  1/8/2001\n";
+"sis900.c: v1.07.09  2/9/2001\n";

 static int max_interrupt_work = 20;
 static int multicast_filter_limit = 128;
@@ -255,7 +256,7 @@
 	long ioaddr;
 	struct net_device *net_dev;
 	int irq;
-	int i, ret = 0;
+	int i, ret;
 	u8 revision;
 	char *card_name = card_names[pci_id->driver_data];

@@ -266,8 +267,9 @@
 	}

 	/* setup various bits in PCI command register */
-	if (pci_enable_device (pci_dev))
-		return -ENODEV;
+	ret = pci_enable_device (pci_dev);
+	if (ret) return ret;
+
 	pci_set_master(pci_dev);

 	irq = pci_dev->irq;
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/winbond-840.c linux-dj/drivers/net/winbond-840.c
--- linux/drivers/net/winbond-840.c	Sat Feb 10 02:49:47 2001
+++ linux-dj/drivers/net/winbond-840.c	Sat Feb 10 03:05:11 2001
@@ -381,8 +381,9 @@
 	int i, option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
 	long ioaddr;

-	if (pci_enable_device(pdev))
-		return -EIO;
+	i = pci_enable_device(pdev);
+	if (i) return i;
+
 	pci_set_master(pdev);

 	irq = pdev->irq;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
