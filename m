Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284393AbRLXDTZ>; Sun, 23 Dec 2001 22:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284370AbRLXDTQ>; Sun, 23 Dec 2001 22:19:16 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:50442 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S284366AbRLXDTK>; Sun, 23 Dec 2001 22:19:10 -0500
Date: Mon, 24 Dec 2001 03:16:19 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Mailing List - sparclinux <sparclinux@vger.kernel.org>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.17 drivers/sbus/char/zs.c
Message-ID: <Pine.LNX.4.33.0112240308100.9228-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of my preparations for writing a driver for the Magma high speed
communication SBus cards on SPARCstations, I have modified zs.c in
drivers/sbus/char to add in the missing /proc/tty/driver/serial entry.
I've learned a lot, hope this patch is useful. Notice that it doesn't yet
implement tx and rx counters, as the driver doesn't keep track, presumably
to keep it fast as possible.

--- linux-2.4.17/drivers/sbus/char/zs.c.orig	Mon Dec 24 01:04:03 2001
+++ linux-2.4.17/drivers/sbus/char/zs.c	Mon Dec 24 02:56:01 2001
@@ -7,6 +7,10 @@
  *
  * Fixed to use tty_get_baud_rate().
  *   Theodore Ts'o <tytso@mit.edu>, 2001-Oct-12
+ *
+ * /proc/tty/driver/serial now exists and is readable.
+ *   Alex Buell <alex.buell@tahallah.demon.co.uk>, 2001-12-23
+ *
  */

 #include <linux/errno.h>
@@ -1699,6 +1703,81 @@
 }

 /*
+ *
+ * line_info - returns information about each channel
+ *
+ */
+static inline int line_info(char *buf, struct sun_serial *info)
+{
+	unsigned char status;
+	char stat_buf[30];
+	int ret;
+
+	ret = sprintf(buf, "%d: uart:Zilog8530 port:%x irq:%d",
+		info->line, info->port, info->irq);
+
+	cli();
+	status = sbus_readb(&info->zs_channel->control);
+	ZSDELAY();
+	ZSLOG(REGCTRL, status, 0);
+	sti();
+
+	stat_buf[0] = 0;
+	stat_buf[1] = 0;
+	if (info->curregs[5] & RTS)
+		strcat(stat_buf, "|RTS");
+	if (status & CTS)
+		strcat(stat_buf, "|CTS");
+	if (info->curregs[5] & DTR)
+		strcat(stat_buf, "|DTR");
+	if (status & SYNC)
+		strcat(stat_buf, "|DSR");
+	if (status & DCD)
+		strcat(stat_buf, "|CD");
+
+	ret += sprintf(buf + ret, " baud:%d %s\n", info->zs_baud, stat_buf + 1);
+	return ret;
+}
+
+/*
+ *
+ * zs_read_proc() - called when /proc/tty/driver/serial is read.
+ *
+ */
+int zs_read_proc(char *page, char **start, off_t off, int count,
+                 int *eof, void *data)
+{
+	char *revision = "$Revision: 1.68 $";
+	char *version, *p;
+	int i, len = 0, l;
+	off_t begin = 0;
+
+	version = strchr(revision, ' ');
+	p = strchr(++version, ' ');
+	*p = '\0';
+	len += sprintf(page, "serinfo:1.0 driver:%s\n", version);
+	*p = ' ';
+
+	for (i = 0; i < NUM_CHANNELS && len < 4000; i++) {
+		l = line_info(page + len, &zs_soft[i]);
+		len += l;
+		if (len+begin > off+count)
+			goto done;
+		if (len+begin < off) {
+			begin += len;
+			len = 0;
+		}
+	}
+
+	*eof = 1;
+done:
+	if (off >= len+begin)
+		return 0;
+	*start = page + (off-begin);
+	return ((count < begin+len-off) ? count : begin+len-off);
+}
+
+/*
  * ------------------------------------------------------------
  * zs_open() and friends
  * ------------------------------------------------------------
@@ -2444,8 +2523,8 @@
 	serial_driver.hangup = zs_hangup;

 	/* I'm too lazy, someone write versions of this for us. -DaveM */
-	serial_driver.read_proc = 0;
-	serial_driver.proc_entry = 0;
+	/* I just did. :-) -AIB 2001-12-23 */
+	serial_driver.read_proc = zs_read_proc;

 	/*
 	 * The callout device is just like normal device except for
@@ -2454,7 +2533,9 @@
 	callout_driver = serial_driver;
 	callout_driver.name = "cua/%d";
 	callout_driver.major = TTYAUX_MAJOR;
-	callout_driver.subtype = SERIAL_TYPE_CALLOUT;
+	callout_driver.subtype = SERIAL_TYPE_CALLOUT;
+	callout_driver.read_proc = 0;
+	callout_driver.proc_entry = 0;

 	if (tty_register_driver(&serial_driver))
 		panic("Couldn't register serial driver\n");


-- 
A big red heart, that's me!

http://www.tahallah.demon.co.uk (updated)

