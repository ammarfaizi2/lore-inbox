Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTKGWJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTKGWIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:08:54 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:30471 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264460AbTKGQ1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 11:27:13 -0500
Subject: Re: lib.a causing modules not to load
From: James Bottomley <James.Bottomley@steeleye.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <1068222065.1894.21.camel@mulgrave>
References: <1068222065.1894.21.camel@mulgrave>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 07 Nov 2003 10:27:09 -0600
Message-Id: <1068222431.1894.24.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-07 at 10:21, James Bottomley wrote:
[...]

And with the actual patch

James

===== fs/Makefile 1.59 vs edited =====
--- 1.59/fs/Makefile	Thu Aug 14 20:17:09 2003
+++ edited/fs/Makefile	Tue Nov  4 16:33:42 2003
@@ -46,8 +46,10 @@
  
 # Do not add any filesystems before this line
 obj-$(CONFIG_EXT3_FS)		+= ext3/ # Before ext2 so root fs can be ext3
+libobj-$(CONFIG_EXT3_FS)	+= ext3/
 obj-$(CONFIG_JBD)		+= jbd/
 obj-$(CONFIG_EXT2_FS)		+= ext2/
+libobj-$(CONFIG_EXT2_FS)	+= ext2/
 obj-$(CONFIG_CRAMFS)		+= cramfs/
 obj-$(CONFIG_RAMFS)		+= ramfs/
 obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
@@ -91,3 +93,6 @@
 obj-$(CONFIG_XFS_FS)		+= xfs/
 obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_BEFS_FS)		+= befs/
+
+# now pick up the lib resolving refs
+obj-y				+= $(libobj-m)
\ No newline at end of file
===== fs/ext2/Makefile 1.10 vs edited =====
--- 1.10/fs/ext2/Makefile	Sat Jul 19 16:53:59 2003
+++ edited/fs/ext2/Makefile	Tue Nov  4 16:32:35 2003
@@ -3,6 +3,10 @@
 #
 
 obj-$(CONFIG_EXT2_FS) += ext2.o
+libobj-$(CONFIG_EXT2_FS) := librefs.o
+
+# if we're a module, add our lib requirements to the kernel
+obj-y	+= $(libobj-m)
 
 ext2-y := balloc.o bitmap.o dir.o file.o fsync.o ialloc.o inode.o \
 	  ioctl.o namei.o super.o symlink.o
--- /dev/null	2003-11-02 22:37:48.000000000 -0600
+++ edited/fs/ext2/librefs.c	2003-11-05 11:42:37.000000000 -0600
@@ -0,0 +1,7 @@
+#include <linux/init.h>
+#include <linux/percpu_counter.h>
+
+__init __attribute__((unused)) static void dummy(void)
+{
+	percpu_counter_mod(NULL, 0);
+}

