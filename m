Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264933AbRFULu6>; Thu, 21 Jun 2001 07:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264934AbRFULus>; Thu, 21 Jun 2001 07:50:48 -0400
Received: from lxmayr6.informatik.tu-muenchen.de ([131.159.44.50]:26539 "EHLO
	lxmayr6.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S264933AbRFULuo>; Thu, 21 Jun 2001 07:50:44 -0400
Date: Thu, 21 Jun 2001 13:50:43 +0200
From: Ingo Rohloff <rohloff@in.tum.de>
To: linux-kernel@vger.kernel.org
Subject: Loop encryption module locking bug (linux-2.4.5).
Message-ID: <20010621135043.A13107@lxmayr6.informatik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There is a bug in the locking scheme for the encryption functions,
which can be hooked into the loop device. I have a patch
which resolves the problem. First what happens:

If you do (for example) a losetup -e twofish /dev/loop0 test.lop
the following happens:

The loop0 device gets opened (to use ioctl after that).  Because no cipher
is selected, the loop device hasn't an associated transfer function
(lo->lo_encrypt_type is zero). That means, that lo_open doesn't call a lock
function.

Then you set your password and loop_set_status is called (via ioctl), which
sets lo->lo_encrypt_type to the correct cipher and also calls the
lock function of the cipher. 

When this is done, losetup closes the device and lo_release is called.
Now lo->lo_encrypt_type contains the right value and this leads to
calling the unlock function of the appropriate cipher.

After that the cipher isn't locked any more, so you can 
rmmod the corresponding cipher, regardless of the fact that
the loop device still has hooks into it.

If lo_open doesn't call the cipher lock function and 
lo_release doesn't call the cipher unlock function, the issue
is resolved. (So code gets deleted in the patch.)

xfer_funcs[type]->lock is then called, when a cipher is selected for a
specific loop device. Unlock is called when a cipher is deselected for a
specific loop device. It doesn't matter if the device is opened or
not, which isn't important for the locking anyway.

The patch which is attached, is against linux-2.4.5.

I try to get this patch in the kernel for quite some time, but
it seems I do something wrong (or no one is interested) ? 
Perhaps it will go in this time...

so long
  Ingo

PS: Because I try to understand the inner workings of the loop
    device better, I have a question:
    In lo_send is a loop: "while (len>0)". How can I configure
    a loop device, so that this loop is executed more than once.
    It seems this is only possible if "bh->b_size" is greater
    than PAGE_CACHE_SIZE. Does this mean, you have to work on
    a filesystem which uses blocks of a size > PAGE_CACHE_SIZE,
    or is bh->b_size a fixed value (which is always less than
    PAGE_CACHE_SIZE) ?

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="loop-lock.patch"

--- drivers/block/loop.c~	Mon Apr 30 17:59:20 2001
+++ drivers/block/loop.c	Thu May 31 14:41:01 2001
@@ -864,7 +864,7 @@
 static int lo_open(struct inode *inode, struct file *file)
 {
 	struct loop_device *lo;
-	int	dev, type;
+	int	dev;
 
 	if (!inode)
 		return -EINVAL;
@@ -879,10 +879,6 @@
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
@@ -891,7 +887,7 @@
 static int lo_release(struct inode *inode, struct file *file)
 {
 	struct loop_device *lo;
-	int	dev, type;
+	int	dev;
 
 	if (!inode)
 		return 0;
@@ -906,11 +902,7 @@
 
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

--rwEMma7ioTxnRzrJ--
