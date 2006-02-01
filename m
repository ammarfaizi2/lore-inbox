Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWBAFlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWBAFlb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWBAFlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:41:09 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:17342 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030389AbWBAFlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:41:05 -0500
Message-Id: <20060201050734.894858000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 14/18] turbografx: handle errors from input_register_device()
Content-Disposition: inline; filename=turbografx-error-handling.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: turbografx - handle errors from input_register_device()

Also tgfx_remove shouldn't be marked __exit as it is also called from
__init code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/turbografx.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

Index: work/drivers/input/joystick/turbografx.c
===================================================================
--- work.orig/drivers/input/joystick/turbografx.c
+++ work/drivers/input/joystick/turbografx.c
@@ -204,14 +204,14 @@ static struct tgfx __init *tgfx_probe(in
 		if (n_buttons[i] > 6) {
 			printk(KERN_ERR "turbografx.c: Invalid number of buttons %d\n", n_buttons[i]);
 			err = -EINVAL;
-			goto err_free_devs;
+			goto err_unreg_devs;
 		}
 
 		tgfx->dev[i] = input_dev = input_allocate_device();
 		if (!input_dev) {
 			printk(KERN_ERR "turbografx.c: Not enough memory for input device\n");
 			err = -ENOMEM;
-			goto err_free_devs;
+			goto err_unreg_devs;
 		}
 
 		tgfx->sticks |= (1 << i);
@@ -238,7 +238,9 @@ static struct tgfx __init *tgfx_probe(in
 		for (j = 0; j < n_buttons[i]; j++)
 			set_bit(tgfx_buttons[j], input_dev->keybit);
 
-		input_register_device(tgfx->dev[i]);
+		err = input_register_device(tgfx->dev[i]);
+		if (err)
+			goto err_free_dev;
 	}
 
         if (!tgfx->sticks) {
@@ -249,9 +251,12 @@ static struct tgfx __init *tgfx_probe(in
 
 	return tgfx;
 
- err_free_devs:
+ err_free_dev:
+	input_free_device(tgfx->dev[i]);
+ err_unreg_devs:
 	while (--i >= 0)
-		input_unregister_device(tgfx->dev[i]);
+		if (tgfx->dev[i])
+			input_unregister_device(tgfx->dev[i]);
  err_free_tgfx:
 	kfree(tgfx);
  err_unreg_pardev:
@@ -262,7 +267,7 @@ static struct tgfx __init *tgfx_probe(in
 	return ERR_PTR(err);
 }
 
-static void __exit tgfx_remove(struct tgfx *tgfx)
+static void tgfx_remove(struct tgfx *tgfx)
 {
 	int i;
 
@@ -300,7 +305,8 @@ static int __init tgfx_init(void)
 
 	if (err) {
 		while (--i >= 0)
-			tgfx_remove(tgfx_base[i]);
+			if (tgfx_base[i])
+				tgfx_remove(tgfx_base[i]);
 		return err;
 	}
 

