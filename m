Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbTISK22 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbTISK1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:27:25 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:20622 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261500AbTISK0x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:26:53 -0400
Subject: [PATCH 10/11] input: Fix I-Force sleeping issues
In-Reply-To: <10639672021535@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 12:26:42 +0200
Message-Id: <10639672023022@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1348, 2003-09-19 01:24:36-07:00, oliver@neukum.org
  iforce-usb.c, iforce-packets.c:
    Fix I-Force sleeping issues.


 iforce-packets.c |    5 ++---
 iforce-usb.c     |    6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

===================================================================

diff -Nru a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
--- a/drivers/input/joystick/iforce/iforce-packets.c	Fri Sep 19 12:15:47 2003
+++ b/drivers/input/joystick/iforce/iforce-packets.c	Fri Sep 19 12:15:47 2003
@@ -166,8 +166,7 @@
 		iforce->expect_packet = 0;
 		iforce->ecmd = cmd;
 		memcpy(iforce->edata, data, IFORCE_MAX_LENGTH);
-		if (waitqueue_active(&iforce->wait))
-			wake_up(&iforce->wait);
+		wake_up(&iforce->wait);
 	}
 #endif
 
@@ -264,7 +263,7 @@
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&iforce->wait, &wait);
 
-		if (usb_submit_urb(iforce->ctrl, GFP_KERNEL)) {
+		if (usb_submit_urb(iforce->ctrl, GFP_ATOMIC)) {
 			set_current_state(TASK_RUNNING);
 			remove_wait_queue(&iforce->wait, &wait);
 			return -1;
diff -Nru a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
--- a/drivers/input/joystick/iforce/iforce-usb.c	Fri Sep 19 12:15:47 2003
+++ b/drivers/input/joystick/iforce/iforce-usb.c	Fri Sep 19 12:15:47 2003
@@ -116,8 +116,7 @@
 
 	iforce_usb_xmit(iforce);
 
-	if (waitqueue_active(&iforce->wait))
-		wake_up(&iforce->wait);
+	wake_up(&iforce->wait);
 }
 
 static void iforce_usb_ctrl(struct urb *urb, struct pt_regs *regs)
@@ -125,8 +124,7 @@
 	struct iforce *iforce = urb->context;
 	if (urb->status) return;
 	iforce->ecmd = 0xff00 | urb->actual_length;
-	if (waitqueue_active(&iforce->wait))
-		wake_up(&iforce->wait);
+	wake_up(&iforce->wait);
 }
 
 static int iforce_usb_probe(struct usb_interface *intf,

