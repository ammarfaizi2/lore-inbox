Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUBKVvq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 16:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUBKVvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 16:51:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:13992 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263868AbUBKVvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 16:51:42 -0500
Date: Wed, 11 Feb 2004 13:53:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: thockin@sun.com
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH - raise max_anon limit
Message-Id: <20040211135325.7b4b5020.akpm@osdl.org>
In-Reply-To: <20040211210930.GJ9155@sun.com>
References: <20040206221545.GD9155@sun.com>
	<20040207005505.784307b8.akpm@osdl.org>
	<20040207094846.GZ21151@parcelfarce.linux.theplanet.co.uk>
	<20040211203306.GI9155@sun.com>
	<Pine.LNX.4.58.0402111236460.2128@home.osdl.org>
	<20040211210930.GJ9155@sun.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> wrote:
>
> > I'd suggest just raising it to 64k or so, that's likely to be acceptable, 
> > and it's a static 8kB array. That's likely not much more than the code 
> > needed to worry about dynamic entries, yet I'd assume that changing it 
> > from 256 to 64k is going to make most people say "enough".
> 
> How's this then?  It doesn't get any simpler..

Well it is lazy, wastes 0.4% of a 2M machine's memory and still has a
hard-wired limit.

Wanna test this?

 25-akpm/fs/super.c |   38 +++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 15 deletions(-)

diff -puN fs/super.c~max_anon-use-idr fs/super.c
--- 25/fs/super.c~max_anon-use-idr	Wed Feb 11 13:41:57 2004
+++ 25-akpm/fs/super.c	Wed Feb 11 13:50:16 2004
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
 
 
@@ -536,38 +539,43 @@ void emergency_remount(void)
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
 
+static int __init unnamed_dev_idr_init(void)
+{
+	idr_init(&unnamed_dev_idr);
+	return 0;
+}
+core_initcall(unnamed_dev_idr_init);
+
 void kill_litter_super(struct super_block *sb)
 {
 	if (sb->s_root)

_

