Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268680AbTBZILq>; Wed, 26 Feb 2003 03:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268682AbTBZILq>; Wed, 26 Feb 2003 03:11:46 -0500
Received: from smtp.rhein-zeitung.DE ([212.7.160.14]:25785 "EHLO
	smtp.rhein-zeitung.DE") by vger.kernel.org with ESMTP
	id <S268680AbTBZILo>; Wed, 26 Feb 2003 03:11:44 -0500
Date: Wed, 26 Feb 2003 09:21:49 +0100
From: Oliver Graf <ograf@rz-online.net>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-storage fails to detect all luns after 2.4.19
Message-ID: <20030226082149.GB2441@rz-online.net>
References: <20030220213037.GA5435@rz-online.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20030220213037.GA5435@rz-online.net>
User-Agent: Mutt/1.3.27i
X-PGP-Key: http://wwwkeys.de.pgp.net:11371/pks/lookup?op=get&search=0x0B17417A
X-RIPE-Key-Cert: PGPKEY-0B17417A
Organization: KEVAG Telekom GmbH / RZ-Online GmbH
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On Thu, Feb 20, 2003 at 10:30:37PM +0100, Oliver Graf wrote:
> The problem: a multi device usb card reader is correctly detected with
> its four subdevices with kernel 2.4.19(-acX). But any patch after this
> fails to detect the subdevices.
> 
> Verbose output with 2.4.19-ac4 shows:
> usb-storage: GetMaxLUN command result is 1, data is 3
> 
> 2.4.21-pre4 gives:
> usb-storage: GetMaxLUN command result is -32, data is 128
> usb-storage: clearing endpoint halt for pipe 0x80000880
> 
> I tried to find the parts that changed between the version, but it seems
> not to be rooted in usb-storage.
> 
> The call to usb_control_msg seems to timeout with the newer kernel
> (just a wild guess!).

It is a timeout:
usb-storage: New GUID 04831307fffe9ffffffffe97
usb-uhci.c: interrupt, status 2, frame# 1765
usb_control/bulk_msg: timeout
usb-storage: GetMaxLUN command result is -110, data is 128

> Finally I did a desparate modification: I return 3 from
> usb_stor_Bulk_max_lun just before the endpoint is cleared. This got my
> card reader up and running again, but it's very very dirty und certainly
> breaks other usb storage devices (I don't own).

A patch which defines a new unusual_dev is appended. But it's still
dirty, cause it sets max_lun to 3 for this device. It should be seen as
a workaround not as something that should go into the kernel.

If someone more elaborate needs more debug output to find the real
problem, feel free to contact me.

Regards,
  Oliver.


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usbstor-tevion.diff"

--- linux-2.4.21-pre4/drivers/usb/storage/transport.h.orig	2003-02-25 07:49:43.000000000 +0100
+++ linux-2.4.21-pre4/drivers/usb/storage/transport.h	2003-02-26 09:04:34.000000000 +0100
@@ -75,6 +75,8 @@
 #define US_PR_JUMPSHOT  0xf3            /* Lexar Jumpshot */
 #endif
 
+#define US_PR_TEV6IN1   0xf4
+
 /*
  * Bulk only data structures
  */
--- linux-2.4.21-pre4/drivers/usb/storage/unusual_devs.h.orig	2003-02-25 07:51:12.000000000 +0100
+++ linux-2.4.21-pre4/drivers/usb/storage/unusual_devs.h	2003-02-26 09:04:34.000000000 +0100
@@ -90,6 +90,12 @@
 		"Nex II Digital",
 		US_SC_SCSI, US_PR_BULK, NULL, US_FL_START_STOP),
 
+/* Hack for the Tevion Card Reader 6in1 by Oliver Graf <ograf@rz-online.net> */
+UNUSUAL_DEV(  0x0483, 0x1307, 0x0000, 0x9999,
+		"Tevion",
+		"Card Reader 6in1",
+		US_SC_SCSI, US_PR_TEV6IN1, NULL, 0),
+
 /* Reported by Paul Stewart <stewart@wetlogic.net>
  * This entry is needed because the device reports Sub=ff */
 UNUSUAL_DEV(  0x04a4, 0x0004, 0x0001, 0x0001,
--- linux-2.4.21-pre4/drivers/usb/storage/usb.c.orig	2003-02-25 07:50:12.000000000 +0100
+++ linux-2.4.21-pre4/drivers/usb/storage/usb.c	2003-02-26 09:04:33.000000000 +0100
@@ -849,6 +849,13 @@
 			ss->max_lun = usb_stor_Bulk_max_lun(ss);
 			break;
 
+		case US_PR_TEV6IN1:
+			ss->transport_name = "Bulk";
+			ss->transport = usb_stor_Bulk_transport;
+			ss->transport_reset = usb_stor_Bulk_reset;
+			ss->max_lun = 3;
+			break;
+
 #ifdef CONFIG_USB_STORAGE_HP8200e
 		case US_PR_SCM_ATAPI:
 			ss->transport_name = "SCM/ATAPI";

--LQksG6bCIzRHxTLp--
