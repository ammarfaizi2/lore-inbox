Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTL0O2H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 09:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbTL0O2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 09:28:07 -0500
Received: from ns.suse.de ([195.135.220.2]:43692 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261406AbTL0O17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 09:27:59 -0500
Subject: Re: chmod -x problem
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <michael.kerrisk@gmx.net>,
       Norberto Bensa <nbensa@gmx.net>, Andrew Morgan <morgan@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20031225173649.0f6b4345.akpm@osdl.org>
References: <200312251844.40654.nbensa@gmx.net>
	 <20031225173649.0f6b4345.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-GleHri74c28Mj0q/0gQT"
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1072535267.1936.9.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 27 Dec 2003 15:27:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GleHri74c28Mj0q/0gQT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

after checking POSIX 1003.1e draft 17 more thoroughly, it turned out
that we have the following situation:

Draft 17 mentions the CAP_DAC_OVERRIDE, CAP_DAC_READ_SEARCH,
CAP_DAC_WRITE, and CAP_DAC_EXECUTE capabilities (among others). In
Appendix B (pp.319) it says that ``the group also considered a single
CAP_DAC_OVERRIDE capability, but this granularity was considered
insufficient'' for reasons explained there. The group decided to split
CAP_DAC_OVERRIDE into CAP_DAC_READ_SEARCH, CAP_DAC_WRITE, and
CAP_DAC_EXECUTE. The deprecated CAP_DAC_OVERRIDE capability is still
mentioned in several places in the draft 17 text, but not in the table
that defines the base set of required capabilities. So it appears that
Andrew Morgan based the Linux Capabilities implementation on an earlier
draft.

Replacing CAP_DAC_OVERRIDE with the split capabilities does not seem a
reasonable thing to do to me at this point. So I believe that the
attached patch is a sufficient fix for the POSIX non-compliance bug
(thread
http://marc.theaimsgroup.com/?l=linux-kernel&m=106631710402696&w=2).

The previous version of the fix for this problem that was posted to LKML
was not granting execute access to directories that had no execute bits
set. This was causing the problems observed. Checking for execute bits
makes sense for regular files, because it prevents privileged users from
trying to execute random files. The operation of traversing a directory
is different from executing an arbitrary file, because it always has
``reasonable'' semantics.

We had the equivalent of the attached patch included for about a month
now, so IMO the patch is safe to apply.


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

--=-GleHri74c28Mj0q/0gQT
Content-Disposition: attachment; filename=permission-2
Content-Type: text/plain; name=permission-2; charset=
Content-Transfer-Encoding: 7bit

Make permission check conform to POSIX.1-2001

The access(2) function does not conform to POSIX.1-2001: For root
and a file with no permissions, access(file, MAY_READ|MAY_EXEC)
returns 0 (it should return -1).

Index: linux-2.6.0+fix/fs/jfs/acl.c
===================================================================
--- linux-2.6.0+fix.orig/fs/jfs/acl.c	2003-12-18 03:58:07.000000000 +0100
+++ linux-2.6.0+fix/fs/jfs/acl.c	2003-12-27 02:01:56.000000000 +0100
@@ -191,7 +191,8 @@ check_capabilities:
 	 * Read/write DACs are always overridable.
 	 * Executable DACs are overridable if at least one exec bit is set.
 	 */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) ||
+	    (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;
 
Index: linux-2.6.0+fix/fs/xfs/xfs_inode.c
===================================================================
--- linux-2.6.0+fix.orig/fs/xfs/xfs_inode.c	2003-12-18 03:59:45.000000000 +0100
+++ linux-2.6.0+fix/fs/xfs/xfs_inode.c	2003-12-27 02:05:00.000000000 +0100
@@ -3722,7 +3722,8 @@ xfs_iaccess(
 	 * Read/write DACs are always overridable.
 	 * Executable DACs are overridable if at least one exec bit is set.
 	 */
-	if ((orgmode & (S_IRUSR|S_IWUSR)) || (inode->i_mode & S_IXUGO))
+	if (!(orgmode & S_IXUSR) || (inode->i_mode & S_IXUGO) ||
+	    (ip->i_d.di_mode & S_IFMT) == S_IFDIR)
 		if (capable_cred(cr, CAP_DAC_OVERRIDE))
 			return 0;
 
Index: linux-2.6.0+fix/fs/ext2/acl.c
===================================================================
--- linux-2.6.0+fix.orig/fs/ext2/acl.c	2003-12-18 03:59:18.000000000 +0100
+++ linux-2.6.0+fix/fs/ext2/acl.c	2003-12-27 02:05:46.000000000 +0100
@@ -322,7 +322,8 @@ check_groups:
 
 check_capabilities:
 	/* Allowed to override Discretionary Access Control? */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) ||
+	    (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;
 	/* Read and search granted if capable(CAP_DAC_READ_SEARCH) */
Index: linux-2.6.0+fix/fs/ext3/acl.c
===================================================================
--- linux-2.6.0+fix.orig/fs/ext3/acl.c	2003-12-18 03:58:39.000000000 +0100
+++ linux-2.6.0+fix/fs/ext3/acl.c	2003-12-27 02:07:02.000000000 +0100
@@ -327,7 +327,8 @@ check_groups:
 
 check_capabilities:
 	/* Allowed to override Discretionary Access Control? */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) ||
+	    (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;
 	/* Read and search granted if capable(CAP_DAC_READ_SEARCH) */
Index: linux-2.6.0+fix/fs/namei.c
===================================================================
--- linux-2.6.0+fix.orig/fs/namei.c	2003-12-18 03:58:40.000000000 +0100
+++ linux-2.6.0+fix/fs/namei.c	2003-12-27 01:58:23.000000000 +0100
@@ -190,7 +190,8 @@ int vfs_permission(struct inode * inode,
 	 * Read/write DACs are always overridable.
 	 * Executable DACs are overridable if at least one exec bit is set.
 	 */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) ||
+	    (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;
 

--=-GleHri74c28Mj0q/0gQT--

