Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbTD2Lpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 07:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTD2Lpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 07:45:45 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:63247 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261609AbTD2Lpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 07:45:43 -0400
Date: Tue, 29 Apr 2003 13:58:00 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH][2.4] fix permissions in /proc
Message-ID: <20030429115800.GA18590@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

On server installations, I'm used to reduce binary file read access to a
special group to make it more difficult for an eventual intruder to copy a
shell, install trivial trojans, get a core, etc. when not root and not in the
required group.  Eg:

bash-2.03$ ls -la /bin/bash /bin/cat /bin/ls
-rwxr-x--x    1 root     bin        437844 Feb 14 08:44 /bin/bash
-rwxr-x--x    1 root     bin         13040 Jan 25 16:03 /bin/cat
-rwxr-x--x    1 root     bin         63248 Jan 25 16:03 /bin/ls

Obviously, this does not radically protect the system against any attacks, but
it slows down the intrusion because the intruder has to use his imagination
when his tools don't work as expected.

I recently noticed that because of this, a simple user cannot use the common
"cat /dev/fd/0" or "cat /proc/self/fd/0" tricks, because permissions in /proc
are restricted to root only, when the task is not dumpable.

I understand that this is useful for several things, but I can't find a case
where preventing a user from seeing his own FDs may increase system security,
regardless if the task is dumpable or not.

So I applied this little patch to my kernel (2.4.21-rc1) which allowed me to
access my FDs again. Does anybody think it represents a security flaw ? if
not, would it be possible to integrate it into 2.4.21 as a fix, since it now
makes the kernel behave accordingly to what is described in proc(5) ?

Here's what I get before and after the patch :

#### before ####

bash-2.03$ cat /proc/self/fd/0
cat: /proc/self/fd/0: Permission denied

bash-2.03$ ls -la /proc/self/fd/0
ls: /proc/self/fd/0: Permission denied

bash-2.03$ ls -la /proc/self/fd/
ls: /proc/self/fd/: Permission denied

bash-2.03$ ls -la /proc/self/
ls: cannot read symbolic link /proc/self/cwd: Permission denied
ls: cannot read symbolic link /proc/self/root: Permission denied
ls: cannot read symbolic link /proc/self/exe: Permission denied
total 0
dr-xr-xr-x    3 willy    users           0 Apr 29 13:51 ./
dr-xr-xr-x   77 root     root            0 Apr 29  2003 ../
-r--r--r--    1 root     root            0 Apr 29 13:51 cmdline
lrwxrwxrwx    1 root     root            0 Apr 29 13:51 cwd
-r--------    1 root     root            0 Apr 29 13:51 environ
lrwxrwxrwx    1 root     root            0 Apr 29 13:51 exe
dr-x------    2 root     root            0 Apr 29 13:51 fd/
-r--r--r--    1 root     root            0 Apr 29 13:51 maps
-rw-------    1 root     root            0 Apr 29 13:51 mem
-r--r--r--    1 root     root            0 Apr 29 13:51 mounts
lrwxrwxrwx    1 root     root            0 Apr 29 13:51 root
-r--r--r--    1 root     root            0 Apr 29 13:51 stat
-r--r--r--    1 root     root            0 Apr 29 13:51 statm
-r--r--r--    1 root     root            0 Apr 29 13:51 status

#### after ####

bash-2.03$ cat /proc/self/fd/0
blah
blah

bash-2.03$ ls -la /proc/self/fd/0
lrwx------    1 willy    users          64 Apr 29 13:52 /proc/self/fd/0 -> /dev/pts/0

bash-2.03$ ls -la /proc/self/fd/ 
total 0
dr-x------    2 willy    users           0 Apr 29 13:52 ./
dr-xr-xr-x    3 willy    users           0 Apr 29 13:52 ../
lrwx------    1 willy    users          64 Apr 29 13:52 0 -> /dev/pts/0
lrwx------    1 willy    users          64 Apr 29 13:52 1 -> /dev/pts/0
lrwx------    1 willy    users          64 Apr 29 13:52 2 -> /dev/pts/0
lr-x------    1 willy    users          64 Apr 29 13:52 3 -> /proc/701/fd/

bash-2.03$ ls -la /proc/self/   
ls: cannot read symbolic link /proc/self/cwd: Permission denied
ls: cannot read symbolic link /proc/self/root: Permission denied
ls: cannot read symbolic link /proc/self/exe: Permission denied
total 0
dr-xr-xr-x    3 willy    users           0 Apr 29 13:52 ./
dr-xr-xr-x   77 root     root            0 Apr 29  2003 ../
-r--r--r--    1 root     root            0 Apr 29 13:52 cmdline
lrwxrwxrwx    1 root     root            0 Apr 29 13:52 cwd
-r--------    1 root     root            0 Apr 29 13:52 environ
lrwxrwxrwx    1 root     root            0 Apr 29 13:52 exe
dr-x------    2 willy    users           0 Apr 29 13:52 fd/
-r--r--r--    1 root     root            0 Apr 29 13:52 maps
-rw-------    1 root     root            0 Apr 29 13:52 mem
-r--r--r--    1 root     root            0 Apr 29 13:52 mounts
lrwxrwxrwx    1 root     root            0 Apr 29 13:52 root
-r--r--r--    1 root     root            0 Apr 29 13:52 stat
-r--r--r--    1 root     root            0 Apr 29 13:52 statm
-r--r--r--    1 root     root            0 Apr 29 13:52 status


#### and here is the patch against 2.4.21-rc1 ####

diff -ur linux-2.4.21-rc1/fs/proc/base.c linux-2.4.21-rc1-procfs-fix/fs/proc/base.c
--- linux-2.4.21-rc1/fs/proc/base.c	Tue Jan  7 15:50:14 2003
+++ linux-2.4.21-rc1-procfs-fix/fs/proc/base.c	Tue Apr 29 13:25:24 2003
@@ -711,7 +711,7 @@
 	inode->u.proc_i.task = task;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
-	if (ino == PROC_PID_INO || task_dumpable(task)) {
+	if (ino == PROC_PID_INO || ino == PROC_PID_FD || ino >= PROC_PID_FD_DIR || task_dumpable(task)) {
 		inode->i_uid = task->euid;
 		inode->i_gid = task->egid;
 	}

###

Any comments ?

Regards,
Willy

