Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275681AbTHOFQe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 01:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275684AbTHOFQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 01:16:32 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:33747 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S275681AbTHOFQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 01:16:30 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Fri, 15 Aug 2003 15:16:18 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16188.27810.50931.158166@gargle.gargle.HOWL>
Subject: Input issues - key down with no key up
cc: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

 I have a notebook (Dell Latitude D800) which has some keys (actual
 fn+something combinations) that generate Down events but no Up events
 (clever, isn't it).

 This makes those keys unusable with 2.6.0 as it is because the input
 layer insists on there being up events.  Once it sees a down, it will
 ignore any future down events until it sees an up event.  It will
 also auto-repeat the key until some other key is pressed.  On the
 whole, not very useful for these keys.

 After some thought, the simplest way I could think of to fix it was
 to have a bitmap of keys that don't generate up events themselves.
 For these keys the auto-repeat code can then generate an "UP" event
 (val==0) instead of a "repeat" event (val==2) after the timeout.

 The following patch does that and I can now use those keys (after
 using the relevant ioctl to associate the scan code with a keycode).

 This may not be the best way to do it, and I am happy to discuss
 other approaches, including different ioctls for getting the new
 status bits into and out-of the kernel.

NeilBrown


 ----------- Diffstat output ------------
 ./drivers/input/evdev.c |   13 +++++++++++++
 ./drivers/input/input.c |    7 +++++--
 ./include/linux/input.h |    3 +++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff ./drivers/input/evdev.c~current~ ./drivers/input/evdev.c
--- ./drivers/input/evdev.c~current~	2003-08-15 13:44:46.000000000 +1000
+++ ./drivers/input/evdev.c	2003-08-15 14:48:52.000000000 +1000
@@ -246,9 +246,21 @@ static int evdev_ioctl(struct inode *ino
 				if(INPUT_KEYCODE(dev, t) == u) break;
 			if (i == dev->keycodemax) clear_bit(u, dev->keybit);
 			set_bit(INPUT_KEYCODE(dev, t), dev->keybit);
+			clear_bit(INPUT_KEYCODE(dev, t), dev->key);
 
 			return 0;
 
+		case EVIOCSKEYNOUP:
+			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
+			if (t < 0 || t > dev->keycodemax) return -EINVAL;
+			if (get_user(u, ((int *) arg) + 1)) return -EFAULT;
+			if (u & ~1) return -EINVAL;
+			if (u)
+				set_bit(t, dev->keynoup);
+			else
+				clear_bit(t, dev->keynoup);
+			return 0;
+
 		case EVIOCSFF:
 			if (dev->upload_effect) {
 				struct ff_effect effect;
@@ -303,6 +315,7 @@ static int evdev_ioctl(struct inode *ino
 				switch (_IOC_NR(cmd) & EV_MAX) {
 					case      0: bits = dev->evbit;  len = EV_MAX;  break;
 					case EV_KEY: bits = dev->keybit; len = KEY_MAX; break;
+					case EV_REP: bits = dev->keynoup; len = KEY_MAX; break;
 					case EV_REL: bits = dev->relbit; len = REL_MAX; break;
 					case EV_ABS: bits = dev->absbit; len = ABS_MAX; break;
 					case EV_LED: bits = dev->ledbit; len = LED_MAX; break;

diff ./drivers/input/input.c~current~ ./drivers/input/input.c
--- ./drivers/input/input.c~current~	2003-08-15 13:44:46.000000000 +1000
+++ ./drivers/input/input.c	2003-08-15 13:44:46.000000000 +1000
@@ -191,8 +191,11 @@ static void input_repeat_key(unsigned lo
 
 	if (!test_bit(dev->repeat_key, dev->key))
 		return;
-
-	input_event(dev, EV_KEY, dev->repeat_key, 2);
+	if (test_bit(dev->repeat_key, dev->keynoup))
+		/* don't auto-repeat, just auto-up */
+		input_event(dev, EV_KEY, dev->repeat_key, 0);
+	else
+		input_event(dev, EV_KEY, dev->repeat_key, 2);
 	input_sync(dev);
 
 	mod_timer(&dev->timer, jiffies + dev->rep[REP_PERIOD]);

diff ./include/linux/input.h~current~ ./include/linux/input.h
--- ./include/linux/input.h~current~	2003-08-15 12:16:16.000000000 +1000
+++ ./include/linux/input.h	2003-08-15 13:44:46.000000000 +1000
@@ -60,6 +60,7 @@ struct input_absinfo {
 #define EVIOCSREP		_IOW('E', 0x03, int[2])			/* get repeat settings */
 #define EVIOCGKEYCODE		_IOR('E', 0x04, int[2])			/* get keycode */
 #define EVIOCSKEYCODE		_IOW('E', 0x04, int[2])			/* set keycode */
+#define EVIOCSKEYNOUP		_IOW('E', 0x05, int[2])			/* set 'no-repeat' bit */
 
 #define EVIOCGNAME(len)		_IOC(_IOC_READ, 'E', 0x06, len)		/* get device name */
 #define EVIOCGPHYS(len)		_IOC(_IOC_READ, 'E', 0x07, len)		/* get physical location */
@@ -790,6 +791,8 @@ struct input_dev {
 	int abs[ABS_MAX + 1];
 	int rep[REP_MAX + 1];
 
+	unsigned long keynoup[NBITS(KEY_MAX)]; /* set if key doesn't generate up event */
+
 	unsigned long key[NBITS(KEY_MAX)];
 	unsigned long led[NBITS(LED_MAX)];
 	unsigned long snd[NBITS(SND_MAX)];
