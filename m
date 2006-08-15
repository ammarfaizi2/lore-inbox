Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932769AbWHOAmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbWHOAmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWHOAmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:42:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60935 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932768AbWHOAmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:42:06 -0400
Date: Tue, 15 Aug 2006 02:42:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/i4l/isdn_common.c: fix array overflows
Message-ID: <20060815004205.GG3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted these guaranteed array overflows.

Please review whether my fix is correct.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/i4l/isdn_common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc4-mm1/drivers/isdn/i4l/isdn_common.c.old	2006-08-15 00:54:32.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/isdn/i4l/isdn_common.c	2006-08-15 01:02:17.000000000 +0200
@@ -1109,61 +1109,61 @@ isdn_read(struct file *file, char __user
 			retval = -ENOMEM;
 			goto out;
 		}
 		len = isdn_readbchan(drvidx, chidx, p, NULL, count,
 				     &dev->drv[drvidx]->rcv_waitq[chidx]);
 		*off += len;
 		if (copy_to_user(buf,p,len)) 
 			len = -EFAULT;
 		kfree(p);
 		retval = len;
 		goto out;
 	}
 	if (minor <= ISDN_MINOR_CTRLMAX) {
 		drvidx = isdn_minor2drv(minor - ISDN_MINOR_CTRL);
 		if (drvidx < 0) {
 			retval = -ENODEV;
 			goto out;
 		}
 		if (!dev->drv[drvidx]->stavail) {
 			if (file->f_flags & O_NONBLOCK) {
 				retval = -EAGAIN;
 				goto out;
 			}
 			interruptible_sleep_on(&(dev->drv[drvidx]->st_waitq));
 		}
 		if (dev->drv[drvidx]->interface->readstat) {
 			if (count > dev->drv[drvidx]->stavail)
 				count = dev->drv[drvidx]->stavail;
 			len = dev->drv[drvidx]->interface->
 				readstat(buf, count, drvidx,
-					 isdn_minor2chan(minor));
+					 isdn_minor2chan(minor - ISDN_MINOR_CTRL));
 		} else {
 			len = 0;
 		}
 		if (len)
 			dev->drv[drvidx]->stavail -= len;
 		else
 			dev->drv[drvidx]->stavail = 0;
 		*off += len;
 		retval = len;
 		goto out;
 	}
 #ifdef CONFIG_ISDN_PPP
 	if (minor <= ISDN_MINOR_PPPMAX) {
 		retval = isdn_ppp_read(minor - ISDN_MINOR_PPP, file, buf, count);
 		goto out;
 	}
 #endif
 	retval = -ENODEV;
  out:
 	unlock_kernel();
 	return retval;
 }
 
 static ssize_t
 isdn_write(struct file *file, const char __user *buf, size_t count, loff_t * off)
 {
 	uint minor = iminor(file->f_dentry->d_inode);
 	int drvidx;
 	int chidx;
 	int retval;
@@ -1177,61 +1177,61 @@ isdn_write(struct file *file, const char
 	if (minor <= ISDN_MINOR_BMAX) {
 		printk(KERN_WARNING "isdn_write minor %d obsolete!\n", minor);
 		drvidx = isdn_minor2drv(minor);
 		if (drvidx < 0) {
 			retval = -ENODEV;
 			goto out;
 		}
 		if (!(dev->drv[drvidx]->flags & DRV_FLAG_RUNNING)) {
 			retval = -ENODEV;
 			goto out;
 		}
 		chidx = isdn_minor2chan(minor);
 		while ((retval = isdn_writebuf_stub(drvidx, chidx, buf, count)) == 0)
 			interruptible_sleep_on(&dev->drv[drvidx]->snd_waitq[chidx]);
 		goto out;
 	}
 	if (minor <= ISDN_MINOR_CTRLMAX) {
 		drvidx = isdn_minor2drv(minor - ISDN_MINOR_CTRL);
 		if (drvidx < 0) {
 			retval = -ENODEV;
 			goto out;
 		}
 		/*
 		 * We want to use the isdnctrl device to load the firmware
 		 *
 		 if (!(dev->drv[drvidx]->flags & DRV_FLAG_RUNNING))
 		 return -ENODEV;
 		 */
 		if (dev->drv[drvidx]->interface->writecmd)
 			retval = dev->drv[drvidx]->interface->
-				writecmd(buf, count, drvidx, isdn_minor2chan(minor));
+				writecmd(buf, count, drvidx, isdn_minor2chan(minor - ISDN_MINOR_CTRL));
 		else
 			retval = count;
 		goto out;
 	}
 #ifdef CONFIG_ISDN_PPP
 	if (minor <= ISDN_MINOR_PPPMAX) {
 		retval = isdn_ppp_write(minor - ISDN_MINOR_PPP, file, buf, count);
 		goto out;
 	}
 #endif
 	retval = -ENODEV;
  out:
 	unlock_kernel();
 	return retval;
 }
 
 static unsigned int
 isdn_poll(struct file *file, poll_table * wait)
 {
 	unsigned int mask = 0;
 	unsigned int minor = iminor(file->f_dentry->d_inode);
 	int drvidx = isdn_minor2drv(minor - ISDN_MINOR_CTRL);
 
 	lock_kernel();
 	if (minor == ISDN_MINOR_STATUS) {
 		poll_wait(file, &(dev->info_waitq), wait);
 		/* mask = POLLOUT | POLLWRNORM; */
 		if (file->private_data) {
 			mask |= POLLIN | POLLRDNORM;
 		}
