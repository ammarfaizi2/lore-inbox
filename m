Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbSJYWDf>; Fri, 25 Oct 2002 18:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSJYWDf>; Fri, 25 Oct 2002 18:03:35 -0400
Received: from oracle.uk.clara.net ([195.8.69.94]:47624 "EHLO
	oracle.uk.clara.net") by vger.kernel.org with ESMTP
	id <S261639AbSJYWDe>; Fri, 25 Oct 2002 18:03:34 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
X-no-productlinks: yes
Subject: USB scanner (2.5.4x) Fail to access minor
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-15
NNTP-Posting-Host: daria.co.uk
Message-ID: <8c1.3db9c10b.90442@trespassersw.daria.co.uk>
Date: Fri, 25 Oct 2002 22:09:15 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I built scanner.o with DEBUG (having applied the following trival
patch)

--- linux-2.5/drivers/usb/image/scanner.c~	Sun Sep 22 05:25:04 2002
+++ linux-2.5/drivers/usb/image/scanner.c	Fri Oct 25 22:36:53 2002
@@ -841,7 +841,7 @@
 	}
 
 	dbg("probe_scanner: USB dev address:%p", dev);
-	dbg("probe_scanner: ifnum:%u", ifnum);
+//	dbg("probe_scanner: ifnum:%u", ifnum);
 
 /*
  * 1. Check Vendor/Product

The probing finds the minor 48, but the USB_SCN_MINOR() macro in open
results in the minor transposed to 0. This obviously causes the 
!p_scn_table[scn_minor] test to fail, dmesg follows:
(/dev/usbscanner0 is 180,48)

drivers/usb/image/scanner.c: probe_scanner: Allocated minor:48
drivers/usb/image/scanner.c: probe_scanner(48): Address of scn:df97ef40
drivers/usb/image/scanner.c: probe_scanner(48): obuf address:da05a000
drivers/usb/image/scanner.c: probe_scanner(48): ibuf address:de598000
drivers/usb/image/scanner.c: scanner48: device node registration failed
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.6:USB Scanner Driver
drivers/usb/image/scanner.c: open_scanner: scn_minor:0
drivers/usb/image/scanner.c: open_scanner(0): Unable to access minor data
drivers/usb/image/scanner.c: open_scanner: scn_minor:0
drivers/usb/image/scanner.c: open_scanner(0): Unable to access minor data

The follow 'fixes' the symptoms: Please can a USB literate provide the
proper fix!

--- linux-2.5/drivers/usb/image/scanner.h.orig	Sun Sep 22 05:25:07 2002
+++ linux-2.5/drivers/usb/image/scanner.h	Fri Oct 25 23:04:01 2002
@@ -216,7 +216,7 @@
 #define IS_EP_BULK_OUT(ep) (IS_EP_BULK(ep) && ((ep).bEndpointAddress & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT)
 #define IS_EP_INTR(ep) ((ep).bmAttributes == USB_ENDPOINT_XFER_INT ? 1 : 0)
 
-#define USB_SCN_MINOR(X) minor((X)->i_rdev) - SCN_BASE_MNR
+#define USB_SCN_MINOR(X) minor((X)->i_rdev)
 
 #ifdef DEBUG
 #define SCN_DEBUG(X) X

