Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267692AbTCFCo7>; Wed, 5 Mar 2003 21:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267693AbTCFCo7>; Wed, 5 Mar 2003 21:44:59 -0500
Received: from fmr05.intel.com ([134.134.136.6]:50671 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267692AbTCFCo6>; Wed, 5 Mar 2003 21:44:58 -0500
Subject: [PATCH]Fix to the new sysfs bin file support
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Mar 2003 18:38:42 -0800
Message-Id: <1046918323.2915.45.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I happen to notice the new binary file support in sysfs and had to take
for a spin.  If I understand this correct my write file will need to
allocate the buffer->data, but then I have no way of freeing that memory
since I don't get a release callback.

Here is a patch that:
* makes sysfs cleanup the buffer->data allocated by the attribute write
functions
* fixes a bug that causes the kernel to oops when somebody attempts to
write to the file.

BTW, would you be totally opposed to a patch that added open, release,
and ioctl to the list of functions supported by sysfs binary files?

Another question... How would a driver know that the various write and
read calls are coming from the same open, or would there be a way for a
driver to make it so that only one thing can open the sysfs file at a
time?
    --rustyl

--- fs/sysfs/bin.c.orig	2003-03-05 18:33:44.000000000 -0800
+++ fs/sysfs/bin.c	2003-03-05 18:34:01.000000000 -0800
@@ -50,6 +50,10 @@
 		ret = count;
 	}
  Done:
+	if (buffer && buffer->data) {
+		kfree(buffer->data);
+		buffer->data = NULL;
+	}
 	return ret;
 }
 
@@ -66,7 +70,7 @@
 static int fill_write(struct file * file, const char * userbuf, 
 		      struct sysfs_bin_buffer * buffer)
 {
-	return copy_from_user(buffer,userbuf,buffer->count) ?
+	return copy_from_user(buffer->data,userbuf,buffer->count) ?
 		-EFAULT : 0;
 }
 



