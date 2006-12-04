Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935732AbWLDKtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935732AbWLDKtt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 05:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935784AbWLDKtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 05:49:49 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:20131 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S935732AbWLDKts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 05:49:48 -0500
Message-ID: <365229382.19908@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 4 Dec 2006 18:49:49 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: drop_pagecache: Possible circular locking dependency
Message-ID: <20061204104949.GB7792@mail.ustc.edu.cn>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <365219737.01594@ustc.edu.cn> <20061204003217.c0f05e00.akpm@osdl.org> <365225031.05635@ustc.edu.cn> <4573F665.4080105@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4573F665.4080105@yahoo.com.au>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 09:20:21PM +1100, Nick Piggin wrote:
> Fengguang Wu wrote:
> 
> >I'd like to move this sysctl interface to the upcoming /proc/filecache. 
> >Being a module, it helps reduce the kernel size :)
> 
> What's /proc/filecache?

It provides access to the in-memory file cache.

To list an index of all cached files:

    echo -n index > /proc/filecache
    cat /proc/filecache

The output looks like:

    # filecache 1.0
    #      ino       size   cached cached%  state   refcnt  dev             file
       1026334         91       92    100   --      66      03:02(hda2)     /lib/ld-2.3.6.so
        233608       1242      972     78   --      66      03:02(hda2)     /lib/tls/libc-2.3.6.so
         65203        651      476     73   --      1       03:02(hda2)     /bin/bash
       1026445        261      160     61   --      10      03:02(hda2)     /lib/libncurses.so.5.5
        235427         10       12    100   --      44      03:02(hda2)     /lib/tls/libdl-2.3.6.so

To list the cached pages of a perticular file:

    echo -n /bin/bash > /proc/filecache
    cat /proc/filecache

    # file /bin/bash
    # flags R:referenced A:active U:uptodate D:dirty W:writeback M:mmap
    # idx   len     state   refcnt
    0       36      RAU__M  3
    36      1       RAU__M  2
    37      8       RAU__M  3
    45      2       RAU___  1
    47      6       RAU__M  3
    53      3       RAU__M  2
    56      2       RAU__M  3

To instruct the kernel to drop clean caches, dentries and inodes from memory,
causing that memory to become free:

    # drop clean file data cache (i.e. file backed pagecache)
    echo drop data > /proc/filecache

    # drop clean file metadata cache (i.e. dentries and inodes)
    echo drop metadata > /proc/filecache


It's first introduced here: http://lkml.org/lkml/2006/6/12/29

And the latest working patch for -mm:

--- linux-2.6.19-rc6-mm2.orig/include/linux/mm.h
+++ linux-2.6.19-rc6-mm2/include/linux/mm.h
@@ -29,6 +29,7 @@ extern unsigned long num_physpages;
 extern void * high_memory;
 extern unsigned long vmalloc_earlyreserve;
 extern int page_cluster;
+extern char *zone_names[];
 
 #ifdef CONFIG_SYSCTL
 extern int sysctl_legacy_va_layout;
--- linux-2.6.19-rc6-mm2.orig/mm/page_alloc.c
+++ linux-2.6.19-rc6-mm2/mm/page_alloc.c
@@ -86,7 +86,7 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 
 EXPORT_SYMBOL(totalram_pages);
 
-static char *zone_names[MAX_NR_ZONES] = {
+char *zone_names[MAX_NR_ZONES] = {
 #ifdef CONFIG_ZONE_DMA
 	 "DMA",
 #endif
--- linux-2.6.19-rc6-mm2.orig/fs/dcache.c
+++ linux-2.6.19-rc6-mm2/fs/dcache.c
@@ -1776,7 +1776,10 @@ static char * __d_path( struct dentry *d
 
 		if (dentry == root && vfsmnt == rootmnt)
 			break;
-		if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
+		if (unlikely(!vfsmnt)) {
+			if (IS_ROOT(dentry))
+				break;
+		} else if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
 			/* Global root? */
 			spin_lock(&vfsmount_lock);
 			if (vfsmnt->mnt_parent == vfsmnt) {
--- linux-2.6.19-rc6-mm2.orig/fs/seq_file.c
+++ linux-2.6.19-rc6-mm2/fs/seq_file.c
@@ -13,6 +13,8 @@
 #include <asm/uaccess.h>
 #include <asm/page.h>
 
+#define SEQFILE_SHOW_FROM_NEXT	LONG_MAX
+
 /**
  *	seq_open -	initialize sequential file
  *	@file: file we initialize
@@ -93,6 +95,7 @@ ssize_t seq_read(struct file *file, char
 	/* if not empty - flush it first */
 	if (m->count) {
 		n = min(m->count, size);
+		BUG_ON(m->from == SEQFILE_SHOW_FROM_NEXT);
 		err = copy_to_user(buf, m->buf + m->from, n);
 		if (err)
 			goto Efault;
@@ -102,7 +105,7 @@ ssize_t seq_read(struct file *file, char
 		buf += n;
 		copied += n;
 		if (!m->count)
-			m->index++;
+			m->from = SEQFILE_SHOW_FROM_NEXT;
 		if (!size)
 			goto Done;
 	}
@@ -113,9 +116,11 @@ ssize_t seq_read(struct file *file, char
 		err = PTR_ERR(p);
 		if (!p || IS_ERR(p))
 			break;
-		err = m->op->show(m, p);
-		if (err)
-			break;
+		if (m->from != SEQFILE_SHOW_FROM_NEXT) {
+			err = m->op->show(m, p);
+			if (err)
+				break;
+		}
 		if (m->count < m->size)
 			goto Fill;
 		m->op->stop(m, p);
@@ -156,7 +161,7 @@ Fill:
 	if (m->count)
 		m->from = n;
 	else
-		pos++;
+		m->from = SEQFILE_SHOW_FROM_NEXT;
 	m->index = pos;
 Done:
 	if (!copied)
@@ -208,11 +213,9 @@ static int traverse(struct seq_file *m, 
 		}
 		pos += m->count;
 		m->count = 0;
-		if (pos == offset) {
-			m->index++;
-			break;
-		}
 		p = m->op->next(m, p, &m->index);
+		if (pos == offset)
+			break;
 	}
 	m->op->stop(m, p);
 	return error;
--- linux-2.6.19-rc6-mm2.orig/Documentation/filesystems/proc.txt
+++ linux-2.6.19-rc6-mm2/Documentation/filesystems/proc.txt
@@ -209,6 +209,7 @@ Table 1-3: Kernel info in /proc 
  driver	     Various drivers grouped here, currently rtc (2.4)
  execdomains Execdomains, related to security			(2.4)
  fb	     Frame Buffer devices				(2.4)
+ filecache   Query/drop in-memory file cache
  fs	     File system parameters, currently nfs/exports	(2.4)
  ide         Directory containing info about the IDE subsystem 
  interrupts  Interrupt usage                                   
@@ -453,6 +454,88 @@ VmallocTotal: total size of vmalloc memo
  VmallocUsed: amount of vmalloc area which is used
 VmallocChunk: largest contigious block of vmalloc area which is free
 
+..............................................................................
+
+filecache:
+
+Provides access to the in-memory file cache.
+
+To list an index of all cached files:
+
+    echo -n index > /proc/filecache
+    cat /proc/filecache
+
+The output looks like:
+
+    # filecache 1.0
+    #      ino       size   cached cached%  state   refcnt  dev             file
+       1026334         91       92    100   --      66      03:02(hda2)     /lib/ld-2.3.6.so
+        233608       1242      972     78   --      66      03:02(hda2)     /lib/tls/libc-2.3.6.so
+         65203        651      476     73   --      1       03:02(hda2)     /bin/bash
+       1026445        261      160     61   --      10      03:02(hda2)     /lib/libncurses.so.5.5
+        235427         10       12    100   --      44      03:02(hda2)     /lib/tls/libdl-2.3.6.so
+
+FIELD	INTRO
+---------------------------------------------------------------------------
+ino	inode number
+size	inode size in KB
+cached	cached size in KB
+cached%	percent of file data cached
+state1	'-' clean; 'd' metadata dirty; 'D' data dirty
+state2	'-' unlocked; 'L' locked, normally indicates file being written out
+refcnt	file reference count, it's an in-kernel one, not exactly open count
+dev	major:minor numbers in hex, followed by a descriptive device name
+file	file path _inside_ the filesystem. There are several special names:
+	'(noname)':	the file name is not available
+	'(03:02)':	the file is a block device file of major:minor
+	'...(deleted)': the named file has been deleted from the disk
+
+To list the cached pages of a perticular file:
+
+    echo -n /bin/bash > /proc/filecache
+    cat /proc/filecache
+
+    # file /bin/bash
+    # flags R:referenced A:active U:uptodate D:dirty W:writeback M:mmap
+    # idx   len     state   refcnt
+    0       36      RAU__M  3
+    36      1       RAU__M  2
+    37      8       RAU__M  3
+    45      2       RAU___  1
+    47      6       RAU__M  3
+    53      3       RAU__M  2
+    56      2       RAU__M  3
+
+FIELD	INTRO
+----------------------------------------------------------------------------
+idx	page index
+len	number of pages which are cached and share the same state
+state	page state of the flags listed in line two
+refcnt	page reference count
+
+Careful users may notice that the file name to be queried is remembered between
+commands. Internally, the module has a global variable to store the file name
+parameter, so that it can be inherited by newly opened /proc/filecache file.
+However it can lead to interference for multiple queriers. The solution here
+is to obey a rule: only root can interactively change the file name parameter;
+normal users must go for scripts to access the interface. Scripts should do it
+by following the code example below:
+
+    filecache = open("/proc/filecache", "rw");
+    # avoid polluting the global parameter filename
+    filecache.write("private session");
+
+To instruct the kernel to drop clean caches, dentries and inodes from memory,
+causing that memory to become free:
+
+    # drop clean file data cache (i.e. file backed pagecache)
+    echo drop data > /proc/filecache
+
+    # drop clean file metadata cache (i.e. dentries and inodes)
+    echo drop metadata > /proc/filecache
+
+Note that the drop commands are non-destructive operations and dirty objects
+are not freeable, the user should run `sync' first.
 
 1.3 IDE devices in /proc/ide
 ----------------------------
--- /dev/null
+++ linux-2.6.19-rc6-mm2/fs/proc/filecache.c
@@ -0,0 +1,614 @@
+/*
+ * linux/fs/proc/filecache.c
+ *
+ * Copyright (C) 2006 Fengguang Wu <wfg@ustc.edu>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/radix-tree.h>
+#include <linux/page-flags.h>
+#include <linux/pagevec.h>
+#include <linux/pagemap.h>
+#include <linux/vmalloc.h>
+#include <linux/writeback.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
+/* Increase it whenever there are visible changes. */
+#define FILECACHE_VERSION	"1.0"
+
+/*
+ * Session management.
+ *
+ * Each opened /proc/filecache file is assiocated with a session object.
+ *
+ * session.query_file is the file whose cache info is to be queried.
+ * Its value determines what we get on read():
+ * 	- NULL: call inode_index_*() to show the index of cached inodes
+ * 	- filp: call page_ranges_*() to show the cached pages of filp
+ *
+ * session.query_file is
+ * 	- initialized from global_name on open();
+ * 	- updated on write("filename");
+ * 	  note that the new filename will also be saved in global_name if
+ * 	  session.private_session is false.
+ */
+
+struct session {
+	int		private_session;
+	struct file	*query_file;
+	struct inode	**ordered_inodes;
+	pgoff_t		next_offset;
+};
+
+static char name_index[] = "index";
+static char *global_name = name_index;
+
+int name_session(struct session *s, char *name)
+{
+	static DEFINE_MUTEX(mutex);
+	int ret = 0;
+
+	mutex_lock(&mutex);
+
+	/* close old file */
+	if (s->query_file) {
+		if ((ret = filp_close(s->query_file, NULL)))
+			goto out;
+		s->query_file = NULL;
+	}
+
+	if (!name)
+		goto out;
+
+	/* open the named file */
+	if (strcmp(name, name_index)) {
+		if (IS_ERR(s->query_file =
+				filp_open(name, O_RDONLY|O_LARGEFILE, 0))) {
+			ret = (int)s->query_file;
+			s->query_file = NULL;
+			goto out;
+		}
+	}
+
+	/* set @name as new global default */
+	if (!s->private_session && name != global_name) {
+		/* non-root users are not allowed to modify global_name */
+		if (current->uid) {
+			ret = -EACCES;
+			goto out;
+		}
+
+		if (global_name != name_index)
+			__putname(global_name);
+
+		if (!strcmp(name, name_index))
+			global_name = name_index;
+		else {
+			global_name = __getname();
+			if (global_name)
+				strcpy(global_name, name);
+			else {
+				global_name = name_index;
+				ret = -ENOMEM;
+			}
+		}
+	}
+
+out:
+	mutex_unlock(&mutex);
+
+	return ret;
+}
+
+/*
+ * Session address is stored in proc_file->f_ra.flags:
+ * we assume that there will be no readahead for proc_file.
+ */
+struct session *get_session(struct file *proc_file)
+{
+	return (struct session *)proc_file->f_ra.flags;
+}
+
+int new_session(struct file* proc_file)
+{
+	struct session *s;
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	BUG_ON(proc_file->f_ra.flags);
+	proc_file->f_ra.flags = (unsigned long)s;
+
+	memset(s, 0, sizeof(*s));
+	return name_session(s, global_name);
+}
+
+int kill_session(struct file *proc_file)
+{
+	struct session *s = get_session(proc_file);
+	int ret;
+
+	if (!(ret = name_session(s, NULL)))
+		kfree(s);
+
+	return ret;
+}
+
+
+/*
+ * Listing of cached files.
+ *
+ * Usage:
+ * 		echo -n index > /proc/filecache
+ * 		cat /proc/filecache
+ */
+
+static int may_show_inode(struct inode *inode)
+{
+	if (!inode)
+		return 0;
+
+	if (!inode->i_mapping->nrpages && !MAJOR(inode->i_sb->s_dev))
+		return 0;
+
+	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+	    S_ISLNK(inode->i_mode) || S_ISBLK(inode->i_mode))
+		return 1;
+	else
+		return 0;
+
+#if 0 /* FIXME: permission() is not enough -
+		it applies to the file content, not the file path. */
+
+	if (!current->uid)
+		return 1;
+
+	return !permission(inode, MAY_READ, NULL);
+#endif
+}
+
+static void show_inode(struct seq_file *m, struct inode *inode)
+{
+	char state[] = "--"; /* dirty, locked */
+	struct dentry *dentry;
+	loff_t size = i_size_read(inode);
+	unsigned long nrpages = inode->i_mapping->nrpages;
+	int percent;
+	int refcnt;
+	int shift;
+
+	if (!size)
+		size++;
+
+	for (shift = 0; (size >> shift) > ULONG_MAX / 128; shift += 12)
+		;
+	percent = min(100UL, (((100 * nrpages) >> shift) << PAGE_CACHE_SHIFT) /
+						(unsigned long)(size >> shift));
+
+	if (inode->i_state & (I_DIRTY_DATASYNC|I_DIRTY_PAGES))
+		state[0] = 'D';
+	else if (inode->i_state & I_DIRTY_SYNC)
+		state[0] = 'd';
+
+	if (inode->i_state & I_LOCK)
+		state[0] = 'L';
+
+	refcnt = 0;
+	list_for_each_entry(dentry, &inode->i_dentry, d_alias) {
+		refcnt += atomic_read(&dentry->d_count);
+	}
+
+	seq_printf(m, "%10lu %10llu %8lu %6d\t%s\t%d\t%02x:%02x(%s)\t",
+			inode->i_ino,
+			DIV_ROUND_UP(size, 1024),
+			nrpages << (PAGE_CACHE_SHIFT - 10),
+			percent,
+			state,
+			refcnt,
+			MAJOR(inode->i_sb->s_dev),
+			MINOR(inode->i_sb->s_dev),
+			inode->i_sb->s_id);
+
+	if (list_empty(&inode->i_dentry)) {
+		if (!atomic_read(&inode->i_count))
+			seq_puts(m, "(noname)\n");
+		else
+			seq_printf(m, "(%02x:%02x)\n",
+					imajor(inode), iminor(inode));
+	} else {
+		dentry = list_entry(inode->i_dentry.next,
+							struct dentry, d_alias);
+		seq_path(m, NULL, dentry, " \t\n\\");
+		seq_putc(m, '\n');
+	}
+}
+
+static int inode_index_show(struct seq_file *m, void *v)
+{
+	unsigned long index = *(loff_t *) v;
+	struct session *s = m->private;
+        struct inode *inode;
+
+	if (index == 0) {
+		seq_puts(m, "# filecache " FILECACHE_VERSION "\n");
+		seq_puts(m, "#      ino       size   cached cached%"
+				"\tstate\trefcnt\tdev\t\tfile\n");
+	}
+
+	BUG_ON(!s->ordered_inodes);
+        inode = s->ordered_inodes[index];
+
+	if (may_show_inode(inode))
+		show_inode(m, inode);
+
+	return 0;
+}
+
+static void *inode_index_start(struct seq_file *m, loff_t *pos)
+{
+	struct session *s = m->private;
+	struct super_block *sb;
+	struct inode *inode;
+	struct inode **ip;
+	unsigned long n;
+
+alloc:
+	n = inodes_stat.nr_inodes + 100;
+	ip = s->ordered_inodes = vmalloc(n * sizeof(*ip));
+	if (!s->ordered_inodes)
+		return NULL;
+	memset(ip, 0, n * sizeof(*ip));
+
+	spin_lock(&inode_lock);
+
+	if (inodes_stat.nr_inodes > n) {
+		spin_unlock(&inode_lock);
+		vfree(ip);
+		goto alloc;
+	}
+
+	/*
+	 * Retrieve the inodes in order - newest one at bottom.
+	 */
+
+	list_for_each_entry_reverse(inode, &inode_unused, i_list) {
+		*ip++ = inode;
+	}
+
+	list_for_each_entry_reverse(inode, &inode_in_use, i_list) {
+		*ip++ = inode;
+	}
+
+	spin_lock(&sb_lock);
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		list_for_each_entry_reverse(inode, &sb->s_dirty, i_list) {
+			*ip++ = inode;
+		}
+		list_for_each_entry_reverse(inode, &sb->s_io, i_list) {
+			*ip++ = inode;
+		}
+	}
+	spin_unlock(&sb_lock);
+
+	return *pos < inodes_stat.nr_inodes ? pos : NULL;
+}
+
+static void *inode_index_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	(*pos)++;
+
+	return *pos < inodes_stat.nr_inodes ? pos : NULL;
+}
+
+static void inode_index_stop(struct seq_file *m, void *v)
+{
+	struct session *s = m->private;
+
+	spin_unlock(&inode_lock);
+	vfree(s->ordered_inodes);
+}
+
+
+/*
+ * Listing of cached page ranges of a file.
+ *
+ * Usage:
+ * 		echo -n 'file name' > /proc/filecache
+ * 		cat /proc/filecache
+ */
+
+unsigned long page_mask;
+#define PG_MMAP		PG_lru	/* reuse this never-relevant flag */
+#define PG_COUNT	(sizeof(page_flag)/sizeof(page_flag[0]))
+
+/*
+ * Page state names, prefixed by their abbreviations.
+ */
+struct {
+	unsigned long	mask;
+	const char     *name;
+} page_flag [] = {
+	{1 << PG_referenced,	"R:referenced"},
+	{1 << PG_active,	"A:active"},
+
+	{1 << PG_uptodate,	"U:uptodate"},
+	{1 << PG_dirty,		"D:dirty"},
+	{1 << PG_writeback,	"W:writeback"},
+
+	{1 << PG_MMAP,		"M:mmap"},
+
+};
+
+static unsigned long page_flags(struct page* page)
+{
+	unsigned long flags;
+
+	flags = page->flags & page_mask;
+
+	if (page_mapped(page))
+		flags |= (1UL << PG_MMAP);
+
+	return flags;
+}
+
+static int pages_similiar(struct page* page0, struct page* page)
+{
+	if (page_count(page0) != page_count(page))
+		return 0;
+
+	if (page_flags(page0) != page_flags(page))
+		return 0;
+
+	return 1;
+}
+
+static void show_range(struct seq_file *m, struct page* page, unsigned long len)
+{
+	int i;
+	unsigned long flags;
+
+	if (!m || !page)
+		return;
+
+	seq_printf(m, "%lu\t%lu\t", page->index, len);
+
+	flags = page_flags(page);
+	for (i = 0; i < PG_COUNT; i++)
+		seq_putc(m, (flags & page_flag[i].mask) ?
+					page_flag[i].name[0] : '_');
+
+	seq_printf(m, "\t%d\n", page_count(page));
+}
+
+#define MAX_LINES	100
+static pgoff_t show_file_cache(struct seq_file *m,
+				struct address_space *mapping, pgoff_t start)
+{
+	int i;
+	int lines = 0;
+	pgoff_t len = 0;
+	struct pagevec pvec;
+	struct page *page;
+	struct page *page0 = NULL;
+
+	for (;;) {
+		pagevec_init(&pvec, 0);
+		pvec.nr = radix_tree_gang_lookup(&mapping->page_tree,
+				(void **)pvec.pages, start + len, PAGEVEC_SIZE);
+
+		if (pvec.nr == 0) {
+			show_range(m, page0, len);
+			start = ULONG_MAX;
+			goto out;
+		}
+
+		if (!page0)
+			page0 = pvec.pages[0];
+
+		for (i = 0; i < pvec.nr; i++) {
+			page = pvec.pages[i];
+
+			if (page->index == start + len &&
+					pages_similiar(page0, page))
+				len++;
+			else {
+				show_range(m, page0, len);
+				page0 = page;
+				start = page->index;
+				len = 1;
+				if (++lines > MAX_LINES)
+					goto out;
+			}
+		}
+	}
+
+out:
+	return start;
+}
+
+static int page_ranges_show(struct seq_file *m, void *v)
+{
+	struct session *s = m->private;
+	struct file *file = s->query_file;
+	pgoff_t offset;
+
+	if (!file)
+		return inode_index_show(m, v);
+
+	offset = *(loff_t *) v;
+
+	if (!offset) { /* print header */
+		int i;
+
+		seq_puts(m, "# file ");
+		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
+
+		seq_puts(m, "\n# flags");
+		for (i = 0; i < PG_COUNT; i++)
+			seq_printf(m, " %s", page_flag[i].name);
+
+		seq_puts(m, "\n# idx\tlen\tstate\trefcnt\n");
+	}
+
+	s->next_offset = show_file_cache(m, file->f_mapping, offset);
+
+	return 0;
+}
+
+static int file_has_page(struct file *file, pgoff_t offset)
+{
+	loff_t size = i_size_read(file->f_mapping->host);
+	pgoff_t pages = DIV_ROUND_UP(size, PAGE_CACHE_SIZE);
+
+	return offset < pages;
+}
+
+static void *page_ranges_start(struct seq_file *m, loff_t *pos)
+{
+	struct session *s = m->private;
+	struct file *file = s->query_file;
+
+	if (!file)
+		return inode_index_start(m, pos);
+
+	read_lock_irq(&file->f_mapping->tree_lock);
+
+	return file_has_page(file, (pgoff_t)*pos) ? pos : NULL;
+}
+
+static void *page_ranges_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct session *s = m->private;
+	struct file *file = s->query_file;
+
+	if (!file)
+		return inode_index_next(m, v, pos);
+
+	*pos = s->next_offset;
+	/* *pos = show_file_cache(NULL, file->f_mapping, *pos); */
+
+	return file_has_page(file, (pgoff_t)*pos) ? pos : NULL;
+}
+
+static void page_ranges_stop(struct seq_file *m, void *v)
+{
+	struct session *s = m->private;
+	struct file *file = s->query_file;
+
+	if (!file)
+		return inode_index_stop(m, v);
+
+	read_unlock_irq(&file->f_mapping->tree_lock);
+}
+
+struct seq_operations seq_filecache_op = {
+	.start	= page_ranges_start,
+	.next	= page_ranges_next,
+	.stop	= page_ranges_stop,
+	.show	= page_ranges_show,
+};
+
+
+/*
+ * Proc file operations.
+ */
+
+static int filecache_open(struct inode *inode, struct file *proc_file)
+{
+	struct seq_file *m;
+	int ret;
+	if (!(ret = seq_open(proc_file, &seq_filecache_op))) {
+		ret = new_session(proc_file);
+		m = proc_file->private_data;
+		m->private = get_session(proc_file);
+	}
+	return ret;
+}
+
+static int filecache_release(struct inode *inode, struct file *proc_file)
+{
+	int ret;
+	if (!(ret = kill_session(proc_file)))
+		ret = seq_release(inode, proc_file);
+	return ret;
+}
+
+ssize_t filecache_write(struct file *proc_file, const char __user * buffer,
+			size_t count, loff_t *ppos)
+{
+	struct session *s;
+	char *name;
+	int e = 0;
+
+	if (count >= PATH_MAX)
+		return -ENAMETOOLONG;
+
+	name = kmalloc(count+1, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	if (copy_from_user(name, buffer, count)) {
+		e = -EFAULT;
+		goto out;
+	}
+	name[count] = '\0';
+
+	s = get_session(proc_file);
+	if (!strcmp(name, "private session")) {
+		s->private_session = 1;
+		goto out;
+	}
+
+	e = name_session(s, name);
+
+out:
+	kfree(name);
+
+	return e ? e : count;
+}
+
+static struct file_operations proc_filecache_fops = {
+	.owner		= THIS_MODULE,
+	.open		= filecache_open,
+	.release	= filecache_release,
+	.write		= filecache_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+};
+
+
+static __init int filecache_init(void)
+{
+	int i;
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry("filecache", 0600, NULL);
+	if (entry)
+		entry->proc_fops = &proc_filecache_fops;
+
+	/* Note: the faked flag PG_MMAP is not included. */
+	for (page_mask = i = 0; i < PG_COUNT - 1; i++)
+		page_mask |= page_flag[i].mask;
+
+	return 0;
+}
+
+static void filecache_exit(void)
+{
+	remove_proc_entry("filecache", NULL);
+}
+
+MODULE_AUTHOR("Fengguang Wu <wfg@ustc.edu>");
+MODULE_LICENSE("GPL");
+
+module_init(filecache_init);
+module_exit(filecache_exit);
--- linux-2.6.19-rc6-mm2.orig/fs/Kconfig
+++ linux-2.6.19-rc6-mm2/fs/Kconfig
@@ -1047,6 +1047,29 @@ config CONFIGFS_FS
 	  Both sysfs and configfs can and should exist together on the
 	  same system. One is not a replacement for the other.
 
+config PROC_FILECACHE
+	tristate "/proc/filecache support"
+	default m
+	depends on PROC_FS
+	help
+	  This option creates a file /proc/filecache which enables one to
+	  query/drop the cached files in memory.
+
+	  A quick start guide:
+
+	  # echo -n index > /proc/filecache
+	  # cat /proc/filecache
+
+	  # echo -n /bin/bash > /proc/filecache
+	  # cat /proc/filecache
+
+	  # echo drop data > /proc/filecache
+	  # echo drop metadata > /proc/filecache
+
+	  For more details, please check Documentation/filesystems/proc.txt .
+
+	  It can be a handy tool for sysadms and desktop users.
+
 endmenu
 
 menu "Miscellaneous filesystems"
--- linux-2.6.19-rc6-mm2.orig/fs/proc/Makefile
+++ linux-2.6.19-rc6-mm2/fs/proc/Makefile
@@ -12,5 +12,6 @@ proc-y       += inode.o root.o base.o ge
 
 proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
+proc-$(CONFIG_PROC_FILECACHE)	+= filecache.o
 proc-$(CONFIG_PROC_DEVICETREE)	+= proc_devtree.o
 proc-$(CONFIG_PRINTK)	+= kmsg.o
