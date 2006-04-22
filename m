Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWDVUst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWDVUst (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWDVUst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:48:49 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:2055 "EHLO
	smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751169AbWDVUss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:48:48 -0400
Date: Sat, 22 Apr 2006 22:48:44 +0200
From: bjd <bjdouma@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Message-ID: <20060422204844.GA16968@skyscraper.unix9.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Disclaimer: sorry
X-Operating-System: human brain v1.04E11
Organization: A training zoo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bauke Jan Douma <bjdouma@xs4all.nl>

Add two new ioctl's to have the input driver return actual current values for
EV_REP and EV_SND event codes.

Currently there is no ioctl to retrieve EV_REP values, even though they have
actually always been stored in dev->rep.  A new ioctl, EVIOCGREPCODE, retrieves
them.

The existing EVCGSND ioctl has never returned anything meaningful; the relevant
fragment in input.c was missing even a change_bit() call.
The actual EV_SND values are now written in dev->snd.  To make this work,
dev->snd had to be made an int array, and as a consequence the EVICGSND ioctl
became problematic.  I have removed it in this diff, but --even though it never
has returned anything meaningful-- I'm not quite sure that's the right thing to
do, so I would appreciate feedback on this.
Anyway, an EVIOCGSNDCODE ioctl was added to retrieve these values.

I have named the two ioctl's EVIOCGREPCODE and EVIOCGSNDCODE; I didn't want
to use EVIOCGSND for obvious reasons, and since the ioctl's retrieve the value
of an event _code_, I named them in this way, more or less analogue to
EVIOCGKEYCODE -- after all the input driver works with type, code, value, which
is nicely reflected in the naming and argument.  Feedback appreciated though.

The ioctl's btw. currently work analoguous to EVIOCKEYCODE; they must be given
an int[2] argument, where int[0] is exactly one event code (of the appropriate
event type) of which the value is queried; the value will be returned in int[1].


Signed-off-by: Bauke Jan Douma <bjdouma@xs4all.nl>

---

Patch is against 2.6.16 proper.


diff -uprN a/drivers/input/evdev.c b/drivers/input/evdev.c
--- ./linux/drivers/input/evdev.c.orig	2006-03-22 23:34:42.000000000 +0100
+++ ./linux/drivers/input/evdev.c	2006-04-22 21:31:43.000000000 +0200
@@ -407,6 +407,24 @@ static long evdev_ioctl_handler(struct f
 
 			return 0;
 
+		case EVIOCGREPCODE:
+			if (get_user(t, ip))
+				return -EFAULT;
+			if (t < 0 || t >= REP_MAX + 1)
+				return -EINVAL;
+			if (put_user(dev->rep[t], ip + 1))
+				return -EFAULT;
+			return 0;
+
+		case EVIOCGSNDCODE:
+			if (get_user(t, ip))
+				return -EFAULT;
+			if (t < 0 || t >= SND_MAX + 1)
+				return -EINVAL;
+			if (put_user(dev->snd[t], ip + 1))
+				return -EFAULT;
+			return 0;
+
 		case EVIOCGKEYCODE:
 			if (get_user(t, ip))
 				return -EFAULT;
@@ -513,10 +531,6 @@ static long evdev_ioctl_handler(struct f
 					return bits_to_user(dev->led, LED_MAX, _IOC_SIZE(cmd),
 							    p, compat_mode);
 
-				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGSND(0)))
-					return bits_to_user(dev->snd, SND_MAX, _IOC_SIZE(cmd),
-							    p, compat_mode);
-
 				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGSW(0)))
 					return bits_to_user(dev->sw, SW_MAX, _IOC_SIZE(cmd),
 							    p, compat_mode);
diff -uprN a/drivers/input/input.c b/drivers/input/input.c
--- ./linux/drivers/input/input.c.orig	2006-03-22 23:34:42.000000000 +0100
+++ ./linux/drivers/input/input.c	2006-04-22 21:31:43.000000000 +0200
@@ -153,6 +153,7 @@ void input_event(struct input_dev *dev, 
 			if (code > SND_MAX || !test_bit(code, dev->sndbit))
 				return;
 
+			dev->snd[code] = value;
 			if (dev->event) dev->event(dev, type, code, value);
 
 			break;
diff -uprN a/include/linux/input.h b/include/linux/input.h
--- ./linux/include/linux/input.h.orig	2006-03-22 23:34:50.000000000 +0100
+++ ./linux/include/linux/input.h	2006-04-22 21:31:43.000000000 +0200
@@ -59,6 +59,8 @@ struct input_absinfo {
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
 #define EVIOCGID		_IOR('E', 0x02, struct input_id)	/* get device ID */
 #define EVIOCGKEYCODE		_IOR('E', 0x04, int[2])			/* get keycode */
+#define EVIOCGREPCODE		_IOR('E', 0x10, int[2])			/* get an EV_REP setting */
+#define EVIOCGSNDCODE		_IOR('E', 0x11, int[2])			/* get an EV_SND setting */
 #define EVIOCSKEYCODE		_IOW('E', 0x04, int[2])			/* set keycode */
 
 #define EVIOCGNAME(len)		_IOC(_IOC_READ, 'E', 0x06, len)		/* get device name */
@@ -67,7 +69,6 @@ struct input_absinfo {
 
 #define EVIOCGKEY(len)		_IOC(_IOC_READ, 'E', 0x18, len)		/* get global keystate */
 #define EVIOCGLED(len)		_IOC(_IOC_READ, 'E', 0x19, len)		/* get all LEDs */
-#define EVIOCGSND(len)		_IOC(_IOC_READ, 'E', 0x1a, len)		/* get all sounds status */
 #define EVIOCGSW(len)		_IOC(_IOC_READ, 'E', 0x1b, len)		/* get all switch states */
 
 #define EVIOCGBIT(ev,len)	_IOC(_IOC_READ, 'E', 0x20 + ev, len)	/* get event bits */
@@ -908,10 +909,10 @@ struct input_dev {
 
 	int abs[ABS_MAX + 1];
 	int rep[REP_MAX + 1];
+	int snd[SND_MAX + 1];
 
 	unsigned long key[NBITS(KEY_MAX)];
 	unsigned long led[NBITS(LED_MAX)];
-	unsigned long snd[NBITS(SND_MAX)];
 	unsigned long sw[NBITS(SW_MAX)];
 
 	int absmax[ABS_MAX + 1];
