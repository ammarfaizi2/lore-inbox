Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTEURPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 13:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbTEURPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 13:15:04 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:32817 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262202AbTEURPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 13:15:03 -0400
Message-ID: <3ECBB723.7070707@google.com>
Date: Wed, 21 May 2003 10:28:03 -0700
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Patch FIOFLUSH
Content-Type: multipart/mixed;
 boundary="------------060703080005020300000609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060703080005020300000609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Here's a patch against 2.4.18 that allows user space to flush a file 
from both the buffer cache and the page cache.  The reason for flushing 
a file from the caches is to the read the file again to verify it made 
it to more permanent storage correctly.  Someone may want to add 
similiar code to 2.5.

    Ross


--------------060703080005020300000609
Content-Type: text/plain;
 name="linux-2.4-FIOFLUSH.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4-FIOFLUSH.patch"

diff -urdbB linux-2.4.18-58/fs/ioctl.c linux-2.4.18-59/fs/ioctl.c
--- linux-2.4.18-58/fs/ioctl.c	Fri Feb  9 11:29:44 2001
+++ linux-2.4.18-59/fs/ioctl.c	Thu May  1 09:52:18 2003
@@ -39,6 +39,13 @@
 			return put_user(inode->i_sb->s_blocksize, (int *) arg);
 		case FIONREAD:
 			return put_user(inode->i_size - filp->f_pos, (int *) arg);
+
+                case FIOFLUSH:
+                        write_inode_now(inode, 1);
+                        invalidate_inode_buffers(inode);
+                        invalidate_inode_pages(inode);
+                        return 0;
+
 	}
 	if (filp->f_op && filp->f_op->ioctl)
 		return filp->f_op->ioctl(inode, filp, cmd, arg);
diff -urdbB linux-2.4.18-58/include/asm/ioctls.h linux-2.4.18-59/include/asm/ioctls.h
--- linux-2.4.18-58/include/asm-i386/ioctls.h	Fri Jul 24 11:10:16 1998
+++ linux-2.4.18-59/include/asm-i386/ioctls.h	Thu May  1 09:53:51 2003
@@ -32,6 +32,7 @@
 #define TIOCGSOFTCAR	0x5419
 #define TIOCSSOFTCAR	0x541A
 #define FIONREAD	0x541B
+#define FIOFLUSH	_IO('F', 1) /* flush a file out of the caches */
 #define TIOCINQ		FIONREAD
 #define TIOCLINUX	0x541C
 #define TIOCCONS	0x541D

--------------060703080005020300000609--

