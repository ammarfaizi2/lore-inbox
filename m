Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUFEHtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUFEHtX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 03:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbUFEHtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 03:49:23 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:4512 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262388AbUFEHtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 03:49:05 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Mousedev - better button handling under load
Date: Sat, 5 Jun 2004 02:49:00 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406050249.02523.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently mousedev combines all hardware motion data that arrivers since
last time userspace read data into one cooked PS/2 packet. The problem is
that under heavy or even moderate load, when userspace can't read data
quickly enough, we start loosing valuable data which manifests in:

- ignoring buton presses as by the time userspace gets to read the data
  button has already been released;
- click starts in wrong place - by the time userspace got aroungd and read
  the packet mouse moved half way across the screen.

The patch below corrects the issue - it will start accumulating new packet
every time userspace is behind and button set changes. Size of the buffer
is 16 packets, i.e. up to 8 pairs of press/release events which should be
more than enough.

The patch is against Vojtech's tree and shuld apply to -mm. I also have
cumulative mousedev patch done against 2.6.7-pre2 at:

http://www.geocities.com/dt_or/input/misc/mousedev-2.6.7-rc2-cumulative.patch.gz

-- 
Dmitry


===================================================================


ChangeSet@1.1828, 2004-06-05 01:05:50-05:00, dtor_core@ameritech.net
  Input: mousedev - better handle button presses when under load
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 mousedev.c |  152 +++++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 104 insertions(+), 48 deletions(-)


===================================================================



diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	2004-06-05 02:08:31 -05:00
+++ b/drivers/input/mousedev.c	2004-06-05 02:08:31 -05:00
@@ -50,6 +50,7 @@
 
 struct mousedev_motion {
 	int dx, dy, dz;
+	unsigned long buttons;
 };
 
 struct mousedev {
@@ -62,21 +63,31 @@
 	struct input_handle handle;
 
 	struct mousedev_motion packet;
-	unsigned long buttons;
 	unsigned int pkt_count;
 	int old_x[4], old_y[4];
 	unsigned int touch;
 };
 
+enum mousedev_emul {
+	MOUSEDEV_EMUL_PS2,
+	MOUSEDEV_EMUL_IMPS,
+	MOUSEDEV_EMUL_EXPS
+} __attribute__ ((packed));
+
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
+
 	signed char ps2[6];
 	unsigned char ready, buffer, bufsiz;
-	unsigned char mode, imexseq, impsseq;
+	unsigned char imexseq, impsseq;
+	enum mousedev_emul mode;
 };
 
 #define MOUSEDEV_SEQ_LEN	6
@@ -165,24 +176,40 @@
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
 
 static void mousedev_notify_readers(struct mousedev *mousedev, struct mousedev_motion *packet)
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
 
@@ -237,7 +264,7 @@
 				mousedev_notify_readers(mousedev, &mousedev->packet);
 				mousedev_notify_readers(&mousedev_mix, &mousedev->packet);
 
-				memset(&mousedev->packet, 0, sizeof(struct mousedev_motion));
+				mousedev->packet.dx = mousedev->packet.dy = mousedev->packet.dz = 0;
 			}
 			break;
 	}
@@ -322,6 +349,7 @@
 		return -ENOMEM;
 	memset(list, 0, sizeof(struct mousedev_list));
 
+	spin_lock_init(&list->packet_lock);
 	list->mousedev = mousedev_table[i];
 	list_add_tail(&list->node, &mousedev_table[i]->list);
 	file->private_data = list;
@@ -341,32 +369,56 @@
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
 
 
@@ -384,31 +436,31 @@
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
@@ -419,13 +471,15 @@
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
@@ -451,8 +505,10 @@
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
