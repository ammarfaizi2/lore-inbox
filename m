Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUKXHTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUKXHTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbUKXHTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:19:45 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:59749 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262333AbUKXHOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:14:54 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 4/11] Twidjoy build fix
Date: Wed, 24 Nov 2004 02:08:12 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411240205.10502.dtor_core@ameritech.net> <200411240206.45763.dtor_core@ameritech.net> <200411240207.33932.dtor_core@ameritech.net>
In-Reply-To: <200411240207.33932.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240208.14115.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1939.3.37, 2004-11-15 23:25:52-05:00, dtor_core@ameritech.net
  Input: twidjoy - apparently Kconfig and Makefile disagreed on the
         name for config option so the module was never built.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru> 


 Makefile  |    2 +-
 twidjoy.c |   14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)


===================================================================



diff -Nru a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
--- a/drivers/input/joystick/Makefile	2004-11-24 01:47:17 -05:00
+++ b/drivers/input/joystick/Makefile	2004-11-24 01:47:17 -05:00
@@ -24,7 +24,7 @@
 obj-$(CONFIG_JOYSTICK_STINGER)		+= stinger.o
 obj-$(CONFIG_JOYSTICK_TMDC)		+= tmdc.o
 obj-$(CONFIG_JOYSTICK_TURBOGRAFX)	+= turbografx.o
-obj-$(CONFIG_JOYSTICK_TWIDJOY)		+= twidjoy.o
+obj-$(CONFIG_JOYSTICK_TWIDDLER)		+= twidjoy.o
 obj-$(CONFIG_JOYSTICK_WARRIOR)		+= warrior.o
 
 obj-$(CONFIG_JOYSTICK_IFORCE)		+= iforce/
diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	2004-11-24 01:47:17 -05:00
+++ b/drivers/input/joystick/twidjoy.c	2004-11-24 01:47:17 -05:00
@@ -58,7 +58,9 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 
-MODULE_DESCRIPTION("Handykey Twiddler keyboard as a joystick driver");
+#define DRIVER_DESC	"Handykey Twiddler keyboard as a joystick driver"
+
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
@@ -147,7 +149,7 @@
 
 static irqreturn_t twidjoy_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	struct twidjoy *twidjoy = serio->private;
+	struct twidjoy *twidjoy = serio_get_drvdata(serio);
 
 	/* All Twiddler packets are 5 bytes. The fact that the first byte
 	 * has a MSB of 0 and all other bytes have a MSB of 1 can be used
@@ -175,9 +177,11 @@
 
 static void twidjoy_disconnect(struct serio *serio)
 {
-	struct twidjoy *twidjoy = serio->private;
+	struct twidjoy *twidjoy = serio_get_drvdata(serio);
+
 	input_unregister_device(&twidjoy->dev);
 	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
 	kfree(twidjoy);
 }
 
@@ -231,9 +235,11 @@
 	}
 
 	twidjoy->dev.private = twidjoy;
-	serio->private = twidjoy;
+
+	serio_set_drvdata(serio, twidjoy);
 
 	if (serio_open(serio, drv)) {
+		serio_set_drvdata(serio, NULL);
 		kfree(twidjoy);
 		return;
 	}
