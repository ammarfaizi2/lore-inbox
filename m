Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVBHQq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVBHQq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVBHQq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:46:57 -0500
Received: from styx.suse.cz ([82.119.242.94]:4817 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261584AbVBHQl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:41:28 -0500
Date: Tue, 8 Feb 2005 17:42:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: [RFC/RFT] [patch] Elo serial touchscreen driver
Message-ID: <20050208164227.GA9790@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I've written a driver for probably the most common touchscreen type -
the serial Elo touchscreen.

The driver should handle all generations of serial Elos, as it handles
Elo 10-byte, 6-byte, 4-byte and 3-byte protocols.

I do not have any touchscreen, so I can't test the driver myself.

So if you have the time, please comment on the code of the patch,
and if you have an Elo, please try the driver with it.

Patch attached, also attached is an uptodate version of inputattach, a
program needed to get the kernel to talk to the device.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=elotouch

ChangeSet@1.2140, 2005-02-08 17:18:38+01:00, vojtech@suse.cz
  input: Add support for serial ELO touchscreens, including
         Elo IntelliTouch, AccuTouch and SecureTouch.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 drivers/input/touchscreen/Kconfig  |   13 +
 drivers/input/touchscreen/Makefile |    1 
 drivers/input/touchscreen/elo.c    |  315 +++++++++++++++++++++++++++++++++++++
 include/linux/serio.h              |    1 
 4 files changed, 330 insertions(+)


diff -Nru a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
--- a/drivers/input/touchscreen/Kconfig	2005-02-08 17:18:52 +01:00
+++ b/drivers/input/touchscreen/Kconfig	2005-02-08 17:18:52 +01:00
@@ -48,6 +48,19 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called gunze.
 
+config TOUCHSCREEN_ELO
+	tristate "Elo serial touchscreens"
+	select SERIO
+	help
+	  Say Y here if you have an Elo serial touchscreen connected to
+	  your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gunze.
+
+
 config TOUCHSCREEN_MK712
 	tristate "ICS MicroClock MK712 touchscreen"
 	help
diff -Nru a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
--- a/drivers/input/touchscreen/Makefile	2005-02-08 17:18:52 +01:00
+++ b/drivers/input/touchscreen/Makefile	2005-02-08 17:18:52 +01:00
@@ -7,4 +7,5 @@
 obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_CORGI)	+= corgi_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
+obj-$(CONFIG_TOUCHSCREEN_ELO)	+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_MK712)	+= mk712.o
diff -Nru a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen/elo.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/input/touchscreen/elo.c	2005-02-08 17:18:52 +01:00
@@ -0,0 +1,315 @@
+/*
+ * Elo serial touchscreen driver
+ *
+ * Copyright (c) 2004 Vojtech Pavlik
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+/*
+ * This driver can handle serial Elo touchscreens using either the Elo standard
+ * 'E271-2210' 10-byte protocol, Elo legacy 'E281A-4002' 6-byte protocol, Elo
+ * legacy 'E271-140' 4-byte protocol and Elo legacy 'E261-280' 3-byte protocol.
+ */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/init.h>
+
+#define DRIVER_DESC	"Elo serial touchscreen driver"
+
+MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+/*
+ * Definitions & global arrays.
+ */
+
+#define	ELO_MAX_LENGTH	10
+
+static char *elo_name = "Elo Serial TouchScreen";
+
+/*
+ * Per-touchscreen data.
+ */
+
+struct elo {
+	struct input_dev dev;
+	struct serio *serio;
+	int id;
+	int idx;
+	unsigned char csum;
+	unsigned char data[ELO_MAX_LENGTH];
+	char phys[32];
+};
+
+static void elo_process_data_10(struct elo* elo, unsigned char data, struct pt_regs *regs)
+{
+	struct input_dev *dev = &elo->dev;
+
+	elo->csum += elo->data[elo->idx] = data;
+
+	switch (elo->idx++) {
+
+		case 0:
+			if (data != 'U') {
+				elo->idx = 0;
+				elo->csum = 0;
+			}
+			break;
+
+		case 1:
+			if (data != 'T') {
+				elo->idx = 0;
+				elo->csum = 0;
+			}
+			break;
+
+		case 9:
+			if (elo->csum) {
+				input_regs(dev, regs);
+				input_report_abs(dev, ABS_X, (elo->data[4] << 8) | elo->data[3]);
+				input_report_abs(dev, ABS_Y, (elo->data[6] << 8) | elo->data[5]);
+				input_report_abs(dev, ABS_PRESSURE, (elo->data[8] << 8) | elo->data[7]);
+				input_report_key(dev, BTN_TOUCH, elo->data[8] || elo->data[7]);
+				input_sync(dev);
+			}
+			elo->idx = 0;
+			elo->csum = 0;
+			break;
+	}
+}
+
+static void elo_process_data_6(struct elo* elo, unsigned char data, struct pt_regs *regs)
+{
+	struct input_dev *dev = &elo->dev;
+
+	elo->data[elo->idx] = data;
+
+	switch (elo->idx++) {
+
+		case 0: if ((data & 0xc0) != 0xc0) elo->idx = 0; break;
+		case 1: if ((data & 0xc0) != 0x80) elo->idx = 0; break;
+		case 2: if ((data & 0xc0) != 0x40) elo->idx = 0; break;
+
+		case 3:
+			if (data & 0xc0) {
+				elo->idx = 0;
+				break;
+			}
+
+			input_regs(dev, regs);
+			input_report_abs(dev, ABS_X, ((elo->data[0] & 0x3f) << 6) | (elo->data[1] & 0x3f));
+			input_report_abs(dev, ABS_Y, ((elo->data[2] & 0x3f) << 6) | (elo->data[3] & 0x3f));
+
+			if (elo->id == 2) {
+				input_report_key(dev, BTN_TOUCH, 1);
+				input_sync(dev);
+				elo->idx = 0;
+			}
+
+			break;
+
+		case 4:
+			if (data) {
+				input_sync(dev);
+				elo->idx = 0;
+			}
+			break;
+
+		case 5:
+			if ((data & 0xf0) == 0) {
+				input_report_abs(dev, ABS_PRESSURE, elo->data[5]);
+				input_report_key(dev, BTN_TOUCH, !!elo->data[5]);
+			}
+			input_sync(dev);
+			elo->idx = 0;
+			break;
+	}
+}
+
+static void elo_process_data_3(struct elo* elo, unsigned char data, struct pt_regs *regs)
+{
+	struct input_dev *dev = &elo->dev;
+
+	elo->data[elo->idx] = data;
+
+	switch (elo->idx++) {
+
+		case 0:
+			if ((data & 0x7f) != 0x01)
+				elo->idx = 0;
+			break;
+		case 2:
+			input_regs(dev, regs);
+			input_report_key(dev, BTN_TOUCH, !(elo->data[1] & 0x80));
+			input_report_abs(dev, ABS_X, elo->data[1]);
+			input_report_abs(dev, ABS_Y, elo->data[2]);
+			input_sync(dev);
+			elo->idx = 0;
+			break;
+	}
+}
+
+static irqreturn_t elo_interrupt(struct serio *serio,
+		unsigned char data, unsigned int flags, struct pt_regs *regs)
+{
+	struct elo* elo = serio_get_drvdata(serio);
+
+	switch(elo->id) {
+		case 0:
+			elo_process_data_10(elo, data, regs);
+			break;
+
+		case 1:
+		case 2:
+			elo_process_data_6(elo, data, regs);
+			break;
+
+		case 3:
+			elo_process_data_3(elo, data, regs);
+			break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * elo_disconnect() is the opposite of elo_connect()
+ */
+
+static void elo_disconnect(struct serio *serio)
+{
+	struct elo* elo = serio_get_drvdata(serio);
+
+	input_unregister_device(&elo->dev);
+	serio_close(serio);
+	serio_set_drvdata(serio, NULL);
+	kfree(elo);
+}
+
+/*
+ * elo_connect() is the routine that is called when someone adds a
+ * new serio device that supports Gunze protocol and registers it as
+ * an input device.
+ */
+
+static int elo_connect(struct serio *serio, struct serio_driver *drv)
+{
+	struct elo *elo;
+	int err;
+
+	if (!(elo = kmalloc(sizeof(struct elo), GFP_KERNEL)))
+		return -ENOMEM;
+
+	memset(elo, 0, sizeof(struct elo));
+
+	init_input_dev(&elo->dev);
+	elo->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	elo->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+
+	elo->id = serio->id.id;
+
+	switch (elo->id) {
+
+		case 0: /* 10-byte protocol */
+			input_set_abs_params(&elo->dev, ABS_X, 96, 4000, 0, 0);
+			input_set_abs_params(&elo->dev, ABS_Y, 96, 4000, 0, 0);
+			input_set_abs_params(&elo->dev, ABS_PRESSURE, 0, 255, 0, 0);
+			break;
+		
+		case 1: /* 6-byte protocol */
+			input_set_abs_params(&elo->dev, ABS_PRESSURE, 0, 15, 0, 0);
+
+		case 2: /* 4-byte protocol */
+			input_set_abs_params(&elo->dev, ABS_X, 96, 4000, 0, 0);
+			input_set_abs_params(&elo->dev, ABS_Y, 96, 4000, 0, 0);
+			break;
+
+		case 3: /* 3-byte protocol */
+			input_set_abs_params(&elo->dev, ABS_X, 0, 255, 0, 0);
+			input_set_abs_params(&elo->dev, ABS_Y, 0, 255, 0, 0);
+			break;
+	}
+
+	elo->serio = serio;
+
+	sprintf(elo->phys, "%s/input0", serio->phys);
+
+	elo->dev.private = elo;
+	elo->dev.name = elo_name;
+	elo->dev.phys = elo->phys;
+	elo->dev.id.bustype = BUS_RS232;
+	elo->dev.id.vendor = SERIO_ELO;
+	elo->dev.id.product = elo->id;
+	elo->dev.id.version = 0x0100;
+
+	serio_set_drvdata(serio, elo);
+
+	err = serio_open(serio, drv);
+	if (err) {
+		serio_set_drvdata(serio, NULL);
+		kfree(elo);
+		return err;
+	}
+
+	input_register_device(&elo->dev);
+
+	printk(KERN_INFO "input: %s on %s\n", elo_name, serio->phys);
+
+	return 0;
+}
+
+/*
+ * The serio driver structure.
+ */
+
+static struct serio_device_id elo_serio_ids[] = {
+	{
+		.type	= SERIO_RS232,
+		.proto	= SERIO_ELO,
+		.id	= SERIO_ANY,
+		.extra	= SERIO_ANY,
+	},
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(serio, elo_serio_ids);
+
+static struct serio_driver elo_drv = {
+	.driver		= {
+		.name	= "elo",
+	},
+	.description	= DRIVER_DESC,
+	.id_table	= elo_serio_ids,
+	.interrupt	= elo_interrupt,
+	.connect	= elo_connect,
+	.disconnect	= elo_disconnect,
+};
+
+/*
+ * The functions for inserting/removing us as a module.
+ */
+
+static int __init elo_init(void)
+{
+	serio_register_driver(&elo_drv);
+	return 0;
+}
+
+static void __exit elo_exit(void)
+{
+	serio_unregister_driver(&elo_drv);
+}
+
+module_init(elo_init);
+module_exit(elo_exit);
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2005-02-08 17:18:52 +01:00
+++ b/include/linux/serio.h	2005-02-08 17:18:52 +01:00
@@ -216,5 +216,6 @@
 #define SERIO_SNES232	0x26
 #define SERIO_SEMTECH	0x27
 #define SERIO_LKKBD	0x28
+#define SERIO_ELO	0x29
 
 #endif

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=serio-compile

ChangeSet@1.2141, 2005-02-08 17:37:12+01:00, vojtech@suse.cz
  input: Move #include <linux/interrupt.h> inside #ifdef __KERNEL__
         in serio.h, to make it userspace-compilable.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 serio.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2005-02-08 17:41:41 +01:00
+++ b/include/linux/serio.h	2005-02-08 17:41:41 +01:00
@@ -10,12 +10,12 @@
  */
 
 #include <linux/ioctl.h>
-#include <linux/interrupt.h>
 
 #define SPIOCSTYPE	_IOW('q', 0x01, unsigned long)
 
 #ifdef __KERNEL__
 
+#include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inputattach.c"

/*
 * $Id: inputattach.c,v 1.22 2005/02/06 13:49:09 vojtech Exp $
 *
 *  Copyright (c) 1999-2000 Vojtech Pavlik
 *
 *  Sponsored by SuSE
 *
 *  Twiddler support Copyright (c) 2001 Arndt Schoenewald
 *  Sponsored by Quelltext AG (http://www.quelltext-ag.de), Dortmund, Germany
 */

/*
 * Input line discipline attach program
 */

/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or 
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 * 
 * Should you need to contact me, the author, you can do so either by
 * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
 * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
 */

#include <linux/serio.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/time.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <termios.h>
#include <string.h>
#include <assert.h>
#include <ctype.h>

int readchar(int fd, unsigned char *c, int timeout)
{
	struct timeval tv;
	fd_set set;
	
	tv.tv_sec = 0;
	tv.tv_usec = timeout * 1000;

	FD_ZERO(&set);
	FD_SET(fd, &set);

	if (!select(fd+1, &set, NULL, NULL, &tv)) return -1;
	if (read(fd, c, 1) != 1) return -1;

	return 0;
}



void setline(int fd, int flags, int speed)
{
	struct termios t;

	tcgetattr(fd, &t);

	t.c_cflag = flags | CREAD | HUPCL | CLOCAL;
	t.c_iflag = IGNBRK | IGNPAR;
	t.c_oflag = 0;
	t.c_lflag = 0;
	t.c_cc[VMIN ] = 1;
	t.c_cc[VTIME] = 0;

	cfsetispeed(&t, speed);
	cfsetospeed(&t, speed);

	tcsetattr(fd, TCSANOW, &t);
}

int logitech_command(int fd, char *c)
{
	int i;
	unsigned char d;
	for (i = 0; c[i]; i++) {
		write(fd, c + i, 1);
		if (readchar(fd, &d, 1000))
			return -1;
		if (c[i] != d)
			return -1;
	}
	return 0;
}

int magellan_init(int fd, long *id, long *extra)
{
	write(fd, "m3\rpBB\rz\r", 9);
	return 0;
}

int warrior_init(int fd, long *id, long *extra)
{
	if (logitech_command(fd, "*S")) return -1;
	setline(fd, CS8, B4800);
	return 0;
}

int spaceball_waitchar(int fd, unsigned char c, unsigned char *d, int timeout)
{
	unsigned char b = 0;

	while (!readchar(fd, &b, timeout)) {
		if (b == 0x0a) continue;
		*d++ = b;
		if (b == c) break;
	}

	*d = 0;

	return -(b != c);
}

int spaceball_waitcmd(int fd, char c, char *d)
{
	int i;

	for (i = 0; i < 8; i++) {
		if (spaceball_waitchar(fd, 0x0d, d, 1000))
			return -1;
		if (d[0] == c)
			return 0;
	}

	return -1;
}

int spaceball_cmd(int fd, char *c, char *d)
{
	int i;

	for (i = 0; c[i]; i++)
		write(fd, c + i, 1);
	write(fd, "\r", 1);

	i = spaceball_waitcmd(fd, toupper(c[0]), d);

	return i;
}

#define SPACEBALL_1003		1
#define SPACEBALL_2003B		3
#define SPACEBALL_2003C		4
#define SPACEBALL_3003C		7
#define SPACEBALL_4000FLX	8
#define SPACEBALL_4000FLX_L 	9

int spaceball_init(int fd, long *id, long *extra)
{
	char r[64];

	if (spaceball_waitchar(fd, 0x11, r, 4000) ||
	    spaceball_waitchar(fd, 0x0d, r, 1000))
		return -1;

	if (spaceball_waitcmd(fd, '@', r))
		return -1; 

	if (strncmp("@1 Spaceball alive", r, 18))
		return -1;

	if (spaceball_waitcmd(fd, '@', r))
		return -1; 

	if (spaceball_cmd(fd, "hm", r))
		return -1;

	if (!strncmp("Hm2003B", r, 7))
		*id = SPACEBALL_2003B;
	if (!strncmp("Hm2003C", r, 7))
		*id = SPACEBALL_2003C;
	if (!strncmp("Hm3003C", r, 7))
		*id = SPACEBALL_3003C;

	if (!strncmp("HvFirmware", r, 10)) {

		if (spaceball_cmd(fd, "\"", r))
			return -1;

		if (strncmp("\"1 Spaceball 4000 FLX", r, 21))
			return -1;

		if (spaceball_waitcmd(fd, '"', r))
			return -1; 

		if (strstr(r, " L "))
			*id = SPACEBALL_4000FLX_L;
		else
			*id = SPACEBALL_4000FLX;

		if (spaceball_waitcmd(fd, '"', r))
			return -1; 

		if (spaceball_cmd(fd, "YS", r))
        	        return -1;

		if (spaceball_cmd(fd, "M", r))
        	        return -1;

		return 0;
	}

	if (spaceball_cmd(fd, "P@A@A", r) ||
	    spaceball_cmd(fd, "FT@", r)   ||
	    spaceball_cmd(fd, "MSS", r))
		return -1;

	return 0;
}

int stinger_init(int fd, long *id, long *extra)
{
	int i;
	unsigned char c;
	unsigned char *response = "\r\n0600520058C272";

	if (write(fd, " E5E5", 5) != 5)		/* Enable command */
		return -1; 

	for (i = 0; i < 16; i++)		/* Check for Stinger */
		if (readchar(fd, &c, 200) || (c != response[i])) 
			return -1;

	return 0;
}

int mzp_init(int fd, long *id, long *extra)
{
	if (logitech_command(fd, "*X*q")) return -1;
	setline(fd, CS8, B9600);
	return 0;
}

int newton_init(int fd, long *id, long *extra)
{
  int i;
  unsigned char c;
  unsigned char response[35] =
  { 0x16, 0x10, 0x02, 0x64, 0x5f, 0x69, 0x64, 0x00,
    0x00, 0x00, 0x0c, 0x6b, 0x79, 0x62, 0x64, 0x61,
    0x70, 0x70, 0x6c, 0x00, 0x00, 0x00, 0x01, 0x6e,
    0x6f, 0x66, 0x6d, 0x00, 0x00, 0x00, 0x00, 0x10,
    0x03, 0xdd, 0xe7 };

  for (i = 0; i < 35; i++)
    if (readchar(fd, &c, 400) || (c != response[i]))
      return -1;

  return 0;
}

int twiddler_init(int fd, long *id, long *extra)
{
	unsigned char c[10];
	int count, line;

	/* Turn DTR off, otherwise the Twiddler won't send any data. */
	if (ioctl(fd, TIOCMGET, &line)) return -1;
	line &= ~TIOCM_DTR;
	if (ioctl(fd, TIOCMSET, &line)) return -1;

	/* Check whether the device on the serial line is the Twiddler.
	 *
	 * The Twiddler sends data packets of 5 bytes which have the following
	 * properties: the MSB is 0 on the first and 1 on all other bytes, and
	 * the high order nibble of the last byte is always 0x8.
	 *
	 * We read and check two of those 5 byte packets to be sure that we
	 * are indeed talking to a Twiddler. */

	/* Read at most 5 bytes until we find one with the MSB set to 0 */
	for (count = 0; count < 5; count++) {
		if (readchar(fd, c+0, 500)) return -1;
		if ((c[0] & 0x80) == 0) break;
	}

	if (count == 5) {
		/* Could not find header byte in data stream */
		return -1;
	}

	/* Read remaining 4 bytes plus the full next data packet */
	for (count = 1; count < 10; count++) {
		if (readchar(fd, c+count, 500)) return -1;
	}

	/* Check whether the bytes of both data packets obey the rules */
	for (count = 1; count < 10; count++) {
		if ((count % 5 == 0 && (c[count] & 0x80) != 0)
		    || (count % 5 == 4 && (c[count] & 0xF0) != 0x80)
		    || (count % 5 != 0 && (c[count] & 0x80) != 0x80)) {
		    	/* Invalid byte in data packet */
			return -1;
		}
	}

	return 0;
}

int dump_init(int fd, long *id, long *extra)
{
	unsigned char c, o = 0;

	c = 0x80;

	if (write(fd, &c, 1) != 1)         /* Enable command */
                return -1;

	while (1)
		if (!readchar(fd, &c, 1)) {
			printf("%02x (%c) ", c, ((c > 32) && (c < 127)) ? c : 'x');
			o = 1;
		} else {
			if (o) {
				printf("\n");
				o = 0;
			}
		}
}

struct input_types {
	char name[16];
	char name2[16];
	int speed;
	int flags;
	unsigned long type;
	unsigned long id;
	unsigned long extra;
	int flush;
	int (*init)(int fd, long *id, long *extra);
};

struct input_types input_types[] = {

{ "--sunkbd",		"-skb",		B1200, CS8,			SERIO_SUNKBD,	0,	0,	1,	NULL },
{ "--lkkbd",		"-lk",		B4800, CS8|CSTOPB,		SERIO_LKKBD,	0,	0,	1,	NULL },
{ "--vsxxx-aa",		"-vs",		B4800, CS8|CSTOPB|PARENB|PARODD,SERIO_VSXXXAA,	0,	0,	1,	NULL },
{ "--spaceorb",		"-orb",		B9600, CS8,			SERIO_SPACEORB,	0,	0,	1,	NULL },
{ "--spaceball",	"-sbl",		B9600, CS8,			SERIO_SPACEBALL,0,	0,	0,	spaceball_init },
{ "--magellan",		"-mag",		B9600, CS8 | CSTOPB | CRTSCTS,	SERIO_MAGELLAN,	0,	0,	1,	magellan_init },
{ "--warrior",		"-war",		B1200, CS7 | CSTOPB,		SERIO_WARRIOR,	0,	0,	1,	warrior_init },
{ "--stinger",		"-sting",	B1200, CS8,			SERIO_STINGER,	0,	0,	1,	stinger_init },
{ "--mousesystems",	"-msc",		B1200, CS8,			SERIO_MSC,	0,	0x01,	1,	NULL },
{ "--sunmouse",		"-sun",		B1200, CS8,			SERIO_SUN,	0,	0x01,	1,	NULL },
{ "--microsoft",	"-bare",	B1200, CS7,			SERIO_MS,	0,	0,	1,	NULL },
{ "--mshack",		"-ms",		B1200, CS7,			SERIO_MS,	0,	0x01,	1,	NULL },
{ "--mouseman",		"-mman",	B1200, CS7,			SERIO_MP,	0,	0x01,	1,	NULL },
{ "--intellimouse",	"-ms3",		B1200, CS7,			SERIO_MZ,	0,	0x11,	1,	NULL },
{ "--mmwheel",		"-mmw",		B1200, CS7 | CSTOPB,		SERIO_MZP,	0,	0x13,	1,	mzp_init },
{ "--iforce",		"-ifor",	B38400, CS8,			SERIO_IFORCE,	0,	0,	0,	NULL },
{ "--newtonkbd",        "-newt",        B9600, CS8,                     SERIO_NEWTON,	0,	0,	0,      newton_init },
{ "--h3600ts",          "-ipaq",     	B115200, CS8,                   SERIO_H3600,	0,	0,	0,      NULL },
{ "--stowawaykbd",      "-ipaqkbd",     B115200, CS8,                   SERIO_STOWAWAY, 0,	0,	0,      NULL },
{ "--ps2serkbd",	"-ps2ser",	B1200, CS8,			SERIO_PS2SER,	0,	0,	1,	NULL },
{ "--twiddler",		"-twid",	B2400, CS8,			SERIO_TWIDKBD,	0,	0,	0,	twiddler_init },
{ "--twiddler-joy",	"-twidjoy",	B2400, CS8,			SERIO_TWIDJOY,	0,	0,	0,	twiddler_init },
{ "--elotouch",		"-elo",		B9600, CS8 | CRTSCTS,		SERIO_ELO,	0,	0,	0,	NULL },
{ "--elo4002",		"-elo6b",	B9600, CS8 | CRTSCTS,		SERIO_ELO,	1,	0,	0,	NULL },
{ "--elo271-140",	"-elo4b",	B9600, CS8 | CRTSCTS,		SERIO_ELO,	2,	0,	0,	NULL },
{ "--elo261-280",	"-elo3b",	B9600, CS8 | CRTSCTS,		SERIO_ELO,	3,	0,	0,	NULL },
{ "--dump",		"-dump",	B2400, CS8, 			0,		0,	0,	0,	dump_init },
{ "", "", 0, 0 }

};

int main(int argc, char **argv)
{
	unsigned long devt;
	int ldisc;
        int type;
	long id, extra;
        int fd;
	char c;

        if (argc < 2 || argc > 3 || !strcmp("--help", argv[1])) {
                puts("");
                puts("Usage: inputttach <mode> <device>");
                puts("");
                puts("Modes:");
                puts("  --sunkbd        -skb   Sun Type 4 and Type 5 keyboards");
		puts("  --lkkbd         -lk    DEC LK201 / LK401 keyboards");
		puts("  --vsxxx-aa      -vs    DEC VSXXX-AA / VSXXX-GA mouse and VSXXX-AB tablet");
                puts("  --spaceorb      -orb   SpaceOrb 360 / SpaceBall Avenger");
		puts("  --spaceball     -sbl   SpaceBall 2003 / 3003 / 4000 FLX");
                puts("  --magellan      -mag   Magellan / SpaceMouse");
                puts("  --warrior       -war   WingMan Warrior");
		puts("  --stinger       -stng  Gravis Stinger");
		puts("  --mousesystems  -msc   3-button Mouse Systems mice");
		puts("  --sunmouse      -sun   3-button Sun mice");
		puts("  --microsoft     -bare  2-button Microsoft mice");
		puts("  --mshack        -ms    3-button mice in Microsoft mode");
		puts("  --mouseman      -mman  3-button Logitech and Genius mice");
		puts("  --intellimouse  -ms3   Microsoft IntelliMouse");
		puts("  --mmwheel       -mmw   Logitech mice with 4-5 buttons or wheel");
		puts("  --iforce        -ifor  I-Force joysticks and wheels");
                puts("  --h3600ts       -ipaq  Ipaq h3600 touchscreen");
		puts("  --stowawaykbd   -ipaqkbd  Stowaway keyboard");
		puts("  --ps2serkbd     -ps2ser PS/2 via serial keyboard");
		puts("  --twiddler      -twid   Handykey Twiddler chording keyboard");
		puts("  --twiddler-joy  -twidjoy  Handykey Twiddler used as a joystick");
		puts("");
                return 1;
        }

        for (type = 0; input_types[type].speed; type++) {
                if (!strncasecmp(argv[1], input_types[type].name, 16) ||
			!strncasecmp(argv[1], input_types[type].name2, 16))
                        break;
        }

	if (!input_types[type].speed) {
		fprintf(stderr, "inputattach: invalid mode\n");
		return 1;
	}

	if ((fd = open(argv[2], O_RDWR | O_NOCTTY | O_NONBLOCK)) < 0) {
		perror("inputattach");
		return 1;
	}

	setline(fd, input_types[type].flags, input_types[type].speed);

	if (input_types[type].flush)
		while (!readchar(fd, &c, 100));

	id = input_types[type].id;
	extra = input_types[type].extra;

	if (input_types[type].init && input_types[type].init(fd, &id, &extra)) {
		fprintf(stderr, "inputattach: device initialization failed\n");
		return 1;
	}

	ldisc = N_MOUSE;
	if(ioctl(fd, TIOCSETD, &ldisc)) {
		fprintf(stderr, "inputattach: can't set line discipline\n"); 
		return 1;
	}

	devt = SERIO_RS232 | input_types[type].type | (id << 8) | (extra << 16);

	if(ioctl(fd, SPIOCSTYPE, &devt)) {
		fprintf(stderr, "inputattach: can't set device type\n");
		return 1;
	}

	read(fd, NULL, 0);

	ldisc = 0;
	ioctl(fd, TIOCSETD, &ldisc);
	close(fd);

	return 0;
}

--9amGYk9869ThD9tj--
