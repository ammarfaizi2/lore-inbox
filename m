Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbULUWU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbULUWU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 17:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbULUWU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 17:20:29 -0500
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:14769 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S261864AbULUWUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 17:20:17 -0500
Date: Tue, 21 Dec 2004 17:20:15 -0500 (EST)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: Ingo Molnar <mingo@elte.hu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] XFS crash using Realtime Preemption patch
In-Reply-To: <20041221104042.GA31843@elte.hu>
Message-ID: <Pine.LNX.4.60-041.0412211649220.11361@unix49.andrew.cmu.edu>
References: <Pine.LNX.4.60-041.0412182025220.5487@unix49.andrew.cmu.edu>
 <20041221104042.GA31843@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Dec 2004, Ingo Molnar wrote:

>
> * Nathaniel W. Filardo <nwf@andrew.cmu.edu> wrote:
>
>> Hello all.
>>
>> Using 2.6.10-rc3-mm1-V0.7.33-04 and TCFQ ver 17, I get the following
>> crash while trying to sync the portage tree, though the system seems
>> stable under interactive load (read: an rm command went OK prior to
>> this crash).
>>
>> Machine is a 933MHz transmeta laptop with IDE disk.
>>
>> Any more information you need?
>> --nwf;
>>
>> kernel BUG at kernel/rt.c:1210!
>
> Seems like an XFS bug at first sight. The BUG() means that an up_write()
> was done while a down_read() was active for the lock. Does XFS really do
> this? Initialization/destruction bugs can possibly cause such messages
> too.

>From what I can make of the XFS code, it looks fine.  Somebody's either 
being horribly rude to memory (stomp) or there's some other issue... 
sadly, the machine is a laptop and thus nigh on impossible to get any real 
debugging out of.

I don't *think* it's memory issues as it's pretty reproducable and is 
exactly the same every time I've tried.

Open to suggestions.

--nwf;

> Here's the call sequence:
>
>> EIP is at up_write+0x8c/0xa0
>>  [<c01d2d5c>] xfs_iunlock+0x7c/0xa0 (32)

fs/xfs/linux-2.6/mrlock.h: mrunlock( mrlock_t *mrp )
 	Switches behavior based on mr_writer flag as to whether to
 	up_read or up_write.  Since we're taking the up_write branch,
 	we should look for where a down_read was called.  This can
 	come through via a mraccessf or mrtryaccess.

 	  if (mrp->mr_writer) {
 	    mrp->mr_writer = 0;
 	    up_write(&mrp->mr_lock);
 	  } else {
 	    up_read(&mrp->mr_lock);
 	  }

fs/xfs/xfs_iget.c
 	calls mrunlock() inlined - see abov
 		on ip->i_lock and/or ip->i_iolock, based on flags

>>  [<c01d728c>] xfs_iflush+0x1cc/0x440 (12)

fs/xfs/xfs_inode.c
 	ASSERT's that ip->i_lock is already taken, so we're probably
 	chasing after that one.

>>  [<c01d85a0>] xfs_inode_item_push+0x10/0x20 (60)

fs/xfs/xfs_inode_item.c
 	ASSERT's that lock is already taken

>>  [<c01ebd0a>] xfs_trans_push_ail+0x1aa/0x1e0 (8)

fs/xfs/xfs_trans_ail.c
 	through IOP_TRYLOCK (maps to xfs_inode_item_trylock)
 	through xfs_ilock_nowait (SHARED)
 	locks both ip->i_lock and ip->i_iolock through mrtryaccess()
