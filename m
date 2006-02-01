Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWBAFJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWBAFJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWBAFJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:08 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:38761 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030322AbWBAFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:03 -0500
Message-Id: <20060201050734.082630000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:21 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 07/18] grip: handle errors from input_register_device()
Content-Disposition: inline; filename=grip-error-handling.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: grip - handle errors from input_register_device()

Also set .owner in driver structure so we'll have a link between
module and driver in sysfs.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/grip.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: work/drivers/input/joystick/grip.c
===================================================================
--- work.orig/drivers/input/joystick/grip.c
+++ work/drivers/input/joystick/grip.c
@@ -384,12 +384,15 @@ static int grip_connect(struct gameport 
 			if (t > 0)
 				set_bit(t, input_dev->keybit);
 
-		input_register_device(grip->dev[i]);
+		err = input_register_device(grip->dev[i]);
+		if (err)
+			goto fail4;
 	}
 
 	return 0;
 
- fail3: for (i = 0; i < 2; i++)
+ fail4:	input_free_device(grip->dev[i]);
+ fail3:	while (--i >= 0)
 		if (grip->dev[i])
 			input_unregister_device(grip->dev[i]);
  fail2:	gameport_close(gameport);
@@ -414,6 +417,7 @@ static void grip_disconnect(struct gamep
 static struct gameport_driver grip_drv = {
 	.driver		= {
 		.name	= "grip",
+		.owner	= THIS_MODULE,
 	},
 	.description	= DRIVER_DESC,
 	.connect	= grip_connect,

