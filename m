Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263219AbSJHNwG>; Tue, 8 Oct 2002 09:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSJHNvv>; Tue, 8 Oct 2002 09:51:51 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:59540 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263219AbSJHNvU>;
	Tue, 8 Oct 2002 09:51:20 -0400
Date: Tue, 8 Oct 2002 15:56:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - BK Merge patch [16/23]
Message-ID: <20021008155651.O18546@ucw.cz>
References: <20021008154415.E18546@ucw.cz> <20021008154549.F18546@ucw.cz> <20021008154631.G18546@ucw.cz> <20021008154733.H18546@ucw.cz> <20021008154824.I18546@ucw.cz> <20021008154904.J18546@ucw.cz> <20021008155003.K18546@ucw.cz> <20021008155045.L18546@ucw.cz> <20021008155125.M18546@ucw.cz> <20021008155236.N18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008155236.N18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:52:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.50, 2002-10-07 10:34:15+02:00, vojtech@suse.cz
  Merge suse.cz:/home/vojtech/bk/linus into suse.cz:/home/vojtech/bk/input


 keyboard/atkbd.c |    2 +-
 mouse/psmouse.c  |   46 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 9 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:25:53 2002
+++ b/drivers/input/keyboard/atkbd.c	Tue Oct  8 15:25:53 2002
@@ -17,7 +17,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/serio.h>
-#include <linux/tqueue.h>
+#include <linux/workqueue.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
diff -Nru a/drivers/input/mouse/psmouse.c b/drivers/input/mouse/psmouse.c
--- a/drivers/input/mouse/psmouse.c	Tue Oct  8 15:25:53 2002
+++ b/drivers/input/mouse/psmouse.c	Tue Oct  8 15:25:53 2002
@@ -20,8 +20,11 @@
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("PS/2 mouse driver");
+MODULE_PARM(psmouse_noext, "1i");
 MODULE_LICENSE("GPL");
 
+static int psmouse_noext;
+
 #define PSMOUSE_CMD_SETSCALE11	0x00e6
 #define PSMOUSE_CMD_SETRES	0x10e8
 #define PSMOUSE_CMD_GETINFO	0x03e9
@@ -32,6 +35,7 @@
 #define PSMOUSE_CMD_SETRATE	0x10f3
 #define PSMOUSE_CMD_ENABLE	0x00f4
 #define PSMOUSE_CMD_RESET_DIS	0x00f6
+#define PSMOUSE_CMD_RESET_BAT	0x02ff
 
 #define PSMOUSE_RET_BAT		0xaa
 #define PSMOUSE_RET_ACK		0xfa
@@ -220,7 +224,11 @@
 	psmouse->ack = 0;
 	psmouse->acking = 1;
 
-	serio_write(psmouse->serio, byte);
+	if (serio_write(psmouse->serio, byte)) {
+		psmouse->acking = 0;
+		return -1;
+	}
+
 	while (!psmouse->ack && timeout--) udelay(10);
 
 	return -(psmouse->ack <= 0);
@@ -300,6 +308,9 @@
 	psmouse->name = "Mouse";
 	psmouse->model = 0;
 
+	if (psmouse_noext)
+		return PSMOUSE_PS2;
+
 /*
  * Try Genius NetMouse magic init.
  */
@@ -336,8 +347,8 @@
 	if (param[1]) {
 
 		int i;
-		static int logitech_4btn[] = { 12, 40, 41, 42, 43, 73, 80, -1 };
-		static int logitech_wheel[] = { 75, 76, 80, 81, 83, 88, -1 };
+		static int logitech_4btn[] = { 12, 40, 41, 42, 43, 52, 73, 80, -1 };
+		static int logitech_wheel[] = { 52, 75, 76, 80, 81, 83, 88, -1 };
 		static int logitech_ps2pp[] = { 12, 13, 40, 41, 42, 43, 50, 51, 52, 53, 73, 75,
 							76, 80, 81, 83, 88, 96, 97, -1 };
 		psmouse->vendor = "Logitech";
@@ -527,15 +538,24 @@
  * Last, we enable the mouse so that we get reports from it.
  */
 
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE)) {
+	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_ENABLE))
 		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n", psmouse->serio->phys);
-	}
 
 }
 
 /*
- * psmouse_disconnect() cleans up after we don't want talk
- * to the mouse anymore.
+ * psmouse_cleanup() resets the mouse into power-on state.
+ */
+
+static void psmouse_cleanup(struct serio *serio)
+{
+	struct psmouse *psmouse = serio->private;
+	unsigned char param[2];
+	psmouse_command(psmouse, param, PSMOUSE_CMD_RESET_BAT);
+}
+
+/*
+ * psmouse_disconnect() closes and frees.
  */
 
 static void psmouse_disconnect(struct serio *serio)
@@ -605,8 +625,18 @@
 static struct serio_dev psmouse_dev = {
 	.interrupt =	psmouse_interrupt,
 	.connect =	psmouse_connect,
-	.disconnect =	psmouse_disconnect
+	.disconnect =	psmouse_disconnect,
+	.cleanup =	psmouse_cleanup,
 };
+
+#ifndef MODULE
+static int __init psmouse_setup(char *str)
+{
+	psmouse_noext = 1;
+	return 1;
+}
+__setup("psmouse_noext", psmouse_setup);
+#endif
 
 int __init psmouse_init(void)
 {

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.50
## Wrapped with gzip_uu ##


begin 664 bkpatch18038
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
*_"\+$WY=-R``````
`
end
