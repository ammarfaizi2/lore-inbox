Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUHOItL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUHOItL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 04:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUHOItL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 04:49:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48093 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266555AbUHOIs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 04:48:57 -0400
Date: Sun, 15 Aug 2004 09:48:56 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
Message-ID: <20040815084856.GD12308@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040814021809.GD30627@logos.cnet> <200408140417.20539.gene.heskett@verizon.net> <200408150009.45034.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408150009.45034.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 12:09:44AM -0400, Gene Heskett wrote:
> The only thing I've noted in the slabinfo reports is the ext3_cache 
> was well into 6 digits in kilobytes.  Now its only 15,000 of its 
> normal units (whatever they are) after the reboot.

What did dcache numbers look like at that time?

Anyway, we could try the patch below and see what shows in /proc/fs/ext3
with it [NOTE: patch is completely untested].  It should show
	major:minor:inumber:mode
for all currently allocated ext3 inodes.  It won't be 100% accurate (we
can miss some entries/get some twice if cache shrinks or grows at the
time), but if the leak is so massive, we ought to see a *lot* of duplicates
in there.  Seeing what kind of inodes really leaks could narrow the things
down.

See if cat /proc/fs/ext3 | sort | uniq -c | sort -nr gives anything interesting
when leak happens (and check it right after boot to see if it works at all
and doesn't oops, obviously ;-)

diff -urN RC8-current/fs/ext3/super.c RC8-leak/fs/ext3/super.c
--- RC8-current/fs/ext3/super.c	Sat Aug 14 05:35:37 2004
+++ RC8-leak/fs/ext3/super.c	Sun Aug 15 04:41:09 2004
@@ -35,6 +35,8 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/quotaops.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <asm/uaccess.h>
 #include "xattr.h"
 #include "acl.h"
@@ -438,6 +440,9 @@
 
 static kmem_cache_t *ext3_inode_cachep;
 
+static LIST_HEAD(ext3_list);
+static spinlock_t ext3_list_lock = SPIN_LOCK_UNLOCKED;
+
 /*
  * Called inside transaction, so use GFP_NOFS
  */
@@ -453,11 +458,17 @@
 	ei->i_default_acl = EXT3_ACL_NOT_CACHED;
 #endif
 	ei->vfs_inode.i_version = 1;
+	spin_lock(&ext3_list_lock);
+	list_add(&ei->list, &ext3_list);
+	spin_unlock(&ext3_list_lock);
 	return &ei->vfs_inode;
 }
 
 static void ext3_destroy_inode(struct inode *inode)
 {
+	spin_lock(&ext3_list_lock);
+	list_del_init(&EXT3_I(inode)->list);
+	spin_unlock(&ext3_list_lock);
 	kmem_cache_free(ext3_inode_cachep, EXT3_I(inode));
 }
 
@@ -475,20 +486,82 @@
 		inode_init_once(&ei->vfs_inode);
 	}
 }
+
+static void *ext3_cache_start(struct seq_file *m, loff_t *pos)
+{
+	struct list_head *p;
+	loff_t l = *pos;
+
+	spin_lock(&ext3_list_lock);
+	list_for_each(p, &ext3_list)
+		if (!l--)
+			return list_entry(p, struct ext3_inode_info, list);
+	return NULL;
+}
+
+static void *ext3_cache_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct list_head *p = ((struct ext3_inode_info *)v)->list.next;
+	(*pos)++;
+	return p==&ext3_list ? NULL : list_entry(p, struct ext3_inode_info, list);
+}
+
+static void ext3_cache_stop(struct seq_file *m, void *v)
+{
+	spin_unlock(&ext3_list_lock);
+}
+
+static int ext3_cache_show(struct seq_file *m, void *v)
+{
+	struct ext3_inode_info *ei = v;
+	struct inode *inode = &ei->vfs_inode;
+	seq_printf(m, "%d:%d:%lu:%o",
+		MAJOR(inode->i_sb->s_dev),
+		MINOR(inode->i_sb->s_dev),
+		inode->i_ino,
+		inode->i_mode);
+	return 0;
+}
+
+static struct seq_operations ext3_cache_op = {
+	.start	= ext3_cache_start,
+	.next	= ext3_cache_next,
+	.stop	= ext3_cache_stop,
+	.show	= ext3_cache_show
+};
+
+static int ext3_cache_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &ext3_cache_op);
+}
+
+static struct file_operations ext3_cache_operations = {
+	.open		= ext3_cache_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
  
 static int init_inodecache(void)
 {
+	struct proc_dir_entry *p;
 	ext3_inode_cachep = kmem_cache_create("ext3_inode_cache",
 					     sizeof(struct ext3_inode_info),
 					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (ext3_inode_cachep == NULL)
 		return -ENOMEM;
+	p = create_proc_entry("fs/ext3", S_IRUGO, NULL);
+	if (p) {
+		p->owner = THIS_MODULE;
+		p->proc_fops = &ext3_cache_operations;
+	}
 	return 0;
 }
 
 static void destroy_inodecache(void)
 {
+	remove_proc_entry("fs/ext3", NULL);
 	if (kmem_cache_destroy(ext3_inode_cachep))
 		printk(KERN_INFO "ext3_inode_cache: not all structures were freed\n");
 }
diff -urN RC8-current/include/linux/ext3_fs_i.h RC8-leak/include/linux/ext3_fs_i.h
--- RC8-current/include/linux/ext3_fs_i.h	Thu Oct  9 17:34:54 2003
+++ RC8-leak/include/linux/ext3_fs_i.h	Sun Aug 15 04:11:03 2004
@@ -107,6 +107,7 @@
 	 * by other means, so we have truncate_sem.
 	 */
 	struct semaphore truncate_sem;
+	struct list_head list;
 	struct inode vfs_inode;
 };
 
