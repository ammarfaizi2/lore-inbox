Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264645AbUFGMBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264645AbUFGMBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbUFGL7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:59:39 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:18305 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264640AbUFGL5K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:57:10 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <1086609355275@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093553089@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:55 +0200
Subject: [PATCH 39/39] input: Exclude tasklet changes to i8042.c
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1846, 2004-06-07 12:56:10+02:00, vojtech@suse.cz
  input: Exclude tasklet changes to i8042.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 i8042.c |  141 ++++++++++++++++++++++------------------------------------------
 1 files changed, 49 insertions(+), 92 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-06-07 13:10:15 +02:00
+++ b/drivers/input/serio/i8042.c	2004-06-07 13:10:15 +02:00
@@ -2,7 +2,6 @@
  *  i8042 keyboard and mouse controller driver for Linux
  *
  *  Copyright (c) 1999-2002 Vojtech Pavlik
- *  Copyright (c) 2004      Dmitry Torokhov
  */
 
 /*
@@ -75,14 +74,6 @@
 	unsigned char *phys;
 };
 
-#define I8042_QUEUE_LEN		64
-struct {
-	unsigned char str[I8042_QUEUE_LEN];
-	unsigned char data[I8042_QUEUE_LEN];
-	unsigned int read_pos;
-	unsigned int write_pos;
-} i8042_buf;
-
 static struct serio i8042_kbd_port;
 static struct serio i8042_aux_port;
 static unsigned char i8042_initial_ctr;
@@ -91,7 +82,7 @@
 static unsigned char i8042_mux_present;
 static unsigned char i8042_sysdev_initialized;
 static struct pm_dev *i8042_pm_dev;
-static struct timer_list i8042_timer;
+struct timer_list i8042_timer;
 
 /*
  * Shared IRQ's require a device pointer, but this driver doesn't support
@@ -383,108 +374,76 @@
 static char i8042_mux_phys[4][32];
 
 /*
- * i8042_handle_data() is the most important function in this driver -
- * it processes data received by i8042_interrupt and sends it to the
- * upper layers.
+ * i8042_interrupt() is the most important function in this driver -
+ * it handles the interrupts from the i8042, and sends incoming bytes
+ * to the upper layers.
  */
 
-static void i8042_handle_data(unsigned long notused)
+static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	unsigned long flags;
 	unsigned char str, data = 0;
 	unsigned int dfl;
+	int ret;
 
-	/*
-	 * No locking it required on i8042_buf as the tasklet is guaranteed
-	 * to be serialized and if write_pos changes while comparing it with
-	 * read_pos another run will be scheduled by i8042_interrupt.
-	 */
-	while (i8042_buf.read_pos != i8042_buf.write_pos) {
-
-		str = i8042_buf.str[i8042_buf.read_pos];
-		data = i8042_buf.data[i8042_buf.read_pos];
+	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
-		i8042_buf.read_pos++;
-		i8042_buf.read_pos %= I8042_QUEUE_LEN;
+	spin_lock_irqsave(&i8042_lock, flags);
+	str = i8042_read_status();
+	if (str & I8042_STR_OBF)
+		data = i8042_read_data();
+	spin_unlock_irqrestore(&i8042_lock, flags);
 
-		dfl = ((str & I8042_STR_PARITY)  ? SERIO_PARITY  : 0) |
-	      	      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
-
-		if (i8042_mux_values[0].exists && (str & I8042_STR_AUXDATA)) {
-
-			if (str & I8042_STR_MUXERR) {
-				switch (data) {
-					case 0xfd:
-					case 0xfe: dfl = SERIO_TIMEOUT; break;
-					case 0xff: dfl = SERIO_PARITY; break;
-				}
-				data = 0xfe;
-			} else dfl = 0;
-
-			dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
-				data, (str >> 6), irq,
-				dfl & SERIO_PARITY ? ", bad parity" : "",
-				dfl & SERIO_TIMEOUT ? ", timeout" : "");
-
-			serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl, NULL);
-		} else {
-
-			dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
-				data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq,
-				dfl & SERIO_PARITY ? ", bad parity" : "",
-				dfl & SERIO_TIMEOUT ? ", timeout" : "");
-
-			if (i8042_aux_values.exists && (str & I8042_STR_AUXDATA))
-				serio_interrupt(&i8042_aux_port, data, dfl, NULL);
-			else if (i8042_kbd_values.exists)
-				serio_interrupt(&i8042_kbd_port, data, dfl, NULL);
-		}
+	if (~str & I8042_STR_OBF) {
+		if (irq) dbg("Interrupt %d, without any data", irq);
+		ret = 0;
+		goto out;
 	}
-}
-
-DECLARE_TASKLET(i8042_tasklet, i8042_handle_data, 0);
-
-/*
- * i8042_interrupt() handles the interrupts from i8042 and schedules
- * i8042_handle_data to process and pass received bytes to the upper
- * layers.
- */
-
-static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	unsigned long flags;
-	unsigned char str;
-	unsigned int n_bytes = 0;
 
-	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
+	dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
+	      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
 
-	spin_lock_irqsave(&i8042_lock, flags);
+	if (i8042_mux_values[0].exists && (str & I8042_STR_AUXDATA)) {
 
-	while ((str = i8042_read_status()) & I8042_STR_OBF) {
-
-		n_bytes++;
+		if (str & I8042_STR_MUXERR) {
+			switch (data) {
+				case 0xfd:
+				case 0xfe: dfl = SERIO_TIMEOUT; break;
+				case 0xff: dfl = SERIO_PARITY; break;
+			}
+			data = 0xfe;
+		} else dfl = 0;
 
-		i8042_buf.str[i8042_buf.write_pos] = str;
-		i8042_buf.data[i8042_buf.write_pos] = i8042_read_data();
+		dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
+			data, (str >> 6), irq,
+			dfl & SERIO_PARITY ? ", bad parity" : "",
+			dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
-		i8042_buf.write_pos++;
-		i8042_buf.write_pos %= I8042_QUEUE_LEN;
+		serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl, regs);
 
-		if (unlikely(i8042_buf.write_pos == i8042_buf.read_pos))
-			printk(KERN_WARNING "i8042.c: ring buffer full\n");
+		goto irq_ret;
 	}
 
-	spin_unlock_irqrestore(&i8042_lock, flags);
+	dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
+		data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq,
+		dfl & SERIO_PARITY ? ", bad parity" : "",
+		dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
-	if (unlikely(n_bytes == 0)) {
-		if (irq) dbg("Interrupt %d, without any data", irq);
-		return IRQ_NONE;
+	if (i8042_aux_values.exists && (str & I8042_STR_AUXDATA)) {
+		serio_interrupt(&i8042_aux_port, data, dfl, regs);
+		goto irq_ret;
 	}
 
-	tasklet_schedule(&i8042_tasklet);
+	if (!i8042_kbd_values.exists)
+		goto irq_ret;
 
-	return IRQ_HANDLED;
-}
+	serio_interrupt(&i8042_kbd_port, data, dfl, regs);
 
+irq_ret:
+	ret = 1;
+out:
+	return IRQ_RETVAL(ret);
+}
 
 /*
  * i8042_enable_mux_mode checks whether the controller has an active
@@ -1058,9 +1017,7 @@
 	for (i = 0; i < 4; i++)
 		if (i8042_mux_values[i].exists)
 			serio_unregister_port(i8042_mux_port + i);
-
 	del_timer_sync(&i8042_timer);
-	tasklet_kill(&i8042_tasklet);
 
 	i8042_platform_exit();
 }

