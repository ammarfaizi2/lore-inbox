Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131246AbRCUJHX>; Wed, 21 Mar 2001 04:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131248AbRCUJHN>; Wed, 21 Mar 2001 04:07:13 -0500
Received: from schmee.sfgoth.com ([63.205.85.133]:12042 "EHLO
	schmee.sfgoth.com") by vger.kernel.org with ESMTP
	id <S131246AbRCUJG7>; Wed, 21 Mar 2001 04:06:59 -0500
Date: Wed, 21 Mar 2001 01:05:59 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Anton Blanchard <anton@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: spinlock usage - ext2_get_block, lru_list_lock
Message-ID: <20010321010559.B27804@sfgoth.com>
In-Reply-To: <20010321180607.A11941@linuxcare.com> <200103210846.f2L8kIe04539@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200103210846.f2L8kIe04539@webber.adilger.int>; from adilger@turbolinux.com on Wed, Mar 21, 2001 at 01:46:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> With per-group (or maybe per-bitmap) locking, files could be created in
> parallel with only a small amount of global locking if they are in different
> groups.

...and then we can let the disc go nuts seeking to actually commit all
these new blocks.  I suspect that this change would only be a win for
memory-based discs where seek time is zero.

I think that before anyone starts modifying the kernel for this they
should benchmark how often the free block checker blocks on lock
contention _AND_ how often the thread its contending with is looking
for a free block in a _different_ allocation group.  I bet it's not
often at all.

> It may also be
> possible to have lazy updating of the superblock counts, and depend on
> e2fsck to update the superblock counts on a crash.

That sounds more promising.

> , and only moving the deltas from the groups
> to the superblock on sync or similar.

If we're going to assume that e2fsck will correct the numbers anyway then
there's really no reason to update them any time except when marking
the filesystem clean (umount, remount-ro)  As a bonus, we have to update
the superblock then anyway.

-Mitch
