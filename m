Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <159972-215>; Fri, 12 Mar 1999 02:10:40 -0500
Received: by vger.rutgers.edu id <157506-215>; Fri, 12 Mar 1999 02:10:23 -0500
Received: from ann.ixlabs.com ([208.201.250.22]:1104 "EHLO ann.ixlabs.com" ident: "root") by vger.rutgers.edu with ESMTP id <157498-212>; Fri, 12 Mar 1999 02:10:11 -0500
Message-Id: <199903120707.XAA03144@ann.ixlabs.com>
To: linux-kernel@vger.rutgers.edu
Cc: quinlan@transmeta.com, hjl@varesearch.com
Subject: Linux @ Connectathon results
Date: Thu, 11 Mar 1999 23:07:02 -0800
From: "G. Allen Morris III" <gam3@ann.ixlabs.com>
Sender: owner-linux-kernel@vger.rutgers.edu


  Daniel Quinlan, H.J. Lu, and G. Allen Morris III (me) spent
parts of the last week testing the Linux 2.2.[23] nfs client
and server at the Connectathon (http://www.connectathon.org).
H.J. Lu did a large amount of testing before the event that
made it possible to have patches available at the event.

Here are some of the results of this testing as posted by Dan
Quinlan:

  Here is the final set of patches that yielded the best results
  (against 2.2.3).  We should try to put them into 2.2 eventually since
  they don't break anything.

	nfsv2-wsize-0.d.dif (trond: wsize=8k, write gathering)

	  Without this patch, performance against correct NFSv2 servers that
	  lack write cache was abysmal.  However, it reduces performance
	  against NFSv2 servers that have a write cache (like NetApps) by
	  about 10%.  That should be addressed, but what we should instead
	  concentrate on is NFSv3.
	
	  The patch didn't change any pass/fail test results.

	nfsd-2.2.2-1.patch (gam3: NFS rename cache and other assorted changes)

	  We fail various tests without this patch, but I think we should
	  be able to make long-term improvements (in 2.3) that make the rename cache
	  necessary only when running NFS on top of odd filesystems like vfat.

	locks-2.2.2.diff (hjl: short patch to address 3 lock test warnings)

	  Fixes several minor problems.  Didn't cause any additional test
	  failures.


  The patches can be found at:

  http://www.fys.uio.no/~trondmy/src/
  http://www.csua.berkeley.edu/~gam3/knfsd/

  and right here:

Index: fs/locks.c
===================================================================
RCS file: /local/work/cvs/linux/linux/fs/locks.c,v
retrieving revision 1.1.1.16
diff -u -p -r1.1.1.16 locks.c
- --- fs/locks.c	1999/01/27 00:28:56	1.1.1.16
+++ fs/locks.c	1999/02/14 01:26:10
@@ -111,7 +111,9 @@
 
 #include <asm/uaccess.h>
 
- -#define OFFSET_MAX	((off_t)0x7fffffff)	/* FIXME: move elsewhere? */
+/* FIXME: move elsewhere? */
+#define OFFSET_MAX	((off_t) (sizeof (off_t) == 4 \
+				  ? 0x7fffffff : 0x7fffffffffffffffL))
 
 static int flock_make_lock(struct file *filp, struct file_lock *fl,
 			       unsigned int cmd);
@@ -672,8 +674,11 @@ static int posix_make_lock(struct file *
 
 	if (((start += l->l_start) < 0) || (l->l_len < 0))
 		return (0);
+	fl->fl_end = start + l->l_len - 1;
+	if (l->l_len > 0 && fl->fl_end < 0)
+		return (0);
 	fl->fl_start = start;	/* we record the absolute position */
- -	if ((l->l_len == 0) || ((fl->fl_end = start + l->l_len - 1) < 0))
+	if (l->l_len == 0)
 		fl->fl_end = OFFSET_MAX;
 	
 	fl->fl_file = filp;

------- End of Forwarded Message


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
