Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbTJOQRK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbTJOQRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:17:10 -0400
Received: from brmea-mail-2.Sun.COM ([192.18.98.43]:12283 "EHLO
	brmea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S263481AbTJOQQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:16:59 -0400
Date: Wed, 15 Oct 2003 12:16:07 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [NFS] RE: [autofs] multiple servers per automount
In-reply-to: <200310151228.02741.ioe-lkml@rameria.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>, linux-kernel@vger.kernel.org,
       Ian Kent <raven@themaw.net>
Message-id: <3F8D72C7.4040005@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------000500060209090904010809
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618
 Debian/1.3.1-3
References: <Pine.LNX.4.44.0310142131090.3044-100000@raven.themaw.net>
 <bmhn7t$odm$1@cesium.transmeta.com> <3F8C82EF.2010104@sun.com>
 <3F8C82EF.2010104@sun.com> <200310151228.02741.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000500060209090904010809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Oeser wrote:
> On Wednesday 15 October 2003 01:12, Mike Waychison wrote:
> 
>>The problem still remains in 2.6 that we limit the count to 256.  I've
>>attached a quick patch that I've compiled and tested.  I don't know if
>>there is a better way to handle dynamic assignment of minors (haven't
>>kept up to date in that realm), but if there is, then we should probably
>>  use it instead.
> 
> 
> 
> In your patch you allocate inside the spinlock.
> 
> I would suggest to do sth. like the following:
> 

Better yet..  we could move it into an __init section that will panic if 
the allocation fails (this should be the desired behaviour..).  This way 
we don't even have to grab the lock either.

Mike Waychison

--------------000500060209090904010809
Content-Type: text/plain;
 name="max_anon_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="max_anon_2.patch"

===== fs/namespace.c 1.49 vs edited =====
--- 1.49/fs/namespace.c	Thu Jul 17 22:30:49 2003
+++ edited/fs/namespace.c	Wed Oct 15 15:59:11 2003
@@ -23,6 +23,7 @@
 #include <linux/mount.h>
 #include <asm/uaccess.h>
 
+extern void __init super_init(void);
 extern int __init init_rootfs(void);
 extern int __init sysfs_init(void);
 
@@ -1154,6 +1155,7 @@
 		d++;
 		i--;
 	} while (i);
+	super_init();
 	sysfs_init();
 	init_rootfs();
 	init_mount_tree();
===== fs/super.c 1.108 vs edited =====
--- 1.108/fs/super.c	Wed Oct  1 15:36:45 2003
+++ edited/fs/super.c	Wed Oct 15 15:59:50 2003
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/init.h>
 #include <linux/acct.h>
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
@@ -527,15 +528,22 @@
  * Unnamed block devices are dummy devices used by virtual
  * filesystems which don't use real block-devices.  -- jrs
  */
-
-enum {Max_anon = 256};
-static unsigned long unnamed_dev_in_use[Max_anon/(8*sizeof(unsigned long))];
+enum {Max_anon = PAGE_SIZE * 8};
+static void *unnamed_dev_in_use;
 static spinlock_t unnamed_dev_lock = SPIN_LOCK_UNLOCKED;/* protects the above */
 
+void __init super_init(void)
+{
+	unnamed_dev_in_use = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!unnamed_dev_in_use)
+		panic("Could not allocate anonymous device map");
+}
+
 int set_anon_super(struct super_block *s, void *data)
 {
 	int dev;
 	spin_lock(&unnamed_dev_lock);
+
 	dev = find_first_zero_bit(unnamed_dev_in_use, Max_anon);
 	if (dev == Max_anon) {
 		spin_unlock(&unnamed_dev_lock);

--------------000500060209090904010809--

