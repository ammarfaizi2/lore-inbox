Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTJNR0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTJNR0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:26:21 -0400
Received: from ee.oulu.fi ([130.231.61.23]:4577 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S262298AbTJNR0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:26:19 -0400
Date: Tue, 14 Oct 2003 20:26:17 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: marc.kalberer@bluewin.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.0-test7 broadcom driver b44
Message-ID: <20031014172617.GA27889@ee.oulu.fi>
References: <3F710B1D00077369@mssbzhh-int.msg.bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3F710B1D00077369@mssbzhh-int.msg.bluewin.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 07:04:38PM +0200, marc.kalberer@bluewin.ch wrote:
> Hello,
> After about 30 recompiling of the kernel and svevral research on the net
> I came to the result :
> the Broadcom driver bcm4400 (b44) has a problem
> 
> log:
> - Kernel: b44.c:v0.9 (july 2003)
> - link is down 
> - flow control is off for tx and off for rx
> 
> First I wasn't able to do a ifup: it gave me a siocsifflags not implemented
> error,
> but it disapear when I enable the acpi (??? Strange how those 2 things are
> related ??)
Hi

If both drivers failed it's probably something else. If ACPI makes
it work, it might be something in the IRQ assignment, so
everything interrupt related from dmesg (and /proc/interrupts) is 
helpful in finding the problem. Also try to see whether turning off
the "PnP OS" selection if you have it enabled in the BIOS helps.

There is one known problem in the driver which the following patch
should fix. It only affects you if you see a tx transmit timeout
message in the logs.

--- linux-2.6.0-0.test6.1.47/drivers/net/b44.c.orig	2003-09-28 03:50:18.000000000 +0300
+++ linux-2.6.0-0.test6.1.47/drivers/net/b44.c	2003-10-03 18:55:29.000000000 +0300
@@ -25,8 +25,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.9"
-#define DRV_MODULE_RELDATE	"Jul 14, 2003"
+#define DRV_MODULE_VERSION	"0.91"
+#define DRV_MODULE_RELDATE	"Oct 3, 2003"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -80,15 +80,6 @@
 
 static int b44_debug = -1;	/* -1 == use B44_DEF_MSG_ENABLE as value */
 
-#ifndef PCI_DEVICE_ID_BCM4401
-#define PCI_DEVICE_ID_BCM4401      0x4401
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#define IRQ_RETVAL(x) 
-#define irqreturn_t void
-#endif
-
 static struct pci_device_id b44_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
@@ -870,6 +861,8 @@
 
 	spin_unlock_irq(&bp->lock);
 
+	b44_enable_ints(bp);
+
 	netif_wake_queue(dev);
 }
 

