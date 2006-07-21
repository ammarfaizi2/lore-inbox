Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWGUGKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWGUGKn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 02:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWGUGKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 02:10:43 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:59405 "EHLO
	asav07.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1160997AbWGUGKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 02:10:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HACcLwESBTw
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Shaun Jackman" <sjackman@gmail.com>
Subject: Re: [PATCH] elo: Support non-pressure-sensitive ELO touchscreens
Date: Fri, 21 Jul 2006 02:10:37 -0400
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>
References: <7f45d9390602241045p45aec8auaf881a4dab00c17a@mail.gmail.com> <7f45d9390603280709u5eea134ejb0aaacdd49984a92@mail.gmail.com> <7f45d9390607191434g6261b6f8pf1c9a9688770d95f@mail.gmail.com>
In-Reply-To: <7f45d9390607191434g6261b6f8pf1c9a9688770d95f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607210210.37923.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 July 2006 17:34, Shaun Jackman wrote:
> On 3/28/06, Shaun Jackman <sjackman@gmail.com> wrote:
> > On 3/27/06, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > ...
> > > No, we should not change basic input device's capabilities "on-fly" -
> > > userspace should be able to rely on what was reported to it in the first
> > > place.
> >
> > Makes sense.
> >
> > > From looking over the documentation (thank you for the link)
> > > it looks like you would need to issue 'i' command to query controller
> > > type and whether the controller supports Z-axis in elo_connect().
> >
> > This sounds like extra (not strictly necessary) functionality to me
> > though. My USB mouse, for example, reports five buttons and three
> > wheels, even though it only has three buttons and one wheel. Support
> > for the 'i' packet could be added later, if someone has a need. Can
> > this patch be applied as is?
> 
> Can this patch adding support for non-pressure-sensitive ELO
> touchscreens be applied? Any comments?
> 

Shaun,

I still think that we need to query the touchscreen andd act based on
its reported features. Could you please tell me if the patch below works?

Thanks!

-- 
Dmitry

Subject: elo - add support for non-pressure-sensitive touchscreens
From: Shaun Jackman <sjackman@gmail.com>

Input: elo - add support for non-pressure-sensitive touchscreens

- Use the touch status bit rather than the pressure bits to
  distinguish a BTN_TOUCH event. Non-pressure-sensitive touchscreens
  always report full pressure
- Report ABS_PRESSURE information only if the touchscreen supports it
- Implement checksum calculation correctly, and verify that the
  transmitted checksum is correct
- Handle input_register_device() failures
- Use dev_dbg to log errors in the protocol

Signed-off-by: Shaun Jackman <sjackman@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/elo.c |  166 ++++++++++++++++++++++++++++++++--------
 1 files changed, 134 insertions(+), 32 deletions(-)

Index: work/drivers/input/touchscreen/elo.c
===================================================================
--- work.orig/drivers/input/touchscreen/elo.c
+++ work/drivers/input/touchscreen/elo.c
@@ -23,6 +23,7 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/init.h>
+#include <linux/ctype.h>
 
 #define DRIVER_DESC	"Elo serial touchscreen driver"
 
@@ -34,7 +35,19 @@ MODULE_LICENSE("GPL");
  * Definitions & global arrays.
  */
 
-#define	ELO_MAX_LENGTH	10
+#define	ELO_MAX_LENGTH		10
+
+#define ELO10_PACKET_LEN	8
+#define ELO10_TOUCH		0x03
+#define ELO10_PRESSURE		0x80
+
+#define ELO10_LEAD_BYTE		'U'
+
+#define ELO10_ID_CMD		'i'
+
+#define ELO10_TOUCH_PACKET	'T'
+#define ELO10_ACK_PACKET	'A'
+#define ELI10_ID_PACKET		'I'
 
 /*
  * Per-touchscreen data.
@@ -43,51 +56,69 @@ MODULE_LICENSE("GPL");
 struct elo {
 	struct input_dev *dev;
 	struct serio *serio;
+	struct mutex cmd_mutex;
+	struct completion cmd_done;
 	int id;
 	int idx;
+	unsigned char expected_packet;
 	unsigned char csum;
 	unsigned char data[ELO_MAX_LENGTH];
+	unsigned char response[ELO10_PACKET_LEN];
 	char phys[32];
 };
 
-static void elo_process_data_10(struct elo* elo, unsigned char data, struct pt_regs *regs)
+static void elo_process_data_10(struct elo *elo, unsigned char data, struct pt_regs *regs)
 {
 	struct input_dev *dev = elo->dev;
+	struct device *dbg = &elo->serio->dev;
 
-	elo->csum += elo->data[elo->idx] = data;
-
+	elo->data[elo->idx] = data;
 	switch (elo->idx++) {
-
 		case 0:
-			if (data != 'U') {
+			elo->csum = 0xaa;
+			if (data != ELO10_LEAD_BYTE) {
+				dev_dbg(dbg, "unsynchronized data: 0x%02x\n", data);
 				elo->idx = 0;
-				elo->csum = 0;
 			}
 			break;
+		case 9:
+			elo->idx = 0;
+			if (elo->csum != elo->data[9]) {
+				dev_dbg(dbg, "bad checksum: 0x%02x, expected 0x%02x\n",
+					elo->data[9], elo->csum);
+				break;
+			}
 
-		case 1:
-			if (data != 'T') {
-				elo->idx = 0;
-				elo->csum = 0;
+			if (elo->data[1] != elo->expected_packet) {
+				if (elo->data[1] != ELO10_TOUCH_PACKET)
+					dev_dbg(dbg, "unexpected packet: 0x%02x\n",
+						elo->data[1]);
+				break;
 			}
-			break;
 
-		case 9:
-			if (elo->csum) {
+			if (likely(elo->data[1] == ELO10_TOUCH_PACKET)) {
 				input_regs(dev, regs);
 				input_report_abs(dev, ABS_X, (elo->data[4] << 8) | elo->data[3]);
 				input_report_abs(dev, ABS_Y, (elo->data[6] << 8) | elo->data[5]);
-				input_report_abs(dev, ABS_PRESSURE, (elo->data[8] << 8) | elo->data[7]);
-				input_report_key(dev, BTN_TOUCH, elo->data[8] || elo->data[7]);
+				if (elo->data[2] & ELO10_PRESSURE)
+					input_report_abs(dev, ABS_PRESSURE,
+							(elo->data[8] << 8) | elo->data[7]);
+				input_report_key(dev, BTN_TOUCH, elo->data[2] & ELO10_TOUCH);
 				input_sync(dev);
+			} else if (elo->data[1] == ELO10_ACK_PACKET) {
+				if (elo->data[2] == '0')
+					elo->expected_packet = ELO10_TOUCH_PACKET;
+				complete(&elo->cmd_done);
+			} else {
+				memcpy(elo->response, &elo->data[1], ELO10_PACKET_LEN);
+				elo->expected_packet = ELO10_ACK_PACKET;
 			}
-			elo->idx = 0;
-			elo->csum = 0;
 			break;
 	}
+	elo->csum += data;
 }
 
-static void elo_process_data_6(struct elo* elo, unsigned char data, struct pt_regs *regs)
+static void elo_process_data_6(struct elo *elo, unsigned char data, struct pt_regs *regs)
 {
 	struct input_dev *dev = elo->dev;
 
@@ -135,7 +166,7 @@ static void elo_process_data_6(struct el
 	}
 }
 
-static void elo_process_data_3(struct elo* elo, unsigned char data, struct pt_regs *regs)
+static void elo_process_data_3(struct elo *elo, unsigned char data, struct pt_regs *regs)
 {
 	struct input_dev *dev = elo->dev;
 
@@ -181,17 +212,81 @@ static irqreturn_t elo_interrupt(struct 
 	return IRQ_HANDLED;
 }
 
+static int elo_command_10(struct elo *elo, unsigned char *packet)
+{
+	int rc = -1;
+	int i;
+	unsigned char csum = 0xaa + ELO10_LEAD_BYTE;
+
+	mutex_lock(&elo->cmd_mutex);
+
+	serio_pause_rx(elo->serio);
+	elo->expected_packet = toupper(packet[0]);
+	init_completion(&elo->cmd_done);
+	serio_continue_rx(elo->serio);
+
+	if (serio_write(elo->serio, ELO10_LEAD_BYTE))
+		goto out;
+
+	for (i = 0; i < ELO10_PACKET_LEN; i++) {
+		csum += packet[i];
+		if (serio_write(elo->serio, packet[i]))
+			goto out;
+	}
+
+	if (serio_write(elo->serio, csum))
+		goto out;
+
+	wait_for_completion_timeout(&elo->cmd_done, HZ);
+
+	if (elo->expected_packet == ELO10_TOUCH_PACKET) {
+		/* We are back in reportinG mode, the command was ACKed */
+		memcpy(packet, elo->response, ELO10_PACKET_LEN);
+		rc = 0;
+	}
+
+ out:
+	mutex_unlock(&elo->cmd_mutex);
+	return rc;
+}
+
+static int elo_setup_10(struct elo *elo)
+{
+	static const char *elo_types[] = { "Accu", "Dura", "Intelli", "Carroll" };
+	struct input_dev *dev = elo->dev;
+	unsigned char packet[ELO10_PACKET_LEN] = { ELO10_ID_CMD };
+
+	if (elo_command_10(elo, packet))
+		return -1;
+
+	dev->id.version = (packet[5] << 8) | packet[4];
+
+	input_set_abs_params(dev, ABS_X, 96, 4000, 0, 0);
+	input_set_abs_params(dev, ABS_Y, 96, 4000, 0, 0);
+	if (packet[3] & ELO10_PRESSURE)
+		input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
+
+	printk(KERN_INFO "elo: %sTouch touchscreen, fw: %02x.%02x, "
+		"features: %x02x, controller: 0x%02x\n",
+		elo_types[(packet[1] -'0') & 0x03],
+		packet[5], packet[4], packet[3], packet[7]);
+
+	return 0;
+}
+
 /*
  * elo_disconnect() is the opposite of elo_connect()
  */
 
 static void elo_disconnect(struct serio *serio)
 {
-	struct elo* elo = serio_get_drvdata(serio);
+	struct elo *elo = serio_get_drvdata(serio);
 
+	input_get_device(elo->dev);
 	input_unregister_device(elo->dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
+	input_put_device(elo->dev);
 	kfree(elo);
 }
 
@@ -211,12 +306,15 @@ static int elo_connect(struct serio *ser
 	input_dev = input_allocate_device();
 	if (!elo || !input_dev) {
 		err = -ENOMEM;
-		goto fail;
+		goto fail1;
 	}
 
 	elo->serio = serio;
 	elo->id = serio->id.id;
 	elo->dev = input_dev;
+	elo->expected_packet = ELO10_TOUCH_PACKET;
+	mutex_init(&elo->cmd_mutex);
+	init_completion(&elo->cmd_done);
 	snprintf(elo->phys, sizeof(elo->phys), "%s/input0", serio->phys);
 
 	input_dev->private = elo;
@@ -231,12 +329,17 @@ static int elo_connect(struct serio *ser
 	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
 
+	serio_set_drvdata(serio, elo);
+	err = serio_open(serio, drv);
+	if (err)
+		goto fail2;
+
 	switch (elo->id) {
 
 		case 0: /* 10-byte protocol */
-			input_set_abs_params(input_dev, ABS_X, 96, 4000, 0, 0);
-			input_set_abs_params(input_dev, ABS_Y, 96, 4000, 0, 0);
-			input_set_abs_params(input_dev, ABS_PRESSURE, 0, 255, 0, 0);
+			if (elo_setup_10(elo))
+				goto fail3;
+
 			break;
 
 		case 1: /* 6-byte protocol */
@@ -247,23 +350,22 @@ static int elo_connect(struct serio *ser
 			input_set_abs_params(input_dev, ABS_Y, 96, 4000, 0, 0);
 			break;
 
+
 		case 3: /* 3-byte protocol */
 			input_set_abs_params(input_dev, ABS_X, 0, 255, 0, 0);
 			input_set_abs_params(input_dev, ABS_Y, 0, 255, 0, 0);
 			break;
 	}
 
-	serio_set_drvdata(serio, elo);
-
-	err = serio_open(serio, drv);
+	err = input_register_device(elo->dev);
 	if (err)
-		goto fail;
+		goto fail3;
 
-	input_register_device(elo->dev);
 	return 0;
 
- fail:	serio_set_drvdata(serio, NULL);
-	input_free_device(input_dev);
+ fail3:	serio_close(serio);
+ fail2:	serio_set_drvdata(serio, NULL);
+ fail1:	input_free_device(input_dev);
 	kfree(elo);
 	return err;
 }
