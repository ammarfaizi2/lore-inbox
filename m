Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWIWTLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWIWTLz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 15:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWIWTLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 15:11:55 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:49618 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751449AbWIWTLy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 15:11:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sT7LhNbSJVU1+Cd/tQVE4Frft6aXq8hsQ0qLd5r6dz3l2xJ/G38mhMFVkdFVyxwijzBTgv6KSgau+LLOCAtogBK7tzI95D9LeRlNh1zWFwVSYWxwKAAq7NvTtST6x8cxwvOzJ7I5JWjemCTl1wyuZR1Y8DpfrHltu5e+p8YROe0=
Message-ID: <4354d3270609231211r6b9227fdhb88a6dc8822fc803@mail.gmail.com>
Date: Sat, 23 Sep 2006 22:11:53 +0300
From: "=?ISO-8859-1?Q?T=F6r=F6k_Edvin?=" <edwintorok@gmail.com>
To: viro@zeniv.linux.org.uk
Subject: [PATCH][RFC] Rearranging files to improve disk performanc
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to implement a feature in the kernel to allow rearranging
files on the disk in order to improve performance.
The purpose is to reduce seeks. Before you say:"we don't need
defragmenting", note that this is _not_ defragmenting.

This is what I want to accomplish:
- a userspace program determines in what order are files accessed
(during boot, startup, etc.), and generates a list of files that are
always accessed
in a certain order
- rearranging these files to be one-after-another will improve disk
performance (it won't have to seek forward/backward)

This is how I suggest to implement it:
- a userspace program gives a 'hint' to the kernel where  certain
files should be placed
[it opens the file, sends the kernel a hint, copies the file to a temp
storage, truncates, and rewrites file: thus the file will end up in a
new location]
- when the kernel allocates space for inodes, it first verifies if
there is a 'hint' for that inode, if there is, it tries to honor it
- there has to be a way to communicate between kernel/userspace the
following: userspace->kernel: which file should be placed where,
kernel->userspace: if it managed to honor userspace hints or not


The following questions came up while developing this:
- what exactly should the 'hint' contain (I chose: inode, device, disk
location, size)
- how should the userspace program communicate with the kernel? (I
chose sysfs for now)
- if sysfs is going to be used, in which directory should files be put?
- should the kernel also preallocate space when receiving a hint
- how should errors be reported? (sysfs?)
- where is the appropriate place to put this stuff? (fs/relayout.c?)
- how can the implementation be as generic as possible (have as much
fs-independent code as possible)
- what can we do if there isn't enough contigous free disk space
available for moving the file (risk fragmenting the file?)
- is somebody else currently trying to implement a similar feature?

The patch below also contains a sample of how the relayout functions
could be used, in this case for reiserfs. (I intend to have support
for at least
ext3, and xfs too, but of course ideal would be if all fs-s would support this)


I am sending this patch (a draft), and waiting for your feedback on it
(and on my questions above), before going any further.

Signed-off-by: Török Edwin <edwintorok@gmail.com>
---
 fs/Kconfig                  |   10 ++
 fs/Makefile                 |    2
 fs/reiserfs/bitmap.c        |   17 +++
 fs/relayout.c               |  279 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs_relayout.h |   21 +++
 5 files changed, 329 insertions(+), 0 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 3f00a9f..b295aec 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -4,6 +4,16 @@ #

 menu "File systems"

+config FS_RELAYOUT
+	bool "Support for rearranging files"
+	help
+		Support for rearranging files (in the order in which they are
accessed) on disk, in order to reduce seeks. This 'relayout'
+		is an online algorithm (doesn't require unmount), and is safe: it
only hints the kernel where to put the file. A userspace program
+		determines optimum file placement, "hints" the kernel where to put
the files,
+		then moves the files using standard file operation functions.
+		[Currently there is work-in-progress to implement this for
reiserfs, and in the future all fs should be supported]
+
+
 config EXT2_FS
 	tristate "Second extended fs support"
 	help
diff --git a/fs/Makefile b/fs/Makefile
index 8913542..5bf603f 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -12,6 +12,8 @@ obj-y :=	open.o read_write.o file_table.
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
 		ioprio.o pnode.o drop_caches.o splice.o sync.o

+
+obj-$(CONFIG_FS_RELAYOUT)	+= relayout.o
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_INOTIFY_USER)	+= inotify_user.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff --git a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
index 4a7dbde..19a1a9f 100644
--- a/fs/reiserfs/bitmap.c
+++ b/fs/reiserfs/bitmap.c
@@ -12,6 +12,7 @@ #include <linux/pagemap.h>
 #include <linux/reiserfs_fs_sb.h>
 #include <linux/reiserfs_fs_i.h>
 #include <linux/quotaops.h>
+#include <linux/fs_relayout.h>

 #define PREALLOCATION_SIZE 9

@@ -879,6 +880,19 @@ #endif
 	/* all persons should feel encouraged to add more special cases here and
 	 * test them */

+#if defined(CONFIG_FS_RELAYOUT) 	
+	if(hint->inode) {
+		struct hint_element search;
+		search.i_ino = hint->inode->i_ino;
+		search.s_dev = hint->inode->i_sb->s_dev;
+
+		if (get_layout_hint_for(&search)) {
+			reiserfs_debug(s, REISERFS_DEBUG_CODE,"Found relayout hint for
inode:%ld",search.i_ino," location:%ld,
size:%ld\n",search.location,search.i_size);
+			hint->search_start = search.location;
+			return;
+		}
+	}
+#endif
 	if (displacing_large_files(s) && !hint->formatted_node
 	    && this_blocknr_allocation_would_make_it_a_large_file(hint)) {
 		displace_large_file(hint);
@@ -1101,6 +1115,9 @@ #endif

 			return NO_DISK_SPACE;
 		}
+#if defined(CONFIG_FS_RELAYOUT)
+		reiserfs_debug(s, REISERFS_DEBUG_CODE,"allocating, start:%ld",start);
+#endif
 	} while ((nr_allocated += allocate_without_wrapping_disk(hint,
 								 new_blocknrs +
 								 nr_allocated,
diff --git a/fs/relayout.c b/fs/relayout.c
new file mode 100644
index 0000000..df415d4
--- /dev/null
+++ b/fs/relayout.c
@@ -0,0 +1,279 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/fs_relayout.h>
+#include <linux/file.h>
+#include <linux/stringify.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+
+static LIST_HEAD(hint_list);
+static LIST_HEAD(hint_results);
+
+static spinlock_t hint_list_lock;
+static spinlock_t hint_results_lock;
+
+
+/* API */
+struct hint_list_element {
+	struct list_head list;
+	struct hint_element data;
+};
+
+struct hint_result_element {
+	struct list_head list;
+	struct hint_result data;
+};
+
+static void hint_dup(const struct hint_element* src,struct hint_element* dst)
+{
+	dst->location = src->location;
+	dst->i_size = src->i_size;
+}
+
+static int is_hint_for(const struct hint_element* hintfor, const
struct hint_element* hint)
+{
+	return (hintfor->s_dev == hint->s_dev) && (hintfor->i_ino == hint->i_ino);
+	/* this should see if this is the hint we are searching for,
+	 * hintfor doesn't have all fields completed, only the inode, device... */
+}
+int add_hint_result(const struct hint_result* result)
+{
+	struct hint_result_element* hint = kmalloc(sizeof(*hint), GFP_KERNEL);
+	if(unlikely(!hint))
+		return -ENOMEM;
+	memcpy(&hint->data,result,sizeof(*result));
+
+	spin_lock(&hint_results_lock);
+	list_add_tail(&hint->list,&hint_results);
+	spin_unlock(&hint_results_lock);
+
+	return 0;
+}
+
+int get_layout_hint_for(struct hint_element* hint_search)
+{
+	struct hint_list_element* hint;
+	spin_lock(&hint_list_lock);
+	list_for_each_entry(hint, &hint_list, list) {
+		if(is_hint_for(hint_search, &hint->data)) {
+			list_del(&hint->list);
+			spin_unlock(&hint_list_lock);
+			hint_dup(&hint->data,hint_search);
+			return 1;
+		}
+	}
+	spin_unlock(&hint_list_lock);
+	return 0;
+}
+/* lists */
+
+static decl_subsys(relayout, NULL, NULL);
+
+/*------ hint parsing & formatting --------*/
+static size_t parse_hint(const char* buf, size_t count, struct
hint_element* hint)
+{
+	int fd;
+	struct file* file;
+
+	if( sscanf(buf,"%d %Ld",&fd,&hint->location)!=2) {
+		printk(KERN_INFO "Unable to parse hint:%s",buf);
+		return count;
+	}
+
+	file = fget(fd);
+	if(file->f_dentry && file->f_dentry->d_inode) {
+		const struct inode* inode = file->f_dentry->d_inode;
+		hint->i_ino = inode->i_ino;
+		hint->i_size = inode->i_size;
+		hint->s_dev = inode->i_sb->s_dev;
+	}
+	else {
+		printk(KERN_INFO "Unable to get inode from fd:%d",fd);
+		fput(file);
+		return count;
+	}
+	fput(file);
+	return count;
+}
+
+static ssize_t format_hint(const struct hint_element* hint, char* buf)
+{
+	return sprintf(buf,"device:%u\ninode:%lu\nsize:%Ld\nlocation
hint:%Ld\n-------\n",hint->s_dev,hint->i_ino,hint->i_size,hint->location);
+}
+
+static int compare_hint(const struct hint_element* a, const struct
hint_element* b)
+{
+	return memcmp(a,b,sizeof(*a));
+}
+
+static ssize_t format_hint_result(const struct hint_result* hint, char* buf)
+{
+	return sprintf(buf,"hint result:\n"/*, hint->...*/);
+	/* TODO: format hint result as string */
+}
+
+/*--------- sysfs interface -----------*/
+static ssize_t show_layout_hint(struct subsystem* entry, char* buf)
+{
+	char* out = buf;
+	struct hint_list_element* hint;
+	/*FIXME: are spinlocks required here? */
+	spin_lock(&hint_list_lock);
+	list_for_each_entry(hint, &hint_list, list) {
+		out += format_hint(&hint->data,out);
+	}
+	spin_unlock(&hint_list_lock);
+	/* TODO: list pending hints */
+	return out-buf;
+}
+
+static ssize_t store_layout_hint(struct subsystem* entry, const char*
buf, size_t count)
+{
+	struct hint_list_element* hint = kmalloc(sizeof(*hint),GFP_KERNEL);
+	ssize_t rc;
+	if(unlikely(!hint))
+		return -ENOMEM;
+
+	rc = parse_hint(buf, count, &hint->data);
+	if(rc == count) {
+		spin_lock(&hint_list_lock);
+		list_add_tail(&hint->list,&hint_list);
+		spin_unlock(&hint_list_lock);
+	}
+	return rc;
+}
+
+
+/* lookup the provided hint, and delete it from the hint list,
+ * the user should then check layout_hint, to see if it has been
successfully deleted */
+static ssize_t store_layout_delete_hint(struct subsystem* entry,
const char* buf, size_t count)
+{
+	struct hint_element hint_search;
+	ssize_t rc = parse_hint(buf, count, &hint_search);
+	if(rc == count) {
+		struct hint_list_element *hint,*tmp;
+		spin_lock(&hint_list_lock);
+		list_for_each_entry_safe(hint, tmp, &hint_list, list) {
+			if(compare_hint(&hint->data,&hint_search) == 0) {
+				list_del_init(&hint->list);
+				kfree(hint);
+			}
+		}
+		spin_unlock(&hint_list_lock);
+	}
+	return count;
+}
+
+static inline void hint_results_del(void)
+{
+	struct hint_result_element *hint,*tmp;
+
+	spin_lock(&hint_results_lock);
+	list_for_each_entry_safe(hint, tmp, &hint_results, list) {
+		list_del(&hint->list);
+		kfree(hint);
+	}
+	list_del_init(&hint_results);
+	spin_unlock(&hint_results_lock);
+}
+
+static inline void hint_list_del(void)
+{
+	struct hint_list_element *hint,*tmp;
+
+	spin_lock(&hint_list_lock);
+	list_for_each_entry_safe(hint, tmp, &hint_list, list) {
+		list_del(&hint->list);
+		kfree(hint);
+	}
+	list_del_init(&hint_list);
+	spin_unlock(&hint_list_lock);
+}
+/* delete all hint results. [Yes, writing this file means empty the
log stored in this file] */
+static ssize_t store_layout_results(struct subsystem* entry, const
char* buf,size_t count)
+{
+	hint_results_del();
+	return count;
+}
+
+
+/* This is a 'log' of relayout results. THe user can check this to
see if its hints were honored.
+	 * Or it can just use FIBMAP to get this info */
+static ssize_t show_layout_results(struct subsystem* entry, char* buf)
+{
+	char* out = buf;
+	const struct hint_result_element* hint;
+
+	spin_lock(&hint_results_lock);
+	list_for_each_entry(hint, &hint_results, list) {
+		out += format_hint_result(&hint->data, out);
+	}
+	spin_unlock(&hint_results_lock);
+	return out-buf;
+}
+
+#define RELAYOUT_ATTR(_name, _mode, _show, _store) \
+struct subsys_attribute relayout_attr_##_name = { \
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE}, \
+	.show = _show, \
+	.store = _store, \
+};
+
+static RELAYOUT_ATTR(layout_hint, 0644, show_layout_hint, store_layout_hint)
+static RELAYOUT_ATTR(layout_delete_hint, 0644, NULL, store_layout_delete_hint)
+static RELAYOUT_ATTR(layout_results, 0644, show_layout_results,
store_layout_results)
+
+static struct subsys_attribute* relayout_attrs[] = {
+	&relayout_attr_layout_hint,
+	&relayout_attr_layout_delete_hint,
+	&relayout_attr_layout_results,
+};
+	
+static int __init init_relayout(void)
+{
+	int err;
+	size_t i;
+
+	printk(KERN_INFO "FS relayout module initializing\n");
+	/* set up relayout subsystem */
+	kset_set_kset_s(&relayout_subsys, fs_subsys);
+	err = subsystem_register(&relayout_subsys);
+	if (err)
+		goto out_err;
+	/* init locking */
+	spin_lock_init(&hint_list_lock);
+	spin_lock_init(&hint_results_lock);
+
+	/* export communication attr files to sysfs */
+	for(i=0;i<sizeof(relayout_attrs)/sizeof(relayout_attrs[0]);i++)
+			subsys_create_file(&relayout_subsys,relayout_attrs[i]);
+
+
+	/*TODO: create sysfs file, used to communicate with userspace:
+	 * userspace will communicate us an inode, and a preferred placement hint
+	 * we shall return him the real allocated place */
+	printk(KERN_INFO "FS relayout module initialization complete\n");
+	return 0;
+out_err:
+	printk(KERN_INFO "FS relayout initialization error\n");
+	return err;
+}
+
+static void __exit cleanup_relayout(void)
+{
+	printk(KERN_INFO "FS relayout module cleaning up\n");
+	hint_results_del();
+	hint_list_del();
+	subsystem_unregister(&relayout_subsys);
+	printk(KERN_INFO "FS relayout module cleanup complete\n");
+}
+
+module_init(init_relayout);
+module_exit(cleanup_relayout);
+
+MODULE_AUTHOR("Torok Edwin");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Filesystem relayout");
+MODULE_VERSION("0.01");
diff --git a/include/linux/fs_relayout.h b/include/linux/fs_relayout.h
new file mode 100644
index 0000000..bcd347e
--- /dev/null
+++ b/include/linux/fs_relayout.h
@@ -0,0 +1,21 @@
+#ifndef _FS_RELAYOUT_H
+#define _FS_RELAYOUT_H
+struct hint_element {
+	dev_t s_dev;
+	unsigned long i_ino;
+	loff_t i_size;
+	loff_t location;
+};
+
+struct hint_result {
+};
+
+#if defined(CONFIG_FS_RELAYOUT)
+int add_hint_result(const struct hint_result* result);
+int get_layout_hint_for(struct hint_element* hint_search);
+#else
+static inline int add_hint_result(const struct hint_result* result) {
return 0; }
+static inline int get_layout_hint_for(struct hint_element*
hint_search) {return 0;}
+#endif
+
+#endif
