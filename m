Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130451AbRCCMkl>; Sat, 3 Mar 2001 07:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130453AbRCCMkb>; Sat, 3 Mar 2001 07:40:31 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:41113 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130451AbRCCMkV>; Sat, 3 Mar 2001 07:40:21 -0500
Message-ID: <3AA0E61B.56BABDF7@uow.edu.au>
Date: Sat, 03 Mar 2001 23:39:55 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] cs89x0.c
In-Reply-To: <E14YteS-00020L-00@the-village.bc.nu> <Pine.LNX.4.21.0103022137310.1440-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> The CS89x0 driver wants a 16KB or 64KB dma_buff (if use_dma and
> ANY_ISA_DMA), thinks it's asking __get_dma_pages() for 4 or 16
> pages, but actually it's demanding order 4 or order 16 buffer.
> Patch below against 2.4.2-ac9 or 2.4.2, offset against 2.4.[01].

I guess nobody's tried a 64k DMA buffer lately.
The patch has been tested and work fine, thanks.

I found and fixed two other bugs.  They preventing the
driver from being loaded more than once.

The driver probe routine appears to go to great pains to avoid
writing to ISA space until it is sure that there is actually a
NIC at the probe address.  To support this, the last thing it
does when the module is being unloaded is to write zero into
its address pointer register.  This way, when the driver is
reloaded the hardware is set up so the probe can look at the ID
register without having to write to anything first.

But unregister_netdevice() calls into the rtnetlink code which
does a get_stats() on the NIC, which undoes the above operation
by leaving the address register pointing at something else.
So this patch does the address register zeroing _after_ the
call to unregister_netdev().

I suspect this is new behaviour in the rtnetlink code.  Interesting
breakage.



Now, if the user adds 1 to the device I/O address, the driver
does the ISA write prior to reading the identification register.
This is more likely to find the NIC, but can presumably break
things if the probe address isn't pointing at a cs89x0 card.

Good in theory, but that was broken too - the wrong address
gets passed to release_region() in two places.  Also fixed.


Also added some media selection debug stuff to
help identify a couple of interface selection problems
which have been reported lately.


Also uninlined some functions which could be quite large
on non-x86 archs.


Patch is against 2.4.3-pre1.


--- linux-2.4.3-pre1/drivers/net/cs89x0.c	Sun Feb 25 17:37:04 2001
+++ lk/drivers/net/cs89x0.c	Sat Mar  3 23:26:35 2001
@@ -74,13 +74,14 @@
                     : Use SET_MODULE_OWNER()
                     : Tidied up strange request_irq() abuse in net_open().
 
-*/
-
-static char version[] =
-"cs89x0.c: v2.4.0-test11-pre4 Russell Nelson <nelson@crynwr.com>, Andrew Morton <andrewm@uow.edu.au>\n";
-
-/* ======================= end of configuration ======================= */
+  Andrew Morton     : Kernel 2.4.3-pre1
+                    : Request correct number of pages for DMA (Hugh Dickens)
+                    : Select PP_ChipID _after_ unregister_netdev in cleanup_module()
+                    :  because unregister_netdev() calls get_stats.
+                    : Make `version[]' __initdata
+                    : Uninlined the read/write reg/word functions.
 
+*/
 
 /* Always include 'config.h' first in case the user wants to turn on
    or override something. */
@@ -121,6 +122,7 @@
 #include <linux/in.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/init.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
@@ -137,6 +139,9 @@
 
 #include "cs89x0.h"
 
+static char version[] __initdata =
+"cs89x0.c: v2.4.3-pre1 Russell Nelson <nelson@crynwr.com>, Andrew Morton <andrewm@uow.edu.au>\n";
+
 /* First, a few definitions that the brave might change.
    A zero-terminated list of I/O addresses to be probed. Some special flags..
       Addr & 1 = Read back the address port, look for signature and reset
@@ -260,7 +265,7 @@
 	SET_MODULE_OWNER(dev);
 
 	if (net_debug)
-		printk("cs89x0:cs89x0_probe()\n");
+		printk("cs89x0:cs89x0_probe(0x%x)\n", base_addr);
 
 	if (base_addr > 0x1ff)		/* Check a single specified location. */
 		return cs89x0_probe1(dev, base_addr);
@@ -275,27 +280,27 @@
 	return -ENODEV;
 }
 
-extern int inline
+static int
 readreg(struct net_device *dev, int portno)
 {
 	outw(portno, dev->base_addr + ADD_PORT);
 	return inw(dev->base_addr + DATA_PORT);
 }
 
-extern void inline
+static void
 writereg(struct net_device *dev, int portno, int value)
 {
 	outw(portno, dev->base_addr + ADD_PORT);
 	outw(value, dev->base_addr + DATA_PORT);
 }
 
-extern int inline
+static int
 readword(struct net_device *dev, int portno)
 {
 	return inw(dev->base_addr + portno);
 }
 
-extern void inline
+static void
 writeword(struct net_device *dev, int portno, int value)
 {
 	outw(value, dev->base_addr + portno);
@@ -383,7 +388,9 @@
 	lp = (struct net_local *)dev->priv;
 
 	/* Grab the region so we can find another board if autoIRQ fails. */
-	if (!request_region(ioaddr, NETCARD_IO_EXTENT, dev->name)) {
+	if (!request_region(ioaddr & ~3, NETCARD_IO_EXTENT, dev->name)) {
+		printk(KERN_ERR "%s: request_region(0x%x, 0x%x) failed\n",
+				dev->name, ioaddr, NETCARD_IO_EXTENT);
 		retval = -EBUSY;
 		goto out1;
 	}
@@ -393,16 +400,23 @@
            expect to find the EISA signature word. An IO with a base of 0x3
 	   will skip the test for the ADD_PORT. */
 	if (ioaddr & 1) {
+		if (net_debug > 1)
+			printk(KERN_INFO "%s: odd ioaddr 0x%x\n", dev->name, ioaddr);
 	        if ((ioaddr & 2) != 2)
 	        	if ((inw((ioaddr & ~3)+ ADD_PORT) & ADD_MASK) != ADD_SIG) {
+				printk(KERN_ERR "%s: bad signature 0x%x\n",
+					dev->name, inw((ioaddr & ~3)+ ADD_PORT));
 		        	retval = -ENODEV;
 				goto out2;
 			}
 		ioaddr &= ~3;
 		outw(PP_ChipID, ioaddr + ADD_PORT);
 	}
+printk("PP_addr=0x%x\n", inw(ioaddr + ADD_PORT));
 
         if (inw(ioaddr + DATA_PORT) != CHIP_EISA_ID_SIG) {
+		printk(KERN_ERR "%s: incorrect signature 0x%x\n",
+			dev->name, inw(ioaddr + DATA_PORT));
   		retval = -ENODEV;
   		goto out2;
 	}
@@ -480,6 +494,10 @@
 			lp->adapter_cnf |=  A_CNF_AUI | A_CNF_10B_T | 
 			A_CNF_MEDIA_AUI | A_CNF_MEDIA_10B_T | A_CNF_MEDIA_AUTO;
 		
+		if (net_debug > 1)
+			printk(KERN_INFO "%s: PP_LineCTL=0x%x, adapter_cnf=0x%x\n",
+					dev->name, i, lp->adapter_cnf);
+
 		/* IRQ. Other chips already probe, see below. */
 		if (lp->chip_type == CS8900) 
 			lp->isa_config = readreg(dev, PP_CS8900_ISAINT) & INT_NO_MASK;
@@ -519,6 +537,9 @@
                         dev->dev_addr[i*2] = eeprom_buff[i];
                         dev->dev_addr[i*2+1] = eeprom_buff[i] >> 8;
                 }
+		if (net_debug > 1)
+			printk(KERN_DEBUG "%s: new adapter_cnf: 0%x\n",
+				dev->name, lp->adapter_cnf);
         }
 
         /* allow them to force multiple transceivers.  If they force multiple, autosense */
@@ -533,6 +554,10 @@
 		else if (lp->force & FORCE_BNC)	{lp->adapter_cnf |= A_CNF_MEDIA_10B_2; }
         }
 
+	if (net_debug > 1)
+		printk(KERN_DEBUG "%s: after force 0x%x, adapter_cnf=0x%x\n",
+			dev->name, lp->force, lp->adapter_cnf);
+
         /* FIXME: We don't let you set dc-dc polarity or low RX squelch from the command line: add it here */
 
         /* FIXME: We don't let you set the IMM bit from the command line: add it to lp->auto_neg_cnf here */
@@ -615,7 +640,7 @@
 		printk("cs89x0_probe1() successful\n");
 	return 0;
 out2:
-	release_region(ioaddr, NETCARD_IO_EXTENT);
+	release_region(ioaddr & ~3, NETCARD_IO_EXTENT);
 out1:
 	kfree(dev->priv);
 	dev->priv = 0;
@@ -1075,7 +1100,7 @@
 		if (lp->isa_config & ANY_ISA_DMA) {
 			unsigned long flags;
 			lp->dma_buff = (unsigned char *)__get_dma_pages(GFP_KERNEL,
-							(lp->dmasize * 1024) / PAGE_SIZE);
+							get_order(lp->dmasize * 1024));
 
 			if (!lp->dma_buff) {
 				printk(KERN_ERR "%s: cannot get %dK memory for DMA\n", dev->name, lp->dmasize);
@@ -1456,7 +1481,7 @@
 static void release_dma_buff(struct net_local *lp)
 {
 	if (lp->dma_buff) {
-		free_pages((unsigned long)(lp->dma_buff), (lp->dmasize * 1024) / PAGE_SIZE);
+		free_pages((unsigned long)(lp->dma_buff), get_order(lp->dmasize * 1024));
 		lp->dma_buff = 0;
 	}
 }
@@ -1690,10 +1715,10 @@
 void
 cleanup_module(void)
 {
-	outw(PP_ChipID, dev_cs89x0.base_addr + ADD_PORT);
         if (dev_cs89x0.priv != NULL) {
                 /* Free up the private structure, or leak memory :-)  */
                 unregister_netdev(&dev_cs89x0);
+		outw(PP_ChipID, dev_cs89x0.base_addr + ADD_PORT);
                 kfree(dev_cs89x0.priv);
                 dev_cs89x0.priv = NULL;	/* gets re-allocated by cs89x0_probe1 */
                 /* If we don't do this, we can't re-insmod it later. */
--- linux-2.4.3-pre1/Documentation/networking/cs89x0.txt	Tue Sep 19 08:58:17 2000
+++ lk/Documentation/networking/cs89x0.txt	Sat Mar  3 23:30:15 2001
@@ -242,13 +242,18 @@
 
 b) The "io" parameter must be specified on the command-line.  
 
-c) In case you can not re-load the driver because Linux system
-   returns the "device or resource busy" message, try to re-load it by
-   increment the IO port address by one.  The driver will write
-   commands to the IO base addresses to reset the data port pointer. 
-   You can specify an I/O address with an address value one greater
-   than the configured address.  Example, to scan for an adapter
-   located at IO base 0x300, specify an IO address of 0x301.  
+c) The driver's hardware probe routine is designed to avoid
+   writing to I/O space until it knows that there is a cs89x0
+   card at the written addresses.  This could cause problems
+   with device probing.  To avoid this behaviour, add one
+   to the `io=' module parameter.  This doesn't actually change
+   the I/O address, but it is a flag to tell the driver
+   topartially initialise the hardware before trying to
+   identify the card.  This could be dangerous if you are
+   not sure that there is a cs89x0 card at the provided address.
+
+   For example, to scan for an adapter located at IO base 0x300,
+   specify an IO address of 0x301.  
 
 d) The "duplex=auto" parameter is only supported for the CS8920.
