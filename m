Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266081AbUHFSes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUHFSes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268196AbUHFSes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:34:48 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:9897 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S266081AbUHFSeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:34:14 -0400
Date: Fri, 6 Aug 2004 20:34:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: d_path errors
Message-ID: <20040806183428.GA3428@dualathlon.random>
References: <20040806152356.GD2514@dualathlon.random> <20040806172321.GR12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806172321.GR12308@parcelfarce.linux.theplanet.co.uk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 06:23:23PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, Aug 06, 2004 at 05:23:56PM +0200, Andrea Arcangeli wrote:
>  
> > on a slightly different topic, Al, could you suggest how to hack d_path
> > so that it provides an absolute path with respect to the init_task root
> > directory?
> 
> Simple: you don't.
> 	a) filesystem may be mounted more than once in init_task's namespace
> 	b) filesystem may be not mounted there at all.
> 	c) different subtrees of filessytem might be mounted there and
> full tree might be not among them; your file might be covered by some of
> them.
> 
> What you are asking for is about as feasible as "I have an unlinked file.
> Show me a pathname of existing link to it".  The best answer will be
> along the lines of "use find(1) if you are that desperate".  And if
> vfsmount/dentry did *not* give you an absolute pathname, you are in
> situation equivalent to that.
> 
> No way in hell it's getting shoved in d_path() and I'm very sceptical
> about any code that really needs that.

This is an heuristic. I doesn't need to be correct. But if a file is
placed in /proc/meminfo I want to generate the string "/proc/meminfo"
_not_ "/meminfo" like it happens right now. I'm fine to workaround the
d_path walking the mountpoints.

See the current patch how it looks and what it does. This dumps into
userspace all dcache accesses so I can preload all getdents and all
read(2) into pagecache and buffercache during boot. The preload is
actually much harder than the logging, not clever preload (i.e. just a
loop that read everything from disk) will make the bootcache useless or
it may even make the boot slower. But the preload is not covered in this
patch, this patch is only about logging the fs metdata accesses into
userspace. Hooking into the pagecache is a minor issue, it's worthless
to preload pagecache offsets (especially if you use lseek and destroy
readhaead) if we don't preload all dcache and buffercache first. I
already use this (without any granularity on the pagecache accesses) and
it reduces my boot time from grub to X of 10% (so I'm already benefiting
from this feature on my own laptop in daily usage), I didn't yet try
to cache kde as well, but before trying any further thing I'd like to
polish the bugs like the fact I see "/meminfo" instead of
"/proc/meminfo" or similar. I obviously need to filter out everything
not filebacked (and I'm going to do that in userspace). And for the
filebacked I need a path that the init task can load. Note, I wrote
init_task below but really this should be current->fs, it's not going to
make a difference in practice.

I'll be offline for the next two weeks, but I'll answer any email after
I'm back.

thanks!

(this is very alpha code, just for measurements)

--- sles/fs/proc/Makefile.~1~	2003-09-23 17:07:06.000000000 +0200
+++ sles/fs/proc/Makefile	2004-08-03 17:28:34.000000000 +0200
@@ -8,7 +8,7 @@ proc-y			:= task_nommu.o
 proc-$(CONFIG_MMU)	:= task_mmu.o
 
 proc-y       += inode.o root.o base.o generic.o array.o \
-		kmsg.o proc_tty.o proc_misc.o
+		kmsg.o proc_tty.o proc_misc.o bootcache.o
 
 proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_DEVICETREE)	+= proc_devtree.o
--- sles/fs/proc/proc_misc.c.~1~	2004-08-02 12:52:36.000000000 +0200
+++ sles/fs/proc/proc_misc.c	2004-08-04 03:41:19.000000000 +0200
@@ -692,6 +692,9 @@ void __init proc_misc_init(void)
 	entry = create_proc_entry("kmsg", S_IRUSR, &proc_root);
 	if (entry)
 		entry->proc_fops = &proc_kmsg_operations;
+	entry = create_proc_entry("bootcache", S_IRUSR, &proc_root);
+	if (entry)
+		entry->proc_fops = &proc_bootcache_operations;
 	create_seq_entry("cpuinfo", 0, &proc_cpuinfo_operations);
 	create_seq_entry("partitions", 0, &proc_partitions_operations);
 	create_seq_entry("stat", 0, &proc_stat_operations);
--- sles/fs/namei.c.~1~	2004-08-02 12:52:21.000000000 +0200
+++ sles/fs/namei.c	2004-08-04 04:10:14.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/personality.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/bootcache.h>
 #include <asm/namei.h>
 #include <asm/uaccess.h>
 
@@ -398,8 +399,11 @@ again:
 			result = dir->i_op->lookup(dir, dentry, nd);
 			if (result)
 				dput(dentry);
-			else
+			else {
 				result = dentry;
+				if (unlikely(is_bootcache_enabled()))
+					bootcache_new_entry(dentry);
+			}
 		}
 		up(&dir->i_sem);
 		return result;
@@ -989,9 +993,11 @@ static struct dentry * __lookup_hash(str
 		if (!new)
 			goto out;
 		dentry = inode->i_op->lookup(inode, new, nd);
-		if (!dentry)
+		if (!dentry) {
 			dentry = new;
-		else
+			if (unlikely(is_bootcache_enabled()))
+				bootcache_new_entry(dentry);
+		} else
 			dput(new);
 	}
 out:
--- sles/include/linux/proc_fs.h.~1~	2004-08-02 12:51:24.000000000 +0200
+++ sles/include/linux/proc_fs.h	2004-08-03 17:44:06.000000000 +0200
@@ -115,6 +115,7 @@ extern struct file_operations proc_file_
 extern struct file_operations proc_kcore_operations;
 extern struct file_operations proc_kmsg_operations;
 extern struct file_operations ppc_htab_operations;
+extern struct file_operations proc_bootcache_operations;
 
 /*
  * proc_tty.c
--- /dev/null	2004-04-06 15:27:52.000000000 +0200
+++ sles/fs/proc/bootcache.c	2004-08-04 05:47:54.540890144 +0200
@@ -0,0 +1,210 @@
+/*
+ *  fs/proc/bootcache.c
+ *
+ *  bootcache userspace logging
+ *
+ *  Copyright (C) 2004  Andrea Arcangeli <andrea@suse.de> Novell/SUSE
+ */
+
+#include <linux/wait.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/spinlock.h>
+#include <linux/mount.h>
+#include <linux/bootcache.h>
+
+static spinlock_t bootcache_lock = SPIN_LOCK_UNLOCKED;
+static DECLARE_WAIT_QUEUE_HEAD(bootcache_wait);
+static struct page * bootcache_buf, * bootcache_d_path_page;
+static unsigned int bootcache_pos;
+static struct vfsmount * bootcache_vfsmnt;
+
+unsigned int bootcache_nr;
+
+static int bootcache_open(struct inode * inode, struct file * file)
+{
+	int ret;
+	struct page * page, * d_path_page;
+
+	page = alloc_page(GFP_KERNEL);
+	d_path_page = alloc_page(GFP_KERNEL);
+
+	ret = -ENOMEM;
+	if (unlikely(!page || !d_path_page))
+		goto out;
+
+	ret = 0;
+	spin_lock(&bootcache_lock);
+	if (likely(!bootcache_nr++)) {
+		bootcache_pos = 0;
+
+		bootcache_buf = page;
+		page = NULL;
+
+		bootcache_d_path_page = d_path_page;
+		d_path_page = NULL;
+
+		read_lock(&init_task.fs->lock);
+		bootcache_vfsmnt = mntget(init_task.fs->rootmnt);
+		read_unlock(&init_task.fs->lock);
+	}
+	spin_unlock(&bootcache_lock);
+
+ out:
+	if (page)
+		__free_page(page);
+	if (d_path_page)
+		__free_page(d_path_page);
+
+	return ret;
+}
+
+static int bootcache_release(struct inode * inode, struct file * file)
+{
+	struct page * page = NULL;
+
+	spin_lock(&bootcache_lock);
+	if (likely(!--bootcache_nr)) {
+		page = bootcache_buf;
+		mntput(bootcache_vfsmnt);
+	}
+	spin_unlock(&bootcache_lock);
+
+	if (page) {
+		__free_page(page);
+		__free_page(bootcache_d_path_page);
+	}
+	return 0;
+}
+
+static void bootcache_push(const char * str, unsigned int len)
+{
+	unsigned int len2, old_len;
+
+	BUG_ON(!bootcache_nr);
+
+	if (len >= PAGE_SIZE || !len)
+		return;
+
+	old_len = len;
+	len2 = 0;
+	if ((bootcache_pos & ~PAGE_MASK) + len > PAGE_SIZE) {
+		len2 = (bootcache_pos & ~PAGE_MASK) + len - PAGE_SIZE;
+		len = PAGE_SIZE - (bootcache_pos & ~PAGE_MASK);
+	}
+	BUG_ON(old_len != len + len2);
+
+	memcpy((char *) page_address(bootcache_buf) + (bootcache_pos & ~PAGE_MASK), str, len);
+	bootcache_pos += len;
+	if (!len2)
+		goto out;
+
+	memcpy((char *) page_address(bootcache_buf), str + len, len2);
+	bootcache_pos += len2;
+
+ out:
+	wake_up_interruptible(&bootcache_wait);
+}
+
+void fastcall bootcache_new_entry(struct dentry * dentry)
+{
+	char * buf;
+
+	spin_lock(&bootcache_lock);
+	if (!bootcache_nr)
+		goto out_unlock;
+
+	buf = d_path(dentry, bootcache_vfsmnt, page_address(bootcache_d_path_page), PAGE_SIZE);
+	if (IS_ERR(buf))
+		goto out_unlock;
+
+	*((char *) page_address(bootcache_d_path_page) + PAGE_SIZE - 1) = '\n';
+
+	bootcache_push(buf, (char *) page_address(bootcache_d_path_page) + PAGE_SIZE - buf);
+
+ out_unlock:
+	spin_unlock(&bootcache_lock);
+}
+
+static ssize_t bootcache_read(struct file * file, char __user * buf,
+			      size_t count, loff_t * ppos)
+{
+	loff_t pos = *ppos;
+	ssize_t ret, written;
+	unsigned int len, len2, old_len;
+
+	written = 0;
+
+	ret = 0;
+	if (unlikely(!count))
+		goto out;
+
+	ret = -EFAULT;
+	if (unlikely(!access_ok(VERIFY_WRITE, buf, count)))
+		goto out;
+
+	ret = 0;
+	spin_lock(&bootcache_lock);
+	while (!((bootcache_pos - pos) & ~PAGE_MASK) && !ret) {
+		spin_unlock(&bootcache_lock);
+		ret = wait_event_interruptible(bootcache_wait, ((bootcache_pos - pos) & ~PAGE_MASK));
+		spin_lock(&bootcache_lock);
+	}
+	if (ret && !((bootcache_pos - pos) & ~PAGE_MASK))
+		goto out_unlock;
+
+	len = (bootcache_pos - pos) & ~PAGE_MASK;
+	if (len > count)
+		len = count;
+	old_len = len;
+	len2 = 0;
+	if ((pos & ~PAGE_MASK) + len > PAGE_SIZE) {
+		len2 = (pos & ~PAGE_MASK) + len - PAGE_SIZE;
+		len = PAGE_SIZE - (pos & ~PAGE_MASK);
+	}
+	BUG_ON(old_len != len + len2);
+	spin_unlock(&bootcache_lock);
+
+	ret = __copy_to_user(buf, (char *) page_address(bootcache_buf) + (pos & ~PAGE_MASK), len);
+	if (unlikely(ret)) {
+		written = len - ret;
+		ret = -EFAULT;
+		goto out;
+	} else
+		written = len;
+	if (!len2)
+		goto out;
+	ret = __copy_to_user(buf + len, (char *) page_address(bootcache_buf), len2);
+	if (unlikely(ret)) {
+		written += len2 - ret;
+		ret = -EFAULT;
+	} else
+		written += len2;
+
+ out:
+	if (written) {
+		ret = written;
+		*ppos = pos + written;
+	}
+	return ret;
+
+ out_unlock:
+	spin_unlock(&bootcache_lock);
+	goto out;
+}
+
+static unsigned int bootcache_poll(struct file * file, struct poll_table_struct * wait)
+{
+	poll_wait(file, &bootcache_wait, wait);
+	if ((bootcache_pos - file->f_pos) & ~PAGE_MASK)
+		return POLLIN | POLLRDNORM;
+	return 0;
+}
+
+struct file_operations proc_bootcache_operations = {
+	.open		= bootcache_open,
+	.release	= bootcache_release,
+	.read		= bootcache_read,
+	.poll		= bootcache_poll,
+};
--- /dev/null	2004-04-06 15:27:52.000000000 +0200
+++ sles/include/linux/bootcache.h	2004-08-04 02:09:08.000000000 +0200
@@ -0,0 +1,24 @@
+#ifndef _BOOTCACHE_H
+#define _BOOTCACHE_H
+
+#include <linux/config.h>
+#include <linux/dcache.h>
+#include <linux/kernel.h>
+
+#ifdef CONFIG_PROC_FS
+extern unsigned int bootcache_nr;
+
+static inline int is_bootcache_enabled(void)
+{
+	return bootcache_nr;
+}
+#else
+static inline int is_bootcache_enabled(void)
+{
+	return 0;
+}
+#endif
+
+extern void FASTCALL(bootcache_new_entry(struct dentry * dentry));
+
+#endif /* _BOOTCACHE_H */
