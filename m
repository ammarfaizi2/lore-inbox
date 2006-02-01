Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWBAFlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWBAFlG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWBAFlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:41:06 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:19809 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030387AbWBAFlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:41:05 -0500
Message-Id: <20060201050734.541844000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:25 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 11/18] sidewinder: handle errors from input_register_device()
Content-Disposition: inline; filename=sidewinder-error-handling.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: sidewinder - handle errors from input_register_device()

Also set .owner in driver structure so we'll have a link between
module and driver in sysfs.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/sidewinder.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: work/drivers/input/joystick/sidewinder.c
===================================================================
--- work.orig/drivers/input/joystick/sidewinder.c
+++ work/drivers/input/joystick/sidewinder.c
@@ -771,12 +771,15 @@ static int sw_connect(struct gameport *g
 
 		dbg("%s%s [%d-bit id %d data %d]\n", sw->name, comment, m, l, k);
 
-		input_register_device(sw->dev[i]);
+		err = input_register_device(sw->dev[i]);
+		if (err)
+			goto fail4;
 	}
 
 	return 0;
 
- fail3: while (--i >= 0)
+ fail4:	input_free_device(sw->dev[i]);
+ fail3:	while (--i >= 0)
 		input_unregister_device(sw->dev[i]);
  fail2:	gameport_close(gameport);
  fail1:	gameport_set_drvdata(gameport, NULL);
@@ -801,6 +804,7 @@ static void sw_disconnect(struct gamepor
 static struct gameport_driver sw_drv = {
 	.driver		= {
 		.name	= "sidewinder",
+		.owner	= THIS_MODULE,
 	},
 	.description	= DRIVER_DESC,
 	.connect	= sw_connect,

