Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVAHJek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVAHJek (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVAHJds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:33:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:25221 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261824AbVAHFsD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:03 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632672444@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:47 -0800
Message-Id: <11051632671073@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.31, 2004/12/17 11:41:58-08:00, david-b@pacbell.net

[PATCH] USB: EHCI "park" mode disabled

This changes the default initialization of the EHCI "park" mode so
that silicon which supports it (NF2, NF3, ALI, GeneSys, ...) will not
use it unless explicitly told to do so by a (new) module parameter.

This is a workaround for some problems observed on some NF2 systems:

    - Throughput ("hdparm -tT") is lower than expected with recent high
      performance drives (Maxtor) ... disabling "park" increases it by
      about 2 MByte/sec, but it's still much slower than expected.
      (USB analyser traces should be informative here.)

    - Some data corruption observed on reads from drives using an
      ALI storage adapter ... disabling "park" stops the corruption.
      (Strongly suggestive of hardware or peripheral firmware bugs;
      multiple back-to-back bulk-IN packets should work just fine.)

The "don't use park mode" workaround will at most reduce USB (and PCI)
throughput slightly on systems that work as expected, but some of those
can re-enable the "park" mode.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ehci-hcd.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)


diff -Nru a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c	2005-01-07 15:46:38 -08:00
+++ b/drivers/usb/host/ehci-hcd.c	2005-01-07 15:46:38 -08:00
@@ -124,11 +124,16 @@
 #define EHCI_ASYNC_JIFFIES	(HZ/20)		/* async idle timeout */
 #define EHCI_SHRINK_JIFFIES	(HZ/200)	/* async qh unlink delay */
 
-/* Initial IRQ latency:  lower than default */
+/* Initial IRQ latency:  faster than hw default */
 static int log2_irq_thresh = 0;		// 0 to 6
 module_param (log2_irq_thresh, int, S_IRUGO);
 MODULE_PARM_DESC (log2_irq_thresh, "log2 IRQ latency, 1-64 microframes");
 
+/* initial park setting:  slower than hw default */
+static unsigned park = 0;
+module_param (park, uint, S_IRUGO);
+MODULE_PARM_DESC (park, "park setting; 1-3 back-to-back async packets");
+
 #define	INTR_MASK (STS_IAA | STS_FATAL | STS_PCD | STS_ERR | STS_INT)
 
 /*-------------------------------------------------------------------------*/
@@ -506,11 +511,24 @@
 	}
 
 	/* clear interrupt enables, set irq latency */
-	temp = readl (&ehci->regs->command) & 0x0fff;
 	if (log2_irq_thresh < 0 || log2_irq_thresh > 6)
 		log2_irq_thresh = 0;
-	temp |= 1 << (16 + log2_irq_thresh);
-	// if hc can park (ehci >= 0.96), default is 3 packets per async QH 
+	temp = 1 << (16 + log2_irq_thresh);
+	if (HCC_CANPARK(hcc_params)) {
+		/* HW default park == 3, on hardware that supports it (like
+		 * NVidia and ALI silicon), maximizes throughput on the async
+		 * schedule by avoiding QH fetches between transfers.
+		 *
+		 * With fast usb storage devices and NForce2, "park" seems to
+		 * make problems:  throughput reduction (!), data errors...
+		 */
+		if (park) {
+			park = min (park, (unsigned) 3);
+			temp |= CMD_PARK;
+			temp |= park << 8;
+		}
+		ehci_info (ehci, "park %d\n", park);
+	}
 	if (HCC_PGM_FRAMELISTLEN (hcc_params)) {
 		/* periodic schedule size can be smaller than default */
 		temp &= ~(3 << 2);
@@ -522,7 +540,6 @@
 		default:	BUG ();
 		}
 	}
-	temp &= ~(CMD_IAAD | CMD_ASE | CMD_PSE),
 	// Philips, Intel, and maybe others need CMD_RUN before the
 	// root hub will detect new devices (why?); NEC doesn't
 	temp |= CMD_RUN;

