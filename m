Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWBFE17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWBFE17 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWBFE16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:27:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750961AbWBFE16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:27:58 -0500
Date: Sun, 5 Feb 2006 20:27:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Prevent large file writeback starvation
Message-Id: <20060205202733.48a02dbe.akpm@osdl.org>
In-Reply-To: <20060206040027.GI43335175@melbourne.sgi.com>
References: <20060206040027.GI43335175@melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner <dgc@sgi.com> wrote:
>
> Folks,
> 
> I have recently been running some mixed workload tests on a 4p Altix,
> and I came across what looks to be a lack-of-writeback problem. The
> filesystem is XFS, but the problem is in the generic writeback code.
> 
> The workload involves ~16 postmark threads running in the background
> each creating ~15m subdirectories of ~1m files each. The idea is
> that this generates a nice, steady background file creation load.
> Each file is between 1-10k in size, and it runs at 3-5k creates/s.
> 
> The disk subsystem is nowhere near I/O bound - the luns are less than 10%
> busy when running this workload, and only writing about 30-40MB/s aggregate.
> 
> The problem comes when I run another thread that writes a large single
> file to disk. e.g.:
> 
> # dd if=/dev/zero of=/mnt/dgc/stripe/testfile bs=1024k count=4096
> 
> to write out a 4GB file. Now this goes straight into memory (takes
> about 7-8s) with some writeback occurring. The result is that approximately
> 2.5GB of the file is still dirty in memory.
> 
> It then takes over an hour to write the remaining data to disk. The
> pattern of writeback appears to be that roughly every
> dirty_expire_centisecs a chunk of 1024 pages (16MB on altix) are
> written to for that large file, and it is done in a single flush.
> Then the inode then gets moved to the superblock dirty list, and the
> next pdflush iteration of 1024 pages works on the next inodes on the
> superblock I/O list.
> 
> The problem is that when you are creating thousands of files per second
> with some data in them, the superblock I/O list blows out to approximately
> (create rate * expiry age) inodes, and any one inode in this list will
> get a maximum of 1024 pages written back per iteration on the list.

That code does so many different things it ain't funny.  This is why when
one thing gets changed, something else gets broken.

The intention here is that once an inode has "expired" (dirtied_when is
more than dirty_expire_centisecs ago), the inode will get fully synced.

>From a quick peek, this code:

			if (wbc->for_kupdate) {
				/*
				 * For the kupdate function we leave the inode
				 * at the head of sb_dirty so it will get more
				 * writeout as soon as the queue becomes
				 * uncongested.
				 */
				inode->i_state |= I_DIRTY_PAGES;
				list_move_tail(&inode->i_list, &sb->s_dirty);


isn't working right any more.

(aside: a "full sync" of a file is livelocky if some process is continually
writing to it.  There's logic in sync_sb_inodes which tries to prevent that).

> So, in a typical 30s period, the superblock dirty inode list grows to 60-70k
> inodes, which pdflush then splices to the I/O list when the I/O list is
> empty. We now have and empty dirty list and a really long I/O list.
> 
> In the time it takes the I/O list to be emptied, we've created many more
> thousands of files, so the large file gets moved to an extremely heavily
> populated dirty list after a tiny amount of writeback. Hence when pdflush
> finally empties the I/O list, it splices another 60-70k inodes into the
> I/O list, and we go through the cycle again.
> 
> The result is that under this sort of load we starve the large files
> of I/O bandwidth and cannot keep the disk subsystem busy.
> 
> If I ran sync(1) while there was lots of dirty data from the large file
> still in memory, it would take roughly 4-5s to complete the writeback
> at disk bandwidth (~400MB/s).
> 
> Looking at this comment in __sync_single_inode():
> 
>     196             if (wbc->for_kupdate) {
>     197                 /*              
>     198                  * For the kupdate function we leave the inode
>     199                  * at the head of sb_dirty so it will get more
>     200                  * writeout as soon as the queue becomes
>     201                  * uncongested.
>     202                  */
>     203                 inode->i_state |= I_DIRTY_PAGES;
>     204                 list_move_tail(&inode->i_list, &sb->s_dirty);
>     205             } else {    
> 
> It appears that it is intended to handle congested devices. The thing
> is, 1024 pages on writeback is not enough to congest a single disk,
> let alone a RAID box 10 or 100 times faster than a single disk.
> Hence we're stopping writeback long before we congest the device.

I think the comment is misleading.  The writeout pass can terminate because
wbc->nr_to_write was satisfied, as well as for queue congestion.

I suspect what's happened here is that someone other than pdflush has tried
to do some writeback and didn't set for_kupdate, so we ended up resetting
dirtied_when.

> Therefore, lets only move the inode back onto the dirty list if the device
> really is congested. Patch against 2.6.15-rc2 below.

This'll break something else, I bet :(

I'll take a look.   Another approach would be to look at nr_to_write. ie:

	if (wbc->for_kupdate || wmb->nr_to_write <= 0)

but it'll take half an hour's grovelling through changelogs to work out wht
that'll break.


