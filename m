Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVIJWgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVIJWgn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVIJWeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:20 -0400
Received: from styx.suse.cz ([82.119.242.94]:37284 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932357AbVIJWdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:52 -0400
Subject: [PATCH 17/26] iforce - use wait_event_interruptible_timeout
In-Reply-To: <11263916532348@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:13 +0200
Message-Id: <11263916532207@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: iforce - use wait_event_interruptible_timeout
From: Vojtech Pavlik <vojtech@suse.cz>
Date: 1125897159 -0500

The timeout while() loops in iforce-packets.c lack a
set_current_state(TASK_INTERRUPTIBLE); call. The right solution is
to replace them with wait_event_interruptible_timeout().

Reported-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/joystick/iforce/iforce-packets.c |   32 +++++-------------------
 drivers/input/joystick/iforce/iforce-usb.c     |    1 +
 2 files changed, 8 insertions(+), 25 deletions(-)

fb76b099f86624d3c629cfab071aa2296f65b7bb
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -249,9 +249,6 @@ void iforce_process_packet(struct iforce
 
 int iforce_get_id_packet(struct iforce *iforce, char *packet)
 {
-	DECLARE_WAITQUEUE(wait, current);
-	int timeout = HZ; /* 1 second */
-
 	switch (iforce->bus) {
 
 	case IFORCE_USB:
@@ -260,22 +257,13 @@ int iforce_get_id_packet(struct iforce *
 		iforce->cr.bRequest = packet[0];
 		iforce->ctrl->dev = iforce->usbdev;
 
-		set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&iforce->wait, &wait);
-
-		if (usb_submit_urb(iforce->ctrl, GFP_ATOMIC)) {
-			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&iforce->wait, &wait);
+		if (usb_submit_urb(iforce->ctrl, GFP_ATOMIC))
 			return -1;
-		}
 
-		while (timeout && iforce->ctrl->status == -EINPROGRESS)
-			timeout = schedule_timeout(timeout);
+		wait_event_interruptible_timeout(iforce->wait,
+			iforce->ctrl->status != -EINPROGRESS, HZ);
 
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&iforce->wait, &wait);
-
-		if (!timeout) {
+		if (iforce->ctrl->status != -EINPROGRESS) {
 			usb_unlink_urb(iforce->ctrl);
 			return -1;
 		}
@@ -290,16 +278,10 @@ int iforce_get_id_packet(struct iforce *
 		iforce->expect_packet = FF_CMD_QUERY;
 		iforce_send_packet(iforce, FF_CMD_QUERY, packet);
 
-		set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&iforce->wait, &wait);
-
-		while (timeout && iforce->expect_packet)
-			timeout = schedule_timeout(timeout);
-
-		set_current_state(TASK_RUNNING);
-		remove_wait_queue(&iforce->wait, &wait);
+		wait_event_interruptible_timeout(iforce->wait,
+			!iforce->expect_packet, HZ);
 
-		if (!timeout) {
+		if (iforce->expect_packet) {
 			iforce->expect_packet = 0;
 			return -1;
 		}
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -95,6 +95,7 @@ static void iforce_usb_irq(struct urb *u
 		goto exit;
 	}
 
+	wake_up(&iforce->wait);
 	iforce_process_packet(iforce,
 		(iforce->data[0] << 8) | (urb->actual_length - 1), iforce->data + 1, regs);
 

