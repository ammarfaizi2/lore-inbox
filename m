Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263059AbTCSPT1>; Wed, 19 Mar 2003 10:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbTCSPT1>; Wed, 19 Mar 2003 10:19:27 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:54422 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S263059AbTCSPTY>; Wed, 19 Mar 2003 10:19:24 -0500
Date: Wed, 19 Mar 2003 07:21:42 -0800
From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.5.65] ehci-hcd, don't use PCI MWI
To: Greg KH <greg@kroah.com>
Cc: usb-devel <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>
Message-id: <3E788B06.4090302@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_xSfr8ASzlbX4W0pHMUNDBA)"
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_xSfr8ASzlbX4W0pHMUNDBA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Hi,

Some users have been sending init logs for Athlon kernels that
include PCI warning messages about the PCI cache line size
getting set incorrectly ... where the kernel thinks that the
right value is 16 bytes.  Since 64 bytes is the right number,
it's dangerous to enable MWI on such systems.

This patch stops trying to use MWI; it's a workaround for the
misbehavior of that PCI cacheline-setting code.  Please apply
to 2.5 and 2.4 trees.

- Dave

--Boundary_(ID_xSfr8ASzlbX4W0pHMUNDBA)
Content-type: text/plain; name=ehci-0319a.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=ehci-0319a.patch

--- 1.45/drivers/usb/host/ehci-hcd.c	Mon Feb 24 03:30:38 2003
+++ edited/drivers/usb/host/ehci-hcd.c	Wed Mar 19 07:05:33 2003
@@ -432,7 +432,11 @@
 	}
 
 	/* help hc dma work well with cachelines */
-	pci_set_mwi (ehci->hcd.pdev);
+	/* NOTE:  disabled until it works reliably ... some x86/Athlon
+	 * kernels are thinking 16 byte cachelines, not 64 byte ones,
+	 * so clearly the MWI prep logic is wrong.
+	 */
+	// pci_set_mwi (ehci->hcd.pdev);
 
 	/* clear interrupt enables, set irq latency */
 	temp = readl (&ehci->regs->command) & 0xff;

--Boundary_(ID_xSfr8ASzlbX4W0pHMUNDBA)--
