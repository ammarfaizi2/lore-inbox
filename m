Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWBAFJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWBAFJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWBAFJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:12 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:34703 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030329AbWBAFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:03 -0500
Message-Id: <20060201050735.062858000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:29 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 15/18] tmdc: handle errors from input_register_device()
Content-Disposition: inline; filename=tmdc-error-handling.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: tmdc - handle errors from input_register_device()

Also set .owner in driver structure so we'll have a link between
module and driver in sysfs.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/tmdc.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

Index: work/drivers/input/joystick/tmdc.c
===================================================================
--- work.orig/drivers/input/joystick/tmdc.c
+++ work/drivers/input/joystick/tmdc.c
@@ -284,13 +284,13 @@ static int tmdc_setup_port(struct tmdc *
 	struct tmdc_port *port;
 	struct input_dev *input_dev;
 	int i, j, b = 0;
+	int err;
 
 	tmdc->port[idx] = port = kzalloc(sizeof (struct tmdc_port), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!port || !input_dev) {
-		kfree(port);
-		input_free_device(input_dev);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto fail;
 	}
 
 	port->mode = data[TMDC_BYTE_ID];
@@ -347,9 +347,15 @@ static int tmdc_setup_port(struct tmdc *
 		b += port->btnc[i];
 	}
 
-	input_register_device(port->dev);
+	err = input_register_device(port->dev);
+	if (err)
+		goto fail;
 
 	return 0;
+
+ fail:	input_free_device(input_dev);
+	kfree(port);
+	return err;
 }
 
 /*
@@ -424,6 +430,7 @@ static void tmdc_disconnect(struct gamep
 static struct gameport_driver tmdc_drv = {
 	.driver		= {
 		.name	= "tmdc",
+		.owner	= THIS_MODULE,
 	},
 	.description	= DRIVER_DESC,
 	.connect	= tmdc_connect,

