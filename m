Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316993AbSFFRut>; Thu, 6 Jun 2002 13:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSFFRus>; Thu, 6 Jun 2002 13:50:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49926 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316993AbSFFRur>;
	Thu, 6 Jun 2002 13:50:47 -0400
Date: Thu, 6 Jun 2002 18:50:48 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Trivial Kernel Patches <trivial@rustcorp.com.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/locks.c: remove MSNFS define
Message-ID: <20020606185048.K27186@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the MSNFS defines.  These locks have a wider purpose
than emulating Microsoft NFS semantics.

--- fs/locks.c2	Thu Jun  6 11:25:15 2002
+++ fs/locks.c3	Thu Jun  6 11:44:03 2002
@@ -1,4 +1,3 @@
-#define MSNFS	/* HACK HACK */
 /*
  *  linux/fs/locks.c
  *
@@ -576,10 +575,8 @@
 	 */
 	if (!IS_FLOCK(sys_fl) || (caller_fl->fl_file == sys_fl->fl_file))
 		return (0);
-#ifdef MSNFS
 	if ((caller_fl->fl_type & LOCK_MAND) || (sys_fl->fl_type & LOCK_MAND))
 		return 0;
-#endif
 
 	return (locks_conflict(caller_fl, sys_fl));
 }
@@ -1029,10 +1026,8 @@
 }
 
 static inline int flock_translate_cmd(int cmd) {
-#ifdef MSNFS
 	if (cmd & LOCK_MAND)
 		return cmd & (LOCK_MAND | LOCK_RW);
-#endif
 	switch (cmd &~ LOCK_NB) {
 	case LOCK_SH:
 		return F_RDLCK;
@@ -1325,11 +1320,7 @@
 	type = error;
 
 	error = -EBADF;
-	if ((type != F_UNLCK)
-#ifdef MSNFS
-		&& !(type & LOCK_MAND)
-#endif
-		&& !(filp->f_mode & 3))
+	if ((type != F_UNLCK) && !(type & LOCK_MAND) && !(filp->f_mode & 3))
 		goto out_putf;
 
 	lock_kernel();
@@ -1718,27 +1709,25 @@
 			      (inode->i_mode & (S_IXGRP | S_ISGID)) == S_ISGID) ?
 			     "MANDATORY" : "ADVISORY ");
 	} else if (IS_FLOCK(fl)) {
-#ifdef MSNFS
 		if (fl->fl_type & LOCK_MAND) {
 			out += sprintf(out, "FLOCK  MSNFS     ");
-		} else
-#endif
+		} else {
 			out += sprintf(out, "FLOCK  ADVISORY  ");
+		}
 	} else if (IS_LEASE(fl)) {
 		out += sprintf(out, "LEASE  MANDATORY ");
 	} else {
 		out += sprintf(out, "UNKNOWN UNKNOWN  ");
 	}
-#ifdef MSNFS
 	if (fl->fl_type & LOCK_MAND) {
 		out += sprintf(out, "%s ",
 			       (fl->fl_type & LOCK_READ)
 			       ? (fl->fl_type & LOCK_WRITE) ? "RW   " : "READ "
 			       : (fl->fl_type & LOCK_WRITE) ? "WRITE" : "NONE ");
-	} else
-#endif
+	} else {
 		out += sprintf(out, "%s ",
 			       (fl->fl_type & F_WRLCK) ? "WRITE" : "READ ");
+	}
 	out += sprintf(out, "%d %s:%ld ",
 		     fl->fl_pid,
 		     inode ? kdevname(inode->i_dev) : "<none>",
@@ -1818,7 +1807,6 @@
 	return length;
 }
 
-#ifdef MSNFS
 /**
  *	lock_may_read - checks that the region is free of locks
  *	@inode: the inode that is being read
@@ -1892,7 +1880,6 @@
 	unlock_kernel();
 	return result;
 }
-#endif
 
 static int __init filelock_init(void)
 {

-- 
Revolutions do not require corporate support.
