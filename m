Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbREVNMh>; Tue, 22 May 2001 09:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbREVNM1>; Tue, 22 May 2001 09:12:27 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:261 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261513AbREVNMS>; Tue, 22 May 2001 09:12:18 -0400
From: Matt Chapman <matthewc@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 22 May 2001 23:11:40 +1000
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux FS-Devel <linux-fsdevel@vger.kernel.org>
Subject: Fix for an SMP locking bug in NFS code
Message-ID: <20010522231139.A515@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I've already run this by Trond so I'm sending this patch without
further ado.  It adds a lock_kernel around a call into NLM code,
and removes an extraneous (really) lock_kernel in sys_fcntl64.

In more detail:

There's no lock_kernel around the F_SETLK case in fcntl, but
some of the NLM code which gets called in the NFS case needs
to be protected by locks (in particular, nlmclnt_block fiddles
with the global list nlm_blocked).  We decided that, to protect
the RPC code as well, the best place to put a lock would be
around the call to nlmclnt_proc in nfs_lock.

There is, on the other hand, a lock_kernel in fcntl64, and
analysis shows that if it's not needed in fcntl - which it
shouldn't be, if the filesystems do any necessary locking -
then it's not needed in fcntl64 either (the code is essentially
identical).

Cheers,
Matt


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nfslockfix-2.4.5-pre4.diff"

diff -u --recursive --new-file linux-2.4.5-pre4/fs/fcntl.c linux-2.4.5-pre4-nfslockfix/fs/fcntl.c
--- linux-2.4.5-pre4/fs/fcntl.c	Thu Nov 16 17:50:25 2000
+++ linux-2.4.5-pre4-nfslockfix/fs/fcntl.c	Tue May 22 22:37:32 2001
@@ -338,7 +338,6 @@
 	if (!filp)
 		goto out;
 
-	lock_kernel();
 	switch (cmd) {
 		case F_GETLK64:
 			err = fcntl_getlk64(fd, (struct flock64 *) arg);
@@ -353,7 +352,6 @@
 			err = do_fcntl(fd, cmd, arg, filp);
 			break;
 	}
-	unlock_kernel();
 	fput(filp);
 out:
 	return err;
diff -u --recursive --new-file linux-2.4.5-pre4/fs/nfs/file.c linux-2.4.5-pre4-nfslockfix/fs/nfs/file.c
--- linux-2.4.5-pre4/fs/nfs/file.c	Tue May 22 22:32:52 2001
+++ linux-2.4.5-pre4-nfslockfix/fs/nfs/file.c	Tue May 22 22:36:00 2001
@@ -299,10 +299,13 @@
 	if (status < 0)
 		return status;
 
-	if ((status = nlmclnt_proc(inode, cmd, fl)) < 0)
+	lock_kernel();
+	status = nlmclnt_proc(inode, cmd, fl);
+	unlock_kernel();
+	if (status < 0)
 		return status;
-	else
-		status = 0;
+	
+	status = 0;
 
 	/*
 	 * Make sure we clear the cache whenever we try to get the lock.

--r5Pyd7+fXNt84Ff3--
