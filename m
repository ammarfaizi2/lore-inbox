Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWINApg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWINApg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 20:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWINApg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 20:45:36 -0400
Received: from twin.jikos.cz ([213.151.79.26]:61826 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751276AbWINApf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 20:45:35 -0400
Date: Thu, 14 Sep 2006 02:44:11 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [PATCH 1/3] Synaptics - fix lockdep warnings 
In-Reply-To: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
Message-ID: <Pine.LNX.4.64.0609140239000.22181@twin.jikos.cz>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 =============================================
 [ INFO: possible recursive locking detected ]
 2.6.18-rc6-mm2-dirty #4
 ---------------------------------------------
 kseriod/140 is trying to acquire lock:
  (&ps2dev->cmd_mutex/1){--..}, at: [<c02b973b>] ps2_command+0x5b/0x3a0

 but task is already holding lock:
  (&ps2dev->cmd_mutex/1){--..}, at: [<c02b973b>] ps2_command+0x5b/0x3a0

 other info that might help us debug this:
 4 locks held by kseriod/140:
  #0:  (serio_mutex){--..}, at: [<c0367c85>] mutex_lock+0x25/0x30
  #1:  (&serio->drv_mutex){--..}, at: [<c0367c85>] mutex_lock+0x25/0x30
  #2:  (psmouse_mutex){--..}, at: [<c0367c85>] mutex_lock+0x25/0x30
  #3:  (&ps2dev->cmd_mutex/1){--..}, at: [<c02b973b>] ps2_command+0x5b/0x3a0

 stack backtrace:
  [<c01039e5>] dump_trace+0x225/0x240
  [<c0103af0>] show_trace_log_lvl+0x30/0x50
  [<c0103b38>] show_trace+0x28/0x30
  [<c0103c72>] dump_stack+0x22/0x30
  [<c0135130>] print_deadlock_bug+0xc0/0xd0
  [<c01351b2>] check_deadlock+0x72/0x80
  [<c0136a4d>] __lock_acquire+0x43d/0x990
  [<c0137468>] lock_acquire+0x68/0x80
  [<c0368003>] mutex_lock_nested+0x93/0x2e0
  [<c02b973b>] ps2_command+0x5b/0x3a0
  [<c02c03fd>] psmouse_sliced_command+0x2d/0x90
  [<c02c3cef>] synaptics_pt_write+0x2f/0x70
  [<c02b9466>] ps2_sendbyte+0x86/0x130
  [<c02b97b4>] ps2_command+0xd4/0x3a0
  [<c02c0ca9>] psmouse_probe+0x29/0xa0
  [<c02c15e2>] psmouse_connect+0x122/0x270
  [<c02b63ac>] serio_connect_driver+0x2c/0x50
  [<c02b7574>] serio_driver_probe+0x24/0x30
  [<c027c489>] really_probe+0xc9/0xf0
  [<c027c533>] driver_probe_device+0x63/0xe0
  [<c027c5c8>] __device_attach+0x18/0x20
  [<c027b607>] bus_for_each_drv+0x57/0x80
  [<c027c641>] device_attach+0x71/0x90
  [<c027b883>] bus_attach_device+0x23/0x50
  [<c0279d99>] device_add+0x219/0x390
  [<c02b7081>] serio_add_port+0x51/0x100
  [<c02b69a8>] serio_handle_event+0x78/0xa0
  [<c02b6ae3>] serio_thread+0x23/0x110
  [<c012e9c5>] kthread+0xa5/0xf0
  [<c0103703>] kernel_thread_helper+0x7/0x14

This warning has already been discussed in [1]. The substitution 
mutex_lock() for mutex_lock_nested() inside the ps2_command() is not 
enough (which already is in mainline) - as this is purely recursive 
situation (the same line of code acquires the lock twice), the 
SINGLE_DEPTH_NESTING doesn't help (as the lock is even in such case the 
same class).

The following patch fixes it. I agree that it is not the prettiest patch 
on Earth, but definitely belongs to make-lockdep-shut-up patches 
cathegory.

This arises with pass-through synaptics port, as in such situation, the 
lock is acquired twice - first for child, then for parent device. I have 
introduced respective variants of functions with _nested prefix, and let 
the synaptics pass-through port driver call them, when performing 
recursive locking for parent device.

The patch is against 2.6.18-rc6-mm2. If applicable, please apply, to get 
rid of spurious lockdep warnings.

[1] http://lkml.org/lkml/2006/7/6/191

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

diff -rup linux-2.6.18-rc6-mm2.orig/drivers/input/mouse/psmouse-base.c linux-2.6.18-rc6-mm2/drivers/input/mouse/psmouse-base.c
--- linux-2.6.18-rc6-mm2.orig/drivers/input/mouse/psmouse-base.c	2006-09-14 00:49:30.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/input/mouse/psmouse-base.c	2006-09-14 00:24:53.000000000 +0200
@@ -377,6 +377,22 @@ int psmouse_sliced_command(struct psmous
 	return 0;
 }
 
+int psmouse_sliced_command_nested(struct psmouse *psmouse, unsigned char command)
+{
+	int i;
+
+	if (ps2_command_nested(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11))
+		return -1;
+
+	for (i = 6; i >= 0; i -= 2) {
+		unsigned char d = (command >> i) & 3;
+		if (ps2_command_nested(&psmouse->ps2dev, &d, PSMOUSE_CMD_SETRES))
+			return -1;
+	}
+
+	return 0;
+}
+
 
 /*
  * psmouse_reset() resets the mouse into power-on state.
diff -rup linux-2.6.18-rc6-mm2.orig/drivers/input/mouse/psmouse.h linux-2.6.18-rc6-mm2/drivers/input/mouse/psmouse.h
--- linux-2.6.18-rc6-mm2.orig/drivers/input/mouse/psmouse.h	2006-09-14 00:49:30.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/input/mouse/psmouse.h	2006-09-14 00:26:06.000000000 +0200
@@ -91,6 +91,7 @@ enum psmouse_type {
 };
 
 int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
+int psmouse_sliced_command_nested(struct psmouse *psmouse, unsigned char command);
 int psmouse_reset(struct psmouse *psmouse);
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
 
diff -rup linux-2.6.18-rc6-mm2.orig/drivers/input/mouse/synaptics.c linux-2.6.18-rc6-mm2/drivers/input/mouse/synaptics.c
--- linux-2.6.18-rc6-mm2.orig/drivers/input/mouse/synaptics.c	2006-09-14 00:49:30.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/input/mouse/synaptics.c	2006-09-14 00:20:16.000000000 +0200
@@ -199,9 +199,9 @@ static int synaptics_pt_write(struct ser
 	struct psmouse *parent = serio_get_drvdata(serio->parent);
 	char rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
 
-	if (psmouse_sliced_command(parent, c))
+	if (psmouse_sliced_command_nested(parent, c))
 		return -1;
-	if (ps2_command(&parent->ps2dev, &rate_param, PSMOUSE_CMD_SETRATE))
+	if (ps2_command_nested(&parent->ps2dev, &rate_param, PSMOUSE_CMD_SETRATE))
 		return -1;
 	return 0;
 }
diff -rup linux-2.6.18-rc6-mm2.orig/drivers/input/serio/libps2.c linux-2.6.18-rc6-mm2/drivers/input/serio/libps2.c
--- linux-2.6.18-rc6-mm2.orig/drivers/input/serio/libps2.c	2006-09-04 04:19:48.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/input/serio/libps2.c	2006-09-14 00:44:00.000000000 +0200
@@ -31,6 +31,7 @@ EXPORT_SYMBOL(ps2_init);
 EXPORT_SYMBOL(ps2_sendbyte);
 EXPORT_SYMBOL(ps2_drain);
 EXPORT_SYMBOL(ps2_command);
+EXPORT_SYMBOL(ps2_command_nested);
 EXPORT_SYMBOL(ps2_schedule_command);
 EXPORT_SYMBOL(ps2_handle_ack);
 EXPORT_SYMBOL(ps2_handle_response);
@@ -157,20 +158,10 @@ static int ps2_adjust_timeout(struct ps2
 	return timeout;
 }
 
-/*
- * ps2_command() sends a command and its parameters to the mouse,
- * then waits for the response and puts it in the param array.
- *
- * ps2_command() can only be called from a process context
- */
-
-int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
+int ps2_command_validate(struct ps2dev *ps2dev, unsigned char *param, int command)
 {
-	int timeout;
 	int send = (command >> 12) & 0xf;
 	int receive = (command >> 8) & 0xf;
-	int rc = -1;
-	int i;
 
 	if (receive > sizeof(ps2dev->cmdbuf)) {
 		WARN_ON(1);
@@ -181,9 +172,24 @@ int ps2_command(struct ps2dev *ps2dev, u
 		WARN_ON(1);
 		return -1;
 	}
+	return 0;	
+}
 
-	mutex_lock_nested(&ps2dev->cmd_mutex, SINGLE_DEPTH_NESTING);
+/*
+ * ps2_command() sends a command and its parameters to the mouse,
+ * then waits for the response and puts it in the param array.
+ *
+ * ps2_command() can only be called from a process context
+ */
 
+int __ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
+{
+	int timeout;
+	int send = (command >> 12) & 0xf;
+	int receive = (command >> 8) & 0xf;
+	int rc = -1;
+	int i;
+	
 	serio_pause_rx(ps2dev->serio);
 	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
 	ps2dev->cmdcnt = receive;
@@ -236,6 +242,27 @@ int ps2_command(struct ps2dev *ps2dev, u
 
 	mutex_unlock(&ps2dev->cmd_mutex);
 	return rc;
+	
+}
+
+int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
+{
+	if (ps2_command_validate(ps2dev, param, command) == -1)
+		return -1;
+
+	mutex_lock(&ps2dev->cmd_mutex);
+	return __ps2_command(ps2dev, param, command);
+
+}
+
+int ps2_command_nested(struct ps2dev *ps2dev, unsigned char *param, int command)
+{
+	if (ps2_command_validate(ps2dev, param, command) == -1)
+		return -1;
+
+	mutex_lock_nested(&ps2dev->cmd_mutex, SINGLE_DEPTH_NESTING);
+	return __ps2_command(ps2dev, param, command);
+	
 }
 
 /*
diff -rup linux-2.6.18-rc6-mm2.orig/include/linux/libps2.h linux-2.6.18-rc6-mm2/include/linux/libps2.h
--- linux-2.6.18-rc6-mm2.orig/include/linux/libps2.h	2006-09-04 04:19:48.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/linux/libps2.h	2006-09-14 00:22:13.000000000 +0200
@@ -43,6 +43,7 @@ void ps2_init(struct ps2dev *ps2dev, str
 int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout);
 void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout);
 int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
+int ps2_command_nested(struct ps2dev *ps2dev, unsigned char *param, int command);
 int ps2_schedule_command(struct ps2dev *ps2dev, unsigned char *param, int command);
 int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data);
 int ps2_handle_response(struct ps2dev *ps2dev, unsigned char data);

