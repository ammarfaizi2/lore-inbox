Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278041AbRKFEs1>; Mon, 5 Nov 2001 23:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281458AbRKFEsR>; Mon, 5 Nov 2001 23:48:17 -0500
Received: from e22.nc.us.ibm.com ([32.97.136.228]:44487 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278041AbRKFEsF>; Mon, 5 Nov 2001 23:48:05 -0500
Date: Tue, 6 Nov 2001 10:24:06 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: viro@math.psu.edu
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] proc_readfd race
Message-ID: <20011106102406.F23390@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

proc_readfd calls fcheck_files() without taking read_lock() for the 
files_struct which could end up in race with expand_fd_array(). The patch
below puts the read_lock to avoid that. I am not very sure if this is already
protected by some other means and read_lock is not needed.

Please comment.

Thank you,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5262355 Extn. 3999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html

diff -urN linux-2.4.14-pre8-orig/fs/proc/base.c linux-2.4.14pre8/fs/proc/base.c
--- linux-2.4.14-pre8-orig/fs/proc/base.c	Tue Nov  6 10:13:27 2001
+++ linux-2.4.14pre8/fs/proc/base.c	Tue Nov  6 10:02:19 2001
@@ -553,6 +553,7 @@
 			task_unlock(p);
 			if (!files)
 				goto out;
+			read_lock(&files->file_lock);
 			for (fd = filp->f_pos-2;
 			     fd < files->max_fds;
 			     fd++, filp->f_pos++) {
@@ -561,6 +562,7 @@
 				if (!fcheck_files(files, fd))
 					continue;
 
+				read_unlock(&files->file_lock);
 				j = NUMBUF;
 				i = fd;
 				do {
@@ -571,8 +573,11 @@
 
 				ino = fake_ino(pid, PROC_PID_FD_DIR + fd);
 				if (filldir(dirent, buf+j, NUMBUF-j, fd+2, ino, DT_LNK) < 0)
-					break;
+					goto done;
+				read_lock(&files->file_lock);
 			}
+			read_unlock(&files->file_lock);
+done:
 			put_files_struct(files);
 	}
 out:
