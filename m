Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVJaHAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVJaHAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 02:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVJaHAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 02:00:34 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:43138 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932208AbVJaHAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 02:00:34 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [GIT PULL] Tiny input update
Date: Mon, 31 Oct 2005 02:00:31 -0500
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310200.31728.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please consider pulling from:

	www.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

The tree contains several one-liners, mostly dealing with the breakages
introduced by input dynalloc conversion:

Changes:
    Input: adbhid - fix OOPS introduced by dynalloc conversion (Paul Mackerras)
    Input: lkkbd - fix debug message in lkkbd_interrupt()
    Input: pcspkr - fix setting name and phys for the device
    Input: fix input_dev registration message
    Input: evdev - allow querying SW state from compat ioctl
    Input: evdev - allow querying EV_SW bits from compat_ioctl

The combined patch is below.

Thanks!

-- 
Dmitry


diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index a4696cd..9f2352b 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -565,6 +565,7 @@ static long evdev_ioctl_compat(struct fi
 						case EV_LED: bits = dev->ledbit; max = LED_MAX; break;
 						case EV_SND: bits = dev->sndbit; max = SND_MAX; break;
 						case EV_FF:  bits = dev->ffbit;  max = FF_MAX;  break;
+						case EV_SW:  bits = dev->swbit;  max = SW_MAX;  break;
 						default: return -EINVAL;
 					}
 					bit_to_user(bits, max);
@@ -579,6 +580,9 @@ static long evdev_ioctl_compat(struct fi
 				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGSND(0)))
 					bit_to_user(dev->snd, SND_MAX);
 
+				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGSW(0)))
+					bit_to_user(dev->sw, SW_MAX);
+
 				if (_IOC_NR(cmd) == _IOC_NR(EVIOCGNAME(0))) {
 					int len;
 					if (!dev->name) return -ENOENT;
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3b1685f..1a1654c 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -730,7 +730,7 @@ static void input_register_classdevice(s
 		 "input%ld", (unsigned long) atomic_inc_return(&input_no) - 1);
 
 	path = kobject_get_path(&dev->cdev.class->subsys.kset.kobj, GFP_KERNEL);
-	printk(KERN_INFO "input: %s/%s as %s\n",
+	printk(KERN_INFO "input: %s as %s/%s\n",
 		dev->name ? dev->name : "Unspecified device",
 		path ? path : "", dev->cdev.class_id);
 	kfree(path);
diff --git a/drivers/input/keyboard/lkkbd.c b/drivers/input/keyboard/lkkbd.c
index 7f06780..9481132 100644
--- a/drivers/input/keyboard/lkkbd.c
+++ b/drivers/input/keyboard/lkkbd.c
@@ -441,7 +441,7 @@ lkkbd_interrupt (struct serio *serio, un
 			input_sync (lk->dev);
 			break;
 		case LK_METRONOME:
-			DBG (KERN_INFO "Got %#d and don't "
+			DBG (KERN_INFO "Got LK_METRONOME and don't "
 					"know how to handle...\n");
 			break;
 		case LK_OUTPUT_ERROR:
diff --git a/drivers/input/misc/pcspkr.c b/drivers/input/misc/pcspkr.c
index e34633c..68ac97f 100644
--- a/drivers/input/misc/pcspkr.c
+++ b/drivers/input/misc/pcspkr.c
@@ -71,7 +71,7 @@ static int __init pcspkr_init(void)
 		return -ENOMEM;
 
 	pcspkr_dev->name = "PC Speaker";
-	pcspkr_dev->name = "isa0061/input0";
+	pcspkr_dev->phys = "isa0061/input0";
 	pcspkr_dev->id.bustype = BUS_ISA;
 	pcspkr_dev->id.vendor = 0x001f;
 	pcspkr_dev->id.product = 0x0001;
diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index cdb6d02..8f02c15 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -723,6 +723,7 @@ adbhid_input_register(int id, int defaul
 
 	sprintf(hid->phys, "adb%d:%d.%02x/input", id, default_id, original_handler_id);
 
+	hid->input = input_dev;
 	hid->id = default_id;
 	hid->original_handler_id = original_handler_id;
 	hid->current_handler_id = current_handler_id;
