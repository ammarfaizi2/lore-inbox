Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318949AbSG1HfS>; Sun, 28 Jul 2002 03:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318951AbSG1Her>; Sun, 28 Jul 2002 03:34:47 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:26349 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S318949AbSG1HeE>; Sun, 28 Jul 2002 03:34:04 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [cset] Add the EVIOCSABS ioctl for X people.
Date: Sun, 28 Jul 2002 17:32:53 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
References: <20020725083716.A20717@ucw.cz> <200207260047.20953.bhards@bigpond.net.au> <20020725170850.A24176@ucw.cz>
In-Reply-To: <20020725170850.A24176@ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_TM7YD68TWS6R557977O6"
Message-Id: <200207281732.53842.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_TM7YD68TWS6R557977O6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Fri, 26 Jul 2002 01:08, Vojtech Pavlik wrote:
> On Fri, Jul 26, 2002 at 12:47:20AM +1000, Brad Hards wrote:
> No problem. Send me a patch that does it for both the EVIOSGABS and
> EVIOCSABS and I'll take it. You can either just do it in evdev.c, or
> change every driver to use the struct.
I am just doing the evdev.c (ie the ABI) at this stage. I may look at the
internal representation later.
Patch against 2.5.29. Looks OK?

> > I could live with curr, min and max instead of *_value, but it
> > would be nicer if it was a bit more descriptive.
>
> You can make it current, minimum, and maximum, if you wish.  I'm a
> minimalist when it comes to naming, and I don't really think "_value" is
> bringing much information here. All of them are values after all.
"current" is a bad idea. I used curr_value.

Also, it is nice if you can retain the attributions (so I can get some
ego satisfaction, and so people know who to blame). This is generally
done by maintainers - any chance you can do this too?

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
--------------Boundary-00=_TM7YD68TWS6R557977O6
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="absinfo-2.5.29.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="absinfo-2.5.29.patch"

diff -Naur -X dontdiff -x Config.in linux-2.5.29/drivers/input/evdev.c linux-2.5.29-eventabs/drivers/input/evdev.c
--- linux-2.5.29/drivers/input/evdev.c	Sat Jul 27 12:58:41 2002
+++ linux-2.5.29-eventabs/drivers/input/evdev.c	Sun Jul 28 17:29:00 2002
@@ -233,6 +233,7 @@
 	struct evdev_list *list = file->private_data;
 	struct evdev *evdev = list->evdev;
 	struct input_dev *dev = evdev->handle.dev;
+	struct input_absinfo abs;
 	int t, u;
 
 	if (!evdev->exist) return -ENODEV;
@@ -378,26 +379,19 @@
 
 				int t = _IOC_NR(cmd) & ABS_MAX;
 
-				if (put_user(dev->abs[t],     ((int *) arg) + 0)) return -EFAULT;
-				if (put_user(dev->absmin[t],  ((int *) arg) + 1)) return -EFAULT;
-				if (put_user(dev->absmax[t],  ((int *) arg) + 2)) return -EFAULT;
-				if (put_user(dev->absfuzz[t], ((int *) arg) + 3)) return -EFAULT;
-				if (put_user(dev->absflat[t], ((int *) arg) + 4)) return -EFAULT;
+				abs.curr_value = dev->abs[t];
+				abs.minimum = dev->absmin[t];
+				abs.maximum = dev->absmax[t];
+				abs.fuzz = dev->absfuzz[t];
+				abs.flat = dev->absflat[t];
+				return copy_to_user((void *) arg, &abs, sizeof(struct input_absinfo));
 
-				return 0;
 			}
 
 			if ((_IOC_NR(cmd) & ~ABS_MAX) == _IOC_NR(EVIOCSABS(0))) {
 
-				int t = _IOC_NR(cmd) & ABS_MAX;
-
-				if (get_user(dev->abs[t],     ((int *) arg) + 0)) return -EFAULT;
-				if (get_user(dev->absmin[t],  ((int *) arg) + 1)) return -EFAULT;
-				if (get_user(dev->absmax[t],  ((int *) arg) + 2)) return -EFAULT;
-				if (get_user(dev->absfuzz[t], ((int *) arg) + 3)) return -EFAULT;
-				if (get_user(dev->absflat[t], ((int *) arg) + 4)) return -EFAULT;
-
-				return 0;
+				return copy_from_user(&abs, (void *) arg, sizeof(struct input_absinfo));
+				
 			}
 	}
 	return -EINVAL;
diff -Naur -X dontdiff -x Config.in linux-2.5.29/include/linux/input.h linux-2.5.29-eventabs/include/linux/input.h
--- linux-2.5.29/include/linux/input.h	Sat Jul 27 12:58:37 2002
+++ linux-2.5.29-eventabs/include/linux/input.h	Sun Jul 28 17:25:40 2002
@@ -63,6 +63,14 @@
 	__u16 version;
 };
 
+struct input_absinfo {
+	int curr_value;
+	int minimum;
+	int maximum;
+	int fuzz;
+	int flat;
+};
+
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
 #define EVIOCGID		_IOR('E', 0x02, struct input_id)	/* get device ID */
 #define EVIOCGREP		_IOR('E', 0x03, int[2])			/* get repeat settings */
@@ -79,8 +87,8 @@
 #define EVIOCGSND(len)		_IOC(_IOC_READ, 'E', 0x1a, len)		/* get all sounds status */
 
 #define EVIOCGBIT(ev,len)	_IOC(_IOC_READ, 'E', 0x20 + ev, len)	/* get event bits */
-#define EVIOCGABS(abs)		_IOR('E', 0x40 + abs, int[5])		/* get abs value/limits */
-#define EVIOCSABS(abs)		_IOW('E', 0xc0 + abs, int[5])		/* set abs value/limits */
+#define EVIOCGABS(abs)		_IOR('E', 0x40 + abs, struct input_absinfo)		/* get abs value/limits */
+#define EVIOCSABS(abs)		_IOW('E', 0xc0 + abs, struct input_absinfo)		/* set abs value/limits */
 
 #define EVIOCSFF		_IOC(_IOC_WRITE, 'E', 0x80, sizeof(struct ff_effect))	/* send a force effect to a force feedback device */
 #define EVIOCRMFF		_IOW('E', 0x81, int)			/* Erase a force effect */

--------------Boundary-00=_TM7YD68TWS6R557977O6--

