Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317533AbSGFIJ7>; Sat, 6 Jul 2002 04:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317538AbSGFIJ6>; Sat, 6 Jul 2002 04:09:58 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:25566 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317533AbSGFIJ4>; Sat, 6 Jul 2002 04:09:56 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.25 no source for joydump
Date: Sat, 6 Jul 2002 18:08:55 +1000
User-Agent: KMail/1.4.5
Cc: torvalds@transmeta.com, vojtech@twilight.ucw.cz
References: <28763.1025936055@ocs3.intra.ocs.com.au>
In-Reply-To: <28763.1025936055@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_VMITCP3ZCZ7AHCWOLZK4"
Message-Id: <200207061808.55345.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_VMITCP3ZCZ7AHCWOLZK4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Sat, 6 Jul 2002 16:14, Keith Owens wrote:
> There is no source for joydump.  Detected by kbuild 2.5, not detected
> by the existing build system.
>
> Index: 25.1/drivers/input/joystick/Makefile
> --- 25.1/drivers/input/joystick/Makefile Sat, 06 Jul 2002 13:37:55 +1000
> kaos (linux-2.5/V/d/23_Makefile 1.3 444) +++
<snip>
Or you could add the driver. Attached.

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
--------------Boundary-00=_VMITCP3ZCZ7AHCWOLZK4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="joydump-add.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="joydump-add.patch"

diff -Naur -X dontdiff linux-2.5.25-clean/drivers/input/joystick/Config.help linux-2.5.25-joydump/drivers/input/joystick/Config.help
--- linux-2.5.25-clean/drivers/input/joystick/Config.help	Sat Jul  6 09:42:03 2002
+++ linux-2.5.25-joydump/drivers/input/joystick/Config.help	Sat Jul  6 17:40:27 2002
@@ -221,3 +221,12 @@
   The module will be called joy-amiga.o. If you want to compile it as
   a module, say M here and read <file:Documentation/modules.txt>.
 
+CONFIG_INPUT_JOYDUMP
+  Say Y here if you want to dump data from your joystick into the system
+  log for debugging purposes. Say N if you are making a production
+  configuration or aren't sure. 
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called joydump.o. If you want to compile it as
+  a module, say M here and read <file:Documentation/modules.txt>.
diff -Naur -X dontdiff linux-2.5.25-clean/drivers/input/joystick/Config.in linux-2.5.25-joydump/drivers/input/joystick/Config.in
--- linux-2.5.25-clean/drivers/input/joystick/Config.in	Sat Jul  6 09:42:33 2002
+++ linux-2.5.25-joydump/drivers/input/joystick/Config.in	Sat Jul  6 17:35:37 2002
@@ -31,3 +31,5 @@
 if [ "$CONFIG_AMIGA" = "y" ]; then
    dep_tristate '  Amiga joysticks' CONFIG_JOYSTICK_AMIJOY $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK
 fi
+
+dep_tristate '  Gameport data dumper' CONFIG_INPUT_JOYDUMP $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK
diff -Naur -X dontdiff linux-2.5.25-clean/drivers/input/joystick/joydump.c linux-2.5.25-joydump/drivers/input/joystick/joydump.c
--- linux-2.5.25-clean/drivers/input/joystick/joydump.c	Thu Jan  1 10:00:00 1970
+++ linux-2.5.25-joydump/drivers/input/joystick/joydump.c	Sat Jul  6 17:41:32 2002
@@ -0,0 +1,152 @@
+/*
+ * $Id: joydump.c,v 1.1 2002/01/23 06:56:16 jsimmons Exp $
+ *
+ *  Copyright (c) 1996-2001 Vojtech Pavlik
+ */
+
+/*
+ * This is just a very simple driver that can dump the data
+ * out of the joystick port into the syslog ...
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or 
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * 
+ * Should you need to contact me, the author, you can do so either by
+ * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
+ * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ */
+
+#include <linux/module.h>
+#include <linux/gameport.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
+MODULE_DESCRIPTION("Gameport data dumper module");
+MODULE_LICENSE("GPL");
+
+#define BUF_SIZE 256
+
+struct joydump {
+	unsigned int time;
+	unsigned char data;
+};
+
+static void __devinit joydump_connect(struct gameport *gameport, struct gameport_dev *dev)
+{
+	struct joydump buf[BUF_SIZE];
+	int axes[4], buttons;
+	int i, j, t, timeout;
+	unsigned long flags;
+	unsigned char u;
+
+	printk(KERN_INFO "joydump: ,------------------- START ------------------.\n");
+	printk(KERN_INFO "joydump: | Dumping gameport%s.\n", gameport->phys);
+	printk(KERN_INFO "joydump: | Speed: %4d kHz.                            |\n", gameport->speed);
+
+	if (gameport_open(gameport, dev, GAMEPORT_MODE_RAW)) {
+
+		printk(KERN_INFO "joydump: | Raw mode not available - trying cooked.    |\n");
+
+		if (gameport_open(gameport, dev, GAMEPORT_MODE_COOKED)) {
+			
+			printk(KERN_INFO "joydump: | Cooked not available either. Failing.      |\n");
+			printk(KERN_INFO "joydump: `-------------------- END -------------------'\n");
+			return;
+		}
+
+		gameport_cooked_read(gameport, axes, &buttons);
+
+		for (i = 0; i < 4; i++)
+			printk(KERN_INFO "joydump: | Axis %d: %4d.                              |\n", i, axes[i]);
+		printk(KERN_INFO "joydump: | Buttons %02x.                                |\n", buttons);
+		printk(KERN_INFO "joydump: `-------------------- END -------------------'\n");
+	}
+
+	timeout = gameport_time(gameport, 10000); /* 10 ms */
+	t = 0;
+	i = 1;
+
+	save_flags(flags);
+	cli();
+
+	u = gameport_read(gameport);
+
+	buf[0].data = u;
+	buf[0].time = t;
+
+	gameport_trigger(gameport);
+
+	while (i < BUF_SIZE && t < timeout) {
+
+		buf[i].data = gameport_read(gameport);
+
+		if (buf[i].data ^ u) {
+			u = buf[i].data;
+			buf[i].time = t;
+			i++;
+		}
+		t++;
+	}
+
+	restore_flags(flags);
+
+/*
+ * Dump data.
+ */
+
+	t = i;
+
+	printk(KERN_INFO "joydump: >------------------- DATA -------------------<\n");
+	printk(KERN_INFO "joydump: | index: %3d delta: %3d.%02d us data: ", 0, 0, 0);
+	for (j = 7; j >= 0; j--)
+		printk("%d",(buf[0].data >> j) & 1);
+	printk(" |\n");
+	for (i = 1; i < t; i++) {
+		printk(KERN_INFO "joydump: | index: %3d delta: %3d us data: ",
+			i, buf[i].time - buf[i-1].time);
+		for (j = 7; j >= 0; j--)
+			printk("%d",(buf[i].data >> j) & 1);
+		printk("    |\n");
+	}
+
+	printk(KERN_INFO "joydump: `-------------------- END -------------------'\n");
+}
+
+static void __devexit joydump_disconnect(struct gameport *gameport)
+{
+	gameport_close(gameport);
+}
+
+static struct gameport_dev joydump_dev = {
+	connect:	joydump_connect,
+	disconnect:	joydump_disconnect,
+};
+
+static int __init joydump_init(void)
+{
+	gameport_register_device(&joydump_dev);
+	return 0;
+}
+
+static void __exit joydump_exit(void)
+{
+	gameport_unregister_device(&joydump_dev);
+}
+
+module_init(joydump_init);
+module_exit(joydump_exit);

--------------Boundary-00=_VMITCP3ZCZ7AHCWOLZK4--

