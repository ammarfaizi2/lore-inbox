Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWBAFJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWBAFJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWBAFJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:11 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:44446 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030330AbWBAFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:03 -0500
Message-Id: <20060201050734.783459000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:27 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 13/18] gamecon: handle errors from input_register_device()
Content-Disposition: inline; filename=gamecon-error-handling.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: gamecon - handle errors from input_register_device()

Also gc_remove shouldn't be marked __exit as it is also called from
__init code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/gamecon.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

Index: work/drivers/input/joystick/gamecon.c
===================================================================
--- work.orig/drivers/input/joystick/gamecon.c
+++ work/drivers/input/joystick/gamecon.c
@@ -706,9 +706,11 @@ static struct gc __init *gc_probe(int pa
 		sprintf(gc->phys[i], "%s/input%d", gc->pd->port->name, i);
 		err = gc_setup_pad(gc, i, pads[i]);
 		if (err)
-			goto err_free_devs;
+			goto err_unreg_devs;
 
-		input_register_device(gc->dev[i]);
+		err = input_register_device(gc->dev[i]);
+		if (err)
+			goto err_free_dev;
 	}
 
 	if (!gc->pads[0]) {
@@ -720,9 +722,12 @@ static struct gc __init *gc_probe(int pa
 	parport_put_port(pp);
 	return gc;
 
- err_free_devs:
+ err_free_dev:
+	input_free_device(gc->dev[i]);
+ err_unreg_devs:
 	while (--i >= 0)
-		input_unregister_device(gc->dev[i]);
+		if (gc->dev[i])
+			input_unregister_device(gc->dev[i]);
  err_free_gc:
 	kfree(gc);
  err_unreg_pardev:
@@ -733,7 +738,7 @@ static struct gc __init *gc_probe(int pa
 	return ERR_PTR(err);
 }
 
-static void __exit gc_remove(struct gc *gc)
+static void gc_remove(struct gc *gc)
 {
 	int i;
 
@@ -771,7 +776,8 @@ static int __init gc_init(void)
 
 	if (err) {
 		while (--i >= 0)
-			gc_remove(gc_base[i]);
+			if (gc_base[i])
+				gc_remove(gc_base[i]);
 		return err;
 	}
 

