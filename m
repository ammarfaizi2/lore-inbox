Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTK1GMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 01:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTK1GMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 01:12:13 -0500
Received: from ssa8.serverconfig.com ([209.51.129.179]:59847 "EHLO
	ssa8.serverconfig.com") by vger.kernel.org with ESMTP
	id S262009AbTK1GMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 01:12:07 -0500
From: "Joseph D. Wagner" <theman@josephdwagner.info>
To: Jamie Lokier <jamie@shareable.org>, Nikita Danilov <Nikita@Namesys.COM>,
       Matthew Wilcox <willy@debian.org>
Subject: [PATCH] VERSION 2: fs/locks.c fcntl_setlease did not check if a file was opened for writing before granting a read lease
Date: Fri, 28 Nov 2003 00:11:59 +0600
User-Agent: KMail/1.5.4
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311280011.59287.theman@josephdwagner.info>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ssa8.serverconfig.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - josephdwagner.info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, it won't work.

Then try this.  A half-@$$ed patch is better than no patch at all.

Joseph D. Wagner

--- /old/src/linux-2.4.22/fs/locks.c	2003-08-25 17:44:43.000000000 +0600
+++ /new/src/linux-2.4.22/fs/locks.c	2003-11-28 00:05:11.000000000 +0600
@@ -111,10 +111,17 @@
  *  Matthew Wilcox <willy@thepuffingroup.com>, March, 2000.
  *
  *  Leases and LOCK_MAND
  *  Matthew Wilcox <willy@linuxcare.com>, June, 2000.
  *  Stephen Rothwell <sfr@canb.auug.org.au>, June, 2000.
+ *
+ *  PARTIALLY FIXED Leases Issue -- Function fcntl_setlease would only
+ *  check if a file had been opened before granting a F_WRLCK, a.k.a. a
+ *  write lease.  It would not check if the file had be opened for
+ *  writing before granting a F_RDLCK, a.k.a. a read lease.  This issue
+ *  has been partially resolved.  See FIXME below.
+ *  Joseph D. Wagner <wagnerjd@users.sourceforge.net> November 2003
  */

 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/smp_lock.h>
@@ -1287,14 +1294,33 @@

 	lock_kernel();

 	time_out_leases(inode);
 
-	/*
-	 * FIXME: What about F_RDLCK and files open for writing?
-	 */
 	error = -EAGAIN;
+	if ((arg == F_RDLCK)
+	    && ((atomic_read(&dentry->d_count) > 1)
+		|| (atomic_read(&inode->i_count) > 1))) {
+
+		/*
+		 * FIXME: Theoretically, what would happen next
+		 * is a loop which checks each open file to see
+		 * if the file is open for writing (i.e. O_WRONLY,
+		 * O_RDWR, O_CREAT, or O_TRUNC).  However, since
+		 * that would require major overhauls in other
+		 * files, it is simply assumed that if a file is
+		 * open that the file is open for writing.  In
+		 * effect, this creates an exclusive read lease
+		 * such that only one process can obtain a read
+		 * lease at any given time.  Theoretically, a file
+		 * should be able to have a virtually limitless
+		 * number of read leases provided that no process
+		 * has the file open for writing.
+		 */
+
+		goto out_unlock;
+	}
 	if ((arg == F_WRLCK)
 	    && ((atomic_read(&dentry->d_count) > 1)
 		|| (atomic_read(&inode->i_count) > 1)))
 		goto out_unlock;


