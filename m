Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264673AbUFGNAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264673AbUFGNAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUFGMXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:23:42 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:8577 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264588AbUFGL4P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:15 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093541635@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093542769@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 25/39] input: Various fixes for H3600 touchscreen driver
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.5, 2004-05-10 01:29:33-05:00, dtor_core@ameritech.net
  Input: various fixes for H3600 touchscreen driver 
         - h3600ts_interrupt, npower_button_handler and action_button_handler
           should return irqreturn_t
         - fix missing argument in h3600ts_process_packet call
         - add MODULE_AUTHOR, MODULE_DESCRIPTION and MODULE_LICENSE
         - small formatting changes


 h3600_ts_input.c |   32 +++++++++++++++++++++-----------
 1 files changed, 21 insertions(+), 11 deletions(-)

===================================================================

diff -Nru a/drivers/input/touchscreen/h3600_ts_input.c b/drivers/input/touchscreen/h3600_ts_input.c
--- a/drivers/input/touchscreen/h3600_ts_input.c	2004-06-07 13:11:34 +02:00
+++ b/drivers/input/touchscreen/h3600_ts_input.c	2004-06-07 13:11:34 +02:00
@@ -45,6 +45,10 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/irqs.h>
 
+MODULE_AUTHOR("James Simmons <jsimmons@transvirtual.com>");
+MODULE_DESCRIPTION("H3600 touchscreen driver");
+MODULE_LICENSE("GPL");
+
 /*
  * Definitions & global arrays.
  */
@@ -103,7 +107,7 @@
 	char phys[32];
 };
 
-static void action_button_handler(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t action_button_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
         int down = (GPLR & GPIO_BITSY_ACTION_BUTTON) ? 0 : 1;
 	struct input_dev *dev = (struct input_dev *) dev_id;
@@ -111,9 +115,11 @@
 	input_regs(dev, regs);
 	input_report_key(dev, KEY_ENTER, down);
 	input_sync(dev);
+
+	return IRQ_HANDLED;
 }
 
-static void npower_button_handler(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t npower_button_handler(int irq, void *dev_id, struct pt_regs *regs)
 {
         int down = (GPLR & GPIO_BITSY_NPOWER_BUTTON) ? 0 : 1;
 	struct input_dev *dev = (struct input_dev *) dev_id;
@@ -126,6 +132,8 @@
 	input_report_key(dev, KEY_SUSPEND, 1);
 	input_report_key(dev, KEY_SUSPEND, down);
 	input_sync(dev);
+
+	return IRQ_HANDLED;
 }
 
 #ifdef CONFIG_PM
@@ -141,7 +149,7 @@
  * h3600_flite_power: enables or disables power to frontlight, using last bright */
 unsigned int h3600_flite_power(struct input_dev *dev, enum flite_pwr pwr)
 {
-	unsigned char brightness = ((pwr==FLITE_PWR_OFF) ? 0:flite_brightness);
+	unsigned char brightness = (pwr == FLITE_PWR_OFF) ? 0 : flite_brightness;
 	struct h3600_dev *ts = dev->private;
 
 	/* Must be in this order */
@@ -317,8 +325,8 @@
 #define STATE_DATA      2       /* state where we decode data */
 #define STATE_EOF       3       /* state where we decode checksum or EOF */
 
-static void h3600ts_interrupt(struct serio *serio, unsigned char data,
-                              unsigned int flags)
+static irqreturn_t h3600ts_interrupt(struct serio *serio, unsigned char data,
+                                     unsigned int flags, struct pt_regs *regs)
 {
         struct h3600_dev *ts = serio->private;
 
@@ -329,7 +337,7 @@
 		case STATE_SOF:
         		if (data == CHAR_SOF)
                 		state = STATE_ID;
-			return;
+			break;
         	case STATE_ID:
 			ts->event = (data & 0xf0) >> 4;
 			ts->len = (data & 0xf);
@@ -339,7 +347,7 @@
                         	break;
 			}
 			ts->chksum = data;
-                	state=(ts->len > 0 ) ? STATE_DATA : STATE_EOF;
+                	state = (ts->len > 0) ? STATE_DATA : STATE_EOF;
 			break;
 		case STATE_DATA:
 			ts->chksum += data;
@@ -349,13 +357,15 @@
 			break;
 		case STATE_EOF:
                 	state = STATE_SOF;
-                	if (data == CHAR_EOF || data == ts->chksum )
-				h3600ts_process_packet(ts);
+                	if (data == CHAR_EOF || data == ts->chksum)
+				h3600ts_process_packet(ts, regs);
                 	break;
         	default:
                 	printk("Error3\n");
                 	break;
 	}
+
+	return IRQ_HANDLED;
 }
 
 /*
@@ -378,8 +388,8 @@
 	init_input_dev(&ts->dev);
 
 	/* Device specific stuff */
-        set_GPIO_IRQ_edge( GPIO_BITSY_ACTION_BUTTON, GPIO_BOTH_EDGES );
-        set_GPIO_IRQ_edge( GPIO_BITSY_NPOWER_BUTTON, GPIO_RISING_EDGE );
+        set_GPIO_IRQ_edge(GPIO_BITSY_ACTION_BUTTON, GPIO_BOTH_EDGES);
+        set_GPIO_IRQ_edge(GPIO_BITSY_NPOWER_BUTTON, GPIO_RISING_EDGE);
 
         if (request_irq(IRQ_GPIO_BITSY_ACTION_BUTTON, action_button_handler,
 			SA_SHIRQ | SA_INTERRUPT | SA_SAMPLE_RANDOM,

