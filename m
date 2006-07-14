Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422709AbWGNTAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbWGNTAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbWGNTAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:00:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41186 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422709AbWGNTAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:00:51 -0400
Date: Fri, 14 Jul 2006 12:00:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: AChittenden@bluearc.com, david-b@pacbell.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.17 hangs during boot on ASUS M2NPV-VM
 motherboard
Message-Id: <20060714120040.c0e66e72.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0607141447320.8006-100000@iolanthe.rowland.org>
References: <20060714093014.2a6e68ff.akpm@osdl.org>
	<Pine.LNX.4.44L0.0607141447320.8006-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006 14:50:16 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Fri, 14 Jul 2006, Andrew Morton wrote:
> 
> > On Fri, 14 Jul 2006 16:54:25 +0100
> > "Andy Chittenden" <AChittenden@bluearc.com> wrote:
> 
> > > > So I guess there's something awry with the USB controller driver?
> > > > 
> > > 
> > > Is there any other info that someone wants to track this down? Or has
> > > someone got a fix?
> 
> It's hard to come up with a fix without knowing what's wrong.  The current 
> development version of that subroutine is essentially the same as the 
> version in 2.6.17.
> 
> If you want to pin down the problem more precisely, try adding a whole 
> bunch of printk() statements to the quirk_usb_handoff_ohci() function in
> drivers/usb/host/pci-quirks.c.
> 

Andy, please add the below, work out what line it gets stuck at and then
let us know?  Thanks.

(bear in mind that our line numbers will usually be different from yours,
so please don't use line numbers to ifdentify where it hung).


diff -puN drivers/usb/host/pci-quirks.c~a drivers/usb/host/pci-quirks.c
--- a/drivers/usb/host/pci-quirks.c~a
+++ a/drivers/usb/host/pci-quirks.c
@@ -164,38 +164,50 @@ static int __devinit mmio_resource_enabl
 	return pci_resource_start(pdev, idx) && mmio_enabled(pdev);
 }
 
+#define D() printk("%s:%d\n", __FILE__, __LINE__);
+
 static void __devinit quirk_usb_handoff_ohci(struct pci_dev *pdev)
 {
 	void __iomem *base;
 
+	D();
+
 	if (!mmio_resource_enabled(pdev, 0))
 		return;
 
+	D();
+
 	base = ioremap_nocache(pci_resource_start(pdev, 0),
 				     pci_resource_len(pdev, 0));
 	if (base == NULL) return;
-
+	D();
 /* On PA-RISC, PDC can leave IR set incorrectly; ignore it there. */
 #ifndef __hppa__
 {
 	u32 control = readl(base + OHCI_CONTROL);
+	D();
 	if (control & OHCI_CTRL_IR) {
 		int wait_time = 500; /* arbitrary; 5 seconds */
+		D();
 		writel(OHCI_INTR_OC, base + OHCI_INTRENABLE);
+		D();
 		writel(OHCI_OCR, base + OHCI_CMDSTATUS);
+		D();
 		while (wait_time > 0 &&
 				readl(base + OHCI_CONTROL) & OHCI_CTRL_IR) {
 			wait_time -= 10;
 			msleep(10);
 		}
+		D();
 		if (wait_time <= 0)
 			printk(KERN_WARNING "%s %s: BIOS handoff "
 					"failed (BIOS bug ?) %08x\n",
 					pdev->dev.bus_id, "OHCI",
 					readl(base + OHCI_CONTROL));
-
+		D();
 		/* reset controller, preserving RWC */
 		writel(control & OHCI_CTRL_RWC, base + OHCI_CONTROL);
+		D();
 	}
 }
 #endif
@@ -203,10 +215,13 @@ static void __devinit quirk_usb_handoff_
 	/*
 	 * disable interrupts
 	 */
+	D();
 	writel(~(u32)0, base + OHCI_INTRDISABLE);
+	D();
 	writel(~(u32)0, base + OHCI_INTRSTATUS);
-
+	D();
 	iounmap(base);
+	D();
 }
 
 static void __devinit quirk_usb_disable_ehci(struct pci_dev *pdev)
_

