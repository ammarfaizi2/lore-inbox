Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281786AbRKQRv5>; Sat, 17 Nov 2001 12:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281787AbRKQRvs>; Sat, 17 Nov 2001 12:51:48 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:26356 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281786AbRKQRvf>;
	Sat, 17 Nov 2001 12:51:35 -0500
Date: Sat, 17 Nov 2001 12:51:33 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: wwcopt@optonline.net, linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] Re: 2.4.15-pre5: /proc/cpuinfo broken
In-Reply-To: <15350.36701.89478.960625@kruemel.monster.org>
Message-ID: <Pine.GSO.4.21.0111171250310.11475-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2001, Wolfgang Wander wrote:

>   Actually its bash - 2.04.0(1)-release (i386-suse-linux)

2.03.0(1)-release (i386-pc-linux-gnu) (Debian variant) works here.

OK, let's see what can be done.  Situation is the same for all seq_file-based
files.

	a) we can revert to old code.  Which had a lot of problems, quite
a few of them unfixable if we want to have lseek() to calculated position.

	b) we can change i_mode for these files, making them S_IFIFO.
That will stop any silliness (if something would rely on seeking
backwards for something that looks like a pipe, it would break on
real pipes, etc. and that's not too likely to stay unnoticed, to put
it mildly).  And that's trivial to implement.

	c) hunt down and fix the userland that relies on arithmetics
on file position in case of regular files (POSIX prohibits it, SuS allows).

(a) - lots of bad problems, including unsolvable userland races.
(b) - user-visible change, but one that is very unlikely to break
anything.
(c) - yeah, right.  In the middle of 2.4.  Since such stuff exists and is
widely used, it's out of question.  Pity, but there's nothing to do about
that.

Frankly, I'd prefer to try (b) before reverting to (a).  Patch doing that
variant follows.  Linus, your opinion?

diff -urN S15-pre5/fs/proc/inode.c S15-pre5-proc/fs/proc/inode.c
--- S15-pre5/fs/proc/inode.c	Tue Oct  9 21:47:27 2001
+++ S15-pre5-proc/fs/proc/inode.c	Sat Nov 17 12:38:08 2001
@@ -160,14 +160,12 @@
 			inode->i_nlink = de->nlink;
 		if (de->owner)
 			__MOD_INC_USE_COUNT(de->owner);
-		if (S_ISBLK(de->mode)||S_ISCHR(de->mode)||S_ISFIFO(de->mode))
+		if (de->proc_iops)
+			inode->i_op = de->proc_iops;
+		if (de->proc_fops)
+			inode->i_fop = de->proc_fops;
+		else if (S_ISBLK(de->mode)||S_ISCHR(de->mode)||S_ISFIFO(de->mode))
 			init_special_inode(inode,de->mode,kdev_t_to_nr(de->rdev));
-		else {
-			if (de->proc_iops)
-				inode->i_op = de->proc_iops;
-			if (de->proc_fops)
-				inode->i_fop = de->proc_fops;
-		}
 	}
 
 out:
diff -urN S15-pre5/fs/proc/proc_misc.c S15-pre5-proc/fs/proc/proc_misc.c
--- S15-pre5/fs/proc/proc_misc.c	Thu Nov 15 23:43:07 2001
+++ S15-pre5-proc/fs/proc/proc_misc.c	Sat Nov 17 12:38:15 2001
@@ -519,6 +519,14 @@
 
 struct proc_dir_entry *proc_root_kcore;
 
+static void create_seq_entry(char *name, mode_t mode, struct file_operations *f)
+{
+	struct proc_dir_entry *entry;
+	entry = create_proc_entry(name, mode|S_IFIFO, NULL);
+	if (entry)
+		entry->proc_fops = f;
+}
+
 void __init proc_misc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -568,16 +576,10 @@
 	entry = create_proc_entry("kmsg", S_IRUSR, &proc_root);
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
-	entry = create_proc_entry("mounts", 0, NULL);
-	if (entry)
-		entry->proc_fops = &proc_mounts_operations;
-	entry = create_proc_entry("cpuinfo", 0, NULL);
-	if (entry)
-		entry->proc_fops = &proc_cpuinfo_operations;
+	create_seq_entry("mounts", 0, &proc_mounts_operations);
+	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 #ifdef CONFIG_MODULES
-	entry = create_proc_entry("ksyms", 0, NULL);
-	if (entry)
-		entry->proc_fops = &proc_ksyms_operations;
+	create_seq_entry("cpuinfo", 0, &proc_ksyms_operations);
 #endif
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {


