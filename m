Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130673AbRAPGyl>; Tue, 16 Jan 2001 01:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130882AbRAPGyc>; Tue, 16 Jan 2001 01:54:32 -0500
Received: from xiomara.msg.com.mx ([200.33.54.2]:35848 "HELO
	xiomara.msg.com.mx") by vger.kernel.org with SMTP
	id <S130673AbRAPGyT>; Tue, 16 Jan 2001 01:54:19 -0500
Date: Tue, 16 Jan 2001 00:53:47 -0600 (EST)
From: Salvador Ortiz Garcia <sog@msg.com.mx>
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
Subject: 2.4.0 - lseek on /proc broken? [with patch]
Message-ID: <Pine.LNX.4.10.10101160024480.20764-100000@xiomara.msg.com.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi:

After diging around for some problems (shutdown/unmount related) I found
that some processes where hidden from ps, pidoff, ls /proc, etc.

A strace reveled that:

open("/proc", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 7
fstat(7, {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
fcntl(7, F_SETFD, FD_CLOEXEC)           = 0
getdents(7, /* 58 entries */, 984)      = 980
lseek(7, 265, SEEK_SET)                 = -1 EINVAL (Invalid argument)

So I change proc_root_operations to use proc_file_lseek and the problems
vanished.

Comments?

Salvador Ortiz.
please CCs to me.

 
=========== cut ===========
diff -u linux/fs/proc/generic.c linux-2.4.0-ac7/fs/proc/generic.c
--- linux/fs/proc/generic.c	Mon Dec 11 15:45:42 2000
+++ linux-2.4.0-msg/fs/proc/generic.c	Tue Jan 16 00:05:24 2001
@@ -22,7 +22,7 @@
 			      size_t nbytes, loff_t *ppos);
 static ssize_t proc_file_write(struct file * file, const char * buffer,
 			       size_t count, loff_t *ppos);
-static loff_t proc_file_lseek(struct file *, loff_t, int);
+loff_t proc_file_lseek(struct file *, loff_t, int);
 
 int proc_match(int len, const char *name,struct proc_dir_entry * de)
 {
@@ -137,7 +137,7 @@
 }
 
 
-static loff_t
+loff_t
 proc_file_lseek(struct file * file, loff_t offset, int orig)
 {
     switch (orig) {
diff -u linux/fs/proc/root.c linux-2.4.0-ac7/fs/proc/root.c
--- linux/fs/proc/root.c	Thu Nov 23 11:07:36 2000
+++ linux-2.4.0-msg/fs/proc/root.c	Tue Jan 16 00:05:27 2001
@@ -81,7 +81,9 @@
  * <pid> directories. Thus we don't use the generic
  * directory handling functions for that..
  */
+extern loff_t proc_file_lseek(struct file *, loff_t, int);
 static struct file_operations proc_root_operations = {
+	llseek:		 proc_file_lseek,
 	read:		 generic_read_dir,
 	readdir:	 proc_root_readdir,
 };

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
