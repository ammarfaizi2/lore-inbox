Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUFGMKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUFGMKO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUFGMJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:09:27 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:15745 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264622AbUFGL40 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:26 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093543861@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093543712@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 33/39] input: Split i8042 interrupt handling into an IRQ handler and a tasklet [excluded later]
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.13, 2004-05-10 01:39:35-05:00, dtor_core@ameritech.net
  Input: split i8042 interrupt handling into an IRQ handler and a tasklet


 i8042.c |  141 +++++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 92 insertions(+), 49 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-06-07 13:10:49 +02:00
+++ b/drivers/input/serio/i8042.c	2004-06-07 13:10:49 +02:00
@@ -2,6 +2,7 @@
  *  i8042 keyboard and mouse controller driver for Linux
  *
  *  Copyright (c) 1999-2002 Vojtech Pavlik
+ *  Copyright (c) 2004      Dmitry Torokhov
  */
 
 /*
@@ -74,6 +75,14 @@
 	unsigned char *phys;
 };
 
+#define I8042_QUEUE_LEN		64
+struct {
+	unsigned char str[I8042_QUEUE_LEN];
+	unsigned char data[I8042_QUEUE_LEN];
+	unsigned int read_pos;
+	unsigned int write_pos;
+} i8042_buf;
+
 static struct serio i8042_kbd_port;
 static struct serio i8042_aux_port;
 static unsigned char i8042_initial_ctr;
@@ -82,7 +91,7 @@
 static unsigned char i8042_mux_present;
 static unsigned char i8042_sysdev_initialized;
 static struct pm_dev *i8042_pm_dev;
-struct timer_list i8042_timer;
+static struct timer_list i8042_timer;
 
 /*
  * Shared IRQ's require a device pointer, but this driver doesn't support
@@ -374,77 +383,109 @@
 static char i8042_mux_phys[4][32];
 
 /*
- * i8042_interrupt() is the most important function in this driver -
- * it handles the interrupts from the i8042, and sends incoming bytes
- * to the upper layers.
+ * i8042_handle_data() is the most important function in this driver -
+ * it processes data received by i8042_interrupt and sends it to the
+ * upper layers.
  */
 
-static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static void i8042_handle_data(unsigned long notused)
 {
-	unsigned long flags;
 	unsigned char str, data = 0;
 	unsigned int dfl;
-	int ret;
 
-	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
+	/*
+	 * No locking it required on i8042_buf as the tasklet is guaranteed
+	 * to be serialized and if write_pos changes while comparing it with
+	 * read_pos another run will be scheduled by i8042_interrupt.
+	 */
+	while (i8042_buf.read_pos != i8042_buf.write_pos) {
 
-	spin_lock_irqsave(&i8042_lock, flags);
-	str = i8042_read_status();
-	if (str & I8042_STR_OBF)
-		data = i8042_read_data();
-	spin_unlock_irqrestore(&i8042_lock, flags);
+		str = i8042_buf.str[i8042_buf.read_pos];
+		data = i8042_buf.data[i8042_buf.read_pos];
 
-	if (~str & I8042_STR_OBF) {
-		if (irq) dbg("Interrupt %d, without any data", irq);
-		ret = 0;
-		goto out;
+		i8042_buf.read_pos++;
+		i8042_buf.read_pos %= I8042_QUEUE_LEN;
+
+		dfl = ((str & I8042_STR_PARITY)  ? SERIO_PARITY  : 0) |
+	      	      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
+
+		if (i8042_mux_values[0].exists && (str & I8042_STR_AUXDATA)) {
+
+			if (str & I8042_STR_MUXERR) {
+				switch (data) {
+					case 0xfd:
+					case 0xfe: dfl = SERIO_TIMEOUT; break;
+					case 0xff: dfl = SERIO_PARITY; break;
+				}
+				data = 0xfe;
+			} else dfl = 0;
+
+			dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
+				data, (str >> 6), irq,
+				dfl & SERIO_PARITY ? ", bad parity" : "",
+				dfl & SERIO_TIMEOUT ? ", timeout" : "");
+
+			serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl, NULL);
+		} else {
+
+			dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
+				data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq,
+				dfl & SERIO_PARITY ? ", bad parity" : "",
+				dfl & SERIO_TIMEOUT ? ", timeout" : "");
+
+			if (i8042_aux_values.exists && (str & I8042_STR_AUXDATA))
+				serio_interrupt(&i8042_aux_port, data, dfl, NULL);
+			else if (i8042_kbd_values.exists)
+				serio_interrupt(&i8042_kbd_port, data, dfl, NULL);
+		}
 	}
+}
+
+DECLARE_TASKLET(i8042_tasklet, i8042_handle_data, 0);
+
+/*
+ * i8042_interrupt() handles the interrupts from i8042 and schedules
+ * i8042_handle_data to process and pass received bytes to the upper
+ * layers.
+ */
 
-	dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
-	      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
+static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long flags;
+	unsigned char str;
+	unsigned int n_bytes = 0;
 
-	if (i8042_mux_values[0].exists && (str & I8042_STR_AUXDATA)) {
+	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
-		if (str & I8042_STR_MUXERR) {
-			switch (data) {
-				case 0xfd:
-				case 0xfe: dfl = SERIO_TIMEOUT; break;
-				case 0xff: dfl = SERIO_PARITY; break;
-			}
-			data = 0xfe;
-		} else dfl = 0;
+	spin_lock_irqsave(&i8042_lock, flags);
 
-		dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
-			data, (str >> 6), irq,
-			dfl & SERIO_PARITY ? ", bad parity" : "",
-			dfl & SERIO_TIMEOUT ? ", timeout" : "");
+	while ((str = i8042_read_status()) & I8042_STR_OBF) {
 
-		serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl, regs);
+		n_bytes++;
 
-		goto irq_ret;
-	}
+		i8042_buf.str[i8042_buf.write_pos] = str;
+		i8042_buf.data[i8042_buf.write_pos] = i8042_read_data();
 
-	dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
-		data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq,
-		dfl & SERIO_PARITY ? ", bad parity" : "",
-		dfl & SERIO_TIMEOUT ? ", timeout" : "");
+		i8042_buf.write_pos++;
+		i8042_buf.write_pos %= I8042_QUEUE_LEN;
 
-	if (i8042_aux_values.exists && (str & I8042_STR_AUXDATA)) {
-		serio_interrupt(&i8042_aux_port, data, dfl, regs);
-		goto irq_ret;
+		if (unlikely(i8042_buf.write_pos == i8042_buf.read_pos))
+			printk(KERN_WARNING "i8042.c: ring buffer full\n");
 	}
 
-	if (!i8042_kbd_values.exists)
-		goto irq_ret;
+	spin_unlock_irqrestore(&i8042_lock, flags);
 
-	serio_interrupt(&i8042_kbd_port, data, dfl, regs);
+	if (unlikely(n_bytes == 0)) {
+		if (irq) dbg("Interrupt %d, without any data", irq);
+		return IRQ_NONE;
+	}
 
-irq_ret:
-	ret = 1;
-out:
-	return IRQ_RETVAL(ret);
+	tasklet_schedule(&i8042_tasklet);
+
+	return IRQ_HANDLED;
 }
 
+
 /*
  * i8042_enable_mux_mode checks whether the controller has an active
  * multiplexor and puts the chip into Multiplexed (as opposed to
@@ -1019,6 +1060,8 @@
 	for (i = 0; i < 4; i++)
 		if (i8042_mux_values[i].exists)
 			serio_unregister_port(i8042_mux_port + i);
+
+	tasklet_kill(&i8042_tasklet);
 
 	i8042_platform_exit();
 }

