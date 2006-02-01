Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWBAFJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWBAFJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWBAFJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:09:16 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:20139 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030312AbWBAFJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:09:02 -0500
Message-Id: <20060201050734.317097000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:23 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 09/18] db9: handle errors from input_register_device()
Content-Disposition: inline; filename=db9-error-handling.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: db9 - handle errors from input_register_device()

Also db9_remove shouldn't be marked __exit as it is also called from
__init code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/db9.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

Index: work/drivers/input/joystick/db9.c
===================================================================
--- work.orig/drivers/input/joystick/db9.c
+++ work/drivers/input/joystick/db9.c
@@ -616,7 +616,7 @@ static struct db9 __init *db9_probe(int 
 		if (!input_dev) {
 			printk(KERN_ERR "db9.c: Not enough memory for input device\n");
 			err = -ENOMEM;
-			goto err_free_devs;
+			goto err_unreg_devs;
 		}
 
 		sprintf(db9->phys[i], "%s/input%d", db9->pd->port->name, i);
@@ -642,13 +642,17 @@ static struct db9 __init *db9_probe(int 
 				input_set_abs_params(input_dev, db9_abs[j], 1, 255, 0, 0);
 		}
 
-		input_register_device(input_dev);
+		err = input_register_device(input_dev);
+		if (err)
+			goto err_free_dev;
 	}
 
 	parport_put_port(pp);
 	return db9;
 
- err_free_devs:
+ err_free_dev:
+	input_free_device(db9->dev[i]);
+ err_unreg_devs:
 	while (--i >= 0)
 		input_unregister_device(db9->dev[i]);
 	kfree(db9);
@@ -660,7 +664,7 @@ static struct db9 __init *db9_probe(int 
 	return ERR_PTR(err);
 }
 
-static void __exit db9_remove(struct db9 *db9)
+static void db9_remove(struct db9 *db9)
 {
 	int i;
 
@@ -698,7 +702,8 @@ static int __init db9_init(void)
 
 	if (err) {
 		while (--i >= 0)
-			db9_remove(db9_base[i]);
+			if (db9_base[i])
+				db9_remove(db9_base[i]);
 		return err;
 	}
 

