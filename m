Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbQKQJIg>; Fri, 17 Nov 2000 04:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130572AbQKQJIQ>; Fri, 17 Nov 2000 04:08:16 -0500
Received: from [213.8.185.152] ([213.8.185.152]:42000 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S130113AbQKQJIF>;
	Fri, 17 Nov 2000 04:08:05 -0500
Date: Fri, 17 Nov 2000 10:37:39 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH (2.4)] atomic use count for proc_dir_entry
In-Reply-To: <Pine.LNX.4.21.0011162320230.17038-100000@callisto.yi.org>
Message-ID: <Pine.LNX.4.21.0011171015270.19287-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Dan Aloni wrote:

> On Thu, 16 Nov 2000, Linus Torvalds wrote:
> 
> > On Thu, 16 Nov 2000, Dan Aloni wrote:
> > > 
> > > Makes procfs use an atomic use count for dir entries, to avoid using 
> > > the Big kernel lock. Axboe says it looks ok.
> > 
> > There's a race there. Look at what happens if de_put() races with
> > remove_proc_entry(): we'd do free_proc_entry() twice. Not good.
> > 
> > Leave the kernel lock for now.
> 
> Is this particular kernel lock helps anyway? We could have been half way
> through remove_proc_entry(), line 569, for example, while in the same time
> another thread enters de_put when the use count is 1 and frees the entry
> while the other thread is locked just before dereferencing the entry.

After reading the code more, I have realized we have a very narrowed race
condition, which can be eliminated if we do this (in remove_proc_entry()):

--- linux/fs/proc/generic.c	Fri Nov 17 10:17:33 2000
+++ linux/fs/proc/generic.c	Fri Nov 17 10:17:50 2000
@@ -573,10 +573,10 @@
 				(void *) proc_alloc_map);
 		proc_kill_inodes(de);
 		de->nlink = 0;
-		de->deleted = 1;
 		if (!atomic_read(&de->count))
 			free_proc_entry(de);
 		else {
+			de->deleted = 1;
 			printk("remove_proc_entry: %s/%s busy, count=%d\n",
 				parent->name, de->name, atomic_read(&de->count));
 		}

Since de_put() only frees entries with deleted != 0, and deleted is only
set to 1 inside remove_proc_entry(), with this patch, there is no way
free_proc_entry() will be called from de_put(), while  remove_proc_entry() 
is about to free or is freeing the entry. After that 'de->delete = 1', the
proc entry is no longer in the proc entry tree, and a second call to
remove_proc_entry() won't find it at all, and leave it safe for
de_put() to handle.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
