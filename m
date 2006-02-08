Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWBHGrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWBHGrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWBHGnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:09 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:25217 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161011AbWBHGmt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:42:49 -0500
Message-Id: <20060208064903.041409000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:14 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: [PATCH 11/23] Input: iforce - fix detection of USB devices
Content-Disposition: inline; filename=input-iforce-fix-detection-of-usb-devices.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Recent conversion to wait_event_interruptible_timeout() caused
USB detection routine erroneously report timeouts for perfectly
working devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/input/joystick/iforce/iforce-packets.c |    4 ++--
 drivers/input/joystick/iforce/iforce-usb.c     |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.15.3/drivers/input/joystick/iforce/iforce-packets.c
===================================================================
--- linux-2.6.15.3.orig/drivers/input/joystick/iforce/iforce-packets.c
+++ linux-2.6.15.3/drivers/input/joystick/iforce/iforce-packets.c
@@ -167,9 +167,9 @@ void iforce_process_packet(struct iforce
 		iforce->expect_packet = 0;
 		iforce->ecmd = cmd;
 		memcpy(iforce->edata, data, IFORCE_MAX_LENGTH);
-		wake_up(&iforce->wait);
 	}
 #endif
+	wake_up(&iforce->wait);
 
 	if (!iforce->type) {
 		being_used--;
@@ -264,7 +264,7 @@ int iforce_get_id_packet(struct iforce *
 		wait_event_interruptible_timeout(iforce->wait,
 			iforce->ctrl->status != -EINPROGRESS, HZ);
 
-		if (iforce->ctrl->status != -EINPROGRESS) {
+		if (iforce->ctrl->status) {
 			usb_unlink_urb(iforce->ctrl);
 			return -1;
 		}
Index: linux-2.6.15.3/drivers/input/joystick/iforce/iforce-usb.c
===================================================================
--- linux-2.6.15.3.orig/drivers/input/joystick/iforce/iforce-usb.c
+++ linux-2.6.15.3/drivers/input/joystick/iforce/iforce-usb.c
@@ -95,7 +95,6 @@ static void iforce_usb_irq(struct urb *u
 		goto exit;
 	}
 
-	wake_up(&iforce->wait);
 	iforce_process_packet(iforce,
 		(iforce->data[0] << 8) | (urb->actual_length - 1), iforce->data + 1, regs);
 

--
