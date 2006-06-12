Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWFLHvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWFLHvc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 03:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWFLHvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 03:51:32 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:16796 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750712AbWFLHvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 03:51:31 -0400
Message-ID: <350098687.15224@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 12 Jun 2006 15:51:30 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lubos Lunak <l.lunak@suse.cz>, Dirk Mueller <dmueller@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [RFC] the /proc/filecache interface
Message-ID: <20060612075130.GA5432@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <fengguang.wu@gmail.com>,
	linux-kernel@vger.kernel.org, Lubos Lunak <l.lunak@suse.cz>,
	Dirk Mueller <dmueller@suse.de>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The /proc/filecache support has been half done. And I'd like to hear
early comments on the interface.

(The patch is not quite ready for code reviews. It is attached in case
someone are interested to have it a try.)


NOTES

- Devices are shown as MAJOR:MINOR numbers(03:00), rather than device
  files(/dev/hda).

- The query is atomic in a single read() context.  So if you need
  consistent result, prepare a large enough read buffer.

- Parameters(only one for now: the file name) are stored in two kind of
  places: one as the global default, and the others inside each opened
  /proc/filecache file. They are set according to the following rules:
        - on opening up a new /proc/filecache fd, it's associated
          parameters are initialized by the global one;
        - on writing to a /proc/filecache file to set new value for a
          parameter, both the file's associated parameters and the
          global one are updated.
  The rules imply that:
        - one can normally query the filecache use simple echo/cat
          command sequences.
        - for scripts that don't want to be disturbed by concurrent
          queries, always reuse one single fd to expect a consistent
          set of private parameters.


TODO

	1) sort the inode list
	       a) dirty inodes for each partition
	       b) in use inodes(newest at top)
	       c) unused inodes
	2) security concerns
	3) split up the patch
	4) documents

	5) breakup the page attribute 'location' into section/node/zone
	6) allow users to specify which attrs to show, examples:
		file.attr = cached% dev file	# show only the three attrs
		file.attr = ALL -uid -gid	# all attrs but uid/gid
		page.attr = NONE		# report only idx/len
		page.state = referenced active	# show only two page flags
		page.state = RF AC		# use acronyms

Note that (6) is necessary only if we want to do (5) and provide
support for the section/node/zone attributes. If ever these attrs
should be supported, they must be optional ones:  For systems with
interleaved memory policies, the page location differs for every
successive pages, thus can make the output rather tedious and huge.

I guess the location attrs might be useful for someone. However I need strong
confirmation on this, to make sure that I'm not wasting time when doing (6).

If you thinks a lot of the page location attrs, please voice it now, thanks.


SAMPLE OUTPUT

root ~# echo -n ALL > /proc/filecache
root ~# head /proc/filecache
# file ALL
#      ino       size   cached cached%  state   refcnt  uid     gid     dev             file
    413605         23       24    100   --      0       0       0       03:00(hda)      /sbin/modprobe
    381701         17       20    100   --      1       0       0       03:00(hda)      /bin/cat
    398088          1        4    100   --      0       0       0       03:00(hda)      /root/bin/checkpath
    381698        611      612    100   --      1       0       0       03:00(hda)      /bin/bash
    159498          1        4    100   --      0       0       0       03:00(hda)      /etc/mtab
    381719         30       32    100   --      0       0       0       03:00(hda)      /bin/rm
    335993          4        4    100   --      0       0       43      03:00(hda)      /var/run/utmp
         0    3687424      828      0   --      0       0       0       00:02(bdev)     03:00
    159701          5        8    100   --      0       0       0       03:00(hda)      /etc/modprobe.d/aliases
     31866       1238     1240    100   --      4       0       0       03:00(hda)      /lib/tls/libc-2.3.5.so
    381705         51       52    100   --      0       0       0       03:00(hda)      /bin/cp
     31814         27       28    100   --      0       0       0       03:00(hda)      /lib/libblkid.so.1.0
    159534         17       20    100   --      0       0       0       03:00(hda)      /etc/ld.so.cache
[...]


root ~# echo -n /lib/tls/libc-2.3.5.so > /proc/filecache
root ~# head /proc/filecache
# file /lib/tls/libc-2.3.5.so
# flags LK:locked ER:error RF:referenced UD:uptodate DT:dirty AC:active SL:slab CK:checked A1:arch_1 RS:reserved PV:private WB:writeback NS:nosave CP:compound SC:swapcache MD:mappedtodisk RC:reclaim ns:nosave_free RA:readahead MM:mmap
# idx   len                     state                   	refcnt  location
0       21      ____RFUD__AC__________________MD______MM        4       0.0.Normal
21      1       ____RFUD__AC__________________MD______MM        3       0.0.Normal
22      3       ______UD______________________MD________        1       0.0.Normal
25      1       ____RFUD__AC__________________MD______MM        2       0.0.Normal
26      2       ______UD______________________MD________        1       0.0.Normal
28      1       ______UD______________________MD____RA__        1       0.0.Normal
29      2       ______UD______________________MD________        1       0.0.Normal


root ~# echo -n /dev/hda > /proc/filecache
root ~# head /proc/filecache
# file /dev/hda
# flags LK:locked ER:error RF:referenced UD:uptodate DT:dirty AC:active SL:slab CK:checked A1:arch_1 RS:reserved PV:private WB:writeback NS:nosave CP:compound SC:swapcache MD:mappedtodisk RC:reclaim ns:nosave_free RA:readahead MM:mmap
# idx   len                     state                   	refcnt  location
0       2       ______UDDTAC________PV__________________        2       0.0.Normal
4       1       ____RF____AC________PV__________________        2       0.0.Normal
501     1       ____RF____AC________PV__________________        2       0.0.Normal
506     1       ____RFUD____________PV__________________        2       0.0.Normal
507     1       ____RF______________PV__________________        2       0.0.Normal
518     1       ____RF____AC________PV__________________        2       0.0.Normal
571     2       ____RF______________PV__________________        2       0.0.Normal


Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 fs/Kconfig          |   10 
 fs/dcache.c         |   17 +
 fs/inode.c          |    9 
 fs/proc/Makefile    |    1 
 fs/proc/filecache.c |  535 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h  |    1 
 include/linux/mm.h  |    1 
 mm/page_alloc.c     |    2 
 8 files changed, 574 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc6-mm1.orig/fs/Kconfig
+++ linux-2.6.17-rc6-mm1/fs/Kconfig
@@ -894,6 +894,16 @@ config CONFIGFS_FS
 	  Both sysfs and configfs can and should exist together on the
 	  same system. One is not a replacement for the other.
 
+config PROC_FILECACHE
+	tristate "/proc/filecache support"
+	default m
+	depends on PROC_FS
+	help
+	  This option creates a file /proc/filecache which enables one to
+	  get the listing of cached files/pages.
+
+	  It can be a handy tool for sysadms and desktop users.
+
 endmenu
 
 menu "Miscellaneous filesystems"
--- /dev/null
+++ linux-2.6.17-rc6-mm1/fs/proc/filecache.c
@@ -0,0 +1,524 @@
+/*
+ * linux/fs/proc/filecache.c
+ *
+ * Copyright (C) 2006 Wu Fengguang <wfg@mail.ustc.edu.cn>
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
+#include <linux/writeback.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
+static char name_all[] = "ALL";
+static char *global_default_name = name_all;
+static DEFINE_MUTEX(fcache_target_mutex);
+
+#define PG_LAST		PG_readahead
+#define PG_MASK		((2UL << PG_LAST) - 1)
+#define FCACHE_PG_MMAP	(PG_LAST + 1)
+#define FCACHE_PG_COUNT	(PG_LAST + 2)
+
+/*
+ * Page state names, prefixed by their abbreviations.
+ */
+const char *flag_names[FCACHE_PG_COUNT] = {
+	[PG_locked]		= "LK:locked",
+	[PG_error]		= "ER:error",
+	[PG_referenced]		= "RF:referenced",
+	[PG_uptodate]		= "UD:uptodate",
+
+	[PG_dirty]		= "DT:dirty",
+	/* [PG_lru]		= "RU:lru", */
+	[PG_active]		= "AC:active",
+	[PG_slab]		= "SL:slab",
+
+	[PG_checked]		= "CK:checked",
+	[PG_arch_1]		= "A1:arch_1",
+	[PG_reserved]		= "RS:reserved",
+	[PG_private]		= "PV:private",
+
+	[PG_writeback]		= "WB:writeback",
+	[PG_nosave]		= "NS:nosave",
+	[PG_compound]		= "CP:compound",
+	[PG_swapcache]		= "SC:swapcache",
+
+	[PG_mappedtodisk]	= "MD:mappedtodisk",
+	[PG_reclaim]		= "RC:reclaim",
+	[PG_nosave_free]	= "ns:nosave_free",
+	/* [PG_buddy]		= "BD:buddy", */
+
+	[PG_readahead]		= "RA:readahead",
+
+	[FCACHE_PG_MMAP]	= "MM:mmap",
+};
+
+/*
+ * Inode listing.
+ *
+ * Usage:
+ * 		echo -n ALL > /proc/filecache
+ * 		cat /proc/filecache
+ *
+ * TODO
+ * show the files in a sorted manner(newest ones at top):
+ * 	- list_for_each(super_blocks)/list_for_each_prev(s_dirty)
+ * 	- list_for_each(inode_in_use)
+ * 	- list_for_each(inode_unused)
+ */
+
+static void show_inode(struct seq_file *m, struct inode *inode)
+{
+	char state[] = "--"; /* dirty, locked */
+	struct dentry *alias;
+	loff_t size = i_size_read(inode);
+	unsigned long pgcached = inode->i_mapping->nrpages;
+	int percent;
+	int refcnt;
+
+	if (!size || !pgcached)
+		return;
+
+	percent = min(100UL, 100 * (pgcached << PAGE_CACHE_SHIFT) /
+							(unsigned long)size);
+
+	if (inode->i_state & (I_DIRTY_DATASYNC|I_DIRTY_PAGES))
+		state[0] = 'D';
+	if (inode->i_state & I_LOCK)
+		state[0] = 'L';
+
+	refcnt = 0;
+	list_for_each_entry(alias, &inode->i_dentry, d_alias) {
+		refcnt += atomic_read(&alias->d_count);
+	}
+
+	seq_printf(m, "%10lu %10llu %8lu %6d\t%s\t%d\t%u\t%u\t%02x:%02x(%s)\t",
+			inode->i_ino,
+			DIV_ROUND_UP(size, 1024),
+			pgcached << (PAGE_CACHE_SHIFT - 10),
+			percent,
+			state,
+			/* atomic_read(&inode->i_count), */
+			refcnt,
+			inode->i_uid,
+			inode->i_gid,
+			MAJOR(inode->i_sb->s_dev),
+			MINOR(inode->i_sb->s_dev),
+			inode->i_sb->s_id);
+
+	if (list_empty(&inode->i_dentry)) {
+		if (!atomic_read(&inode->i_count))
+			seq_puts(m, "NONAME\n");
+		else
+			seq_printf(m, "%02x:%02x\n",
+					imajor(inode), iminor(inode));
+	} else {
+		alias = list_entry(inode->i_dentry.next,
+							struct dentry, d_alias);
+		seq_path(m, NULL, alias, " \t\n\\");
+		seq_putc(m, '\n');
+	}
+}
+
+static int may_show_inode(struct inode *inode)
+{
+	if (!inode->i_mapping->nrpages)
+		return 0;
+
+	if (!current->uid)
+		return 1;
+
+	return !permission(inode, MAY_READ, NULL);
+}
+
+static int ftable_show(struct seq_file *m, void *v)
+{
+	unsigned long index = *(loff_t *) v;
+	struct hlist_head *head = get_inode_hash_budget(index);
+	struct hlist_node *node;
+        struct inode * inode;
+
+	if (index == 0) {
+		seq_printf(m, "# file %s\n" , name_all);
+		seq_puts(m, "#      ino       size   cached cached%"
+				"\tstate\trefcnt\tuid\tgid\tdev\t\tfile\n");
+	}
+
+	BUG_ON (head == NULL);
+        hlist_for_each (node, head) {
+                inode = hlist_entry(node, struct inode, i_hash);
+
+		if (may_show_inode(inode))
+			show_inode(m, inode);
+	}
+
+	return 0;
+}
+
+static void *ftable_start(struct seq_file *m, loff_t *pos)
+{
+	spin_lock(&inode_lock);
+
+	return get_inode_hash_budget(*pos) ? pos : NULL;
+}
+
+static void *ftable_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	(*pos)++;
+
+	return get_inode_hash_budget(*pos) ? pos : NULL;
+}
+
+static void ftable_stop(struct seq_file *m, void *v)
+{
+	spin_unlock(&inode_lock);
+}
+
+
+/*
+ * Show cached pages of a file.
+ *
+ * Usage:
+ * 		echo -n 'file name' > /proc/filecache
+ * 		cat /proc/filecache
+ */
+
+static unsigned long page_flags(struct page* page)
+{
+	unsigned long flags;
+
+	flags = page->flags & PG_MASK;
+
+	if (page_mapped(page))
+		flags |= (1UL << FCACHE_PG_MMAP);
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
+	if (page_zone_id(page0) != page_zone_id(page))
+		return 0;
+
+	return 1;
+}
+
+static void show_range(struct seq_file *m, struct page* page, unsigned long len)
+{
+	const char **s;
+	unsigned long flags;
+
+	if (!m || !page)
+		return;
+
+	seq_printf(m, "%lu\t%lu\t", page->index, len);
+
+	for (	s = flag_names, flags = page_flags(page);
+		s - flag_names < FCACHE_PG_COUNT;
+		s++, flags >>= 1)
+		if (*s)
+			seq_printf(m, "%.2s", (flags & 1UL) ? *s : "__");
+
+	BUG_ON(!PageLRU(page));
+	BUG_ON(PageBuddy(page));
+
+	seq_printf(m, "\t%d\t%lu.%lu.%s\n",
+			page_count(page),
+			page_to_section(page),
+			page_to_nid(page),
+			zone_names[page_zonenum(page)]);
+}
+
+#define MAX_LINES	50
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
+static int fcache_show(struct seq_file *m, void *v)
+{
+	struct file *file = (struct file *)(unsigned long)(m->version);
+	pgoff_t offset;
+
+	if (!file)
+		return ftable_show(m, v);
+
+	offset = *(loff_t *) v;
+	BUG_ON (offset != (pgoff_t)m->private);
+
+	if (!offset) { /* print header */
+		int i;
+		seq_puts(m, "# file ");
+		seq_path(m, file->f_vfsmnt, file->f_dentry, " \t\n\\");
+		seq_puts(m, "\n# flags");
+		for (i = 0; i < FCACHE_PG_COUNT; i++)
+			if (flag_names[i])
+				seq_printf(m, " %s", flag_names[i]);
+		seq_puts(m, "\n# idx\tlen\t\t\tstate\t\t\t\trefcnt\tlocation\n");
+	}
+
+	m->private = (void *)show_file_cache(m, file->f_mapping, offset);
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
+static void *fcache_start(struct seq_file *m, loff_t *pos)
+{
+	struct file *file = (struct file *)(unsigned long)(m->version);
+
+	if (!file)
+		return ftable_start(m, pos);
+
+	read_lock_irq(&file->f_mapping->tree_lock);
+
+	if (*pos)
+		return NULL;
+
+	m->private = NULL;
+	return pos;
+}
+
+static void *fcache_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct file *file = (struct file *)(unsigned long)(m->version);
+
+	if (!file)
+		return ftable_next(m, v, pos);
+
+	*pos = (unsigned long)m->private;
+	/* *pos = show_file_cache(NULL, file->f_mapping, *pos); */
+
+	return file_has_page(file, (pgoff_t)m->private) ? pos : NULL;
+}
+
+static void fcache_stop(struct seq_file *m, void *v)
+{
+	struct file *file = (struct file *)(unsigned long)(m->version);
+
+	if (!file)
+		return ftable_stop(m, v);
+
+	read_unlock_irq(&file->f_mapping->tree_lock);
+}
+
+struct seq_operations seq_filecache_op = {
+	.start	= fcache_start,
+	.next	= fcache_next,
+	.stop	= fcache_stop,
+	.show	= fcache_show,
+};
+
+
+/*
+ * Target file management.
+ *
+ * Target file is stored in proc_file->f_version:
+ * 	- NULL: show a comprehensive cached inode listing
+ * 	- filp: show cached pages of filp
+ */
+
+/*
+ * Close target file associated with @file.
+ */
+static void fcache_target_close(struct file *file)
+{
+	if (file->f_version) {
+		filp_close((struct file *)file->f_version, NULL);
+		file->f_version = 0;
+	}
+}
+
+/*
+ * Open target file specified by @name.
+ * And associated it with @file.
+ */
+static struct file* fcache_target_open(struct file *file, const char *name)
+{
+	struct file *tf;
+
+	if (name == name_all)
+		tf = NULL;
+	else
+		tf = filp_open(name, O_RDONLY|O_LARGEFILE, 0);
+
+	if (!IS_ERR(tf))
+		file->f_version = (unsigned long)tf;
+
+	return tf;
+}
+
+/*
+ * Associate @file with a default target file.
+ */
+static void fcache_target_init(struct file *file)
+{
+	mutex_lock(&fcache_target_mutex);
+	fcache_target_open(file, global_default_name);
+	mutex_unlock(&fcache_target_mutex);
+}
+
+/*
+ * - set @name as new global default.
+ * - renew target file of @file.
+ */
+static struct file* fcache_target_update(struct file *file, char *name)
+{
+	struct file *tf = NULL;
+
+	mutex_lock(&fcache_target_mutex);
+
+	if (global_default_name != name_all)
+		kfree(global_default_name);
+
+	if (!strcmp(name, name_all)) {
+		kfree(name);
+		name = name_all;
+	}
+
+	global_default_name = name;
+	fcache_target_close(file);
+	tf = fcache_target_open(file, name);
+
+	mutex_unlock(&fcache_target_mutex);
+
+	return tf;
+}
+
+static int filecache_open(struct inode *inode, struct file *file)
+{
+	int ret = seq_open(file, &seq_filecache_op);
+	fcache_target_init(file);
+	return ret;
+}
+
+static int filecache_release(struct inode *inode, struct file *file)
+{
+	fcache_target_close(file);
+	return seq_release(inode, file);
+}
+
+ssize_t filecache_write(struct file *file, const char __user * buffer,
+			size_t count, loff_t *ppos)
+{
+	struct file *err;
+	char *name;
+
+	if (*ppos)
+		return -EINVAL;
+
+	if (count >= PATH_MAX)
+		return -ENAMETOOLONG;
+
+	name = kmalloc(count+1, GFP_KERNEL);
+	if (name == NULL)
+		return -ENOMEM;
+
+	if (copy_from_user(name, buffer, count)) {
+		kfree(name);
+		return -EFAULT;
+	}
+	name[count] = '\0';
+
+	err = fcache_target_update(file, name);
+
+	if (IS_ERR(err))
+		return (ssize_t)err;
+	else
+		return count;
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
+static __init int file_cache_init(void)
+{
+	struct proc_dir_entry *entry;
+
+	entry = create_proc_entry("filecache", 0, NULL);
+	if (entry)
+		entry->proc_fops = &proc_filecache_fops;
+
+	return 0;
+}
+
+static void file_cache_exit(void)
+{
+	remove_proc_entry("filecache", NULL);
+}
+
+MODULE_AUTHOR("Wu Fengguang <wfg@mail.ustc.edu.cn>");
+MODULE_LICENSE("GPL");
+
+module_init(file_cache_init);
+module_exit(file_cache_exit);
--- linux-2.6.17-rc6-mm1.orig/fs/inode.c
+++ linux-2.6.17-rc6-mm1/fs/inode.c
@@ -1328,6 +1328,15 @@ void wake_up_inode(struct inode *inode)
 	wake_up_bit(&inode->i_state, __I_LOCK);
 }
 
+struct hlist_head * get_inode_hash_budget(unsigned long index)
+{
+	if (index >= (1 << i_hash_shift))
+		return NULL;
+
+	return inode_hashtable + index;
+}
+EXPORT_SYMBOL_GPL(get_inode_hash_budget);
+
 static __initdata unsigned long ihash_entries;
 static int __init set_ihash_entries(char *str)
 {
--- linux-2.6.17-rc6-mm1.orig/include/linux/fs.h
+++ linux-2.6.17-rc6-mm1/include/linux/fs.h
@@ -1674,6 +1674,7 @@ extern void remove_inode_hash(struct ino
 static inline void insert_inode_hash(struct inode *inode) {
 	__insert_inode_hash(inode, inode->i_ino);
 }
+struct hlist_head * get_inode_hash_budget(unsigned long index);
 
 extern struct file * get_empty_filp(void);
 extern void file_move(struct file *f, struct list_head *list);
--- linux-2.6.17-rc6-mm1.orig/fs/dcache.c
+++ linux-2.6.17-rc6-mm1/fs/dcache.c
@@ -1478,7 +1478,10 @@ static char * __d_path( struct dentry *d
 
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
--- linux-2.6.17-rc6-mm1.orig/fs/proc/Makefile
+++ linux-2.6.17-rc6-mm1/fs/proc/Makefile
@@ -13,3 +13,4 @@ proc-y       += inode.o root.o base.o ge
 proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
 proc-$(CONFIG_PROC_DEVICETREE)	+= proc_devtree.o
+proc-$(CONFIG_PROC_FILECACHE)	+= filecache.o
--- linux-2.6.17-rc6-mm1.orig/include/linux/mm.h
+++ linux-2.6.17-rc6-mm1/include/linux/mm.h
@@ -483,6 +483,7 @@ static inline unsigned long page_zonenum
 
 struct zone;
 extern struct zone *zone_table[];
+extern char *zone_names[];
 
 static inline int page_zone_id(struct page *page)
 {
--- linux-2.6.17-rc6-mm1.orig/mm/page_alloc.c
+++ linux-2.6.17-rc6-mm1/mm/page_alloc.c
@@ -81,7 +81,7 @@ EXPORT_SYMBOL(totalram_pages);
 struct zone *zone_table[1 << ZONETABLE_SHIFT] __read_mostly;
 EXPORT_SYMBOL(zone_table);
 
-static char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
+char *zone_names[MAX_NR_ZONES] = { "DMA", "DMA32", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
 
 unsigned long __meminitdata nr_kernel_pages;
