Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272481AbTHJIEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 04:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272548AbTHJIEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 04:04:52 -0400
Received: from smtp4.pacifier.net ([64.255.237.174]:29889 "EHLO
	smtp4.pacifier.net") by vger.kernel.org with ESMTP id S272481AbTHJIEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 04:04:25 -0400
Date: Sun, 10 Aug 2003 01:04:20 -0700
From: "B. D. Elliott" <bde@nwlink.com>
To: linux-kernel@vger.kernel.org
Subject: A Mess in 2.5/2.6- proc-pid Permissions
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Message-Id: <20030810074057.840CA6A8DD@smtp4.pacifier.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever I log in to a late 2.5 or 2.6-pre, I see the following:

    laptop login: bde
    Password: 
    Last login: Tue Aug  5 02:54:35 on tty3
    bash: /dev/fd/62: Permission denied
    test: : integer expression expected
    laptop:/home/bde: 

This occurs through getty, telnetd, and sshd.

The problem is that my .bash_profile contains the following line, as a
part of setting up a possible "chroot-" prefix on my prompt:

    read -a CHR__ < <(ls -id /)

This, in turn, uses the "/dev/fd" capability for the command redirection.

Looking at /proc/$$ shows the immediate problem:

    laptop:/home/bde: ls -lR /proc/$$
    /proc/1395:
    total 0
    -r--r--r--    1 bde      users           0 Aug 10 00:24 cmdline
    lrwxrwxrwx    1 bde      users           0 Aug 10 00:24 cwd -> /home/bde/
    -r--------    1 bde      users           0 Aug 10 00:24 environ
    lrwxrwxrwx    1 bde      users           0 Aug 10 00:24 exe -> /bin/bash*
    dr-x------    2 root     root            0 Aug 10 00:22 fd/
    -r--r--r--    1 bde      users           0 Aug 10 00:24 maps
    -rw-------    1 bde      users           0 Aug 10 00:24 mem
    -r--r--r--    1 bde      users           0 Aug 10 00:24 mounts
    lrwxrwxrwx    1 bde      users           0 Aug 10 00:24 root -> //
    -r--r--r--    1 bde      users           0 Aug 10 00:24 stat
    -r--r--r--    1 bde      users           0 Aug 10 00:24 statm
    -r--r--r--    1 bde      users           0 Aug 10 00:24 status
    -r--r--r--    1 bde      users           0 Aug 10 00:24 wchan

    ls: /proc/1395/fd: Permission denied
    laptop:/home/bde:

To see how this comes about, try the following:

1.  Log in as somebody.

2.  Do su - to become root; then do "ls -lR /proc/$$".  This will look like:

    laptop:/home/bde: su -
    Password:
    laptop:/root# ls -lR /proc/$$
    /proc/1405:
    total 0
    -r--r--r--    1 root     root            0 Aug 10 00:27 cmdline
    lrwxrwxrwx    1 root     root            0 Aug 10 00:27 cwd -> /root/
    -r--------    1 root     root            0 Aug 10 00:27 environ
    lrwxrwxrwx    1 root     root            0 Aug 10 00:27 exe -> /bin/bash*
    dr-x------    2 root     root            0 Aug 10 00:27 fd/
    -r--r--r--    1 root     root            0 Aug 10 00:27 maps
    -rw-------    1 root     root            0 Aug 10 00:27 mem
    -r--r--r--    1 root     root            0 Aug 10 00:27 mounts
    lrwxrwxrwx    1 root     root            0 Aug 10 00:27 root -> //
    -r--r--r--    1 root     root            0 Aug 10 00:27 stat
    -r--r--r--    1 root     root            0 Aug 10 00:27 statm
    -r--r--r--    1 root     root            0 Aug 10 00:27 status
    -r--r--r--    1 root     root            0 Aug 10 00:27 wchan

    /proc/1405/fd:
    total 0
    lrwx------    1 root     root           64 Aug 10 00:27 0 -> /dev/pts/1
    lrwx------    1 root     root           64 Aug 10 00:27 1 -> /dev/pts/1
    lrwx------    1 root     root           64 Aug 10 00:27 2 -> /dev/pts/1
    lrwx------    1 root     root           64 Aug 10 00:27 255 -> /dev/pts/1
    laptop:/root# 

3.  Now do "exec su - some-user"; then repeat "ls -lR /proc/$$".

    laptop:/root# exec su - bde
    bash: /dev/fd/62: Permission denied
    test: : integer expression expected
    laptop:/home/bde: ls -lR /proc/$$
    ls: /proc/1405/cwd: Permission denied
    ls: /proc/1405/root: Permission denied
    ls: /proc/1405/exe: Permission denied
    /proc/1405:
    total 0
    -r--r--r--    1 root     root            0 Aug 10 00:27 cmdline
    lrwxrwxrwx    1 root     root            0 Aug 10 00:27 cwd
    -r--------    1 root     root            0 Aug 10 00:27 environ
    lrwxrwxrwx    1 root     root            0 Aug 10 00:27 exe
    dr-x------    2 root     root            0 Aug 10 00:27 fd/
    -r--r--r--    1 root     root            0 Aug 10 00:27 maps
    -rw-------    1 root     root            0 Aug 10 00:27 mem
    -r--r--r--    1 root     root            0 Aug 10 00:27 mounts
    lrwxrwxrwx    1 root     root            0 Aug 10 00:27 root
    -r--r--r--    1 root     root            0 Aug 10 00:27 stat
    -r--r--r--    1 root     root            0 Aug 10 00:27 statm
    -r--r--r--    1 root     root            0 Aug 10 00:27 status
    -r--r--r--    1 root     root            0 Aug 10 00:27 wchan

    ls: /proc/1405/fd: Permission denied
    laptop:/home/bde: 

4.  Now exit from the current shell (the one invoked from the login shell).

5.  Repeat the above sequence __without__ the "ls -lR /proc/$$" as root.

    laptop:/home/bde: su -
    Password:
    laptop:/root# exec su - bde
    laptop:/home/bde: ls -lR /proc/$$
    /proc/1417:
    total 0
    -r--r--r--    1 bde      users           0 Aug 10 00:32 cmdline
    lrwxrwxrwx    1 bde      users           0 Aug 10 00:32 cwd -> /home/bde/
    -r--------    1 bde      users           0 Aug 10 00:32 environ
    lrwxrwxrwx    1 bde      users           0 Aug 10 00:32 exe -> /bin/bash*
    dr-x------    2 bde      users           0 Aug 10 00:32 fd/
    -r--r--r--    1 bde      users           0 Aug 10 00:32 maps
    -rw-------    1 bde      users           0 Aug 10 00:32 mem
    -r--r--r--    1 bde      users           0 Aug 10 00:32 mounts
    lrwxrwxrwx    1 bde      users           0 Aug 10 00:32 root -> //
    -r--r--r--    1 bde      users           0 Aug 10 00:32 stat
    -r--r--r--    1 bde      users           0 Aug 10 00:32 statm
    -r--r--r--    1 bde      users           0 Aug 10 00:32 status
    -r--r--r--    1 bde      users           0 Aug 10 00:32 wchan

    /proc/1417/fd:
    total 0
    lrwx------    1 bde      users          64 Aug 10 00:32 0 -> /dev/pts/1
    lrwx------    1 bde      users          64 Aug 10 00:32 1 -> /dev/pts/1
    lrwx------    1 bde      users          64 Aug 10 00:32 2 -> /dev/pts/1
    lrwx------    1 bde      users          64 Aug 10 00:32 255 -> /dev/pts/1
    laptop:/home/bde: 

The real problem here is that the inode ownership for the proc-pid files
is set on the first access (when the inode is created).  If the uid
changes, which it does during login, the old one remains, preventing any
legitimate access.

The following "sort-of" patch appears to fix this for me.  I don't know
whether some locking rules might be violated, however.  The patch resets
the inode uid/gid to the present euid/egid at each "revalidate" call.

========================================================================
--- ./fs/proc/base.c.orig	2003-08-08 21:38:05.000000000 -0700
+++ ./fs/proc/base.c	2003-08-09 01:50:03.000000000 -0700
@@ -867,8 +867,13 @@
  */
 static int pid_revalidate(struct dentry * dentry, struct nameidata *nd)
 {
-	if (pid_alive(proc_task(dentry->d_inode)))
+	if (pid_alive(proc_task(dentry->d_inode))) {
+		struct task_struct *task = proc_task(dentry->d_inode);
+
+		dentry->d_inode->i_uid = task->euid;
+		dentry->d_inode->i_gid = task->egid;
 		return 1;
+	}
 	d_drop(dentry);
 	return 0;
 }
@@ -889,6 +894,8 @@
 		if (fcheck_files(files, fd)) {
 			spin_unlock(&files->file_lock);
 			put_files_struct(files);
+			dentry->d_inode->i_uid = task->euid;
+			dentry->d_inode->i_gid = task->egid;
 			return 1;
 		}
 		spin_unlock(&files->file_lock);
========================================================================

-- 
B. D. Elliott   bde@nwlink.com
