Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUIMQCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUIMQCJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUIMP7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:59:54 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:16619 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267165AbUIMPzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:55:23 -0400
Subject: fake_ino fixes
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1095090739.2191.1465.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Sep 2004 11:52:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This improves /proc inode numbering a bit.
If ino_t is 32-bit: just fix task 0 handling
If ino_t is 64-bit: fix large fd numbers too

Handling PID 0xffff on 32-bit was dropped in
favor of handling PID 0 correctly, since PID 0
can be seen with the default pid_max value.

Signed-off-by: Albert Cahalan <albert@users.sf.net>

diff -Naurd ol/fs/proc/base.c nl/fs/proc/base.c
--- ol/fs/proc/base.c	2004-09-13 11:13:54.000000000 -0400
+++ nl/fs/proc/base.c	2004-09-13 11:47:29.000000000 -0400
@@ -34,14 +34,16 @@
 #include <linux/ptrace.h>
 
 /*
- * For hysterical raisins we keep the same inumbers as in the old procfs.
- * Feel free to change the macro below - just keep the range distinct from
- * inumbers of the rest of procfs (currently those are in 0x0000--0xffff).
+ * This range should be distinct from inumbers of the rest of procfs.
+ * (currently those are in 0x0000--0xffff) Remember that PID 0 can
+ * be seen. Don't go above PID 0xfffe on any port with a 32-bit ino_t!
+ * (currently: Alpha, zSeries, and all 32-bit ports) Also, you'd best
+ * avoid using over 0x8000 file descriptors per task on such ports.
  * As soon as we'll get a separate superblock we will be able to forget
  * about magical ranges too.
  */
 
-#define fake_ino(pid,ino) (((pid)<<16)|(ino))
+#define fake_ino(pid,ino) ((((ino_t)pid+1)<<(sizeof(ino_t)*4))|(ino))
 
 enum pid_directory_inos {
 	PROC_TGID_INO = 2,
@@ -779,7 +781,8 @@
 {
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct task_struct *p = proc_task(inode);
-	unsigned int fd, tid, ino;
+	unsigned int fd, tid;
+	ino_t ino;
 	int retval;
 	char buf[NUMBUF];
 	struct files_struct * files;



