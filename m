Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSGYOfL>; Thu, 25 Jul 2002 10:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSGYOfK>; Thu, 25 Jul 2002 10:35:10 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:40391 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314584AbSGYOfG>;
	Thu, 25 Jul 2002 10:35:06 -0400
Date: Thu, 25 Jul 2002 16:38:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: [cset] Add the EVIOCSABS ioctl for X people.
Message-ID: <20020725163816.A23988@ucw.cz>
References: <20020725083716.A20717@ucw.cz> <20020725140040.A14561@ucw.cz> <20020725140342.B14561@ucw.cz> <20020725142559.C14561@ucw.cz> <20020725161132.A22767@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020725161132.A22767@ucw.cz>; from vojtech@suse.cz on Thu, Jul 25, 2002 at 04:11:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull http://linux-input.bkbits.net:8080/linux-input' should also
work.

===================================================================

ChangeSet@1.448, 2002-07-25 16:36:05+02:00, vojtech@twilight.ucw.cz
  Add EVIOCSABS() ioctl to change the abs* informative
  values on input devices. This is something the X peoople
  really wanted.
  Rename input_devinfo to input_id, it's shorter and more 
  to the point.
  Remove superfluous printks in uinput.c
  Clean up return values in evdev.c ioctl. 

===================================================================

 drivers/input/evdev.c    |   53 ++++++++++++++++++++++++++++-------------------
 drivers/input/uinput.c   |   12 ----------
 include/linux/gameport.h |    2 -
 include/linux/input.h    |    9 ++++---
 include/linux/uinput.h   |    2 -
 5 files changed, 40 insertions(+), 38 deletions(-)


diff -Nru a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c	Thu Jul 25 16:36:22 2002
+++ b/drivers/input/evdev.c	Thu Jul 25 16:36:22 2002
@@ -233,7 +233,7 @@
 	struct evdev_list *list = file->private_data;
 	struct evdev *evdev = list->evdev;
 	struct input_dev *dev = evdev->handle.dev;
-	int retval, t, u;
+	int t, u;
 
 	if (!evdev->exist) return -ENODEV;
 
@@ -243,20 +243,20 @@
 			return put_user(EV_VERSION, (int *) arg);
 
 		case EVIOCGID:
-			return copy_to_user((void *) arg, &dev->id, sizeof(struct input_devinfo));
+			return copy_to_user((void *) arg, &dev->id, sizeof(struct input_id));
 		
 		case EVIOCGREP:
-			if ((retval = put_user(dev->rep[0], ((int *) arg) + 0))) return retval;
-			if ((retval = put_user(dev->rep[1], ((int *) arg) + 1))) return retval;
+			if (put_user(dev->rep[0], ((int *) arg) + 0)) return -EFAULT;
+			if (put_user(dev->rep[1], ((int *) arg) + 1)) return -EFAULT;
 			return 0;
 
 		case EVIOCSREP:
-			if ((retval = get_user(dev->rep[0], ((int *) arg) + 0))) return retval;
-			if ((retval = get_user(dev->rep[1], ((int *) arg) + 1))) return retval;
+			if (get_user(dev->rep[0], ((int *) arg) + 0)) return -EFAULT;
+			if (get_user(dev->rep[1], ((int *) arg) + 1)) return -EFAULT;
 			return 0;
 
 		case EVIOCGKEYCODE:
-			if ((retval = get_user(t, ((int *) arg) + 0))) return retval;
+			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
 			if (t < 0 || t > dev->keycodemax) return -EINVAL;
 			switch (dev->keycodesize) {
 				case 1: u = *(u8*)(dev->keycode + t); break;
@@ -264,13 +264,13 @@
 				case 4: u = *(u32*)(dev->keycode + t * 4); break;
 				default: return -EINVAL;
 			}
-			if ((retval = put_user(u, ((int *) arg) + 1))) return retval;
+			if (put_user(u, ((int *) arg) + 1)) return -EFAULT;
 			return 0;
 
 		case EVIOCSKEYCODE:
-			if ((retval = get_user(t, ((int *) arg) + 0))) return retval;
+			if (get_user(t, ((int *) arg) + 0)) return -EFAULT;
 			if (t < 0 || t > dev->keycodemax) return -EINVAL;
-			if ((retval = get_user(u, ((int *) arg) + 1))) return retval;
+			if (get_user(u, ((int *) arg) + 1)) return -EFAULT;
 			switch (dev->keycodesize) {
 				case 1: *(u8*)(dev->keycode + t) = u; break;
 				case 2: *(u16*)(dev->keycode + t * 2) = u; break;
@@ -284,13 +284,11 @@
 				struct ff_effect effect;
 				int err;
 
-				if (copy_from_user((void*)(&effect), (void*)arg, sizeof(effect))) {
+				if (copy_from_user((void*)(&effect), (void*)arg, sizeof(effect)))
 					return -EFAULT;
-				}
 				err = dev->upload_effect(dev, &effect);
-				if (put_user(effect.id, &(((struct ff_effect*)arg)->id))) {
+				if (put_user(effect.id, &(((struct ff_effect*)arg)->id)))
 					return -EFAULT;
-				}
 				return err;
 			}
 			else return -ENOSYS;
@@ -302,8 +300,8 @@
 			else return -ENOSYS;
 
 		case EVIOCGEFFECTS:
-			if ((retval = put_user(dev->ff_effects_max, (int*) arg)))
-				return retval;
+			if (put_user(dev->ff_effects_max, (int*) arg))
+				return -EFAULT;
 			return 0;
 
 		default:
@@ -380,11 +378,24 @@
 
 				int t = _IOC_NR(cmd) & ABS_MAX;
 
-				if ((retval = put_user(dev->abs[t],     ((int *) arg) + 0))) return retval;
-				if ((retval = put_user(dev->absmin[t],  ((int *) arg) + 1))) return retval;
-				if ((retval = put_user(dev->absmax[t],  ((int *) arg) + 2))) return retval;
-				if ((retval = put_user(dev->absfuzz[t], ((int *) arg) + 3))) return retval;
-				if ((retval = put_user(dev->absflat[t], ((int *) arg) + 4))) return retval;
+				if (put_user(dev->abs[t],     ((int *) arg) + 0)) return -EFAULT;
+				if (put_user(dev->absmin[t],  ((int *) arg) + 1)) return -EFAULT;
+				if (put_user(dev->absmax[t],  ((int *) arg) + 2)) return -EFAULT;
+				if (put_user(dev->absfuzz[t], ((int *) arg) + 3)) return -EFAULT;
+				if (put_user(dev->absflat[t], ((int *) arg) + 4)) return -EFAULT;
+
+				return 0;
+			}
+
+			if ((_IOC_NR(cmd) & ~ABS_MAX) == _IOC_NR(EVIOCSABS(0))) {
+
+				int t = _IOC_NR(cmd) & ABS_MAX;
+
+				if (get_user(dev->abs[t],     ((int *) arg) + 0)) return -EFAULT;
+				if (get_user(dev->absmin[t],  ((int *) arg) + 1)) return -EFAULT;
+				if (get_user(dev->absmax[t],  ((int *) arg) + 2)) return -EFAULT;
+				if (get_user(dev->absfuzz[t], ((int *) arg) + 3)) return -EFAULT;
+				if (get_user(dev->absflat[t], ((int *) arg) + 4)) return -EFAULT;
 
 				return 0;
 			}
diff -Nru a/drivers/input/uinput.c b/drivers/input/uinput.c
--- a/drivers/input/uinput.c	Thu Jul 25 16:36:22 2002
+++ b/drivers/input/uinput.c	Thu Jul 25 16:36:22 2002
@@ -357,7 +357,6 @@
 	.read =		uinput_read,
 	.write =	uinput_write,
 	.poll =		uinput_poll,
-//	fasync:		uinput_fasync,
 	.ioctl =	uinput_ioctl,
 };
 
@@ -369,16 +368,7 @@
 
 static int __init uinput_init(void)
 {
-	int	retval;
-	
-	retval = misc_register(&uinput_misc);
-
-	if (!retval) {
-		printk(KERN_INFO "%s: User level driver support for input subsystem loaded\n", UINPUT_NAME);
-		printk(KERN_INFO "%s: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>\n", UINPUT_NAME);
-	}
-
-	return retval;
+	return misc_register(&uinput_misc);
 }
 
 static void __exit uinput_exit(void)
diff -Nru a/include/linux/gameport.h b/include/linux/gameport.h
--- a/include/linux/gameport.h	Thu Jul 25 16:36:22 2002
+++ b/include/linux/gameport.h	Thu Jul 25 16:36:22 2002
@@ -39,7 +39,7 @@
 	char *name;
 	char *phys;
 
-	struct input_devinfo id;
+	struct input_id id;
 
 	int io;
 	int speed;
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Thu Jul 25 16:36:22 2002
+++ b/include/linux/input.h	Thu Jul 25 16:36:22 2002
@@ -56,7 +56,7 @@
  * IOCTLs (0x00 - 0x7f)
  */
 
-struct input_devinfo {
+struct input_id {
 	__u16 bustype;
 	__u16 vendor;
 	__u16 product;
@@ -64,7 +64,7 @@
 };
 
 #define EVIOCGVERSION		_IOR('E', 0x01, int)			/* get driver version */
-#define EVIOCGID		_IOR('E', 0x02, struct input_devinfo)	/* get device ID */
+#define EVIOCGID		_IOR('E', 0x02, struct input_id)	/* get device ID */
 #define EVIOCGREP		_IOR('E', 0x03, int[2])			/* get repeat settings */
 #define EVIOCSREP		_IOW('E', 0x03, int[2])			/* get repeat settings */
 #define EVIOCGKEYCODE		_IOR('E', 0x04, int[2])			/* get keycode */
@@ -80,6 +80,7 @@
 
 #define EVIOCGBIT(ev,len)	_IOC(_IOC_READ, 'E', 0x20 + ev, len)	/* get event bits */
 #define EVIOCGABS(abs)		_IOR('E', 0x40 + abs, int[5])		/* get abs value/limits */
+#define EVIOCSABS(abs)		_IOW('E', 0xc0 + abs, int[5])		/* set abs value/limits */
 
 #define EVIOCSFF		_IOC(_IOC_WRITE, 'E', 0x80, sizeof(struct ff_effect))	/* send a force effect to a force feedback device */
 #define EVIOCRMFF		_IOW('E', 0x81, int)			/* Erase a force effect */
@@ -754,7 +755,7 @@
 	char *name;
 	char *phys;
 	char *uniq;
-	struct input_devinfo id;
+	struct input_id id;
 
 	unsigned long evbit[NBITS(EV_MAX)];
 	unsigned long keybit[NBITS(KEY_MAX)];
@@ -829,7 +830,7 @@
 
 	unsigned long flags;
 
-	struct input_devinfo id;
+	struct input_id id;
 
 	unsigned long evbit[NBITS(EV_MAX)];
 	unsigned long keybit[NBITS(KEY_MAX)];
diff -Nru a/include/linux/uinput.h b/include/linux/uinput.h
--- a/include/linux/uinput.h	Thu Jul 25 16:36:22 2002
+++ b/include/linux/uinput.h	Thu Jul 25 16:36:22 2002
@@ -64,7 +64,7 @@
 #define UINPUT_MAX_NAME_SIZE	80
 struct uinput_user_dev {
 	char name[UINPUT_MAX_NAME_SIZE];
-	struct input_devinfo id;
+	struct input_id id;
         int ff_effects_max;
         int absmax[ABS_MAX + 1];
         int absmin[ABS_MAX + 1];

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch23969
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
9U:,^C[Z4U?"(!8Z;1`$U_@$GS:7VRQ<`````
`
end

-- 
Vojtech Pavlik
SuSE Labs
