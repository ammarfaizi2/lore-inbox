Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVBVVwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVBVVwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVBVVwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:52:11 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:26857 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261283AbVBVVwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:52:02 -0500
Date: Tue, 22 Feb 2005 14:51:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6.11-rc4 i386] Re-order <linux/fs.h> includes to fix userland breakage
Message-ID: <20050222215141.GA30663@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following moves all includes <linux/fs.h> (except <linux/ioctl.h>
and <linux/config.h> down to below the existing __KERNEL__ test.  None
of these includes are needed by the user-visible portions of the header,
and in some cases can cause userland apps to break.  For example, LTP
and sash with an empty <linux/autoconf.h> will fail thusly:
cc -Wall  -I../../include -g -Wall -I../../../../include -Wall    setrlimit02.c -L../../../../lib -lltp  -o setrlimit02
In file included from /usr/include/asm/atomic.h:6,
                 from /usr/include/linux/fs.h:20,
                 from setrlimit02.c:46:
/usr/include/asm/processor.h:68: error: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here (not in a function)
/usr/include/asm/processor.h:68: error: requested alignment is not a constant

Build/run tested with a glibc rebuild as well.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

===== include/linux/fs.h 1.376 vs edited =====
--- 1.376/include/linux/fs.h	2005-02-03 07:42:40 -07:00
+++ edited/include/linux/fs.h	2005-02-22 14:44:27 -07:00
@@ -7,25 +7,7 @@
  */
 
 #include <linux/config.h>
-#include <linux/linkage.h>
-#include <linux/limits.h>
-#include <linux/wait.h>
-#include <linux/types.h>
-#include <linux/kdev_t.h>
 #include <linux/ioctl.h>
-#include <linux/dcache.h>
-#include <linux/stat.h>
-#include <linux/cache.h>
-#include <linux/kobject.h>
-#include <asm/atomic.h>
-
-struct iovec;
-struct nameidata;
-struct pipe_inode_info;
-struct poll_table_struct;
-struct kstatfs;
-struct vm_area_struct;
-struct vfsmount;
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -216,13 +198,32 @@ extern int dir_notify_enable;
 
 #ifdef __KERNEL__
 
+#include <linux/linkage.h>
+#include <linux/limits.h>
+#include <linux/wait.h>
+#include <linux/types.h>
+#include <linux/kdev_t.h>
+#include <linux/dcache.h>
+#include <linux/stat.h>
+#include <linux/cache.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/radix-tree.h>
 #include <linux/prio_tree.h>
 #include <linux/audit.h>
 #include <linux/init.h>
+
+#include <asm/atomic.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
+
+struct iovec;
+struct nameidata;
+struct pipe_inode_info;
+struct poll_table_struct;
+struct kstatfs;
+struct vm_area_struct;
+struct vfsmount;
 
 /* Used to be a macro which just called the function, now just a function */
 extern void update_atime (struct inode *);

-- 
Tom Rini
http://gate.crashing.org/~trini/
