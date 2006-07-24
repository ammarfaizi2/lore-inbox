Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWGXRWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWGXRWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWGXRWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:22:14 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:11908 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932231AbWGXRWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:22:11 -0400
Subject: [patch] inotify: fix deadlock found by lockdep
From: Arjan van de Ven <arjan@linux.intel.com>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John McCutchan <john@johnmccutchan.com>, Andrew Morton <akpm@osdl.org>,
       rml@novell.com, viro@zeniv.linux.org.uk
In-Reply-To: <44C2C90B.6090108@reub.net>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	 <44C2C90B.6090108@reub.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Jul 2006 19:21:10 +0200
Message-Id: <1153761671.3043.89.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] inotify: fix deadlock found by lockdep
From: Arjan van de Ven <arjan@linux.intel.com>

This is a real deadlock, a nice complex one:
(warning: long explanation follows so that Andrew can have a complete
patch description)

it's an ABCDA deadlock:

A iprune_mutex 
B inode->inotify_mutex
C ih->mutex
D dev->ev_mutex


The AB relationship comes straight from invalidate_inodes()
 
int invalidate_inodes(struct super_block * sb)
{
        int busy;
        LIST_HEAD(throw_away);

        mutex_lock(&iprune_mutex);
        spin_lock(&inode_lock);
        inotify_unmount_inodes(&sb->s_inodes);

where inotify_umount_inodes() takes the 
                mutex_lock(&inode->inotify_mutex);

The BC relationship comes directly from inotify_find_update_watch():
s32 inotify_find_update_watch(struct inotify_handle *ih, struct inode *inode,
                              u32 mask)
{
   ...
        mutex_lock(&inode->inotify_mutex);
        mutex_lock(&ih->mutex);


The CD relationship comes from inotify_rm_wd:
inotify_rm_wd does
        mutex_lock(&inode->inotify_mutex);
        mutex_lock(&ih->mutex)
and then calls inotify_remove_watch_locked() which calls
notify_dev_queue_event() which does
	        mutex_lock(&dev->ev_mutex);

(this strictly is a BCD relationship)


The DA relationship comes from the most interesting part:

  [<ffffffff8022d9f2>] shrink_icache_memory+0x42/0x270
  [<ffffffff80240dc4>] shrink_slab+0x11d/0x1c9
  [<ffffffff802b5104>] try_to_free_pages+0x187/0x244
  [<ffffffff8020efed>] __alloc_pages+0x1cd/0x2e0
  [<ffffffff8025e1f8>] cache_alloc_refill+0x3f8/0x821
  [<ffffffff8020a5e5>] kmem_cache_alloc+0x85/0xcb
  [<ffffffff802db027>] kernel_event+0x2e/0x122
  [<ffffffff8021d61c>] inotify_dev_queue_event+0xcc/0x140

inotify_dev_queue_event schedules a kernel_event which does a
kmem_cache_alloc( , GFP_KERNEL) which may try to shrink slabs, including
the inode cache .. which then takes iprune_mutex. 

And voila, there is an AB, a BC, a CD relationship (even a direct BCD),
and also now a DA relationship -> a circular type AB-BA deadlock but
involving 4 locks.

The solution is simple: kernel_event() is NOT allowed to use GFP_KERNEL,
but must use GFP_NOFS to not cause recursion into the VFS.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6.18-rc1/fs/inotify_user.c
===================================================================
--- linux-2.6.18-rc1.orig/fs/inotify_user.c
+++ linux-2.6.18-rc1/fs/inotify_user.c
@@ -187,7 +187,7 @@ static struct inotify_kernel_event * ker
 {
 	struct inotify_kernel_event *kevent;
 
-	kevent = kmem_cache_alloc(event_cachep, GFP_KERNEL);
+	kevent = kmem_cache_alloc(event_cachep, GFP_NOFS);
 	if (unlikely(!kevent))
 		return NULL;
 



