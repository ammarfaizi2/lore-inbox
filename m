Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWBAFJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWBAFJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWBAFJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:18 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:27764 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030318AbWBAFJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:04 -0500
Message-Id: <20060201050735.246267000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 17/18] iforce - fix detection of USB devices
Content-Disposition: inline; filename=iforce-fix-timeouts.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: iforce - fix detection of USB devices

Recent conversion to wait_event_interruptible_timeout() caused
USB detection routine erroneously report timeouts for perfectly
working devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/iforce/iforce-packets.c |    4 ++--
 drivers/input/joystick/iforce/iforce-usb.c     |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

Index: work/drivers/input/joystick/iforce/iforce-packets.c
===================================================================
--- work.orig/drivers/input/joystick/iforce/iforce-packets.c
+++ work/drivers/input/joystick/iforce/iforce-packets.c
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
Index: work/drivers/input/joystick/iforce/iforce-usb.c
===================================================================
--- work.orig/drivers/input/joystick/iforce/iforce-usb.c
+++ work/drivers/input/joystick/iforce/iforce-usb.c
@@ -95,7 +95,6 @@ static void iforce_usb_irq(struct urb *u
 		goto exit;
 	}
 
-	wake_up(&iforce->wait);
 	iforce_process_packet(iforce,
 		(iforce->data[0] << 8) | (urb->actual_length - 1), iforce->data + 1, regs);
 

