Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUBKWrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUBKWrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:47:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:43469 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266222AbUBKWrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:47:04 -0500
Date: Wed, 11 Feb 2004 14:48:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: thockin@sun.com
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH - raise max_anon limit
Message-Id: <20040211144844.0e4a2888.akpm@osdl.org>
In-Reply-To: <20040211222849.GL9155@sun.com>
References: <20040206221545.GD9155@sun.com>
	<20040207005505.784307b8.akpm@osdl.org>
	<20040207094846.GZ21151@parcelfarce.linux.theplanet.co.uk>
	<20040211203306.GI9155@sun.com>
	<Pine.LNX.4.58.0402111236460.2128@home.osdl.org>
	<20040211210930.GJ9155@sun.com>
	<20040211135325.7b4b5020.akpm@osdl.org>
	<20040211222849.GL9155@sun.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> wrote:
>
> > Wanna test this?
> 
> sure:
> 
> -------------------
> sysfs: could not mount!
> Unable to handle kernel paging request at virtual address ffffff01

Bah, ordering problem.


 25-akpm/fs/super.c         |   36 +++++++++++++++++++++---------------
 25-akpm/include/linux/fs.h |    1 +
 25-akpm/init/main.c        |    1 +
 3 files changed, 23 insertions(+), 15 deletions(-)

diff -puN fs/super.c~max_anon-use-idr fs/super.c
--- 25/fs/super.c~max_anon-use-idr	Wed Feb 11 14:42:15 2004
+++ 25-akpm/fs/super.c	Wed Feb 11 14:47:16 2004
@@ -23,6 +23,8 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/init.h>
+#include <asm/semaphore.h>
 #include <linux/smp_lock.h>
 #include <linux/acct.h>
 #include <linux/blkdev.h>
@@ -33,6 +35,7 @@
 #include <linux/security.h>
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
+#include <linux/idr.h>
 #include <asm/uaccess.h>
 
 
@@ -536,38 +539,41 @@ void emergency_remount(void)
  * filesystems which don't use real block-devices.  -- jrs
  */
 
-enum {Max_anon = 256};
-static unsigned long unnamed_dev_in_use[Max_anon/(8*sizeof(unsigned long))];
-static spinlock_t unnamed_dev_lock = SPIN_LOCK_UNLOCKED;/* protects the above */
+static struct idr unnamed_dev_idr;
+static DECLARE_MUTEX(unnamed_dev_sem);
 
 int set_anon_super(struct super_block *s, void *data)
 {
 	int dev;
-	spin_lock(&unnamed_dev_lock);
-	dev = find_first_zero_bit(unnamed_dev_in_use, Max_anon);
-	if (dev == Max_anon) {
-		spin_unlock(&unnamed_dev_lock);
-		return -EMFILE;
+
+	down(&unnamed_dev_sem);
+	if (idr_pre_get(&unnamed_dev_idr) == 0) {
+		up(&unnamed_dev_sem);
+		return -ENOMEM;
 	}
-	set_bit(dev, unnamed_dev_in_use);
-	spin_unlock(&unnamed_dev_lock);
+	dev = idr_get_new(&unnamed_dev_idr, NULL);
+	up(&unnamed_dev_sem);
 	s->s_dev = MKDEV(0, dev);
 	return 0;
 }
-
 EXPORT_SYMBOL(set_anon_super);
 
 void kill_anon_super(struct super_block *sb)
 {
 	int slot = MINOR(sb->s_dev);
+
 	generic_shutdown_super(sb);
-	spin_lock(&unnamed_dev_lock);
-	clear_bit(slot, unnamed_dev_in_use);
-	spin_unlock(&unnamed_dev_lock);
+	down(&unnamed_dev_sem);
+	idr_remove(&unnamed_dev_idr, slot);
+	up(&unnamed_dev_sem);
 }
-
 EXPORT_SYMBOL(kill_anon_super);
 
+void __init unnamed_dev_init(void)
+{
+	idr_init(&unnamed_dev_idr);
+}
+
 void kill_litter_super(struct super_block *sb)
 {
 	if (sb->s_root)
diff -puN include/linux/fs.h~max_anon-use-idr include/linux/fs.h
--- 25/include/linux/fs.h~max_anon-use-idr	Wed Feb 11 14:45:52 2004
+++ 25-akpm/include/linux/fs.h	Wed Feb 11 14:46:06 2004
@@ -1051,6 +1051,7 @@ struct super_block *sget(struct file_sys
 			void *data);
 struct super_block *get_sb_pseudo(struct file_system_type *, char *,
 			struct super_operations *ops, unsigned long);
+void unnamed_dev_init(void);
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
 #define fops_get(fops) \
diff -puN init/main.c~max_anon-use-idr init/main.c
--- 25/init/main.c~max_anon-use-idr	Wed Feb 11 14:48:12 2004
+++ 25-akpm/init/main.c	Wed Feb 11 14:48:15 2004
@@ -473,6 +473,7 @@ asmlinkage void __init start_kernel(void
 	fork_init(num_physpages);
 	proc_caches_init();
 	buffer_init();
+	unnamed_dev_init();
 	security_scaffolding_startup();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();

_

