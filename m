Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTK0QfO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 11:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTK0QfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 11:35:14 -0500
Received: from ssa8.serverconfig.com ([209.51.129.179]:14241 "EHLO
	ssa8.serverconfig.com") by vger.kernel.org with ESMTP
	id S262353AbTK0QfE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 11:35:04 -0500
From: "Joseph D. Wagner" <theman@josephdwagner.info>
To: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: "'Matthew Wilcox'" <willy@debian.org>,
       "'Jamie Lokier'" <jamie@shareable.org>
Subject: [PATCH] fs/locks.c fcntl_setlease did not check if a file was opened for writing before granting a read lease
Date: Thu, 27 Nov 2003 10:35:02 -0600
Message-ID: <000301c3b504$689afbf0$0201a8c0@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ssa8.serverconfig.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - josephdwagner.info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gee, that seemed simple enough.

Keep in mind that I'm new to this whole 'kernel development' thing, and I offer no assurance that my patch actually works.  I only know that it compiles without errors or warnings.

But I THINK this is how a patch would fix the problem, in theory.

This is where the 'theory of a thousand eyes' is going to have to help me out.

TIA guys.

BTW, this patch should be applied to both the 2.4 and 2.6 series of kernels (if it works).

Joseph D. Wagner

--- /old/linux-2.4.22/fs/locks.c	2003-08-25 17:44:43.000000000 +0600
+++ /new/linux-2.4.22/fs/locks.c	2003-11-27 10:08:41.000000000 +0600
@@ -111,10 +111,16 @@
  *  Matthew Wilcox <willy@thepuffingroup.com>, March, 2000.
  *
  *  Leases and LOCK_MAND
  *  Matthew Wilcox <willy@linuxcare.com>, June, 2000.
  *  Stephen Rothwell <sfr@canb.auug.org.au>, June, 2000.
+ *
+ *  FIXED Leases Issue -- Function fcntl_setlease would only check if a
+ *  file had been opened before granting a F_WRLCK, a.k.a. a write lease.
+ *  It would not check if the file had be opened for writing before
+ *  granting a F_RDLCK, a.k.a. a read lease.  This issue is now resolved.
+ *  Joseph D. Wagner <wagnerjd@users.sourceforge.net> November 2003
  */
 
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/smp_lock.h>
@@ -1287,18 +1293,25 @@
 
 	lock_kernel();
 
 	time_out_leases(inode);
 
-	/*
-	 * FIXME: What about F_RDLCK and files open for writing?
-	 */
 	error = -EAGAIN;
 	if ((arg == F_WRLCK)
 	    && ((atomic_read(&dentry->d_count) > 1)
 		|| (atomic_read(&inode->i_count) > 1)))
 		goto out_unlock;
+	if ((arg == F_RDLCK)
+	    && ((dentry->d_flags & O_WRONLY)
+		|| (dentry->d_flags & O_RDWR)
+		|| (dentry->d_flags & O_CREAT)
+		|| (dentry->d_flags & O_TRUNC)
+		|| (inode->i_flags & O_WRONLY)
+		|| (inode->i_flags & O_RDWR)
+		|| (inode->i_flags & O_CREAT)
+		|| (inode->i_flags & O_TRUNC)))
+		goto out_unlock;
 
 	/*
 	 * At this point, we know that if there is an exclusive
 	 * lease on this file, then we hold it on this filp
 	 * (otherwise our open of this file would have blocked).

