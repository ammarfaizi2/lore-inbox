Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266040AbUFPAuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266040AbUFPAuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 20:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbUFPAuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 20:50:52 -0400
Received: from pat.uio.no ([129.240.130.16]:42881 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S266040AbUFPAuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 20:50:44 -0400
To: linux-kernel@vger.kernel.org
Cc: viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org
Subject: [PATCH] atime on devices
From: Sturle Sunde <sturle.sunde@usit.uio.no>
Organization: Universitetets senter for informasjonsteknologi
Date: Wed, 09 Jun 2004 16:20:17 +0200
Message-ID: <riqhdtkke3i.fsf@maggie.uio.no>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some software use access times on device files to check if there is
mouse or keyboard activity on the console.  This used to work in old
kernels, or perhaps it was old hardware, but not any more.  Google
didn't find any other portable ways of checking for mouse or keyboard
activity without accessing the X11 display.

After writing a patch for it, I searched a bit more, and found this
discussion in the linux-kernel list archives from April:

|[Viro]
|Particulary interesting one is in tty_io.c. There we
|1) unconditionally touch i_atime on read()
|2) do not touch it on write()
|3) never mark the inode dirty.

|[Viro]
|>[Linus]
|> >[Viro]
|> > There are similar places in some other char drivers. Obvious step
|> > would be to have them do file_accessed() instead; however, I'd
|> > really like to hear the rationale for existing
|> > behaviour. Comments?
|>
|> I don't know about other char drivers, those may well be wrong. But
|> for tty's in particular, idle time calculations really do pretty
|> much require the behaviour (apart from #3 - and #3 is, I think,
|> effectively required by not wanting to touch the disk on keyboard
|> accesses).
|
|AFAICS, they simply copy what tty_io.c does. Out of these guys
|busmouse.c might have a similar excuse; qtronix.c and sonypi.c AFAICS
|have no reason to touch atime at all. No idea what should
|usb/core/devio.c do...
|
|Anyway, I'm going down right now; expect a patchbomb tonight after I
|get some sleep...

Was there any patches regarding atime on devices?

Here is a patch to set atime on device files for mouse, joystick,
touchscreen, USB and hid devices in the same way as tty devices.  I
hope it doesn't collide with any ongoing atime work.


Description:

  Update atime on successfull reads from input devices in the same way
  as TTY devices and other related character devices.

Patch against 2.6.7-rc3:

------------8<-------------8<-------------8<-------------8<-------------
diff -uprN linux-2.6.7-rc3.orig/drivers/input/evdev.c linux-2.6.7-rc3/drivers/input/evdev.c
--- linux-2.6.7-rc3.orig/drivers/input/evdev.c	2004-06-13 19:35:47.512015637 +0200
+++ linux-2.6.7-rc3/drivers/input/evdev.c	2004-06-13 19:40:35.933984810 +0200
@@ -190,6 +190,9 @@ static ssize_t evdev_read(struct file * 
 		retval += sizeof(struct input_event);
 	}
 
+	if (retval > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 	return retval;
 }
 
diff -uprN linux-2.6.7-rc3.orig/drivers/input/joydev.c linux-2.6.7-rc3/drivers/input/joydev.c
--- linux-2.6.7-rc3.orig/drivers/input/joydev.c	2004-06-13 19:35:47.527015739 +0200
+++ linux-2.6.7-rc3/drivers/input/joydev.c	2004-06-13 19:40:35.933984810 +0200
@@ -273,6 +273,9 @@ static ssize_t joydev_read(struct file *
 		retval += sizeof(struct js_event);
 	}
 
+	if (retval > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 	return retval;
 }
 
diff -uprN linux-2.6.7-rc3.orig/drivers/input/mousedev.c linux-2.6.7-rc3/drivers/input/mousedev.c
--- linux-2.6.7-rc3.orig/drivers/input/mousedev.c	2004-06-13 19:35:47.657016630 +0200
+++ linux-2.6.7-rc3/drivers/input/mousedev.c	2004-06-13 20:22:04.210901032 +0200
@@ -462,6 +462,9 @@ static ssize_t mousedev_read(struct file
 	if (copy_to_user(buffer, list->ps2 + list->bufsiz - list->buffer - count, count))
 		return -EFAULT;
 
+	if (count > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 	return count;
 }
 
diff -uprN linux-2.6.7-rc3.orig/drivers/input/tsdev.c linux-2.6.7-rc3/drivers/input/tsdev.c
--- linux-2.6.7-rc3.orig/drivers/input/tsdev.c	2004-05-10 04:33:20.000000000 +0200
+++ linux-2.6.7-rc3/drivers/input/tsdev.c	2004-06-13 19:40:35.933984810 +0200
@@ -176,6 +176,9 @@ static ssize_t tsdev_read(struct file *f
 		retval += sizeof(TS_EVENT);
 	}
 
+	if (retval > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 	return retval;
 }
 
diff -uprN linux-2.6.7-rc3.orig/drivers/usb/core/devio.c linux-2.6.7-rc3/drivers/usb/core/devio.c
--- linux-2.6.7-rc3.orig/drivers/usb/core/devio.c	2004-06-13 19:35:52.027046571 +0200
+++ linux-2.6.7-rc3/drivers/usb/core/devio.c	2004-06-13 19:40:35.933984810 +0200
@@ -172,6 +172,9 @@ static ssize_t usbdev_read(struct file *
 		pos += length;
 	}
 
+	if (ret > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 err:
 	up(&dev->serialize);
 	return ret;
diff -uprN linux-2.6.7-rc3.orig/drivers/usb/input/hiddev.c linux-2.6.7-rc3/drivers/usb/input/hiddev.c
--- linux-2.6.7-rc3.orig/drivers/usb/input/hiddev.c	2004-06-13 19:35:52.232047975 +0200
+++ linux-2.6.7-rc3/drivers/usb/input/hiddev.c	2004-06-13 20:21:33.435693144 +0200
@@ -371,6 +371,9 @@ static ssize_t hiddev_read(struct file *
 
 	}
 
+	if(retval > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 	return retval;
 }
 
------------8<-------------8<-------------8<-------------8<-------------

-- 
Sturle
~~~~~
et atime on device files for mouse, joystick,
touchscreen, USB and hid devices in the same way as tty devices.  I
hope it doesn't collide with any ongoing atime work.


Description:

  Update atime on successfull reads from input devices in the same way
  as TTY devices and other related character devices.

Patch against 2.6.7-rc3:

------------8<-------------8<-------------8<-------------8<-------------
diff -uprN linux-2.6.7-rc3.orig/drivers/input/evdev.c linux-2.6.7-rc3/drivers/input/evdev.c
--- linux-2.6.7-rc3.orig/drivers/input/evdev.c	2004-06-13 19:35:47.512015637 +0200
+++ linux-2.6.7-rc3/drivers/input/evdev.c	2004-06-13 19:40:35.933984810 +0200
@@ -190,6 +190,9 @@ static ssize_t evdev_read(struct file * 
 		retval += sizeof(struct input_event);
 	}
 
+	if (retval > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 	return retval;
 }
 
diff -uprN linux-2.6.7-rc3.orig/drivers/input/joydev.c linux-2.6.7-rc3/drivers/input/joydev.c
--- linux-2.6.7-rc3.orig/drivers/input/joydev.c	2004-06-13 19:35:47.527015739 +0200
+++ linux-2.6.7-rc3/drivers/input/joydev.c	2004-06-13 19:40:35.933984810 +0200
@@ -273,6 +273,9 @@ static ssize_t joydev_read(struct file *
 		retval += sizeof(struct js_event);
 	}
 
+	if (retval > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 	return retval;
 }
 
diff -uprN linux-2.6.7-rc3.orig/drivers/input/mousedev.c linux-2.6.7-rc3/drivers/input/mousedev.c
--- linux-2.6.7-rc3.orig/drivers/input/mousedev.c	2004-06-13 19:35:47.657016630 +0200
+++ linux-2.6.7-rc3/drivers/input/mousedev.c	2004-06-13 20:22:04.210901032 +0200
@@ -462,6 +462,9 @@ static ssize_t mousedev_read(struct file
 	if (copy_to_user(buffer, list->ps2 + list->bufsiz - list->buffer - count, count))
 		return -EFAULT;
 
+	if (count > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 	return count;
 }
 
diff -uprN linux-2.6.7-rc3.orig/drivers/input/tsdev.c linux-2.6.7-rc3/drivers/input/tsdev.c
--- linux-2.6.7-rc3.orig/drivers/input/tsdev.c	2004-05-10 04:33:20.000000000 +0200
+++ linux-2.6.7-rc3/drivers/input/tsdev.c	2004-06-13 19:40:35.933984810 +0200
@@ -176,6 +176,9 @@ static ssize_t tsdev_read(struct file *f
 		retval += sizeof(TS_EVENT);
 	}
 
+	if (retval > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 	return retval;
 }
 
diff -uprN linux-2.6.7-rc3.orig/drivers/usb/core/devio.c linux-2.6.7-rc3/drivers/usb/core/devio.c
--- linux-2.6.7-rc3.orig/drivers/usb/core/devio.c	2004-06-13 19:35:52.027046571 +0200
+++ linux-2.6.7-rc3/drivers/usb/core/devio.c	2004-06-13 19:40:35.933984810 +0200
@@ -172,6 +172,9 @@ static ssize_t usbdev_read(struct file *
 		pos += length;
 	}
 
+	if (ret > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 err:
 	up(&dev->serialize);
 	return ret;
diff -uprN linux-2.6.7-rc3.orig/drivers/usb/input/hiddev.c linux-2.6.7-rc3/drivers/usb/input/hiddev.c
--- linux-2.6.7-rc3.orig/drivers/usb/input/hiddev.c	2004-06-13 19:35:52.232047975 +0200
+++ linux-2.6.7-rc3/drivers/usb/input/hiddev.c	2004-06-13 20:21:33.435693144 +0200
@@ -371,6 +371,9 @@ static ssize_t hiddev_read(struct file *
 
 	}
 
+	if(retval > 0)
+		file->f_dentry->d_inode->i_atime = CURRENT_TIME;
+
 	return retval;
 }
 
------------8<-------------8<-------------8<-------------8<-------------

-- 
Sturle
~~~~~
