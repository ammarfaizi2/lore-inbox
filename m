Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVHVWXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVHVWXs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVHVWXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:23:10 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:44424 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751372AbVHVWWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:22:43 -0400
Subject: [PATCH] hiddev: output reports are dropped when HIDIOCSREPORT is
	called in short succession
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       linux-usb-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-Vy1QynKa4ck+ci4As1i1"
Organization: Kontron Modular Computers
Date: Mon, 22 Aug 2005 11:25:31 +0200
Message-Id: <1124702731.19750.6.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-OriginalArrivalTime: 22 Aug 2005 09:25:32.0358 (UTC) FILETIME=[71A52E60:01C5A6FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Vy1QynKa4ck+ci4As1i1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

when trying to make the hiddev driver issue several Set_Report control
transfers to a custom device with 2.6.13-rc6, only the first transfer in
a row is carried out, while others immediately following it are silently
dropped.

This happens where hid_submit_report() (in hid-core.c) tests for
HID_CTRL_RUNNING, which seems to be still set because the first transfer
is not finished yet.

As a workaround, inserting a delay between the two calls to
ioctl(HIDIOCSREPORT) in userspace "solves" the problem.
The straightforward fix is to add a call to hid_wait_io() to the
implementation of HIDIOCSREPORT (in hiddev.c), just like for
HIDIOCGREPORT. Works fine for me.

Apparently, this issue has some history:
http://marc.theaimsgroup.com/?l=linux-usb-users&m=111100670105558&w=2

Signed-off-by: Stefan Nickl <Stefan.Nickl@kontron.com>

-- 
Stefan Nickl
Kontron Modular Computers


--=-Vy1QynKa4ck+ci4As1i1
Content-Disposition: attachment; filename=hiddev_HIDIOCSREPORT_wait_io.patch
Content-Type: text/x-patch; name=hiddev_HIDIOCSREPORT_wait_io.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- v2.6.13-rc6/drivers/usb/input/hiddev.c.orig	2005-08-22 10:56:55.000000000 +0200
+++ v2.6.13-rc6/drivers/usb/input/hiddev.c	2005-08-22 10:57:07.000000000 +0200
@@ -507,6 +507,7 @@ static int hiddev_ioctl(struct inode *in
 			return -EINVAL;
 
 		hid_submit_report(hid, report, USB_DIR_OUT);
+		hid_wait_io(hid);
 
 		return 0;
 

--=-Vy1QynKa4ck+ci4As1i1--

