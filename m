Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUGKEDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUGKEDs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 00:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUGKEDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 00:03:48 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:1389 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266491AbUGKEDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 00:03:30 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFT] mousedev and handling absolute devices
Date: Sat, 10 Jul 2004 23:03:25 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407102303.26978.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One of my changes to mousedev where I was trying to do better multiplexing
of absolute and relative devices actually broke absolute device handling.

While I was looking at the possible fixes I realized that my approach was
wrong - it is impossible to maintain single position for a device and report
it to all readers. While real world position is only one for a given device
every client (reader) has it's own idea where the cursor is. As far as I know
X and GPM both position cursor in the middle of the screen and go from there.

To address the problem the following changes have been made:

- every reader tracks the vrtual cursor position, when opening /dev/inpu/mice
  (or /dev/input/mouseX) the position is assumed to be in the middle of the
  screen.
- both relative and absolute events adjust the current position
- when calculating displacement for absolute event use reader's virtual
  position instead of device's previous position so produce accurate
  results in case when cursor was moved by relative device afetr last report
  from the absolute device. 

Unfortunately I do not have a tablet or touchscreen to give the code proper
testing. I did bastardize my touchpad to work as a crude replacement of an
absolute device, but that's not enough. I am especially interested in tests
with multiple devices (tablet/mouse) and when switching from X and back.

The patch is against vanilla 2.6.7. It also has some additional changes, like
support tapping for touchpads - I will do a proper split later.

-- 
Dmitry

--- linux-2.6.7/drivers/input/mousedev.c	2004-06-16 00:20:03.000000000 -0500
+++ dtor/drivers/input/mousedev.c	2004-07-10 02:08:59.000000000 -0500
@@ -48,8 +48,15 @@
 module_param(yres, uint, 0);
 MODULE_PARM_DESC(yres, "Vertical screen resolution");
 
-struct mousedev_motion {
+static unsigned tap_time = 200;
+module_param(tap_time, uint, 0);
+MODULE_PARM_DESC(tap_time, "Tap time for touchpads in absolute mode (msecs)");
+
+struct mousedev_hw_data {
 	int dx, dy, dz;
+	int x, y;
+	int abs_event;
+	unsigned long buttons;
 };
 
 struct mousedev {
@@ -61,22 +68,38 @@
 	struct list_head list;
 	struct input_handle handle;
 
-	struct mousedev_motion packet;
-	unsigned long buttons;
+	struct mousedev_hw_data packet;
 	unsigned int pkt_count;
 	int old_x[4], old_y[4];
-	unsigned int touch;
+	unsigned long touch;
+};
+
+enum mousedev_emul {
+	MOUSEDEV_EMUL_PS2,
+	MOUSEDEV_EMUL_IMPS,
+	MOUSEDEV_EMUL_EXPS
+} __attribute__ ((packed));
+
+struct mousedev_motion {
+	int dx, dy, dz;
+	unsigned long buttons;
 };
 
+#define PACKET_QUEUE_LEN	16
 struct mousedev_list {
 	struct fasync_struct *fasync;
 	struct mousedev *mousedev;
 	struct list_head node;
-	int dx, dy, dz;
-	unsigned long buttons;
+
+	struct mousedev_motion packets[PACKET_QUEUE_LEN];
+	unsigned int head, tail;
+	spinlock_t packet_lock;
+	int pos_x, pos_y;
+
 	signed char ps2[6];
 	unsigned char ready, buffer, bufsiz;
-	unsigned char mode, imexseq, impsseq;
+	unsigned char imexseq, impsseq;
+	enum mousedev_emul mode;
 };
 
 #define MOUSEDEV_SEQ_LEN	6
@@ -119,15 +142,19 @@
 		case ABS_X:
 			size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
 			if (size == 0) size = xres;
-			mousedev->packet.dx = (value * xres - mousedev->old_x[0]) / size;
-			mousedev->old_x[0] = mousedev->packet.dx * size;
+			if (value > dev->absmax[ABS_X]) value = dev->absmax[ABS_X];
+			if (value < dev->absmin[ABS_X]) value = dev->absmin[ABS_X];
+			mousedev->packet.x = ((value - dev->absmin[ABS_X]) * xres) / size;
+			mousedev->packet.abs_event = 1;
 			break;
 
 		case ABS_Y:
 			size = dev->absmax[ABS_Y] - dev->absmin[ABS_Y];
 			if (size == 0) size = yres;
-			mousedev->packet.dy = (value * yres - mousedev->old_y[0]) / size;
-			mousedev->old_y[0] = mousedev->packet.dy * size;
+			if (value > dev->absmax[ABS_Y]) value = dev->absmax[ABS_Y];
+			if (value < dev->absmin[ABS_Y]) value = dev->absmin[ABS_Y];
+			mousedev->packet.y = yres - ((value - dev->absmin[ABS_Y]) * yres) / size;
+			mousedev->packet.abs_event = 1;
 			break;
 	}
 }
@@ -165,30 +192,82 @@
 	}
 
 	if (value) {
-		set_bit(index, &mousedev->buttons);
-		set_bit(index, &mousedev_mix.buttons);
+		set_bit(index, &mousedev->packet.buttons);
+		set_bit(index, &mousedev_mix.packet.buttons);
 	} else {
-		clear_bit(index, &mousedev->buttons);
-		clear_bit(index, &mousedev_mix.buttons);
+		clear_bit(index, &mousedev->packet.buttons);
+		clear_bit(index, &mousedev_mix.packet.buttons);
 	}
 }
 
-static void mousedev_notify_readers(struct mousedev *mousedev, struct mousedev_motion *packet)
+static void mousedev_notify_readers(struct mousedev *mousedev, struct mousedev_hw_data *packet)
 {
 	struct mousedev_list *list;
+	struct mousedev_motion *p;
+	unsigned long flags;
 
 	list_for_each_entry(list, &mousedev->list, node) {
-		list->dx += packet->dx;
-		list->dy += packet->dy;
-		list->dz += packet->dz;
-		list->buttons = mousedev->buttons;
+		spin_lock_irqsave(&list->packet_lock, flags);
+
+		p = &list->packets[list->head];
+		if (list->ready && p->buttons != packet->buttons) {
+			unsigned int new_head = (list->head + 1) % PACKET_QUEUE_LEN;
+			if (new_head != list->tail) {
+				p = &list->packets[list->head = new_head];
+				memset(p, 0, sizeof(struct mousedev_motion));
+			}
+		}
+
+		if (packet->abs_event) {
+			p->dx += packet->x - list->pos_x;
+			p->dy += packet->y - list->pos_y;
+			list->pos_x = packet->x;
+			list->pos_y = packet->y;
+		}
+
+		list->pos_x += packet->dx;
+		list->pos_x = list->pos_x < 0 ? 0 : (list->pos_x >= xres ? xres : list->pos_x);
+		list->pos_y += packet->dy;
+		list->pos_y = list->pos_y < 0 ? 0 : (list->pos_y >= yres ? yres : list->pos_y);
+
+		p->dx += packet->dx;
+		p->dy += packet->dy;
+		p->dz += packet->dz;
+		p->buttons = mousedev->packet.buttons;
+
 		list->ready = 1;
+
+		spin_unlock_irqrestore(&list->packet_lock, flags);
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
 	}
 
 	wake_up_interruptible(&mousedev->wait);
 }
 
+static void mousedev_touchpad_touch(struct mousedev *mousedev, int value)
+{
+	if (!value) {
+		if (mousedev->touch &&
+		    time_before(jiffies, mousedev->touch + msecs_to_jiffies(tap_time))) {
+			/*
+			 * Toggle left button to emulate tap.
+			 * We rely on the fact that mousedev_mix always has 0
+			 * motion packet so we won't mess current position.
+			 */
+			set_bit(0, &mousedev->packet.buttons);
+			set_bit(0, &mousedev_mix.packet.buttons);
+			mousedev_notify_readers(mousedev, &mousedev_mix.packet);
+			mousedev_notify_readers(&mousedev_mix, &mousedev_mix.packet);
+			clear_bit(0, &mousedev->packet.buttons);
+			clear_bit(0, &mousedev_mix.packet.buttons);
+		}
+		mousedev->touch = mousedev->pkt_count = 0;
+	}
+	else
+		if (!mousedev->touch)
+			mousedev->touch = jiffies;
+}
+
 static void mousedev_event(struct input_handle *handle, unsigned int type, unsigned int code, int value)
 {
 	struct mousedev *mousedev = handle->private;
@@ -212,12 +291,8 @@
 
 		case EV_KEY:
 			if (value != 2) {
-				if (code == BTN_TOUCH && test_bit(BTN_TOOL_FINGER, handle->dev->keybit)) {
-					/* Handle touchpad data */
-					mousedev->touch = value;
-					if (!mousedev->touch)
-						mousedev->pkt_count = 0;
-				}
+				if (code == BTN_TOUCH && test_bit(BTN_TOOL_FINGER, handle->dev->keybit))
+					mousedev_touchpad_touch(mousedev, value);
 				else
 					mousedev_key_event(mousedev, code, value);
 			}
@@ -237,7 +312,8 @@
 				mousedev_notify_readers(mousedev, &mousedev->packet);
 				mousedev_notify_readers(&mousedev_mix, &mousedev->packet);
 
-				memset(&mousedev->packet, 0, sizeof(struct mousedev_motion));
+				mousedev->packet.dx = mousedev->packet.dy = mousedev->packet.dz = 0;
+				mousedev->packet.abs_event = 0;
 			}
 			break;
 	}
@@ -321,7 +397,10 @@
 	if (!(list = kmalloc(sizeof(struct mousedev_list), GFP_KERNEL)))
 		return -ENOMEM;
 	memset(list, 0, sizeof(struct mousedev_list));
+	list->pos_x = xres / 2;
+	list->pos_y = yres / 2;
 
+	spin_lock_init(&list->packet_lock);
 	list->mousedev = mousedev_table[i];
 	list_add_tail(&list->node, &mousedev_table[i]->list);
 	file->private_data = list;
@@ -341,32 +420,56 @@
 	return 0;
 }
 
-static void mousedev_packet(struct mousedev_list *list, unsigned char off)
+static inline int mousedev_limit_delta(int delta, int limit)
 {
-	list->ps2[off] = 0x08 | ((list->dx < 0) << 4) | ((list->dy < 0) << 5) | (list->buttons & 0x07);
-	list->ps2[off + 1] = (list->dx > 127 ? 127 : (list->dx < -127 ? -127 : list->dx));
-	list->ps2[off + 2] = (list->dy > 127 ? 127 : (list->dy < -127 ? -127 : list->dy));
-	list->dx -= list->ps2[off + 1];
-	list->dy -= list->ps2[off + 2];
-	list->bufsiz = off + 3;
-
-	if (list->mode == 2) {
-		list->ps2[off + 3] = (list->dz > 7 ? 7 : (list->dz < -7 ? -7 : list->dz));
-		list->dz -= list->ps2[off + 3];
-		list->ps2[off + 3] = (list->ps2[off + 3] & 0x0f) | ((list->buttons & 0x18) << 1);
-		list->bufsiz++;
-	} else {
-		list->ps2[off] |= ((list->buttons & 0x10) >> 3) | ((list->buttons & 0x08) >> 1);
+	return delta > limit ? limit : (delta < -limit ? -limit : delta);
+}
+
+static void mousedev_packet(struct mousedev_list *list, signed char *ps2_data)
+{
+	struct mousedev_motion *p;
+	unsigned long flags;
+
+	spin_lock_irqsave(&list->packet_lock, flags);
+	p = &list->packets[list->tail];
+
+	ps2_data[0] = 0x08 | ((p->dx < 0) << 4) | ((p->dy < 0) << 5) | (p->buttons & 0x07);
+	ps2_data[1] = mousedev_limit_delta(p->dx, 127);
+	ps2_data[2] = mousedev_limit_delta(p->dy, 127);
+	p->dx -= ps2_data[1];
+	p->dy -= ps2_data[2];
+
+	switch (list->mode) {
+		case MOUSEDEV_EMUL_EXPS:
+			ps2_data[3] = mousedev_limit_delta(p->dz, 127);
+			p->dz -= ps2_data[3];
+			ps2_data[3] = (ps2_data[3] & 0x0f) | ((p->buttons & 0x18) << 1);
+			list->bufsiz = 4;
+			break;
+
+		case MOUSEDEV_EMUL_IMPS:
+			ps2_data[0] |= ((p->buttons & 0x10) >> 3) | ((p->buttons & 0x08) >> 1);
+			ps2_data[3] = mousedev_limit_delta(p->dz, 127);
+			p->dz -= ps2_data[3];
+			list->bufsiz = 4;
+			break;
+
+		case MOUSEDEV_EMUL_PS2:
+		default:
+			ps2_data[0] |= ((p->buttons & 0x10) >> 3) | ((p->buttons & 0x08) >> 1);
+			p->dz = 0;
+			list->bufsiz = 3;
+			break;
 	}
 
-	if (list->mode == 1) {
-		list->ps2[off + 3] = (list->dz > 127 ? 127 : (list->dz < -127 ? -127 : list->dz));
-		list->dz -= list->ps2[off + 3];
-		list->bufsiz++;
+	if (!p->dx && !p->dy && !p->dz) {
+		if (list->tail != list->head)
+			list->tail = (list->tail + 1) % PACKET_QUEUE_LEN;
+		if (list->tail == list->head)
+			list->ready = 0;
 	}
 
-	if (!list->dx && !list->dy && (!list->mode || !list->dz)) list->ready = 0;
-	list->buffer = list->bufsiz;
+	spin_unlock_irqrestore(&list->packet_lock, flags);
 }
 
 
@@ -384,31 +487,31 @@
 		if (c == mousedev_imex_seq[list->imexseq]) {
 			if (++list->imexseq == MOUSEDEV_SEQ_LEN) {
 				list->imexseq = 0;
-				list->mode = 2;
+				list->mode = MOUSEDEV_EMUL_EXPS;
 			}
 		} else list->imexseq = 0;
 
 		if (c == mousedev_imps_seq[list->impsseq]) {
 			if (++list->impsseq == MOUSEDEV_SEQ_LEN) {
 				list->impsseq = 0;
-				list->mode = 1;
+				list->mode = MOUSEDEV_EMUL_IMPS;
 			}
 		} else list->impsseq = 0;
 
 		list->ps2[0] = 0xfa;
-		list->bufsiz = 1;
 
 		switch (c) {
 
 			case 0xeb: /* Poll */
-				mousedev_packet(list, 1);
+				mousedev_packet(list, &list->ps2[1]);
+				list->bufsiz++; /* account for leading ACK */
 				break;
 
 			case 0xf2: /* Get ID */
 				switch (list->mode) {
-					case 0: list->ps2[1] = 0; break;
-					case 1: list->ps2[1] = 3; break;
-					case 2: list->ps2[1] = 4; break;
+					case MOUSEDEV_EMUL_PS2:  list->ps2[1] = 0; break;
+					case MOUSEDEV_EMUL_IMPS: list->ps2[1] = 3; break;
+					case MOUSEDEV_EMUL_EXPS: list->ps2[1] = 4; break;
 				}
 				list->bufsiz = 2;
 				break;
@@ -419,13 +522,15 @@
 				break;
 
 			case 0xff: /* Reset */
-				list->impsseq = 0;
-				list->imexseq = 0;
-				list->mode = 0;
-				list->ps2[1] = 0xaa;
-				list->ps2[2] = 0x00;
+				list->impsseq = list->imexseq = 0;
+				list->mode = MOUSEDEV_EMUL_PS2;
+				list->ps2[1] = 0xaa; list->ps2[2] = 0x00;
 				list->bufsiz = 3;
 				break;
+
+			default:
+				list->bufsiz = 1;
+				break;
 		}
 
 		list->buffer = list->bufsiz;
@@ -451,8 +556,10 @@
 	if (retval)
 		return retval;
 
-	if (!list->buffer && list->ready)
-		mousedev_packet(list, 0);
+	if (!list->buffer && list->ready) {
+		mousedev_packet(list, list->ps2);
+		list->buffer = list->bufsiz;
+	}
 
 	if (count > list->buffer)
 		count = list->buffer;
