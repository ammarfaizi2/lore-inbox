Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUD2CEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUD2CEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUD2CEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:04:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32218 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261832AbUD2CDK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:03:10 -0400
Date: Thu, 29 Apr 2004 03:03:09 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG: might_sleep in /proc/swaps code
Message-ID: <20040429020309.GF17014@parcelfarce.linux.theplanet.co.uk>
References: <20040428232457.GB1483@sun.com> <20040429005333.GE17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429005333.GE17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 01:53:35AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Apr 28, 2004 at 04:24:58PM -0700, Tim Hockin wrote:
> > * /proc/swaps uses seq_file code, calling seq_path() with swaplock held
> > * seq_path() calls d_path()
> > * d_path() calls mntput() which might_sleep()
> > 
> > Is this worth trying to solve?  
> 
> Hrm...  Yes, it is - we could have chroot(2) called from another thread
> while traversing the path to current root and have e.g. umount -l trigger
> final umount when d_path() is finished.
> 
> Note that we have another blocking function called there anyway - dput()
> will happily block under similar conditions (s/umount -l/rm/).
> 
> Lovely...  So we need yet another semaphore in swapfile.c (we can't turn
> swaplock into semaphore *and* can't reuse swaps_bdev_sem, since dput()
> et.al. are not just blocking but can cause any IO and memory allocations).
> 
> I'll try to put together something not too revolting; will post the patch
> in a followup...

OK, here comes.  New semaphore protecting insertions/removals in the
set of swap components + switch of ->start()/->stop() to the same
semaphore [fixes deadlocks] + trivial cleanup of ->next().

See if it works for you...

diff -urN RC6-rc3/mm/swapfile.c RC6-rc3-current/mm/swapfile.c
--- RC6-rc3/mm/swapfile.c	Tue Apr 27 23:17:39 2004
+++ RC6-rc3-current/mm/swapfile.c	Wed Apr 28 21:34:30 2004
@@ -45,6 +45,8 @@
 
 struct swap_info_struct swap_info[MAX_SWAPFILES];
 
+static DECLARE_MUTEX(swapon_sem);
+
 /*
  * Array of backing blockdevs, for swap_unplug_fn.  We need this because the
  * bdev->unplug_fn can sleep and we cannot hold swap_list_lock while calling
@@ -1158,6 +1160,7 @@
 		swap_list_unlock();
 		goto out_dput;
 	}
+	down(&swapon_sem);
 	down(&swap_bdevs_sem);
 	swap_list_lock();
 	swap_device_lock(p);
@@ -1172,6 +1175,7 @@
 	swap_list_unlock();
 	remove_swap_bdev(p->bdev);
 	up(&swap_bdevs_sem);
+	up(&swapon_sem);
 	vfree(swap_map);
 	if (S_ISBLK(mapping->host->i_mode)) {
 		struct block_device *bdev = I_BDEV(mapping->host);
@@ -1197,7 +1201,7 @@
 	int i;
 	loff_t l = *pos;
 
-	swap_list_lock();
+	down(&swapon_sem);
 
 	for (i = 0; i < nr_swapfiles; i++, ptr++) {
 		if (!(ptr->flags & SWP_USED) || !ptr->swap_map)
@@ -1212,9 +1216,9 @@
 static void *swap_next(struct seq_file *swap, void *v, loff_t *pos)
 {
 	struct swap_info_struct *ptr = v;
-	void *endptr = (void *) swap_info + nr_swapfiles * sizeof(struct swap_info_struct);
+	struct swap_info_struct *endptr = swap_info + nr_swapfiles;
 
-	for (++ptr; ptr < (struct swap_info_struct *) endptr; ptr++) {
+	for (++ptr; ptr < endptr; ptr++) {
 		if (!(ptr->flags & SWP_USED) || !ptr->swap_map)
 			continue;
 		++*pos;
@@ -1226,7 +1230,7 @@
 
 static void swap_stop(struct seq_file *swap, void *v)
 {
-	swap_list_unlock();
+	up(&swapon_sem);
 }
 
 static int swap_show(struct seq_file *swap, void *v)
@@ -1513,6 +1517,7 @@
 	if (error)
 		goto bad_swap;
 
+	down(&swapon_sem);
 	down(&swap_bdevs_sem);
 	swap_list_lock();
 	swap_device_lock(p);
@@ -1541,6 +1546,7 @@
 	swap_list_unlock();
 	install_swap_bdev(p->bdev);
 	up(&swap_bdevs_sem);
+	up(&swapon_sem);
 	error = 0;
 	goto out;
 bad_swap:
