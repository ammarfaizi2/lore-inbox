Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276670AbRJGUa0>; Sun, 7 Oct 2001 16:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276671AbRJGUaS>; Sun, 7 Oct 2001 16:30:18 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:34062 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S276670AbRJGUaC>; Sun, 7 Oct 2001 16:30:02 -0400
Date: Sun, 7 Oct 2001 16:33:00 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] uhci.c interrupts
Message-ID: <20011007163300.I14479@sventech.com>
In-Reply-To: <Pine.LNX.4.33.0110071148380.7382-100000@penguin.transmeta.com> <20011007121851.A1137@netnation.com> <20011007153433.G14479@sventech.com> <20011007124038.A22923@netnation.com> <20011007161903.H14479@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011007161903.H14479@sventech.com>; from johannes@erdfelt.com on Sun, Oct 07, 2001 at 04:19:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A quick update patch to fix a couple of bugs, one important.

- Don't disable PIRQ on controller
- Print I/O base for controller when we suspend or wakeup
- Suspend controller, don't reset when system suspend's
- Don't print terminating TD twice in debug code
- Don't shadow irq parameter in alloc_uhci

Greg, please send it on to Linus. The patch is relative to 2.4.11-pre5

JE

--- linux-2.4.11-pre5/drivers/usb/uhci.c	Sun Oct  7 13:20:29 2001
+++ linux/drivers/usb/uhci.c	Sun Oct  7 13:21:51 2001
@@ -2410,7 +2410,7 @@
 {
 	unsigned int io_addr = uhci->io_addr;
 
-	dbg("suspend_hc");
+	dbg("%x: suspend_hc", io_addr);
 
 	outw(USBCMD_EGSM, io_addr + USBCMD);
 
@@ -2422,7 +2422,7 @@
 	unsigned int io_addr = uhci->io_addr;
 	unsigned int status;
 
-	dbg("wakeup_hc");
+	dbg("%x: wakeup_hc", io_addr);
 
 	outw(0, io_addr + USBCMD);
 	
@@ -2564,7 +2564,7 @@
  *  - The fourth queue is the bandwidth reclamation queue, which loops back
  *    to the high speed control queue.
  */
-static int alloc_uhci(struct pci_dev *dev, int irq, unsigned int io_addr, unsigned int io_size)
+static int alloc_uhci(struct pci_dev *dev, unsigned int io_addr, unsigned int io_size)
 {
 	struct uhci *uhci;
 	int retval = -EBUSY;
@@ -2602,9 +2602,9 @@
 	pci_set_master(dev);
 
 #ifndef __sparc__
-	sprintf(buf, "%d", irq);
+	sprintf(buf, "%d", dev->irq);
 #else
-	bufp = __irq_itoa(irq);
+	bufp = __irq_itoa(dev->irq);
 #endif
 	printk(KERN_INFO __FILE__ ": USB UHCI at I/O 0x%x, IRQ %s\n",
 		io_addr, bufp);
@@ -2828,13 +2828,13 @@
 
 	start_hc(uhci);
 
-	if (request_irq(irq, uhci_interrupt, SA_SHIRQ, "usb-uhci", uhci))
+	if (request_irq(dev->irq, uhci_interrupt, SA_SHIRQ, "usb-uhci", uhci))
 		goto err_request_irq;
 
-	uhci->irq = irq;
+	uhci->irq = dev->irq;
 
 	/* disable legacy emulation */
-	pci_write_config_word(uhci->dev, USBLEGSUP, 0);
+	pci_write_config_word(uhci->dev, USBLEGSUP, USBLEGSUP_DEFAULT);
 
 	usb_connect(uhci->rh.dev);
 
@@ -2925,7 +2925,7 @@
 		if (!(pci_resource_flags(dev, i) & IORESOURCE_IO))
 			continue;
 
-		return alloc_uhci(dev, dev->irq, io_addr, io_size);
+		return alloc_uhci(dev, io_addr, io_size);
 	}
 
 	return -ENODEV;
@@ -2958,7 +2958,7 @@
 #ifdef CONFIG_PM
 static int uhci_pci_suspend(struct pci_dev *dev, u32 state)
 {
-	reset_hc((struct uhci *) dev->driver_data);
+	suspend_hc((struct uhci *) dev->driver_data);
 	return 0;
 }
 
--- linux-2.4.11-pre5/drivers/usb/uhci-debug.h	Wed Aug 15 14:23:46 2001
+++ linux/drivers/usb/uhci-debug.h	Sun Oct  7 12:50:55 2001
@@ -372,7 +372,9 @@
 				if (td->link != td->dma_handle)
 					out += sprintf(out, "    skel_term_td does not link to self\n");
 
-				out += uhci_show_td(td, out, len - (out - buf), 4);
+				/* Don't show it twice */
+				if (debug <= 1)
+					out += uhci_show_td(td, out, len - (out - buf), 4);
 			}
 
 			continue;
--- linux-2.4.11-pre5/drivers/usb/uhci.h	Wed Aug 15 14:23:46 2001
+++ linux/drivers/usb/uhci.h	Sun Oct  7 13:11:57 2001
@@ -53,8 +53,8 @@
 #define   USBPORTSC_SUSP	0x1000	/* Suspend */
 
 /* Legacy support register */
-#define USBLEGSUP 0xc0
-#define USBLEGSUP_DEFAULT	0x2000	/* only PIRQ enable set */
+#define USBLEGSUP		0xc0
+#define   USBLEGSUP_DEFAULT	0x2000	/* only PIRQ enable set */
 
 #define UHCI_NULL_DATA_SIZE	0x7FF	/* for UHCI controller TD */
 
