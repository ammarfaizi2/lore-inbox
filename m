Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUDOCjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 22:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbUDOCjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 22:39:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:7908 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261802AbUDOCiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 22:38:51 -0400
Message-ID: <407DF5AD.5090909@austin.ibm.com>
Date: Wed, 14 Apr 2004 21:38:37 -0500
From: Nathan Lynch <nathanl@austin.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Olof Johansson <olof@austin.ibm.com>
Subject: Re: [PATCH] Increase number of dynamic inodes in procfs (2.6.5)
References: <407C4130.8000901@austin.ibm.com> <20040413170642.22894ebc.akpm@osdl.org>
In-Reply-To: <20040413170642.22894ebc.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000902090900030803060602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000902090900030803060602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Nathan Lynch <nathanl@austin.ibm.com> wrote:
> 
>>On some larger ppc64 configurations /proc/device-tree is exhausting 
>> procfs' dynamic (non-pid) inode range (16K).  This patch makes the 
>> dynamic inode range 0xf0000000-0xffffffff
>>and changes the inode number 
>> allocator to use a growable linked list of bitmaps.
> 
> This open-codes a simple version of lib/idr.c.  Please use lib/idr.c
> instead.  There's an example in fs/super.c

Ok, thanks for the tip.  Is this better?

Nathan

--------------000902090900030803060602
Content-Type: text/x-patch;
 name="procfs_inum_idr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="procfs_inum_idr.patch"

diff -pru linux-2.6.5-mm4/fs/proc/generic.c linux-2.6.5-mm4.new/fs/proc/generic.c
--- linux-2.6.5-mm4/fs/proc/generic.c	2004-04-14 20:32:34.000000000 -0500
+++ linux-2.6.5-mm4.new/fs/proc/generic.c	2004-04-14 20:34:57.000000000 -0500
@@ -15,6 +15,8 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/smp_lock.h>
+#include <linux/init.h>
+#include <linux/idr.h>
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
 
@@ -275,24 +277,51 @@ static int xlate_proc_name(const char *n
 	return 0;
 }
 
-static unsigned long proc_alloc_map[(PROC_NDYNAMIC + BITS_PER_LONG - 1) / BITS_PER_LONG];
+static struct idr proc_inum_idr;
+static spinlock_t proc_inum_lock = SPIN_LOCK_UNLOCKED; /* protects the above */
 
-spinlock_t proc_alloc_map_lock = SPIN_LOCK_UNLOCKED;
+#define PROC_DYNAMIC_FIRST 0xF0000000UL
 
-static int make_inode_number(void)
+void __init init_proc_inum_idr(void)
 {
-	int i;
-	spin_lock(&proc_alloc_map_lock);
-	i = find_first_zero_bit(proc_alloc_map, PROC_NDYNAMIC);
-	if (i < 0 || i >= PROC_NDYNAMIC) {
-		i = -1;
-		goto out;
-	}
-	set_bit(i, proc_alloc_map);
-	i += PROC_DYNAMIC_FIRST;
-out:
-	spin_unlock(&proc_alloc_map_lock);
-	return i;
+	idr_init(&proc_inum_idr);
+}
+
+/*
+ * Return an inode number between PROC_DYNAMIC_FIRST and
+ * 0xffffffff, or zero on failure.
+ */
+static unsigned int get_inode_number(void)
+{
+	unsigned int i, inum = 0;
+
+retry:
+	if (0 == idr_pre_get(&proc_inum_idr, GFP_KERNEL))
+		return 0;
+
+	spin_lock(&proc_inum_lock);
+	i = idr_get_new(&proc_inum_idr, NULL);
+	spin_unlock(&proc_inum_lock);
+
+	if (i == -1)
+		goto retry;
+
+	inum = (i & MAX_ID_MASK) + PROC_DYNAMIC_FIRST;
+
+	/* inum will never be more than 0xf0ffffff, so no check
+	 * for overflow.
+	 */
+
+	return inum;
+}
+
+static void release_inode_number(unsigned int inum)
+{
+	int id = (inum - PROC_DYNAMIC_FIRST) | ~MAX_ID_MASK;
+
+	spin_lock(&proc_inum_lock);
+	idr_remove(&proc_inum_idr, id);
+	spin_unlock(&proc_inum_lock);
 }
 
 static int
@@ -346,7 +375,7 @@ struct dentry *proc_lookup(struct inode 
 			if (de->namelen != dentry->d_name.len)
 				continue;
 			if (!memcmp(dentry->d_name.name, de->name, de->namelen)) {
-				int ino = de->low_ino;
+				unsigned int ino = de->low_ino;
 				error = -EINVAL;
 				inode = proc_get_inode(dir->i_sb, ino, de);
 				break;
@@ -452,10 +481,10 @@ static struct inode_operations proc_dir_
 
 static int proc_register(struct proc_dir_entry * dir, struct proc_dir_entry * dp)
 {
-	int	i;
+	unsigned int i;
 	
-	i = make_inode_number();
-	if (i < 0)
+	i = get_inode_number();
+	if (i == 0)
 		return -EAGAIN;
 	dp->low_ino = i;
 	dp->next = dir->subdir;
@@ -621,11 +650,13 @@ struct proc_dir_entry *create_proc_entry
 
 void free_proc_entry(struct proc_dir_entry *de)
 {
-	int ino = de->low_ino;
+	unsigned int ino = de->low_ino;
 
-	if (ino < PROC_DYNAMIC_FIRST ||
-	    ino >= PROC_DYNAMIC_FIRST+PROC_NDYNAMIC)
+	if (ino < PROC_DYNAMIC_FIRST)
 		return;
+
+	release_inode_number(ino);
+
 	if (S_ISLNK(de->mode) && de->data)
 		kfree(de->data);
 	kfree(de);
@@ -653,8 +684,6 @@ void remove_proc_entry(const char *name,
 		de->next = NULL;
 		if (S_ISDIR(de->mode))
 			parent->nlink--;
-		clear_bit(de->low_ino - PROC_DYNAMIC_FIRST,
-			  proc_alloc_map);
 		proc_kill_inodes(de);
 		de->nlink = 0;
 		WARN_ON(de->subdir);
diff -pru linux-2.6.5-mm4/fs/proc/inode-alloc.txt linux-2.6.5-mm4.new/fs/proc/inode-alloc.txt
--- linux-2.6.5-mm4/fs/proc/inode-alloc.txt	2004-01-09 00:59:26.000000000 -0600
+++ linux-2.6.5-mm4.new/fs/proc/inode-alloc.txt	2004-04-14 20:34:57.000000000 -0500
@@ -4,9 +4,10 @@ Current inode allocations in the proc-fs
   00000001-00000fff	static entries	(goners)
        001		root-ino
 
-  00001000-00001fff	dynamic entries
+  00001000-00001fff	unused
   0001xxxx-7fffxxxx	pid-dir entries for pid 1-7fff
-  80000000-ffffffff	unused
+  80000000-efffffff	unused
+  f0000000-ffffffff	dynamic entries
 
 Goal:
 	a) once we'll split the thing into several virtual filesystems we
diff -pru linux-2.6.5-mm4/fs/proc/inode.c linux-2.6.5-mm4.new/fs/proc/inode.c
--- linux-2.6.5-mm4/fs/proc/inode.c	2004-04-14 20:32:34.000000000 -0500
+++ linux-2.6.5-mm4.new/fs/proc/inode.c	2004-04-14 20:34:57.000000000 -0500
@@ -181,7 +181,7 @@ static int parse_options(char *options,u
 	return 1;
 }
 
-struct inode * proc_get_inode(struct super_block * sb, int ino,
+struct inode * proc_get_inode(struct super_block * sb, unsigned int ino,
 				struct proc_dir_entry * de)
 {
 	struct inode * inode;
diff -pru linux-2.6.5-mm4/include/linux/proc_fs.h linux-2.6.5-mm4.new/include/linux/proc_fs.h
--- linux-2.6.5-mm4/include/linux/proc_fs.h	2004-04-14 20:32:35.000000000 -0500
+++ linux-2.6.5-mm4.new/include/linux/proc_fs.h	2004-04-14 20:34:57.000000000 -0500
@@ -26,9 +26,6 @@ enum {
 
 /* Finally, the dynamically allocatable proc entries are reserved: */
 
-#define PROC_DYNAMIC_FIRST 4096
-#define PROC_NDYNAMIC      16384
-
 #define PROC_SUPER_MAGIC 0x9fa0
 
 /*
@@ -53,7 +50,7 @@ typedef	int (write_proc_t)(struct file *
 typedef int (get_info_t)(char *, char **, off_t, int);
 
 struct proc_dir_entry {
-	unsigned short low_ino;
+	unsigned int low_ino;
 	unsigned short namelen;
 	const char *name;
 	mode_t mode;
@@ -102,7 +99,7 @@ extern void remove_proc_entry(const char
 
 extern struct vfsmount *proc_mnt;
 extern int proc_fill_super(struct super_block *,void *,int);
-extern struct inode * proc_get_inode(struct super_block *, int, struct proc_dir_entry *);
+extern struct inode * proc_get_inode(struct super_block *, unsigned int, struct proc_dir_entry *);
 
 extern int proc_match(int, const char *,struct proc_dir_entry *);
 

--------------000902090900030803060602--
