Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318020AbSGMCj1>; Fri, 12 Jul 2002 22:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318072AbSGMCj0>; Fri, 12 Jul 2002 22:39:26 -0400
Received: from pop.gmx.de ([213.165.64.20]:26894 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S318020AbSGMCjX>;
	Fri, 12 Jul 2002 22:39:23 -0400
Date: Sat, 13 Jul 2002 04:42:02 +0200
From: Ingo Rohloff <lundril@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Patch to loop.c - fixes locking issues (IMHO)
Message-ID: <20020713024202.GA2007@curin.highspeed>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I think the time has come again, to start a discussion
about the way locking is done in drivers/block/loop.c

Assume we use an unmodified kernel and plug in an
encryption module (lets say a twofish.o module).

Then we do the following:

dd if=/dev/zero of=foo bs=1024 count=1024
losetup -e twofish /dev/loop0 foo
mke2fs /dev/loop0
rmmod twofish
mount /dev/loop0 /mnt

-> funny doesn't work...

What happened: 
losetup doesn't lock "twofish.o", because the following
functions are called in the following order:

lo_open 
  no encryption module defined yet, so no locking is done
loop_set_status 
  calls loop_init_xfer, which will lock twofish.o once
lo_release
  encryption module is unlocked

I think this is simply wrong, because
a) People don't expect this.
b) People probably don't want this.
c) A correct locking scheme will make the code
   in loop_unregister_transfer quite useless, because
   it will ensure that loop_unregister_transfer is only
   called from a module that isn't used by any loop device.

My patch simply removes the locking/unlocking from lo_open
and lo_release. 
(I left in the code in loop_unregister_transfer because
 this makes the change in code as small as possible and
 the code doesn't hurt even if I think it's obsolete.)

The result is that an encryption module is locked as many times
as there are loop devices using it. 
The module will be locked as soon as "loop_set_status" is called
and it will be unlocked when "loop_clr_fd" is called.

So the number of locks on the encryption module corresponds to the 
number of loop devices using the encryption module...

Please can someone help me get this patch into the kernel...
(I tried at least 3 times and have failed so far...)

so long
  Ingo Rohloff

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop-lock.patch"

--- loop-orig.c	Thu Jul 11 05:25:05 2002
+++ loop.c	Sat Jul 13 03:56:14 2002
@@ -902,7 +902,7 @@
 static int lo_open(struct inode *inode, struct file *file)
 {
 	struct loop_device *lo;
-	int	dev, type;
+	int	dev;
 
 	if (!inode)
 		return -EINVAL;
@@ -917,10 +917,6 @@
 	lo = &loop_dev[dev];
 	MOD_INC_USE_COUNT;
 	down(&lo->lo_ctl_mutex);
-
-	type = lo->lo_encrypt_type; 
-	if (type && xfer_funcs[type] && xfer_funcs[type]->lock)
-		xfer_funcs[type]->lock(lo);
 	lo->lo_refcnt++;
 	up(&lo->lo_ctl_mutex);
 	return 0;
@@ -929,7 +925,7 @@
 static int lo_release(struct inode *inode, struct file *file)
 {
 	struct loop_device *lo;
-	int	dev, type;
+	int	dev;
 
 	if (!inode)
 		return 0;
@@ -944,11 +940,7 @@
 
 	lo = &loop_dev[dev];
 	down(&lo->lo_ctl_mutex);
-	type = lo->lo_encrypt_type;
 	--lo->lo_refcnt;
-	if (xfer_funcs[type] && xfer_funcs[type]->unlock)
-		xfer_funcs[type]->unlock(lo);
-
 	up(&lo->lo_ctl_mutex);
 	MOD_DEC_USE_COUNT;
 	return 0;

--qDbXVdCdHGoSgWSk--
