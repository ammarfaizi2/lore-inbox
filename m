Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWFHJzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWFHJzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 05:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWFHJzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 05:55:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:17606 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964816AbWFHJzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 05:55:52 -0400
Date: Thu, 8 Jun 2006 11:55:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock detected!
Message-ID: <20060608095522.GA30946@elte.hu>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com> <1149751953.10056.10.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149751953.10056.10.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi Anton,

* Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> [...] It perhaps is getting confused by the special case for the table 
> of inodes ($MFT) which has the lock dependency reverse to all other 
> inodes but it is special because it can never take the lock 
> recursively (and hence deadlock) because we always keep the whole 
> runlist for $MFT in memory and should a bug or memory corruption cause 
> this not to be the case then ntfs will detect this and go BUG() so it 
> still will not deadlock...

Please help me understand NTFS locking a bit better. As far as i can see 
at the moment, the NTFS locking scenario that the lock validator flagged 
does not involve two inodes - it only involves the MFT inode itself, and 
two of its locks.

Firstly, here is a list of the NTFS terms, locks in question:

  ni              - NTFS inode structure

  mft_ni          - special "Master File Table" inode - one per fs. 
                    Consists of "MFT records", which describe an inode 
                    each. (mft_ni is also called the "big inode")

  &ni->mrec_lock  - a spinlock protecting a particular inode's MFT data. 
                    (finegrained lock for the MFT record) It is 
                    typically taken by map_mft_record() and released by 
                    unmap_mft_record().

  ni->runlist     - maps logical addresses to on-disk addresses. (There 
                    are (two) runlists, one for normal inode data, 
                    another for attribute space data.)

  &rl->lock       - ni->runlist.lock, a rw semaphore that protects the 
                    mapping data. Read-locked on access, write-locked on 
                    modification (extension of an inode, etc.).

The MFT is loaded in-memory permanently at mount time, and its runlist 
gives us access to NTFS inodes. Is its runlist loaded into memory 
permanently too? An NTFS inode's runlist gives access to the actual file 
data.

What the validator flagged is the following locking construct:

we first acquired the MFT's &ni->mrec_lock in map_mft_record(), at:

       [<c0340508>] mutex_lock+0x8/0x10
       [<c01d4d61>] map_mft_record+0x51/0x2c0
       [<c01c51e8>] ntfs_map_runlist_nolock+0x3d8/0x530
       [<c01c58b1>] ntfs_map_runlist+0x41/0x70
       [<c01c1621>] ntfs_readpage+0x8c1/0x9a0
       [<c0142e1c>] read_cache_page+0xac/0x150
       [<c01e23f2>] load_system_files+0x472/0x2250
       [<c01e4e26>] ntfs_fill_super+0xc56/0x1a50
       [<c016bdee>] get_sb_bdev+0xde/0x120
       [<c01e028b>] ntfs_get_sb+0x1b/0x30
       [<c016b413>] vfs_kern_mount+0x33/0xa0
       [<c016b4d6>] do_kern_mount+0x36/0x50
       [<c01818de>] do_mount+0x28e/0x640
       [<c0181cff>] sys_mount+0x6f/0xb0

then we read-locked &rl->lock [the MFT's runlist semaphore] later in 
map_mft_record() -> ntfs_readpage(), while still holding &ni->mrec_lock:

       [<c0134c4e>] down_read+0x2e/0x40
       [<c01c159c>] ntfs_readpage+0x83c/0x9a0
       [<c0142e1c>] read_cache_page+0xac/0x150
       [<c01d4e22>] map_mft_record+0x112/0x2c0
       [<c01d229d>] ntfs_read_locked_inode+0x8d/0x15d0
       [<c01d3c6b>] ntfs_read_inode_mount+0x48b/0xba0
       [<c01e4dcb>] ntfs_fill_super+0xbfb/0x1a50
       [<c016bdee>] get_sb_bdev+0xde/0x120
       [<c01e028b>] ntfs_get_sb+0x1b/0x30
       [<c016b413>] vfs_kern_mount+0x33/0xa0
       [<c016b4d6>] do_kern_mount+0x36/0x50
       [<c01818de>] do_mount+0x28e/0x640
       [<c0181cff>] sys_mount+0x6f/0xb0

so this is a "&ni->mrec_lock => &rl->lock" dependency for the MFT, which 
the validator recorded.

Then the validator also observed the reverse order. We first 
write-locked &rl->lock (of the MFT inode):

 [<c0134c8e>] down_write+0x2e/0x50
 [<c01c5910>] ntfs_map_runlist+0x20/0x70
 [<c01c16a1>] ntfs_readpage+0x8c1/0x9a0
 [<c0142e9c>] read_cache_page+0xac/0x150
 [<c01e2472>] load_system_files+0x472/0x2250
 [<c01e4ea6>] ntfs_fill_super+0xc56/0x1a50
 [<c016be6e>] get_sb_bdev+0xde/0x120
 [<c01e030b>] ntfs_get_sb+0x1b/0x30
 [<c016b493>] vfs_kern_mount+0x33/0xa0
 [<c016b556>] do_kern_mount+0x36/0x50
 [<c018195e>] do_mount+0x28e/0x640
 [<c0181d7f>] sys_mount+0x6f/0xb0

then we took &ni->mrec_lock [this is still the MFT inode's mrec_lock, 
and we have the &rl->lock still held]:

 [<c0340588>] mutex_lock+0x8/0x10
 [<c01d4de1>] map_mft_record+0x51/0x2c0
 [<c01c5268>] ntfs_map_runlist_nolock+0x3d8/0x530
 [<c01c5931>] ntfs_map_runlist+0x41/0x70
 [<c01c16a1>] ntfs_readpage+0x8c1/0x9a0
 [<c0142e9c>] read_cache_page+0xac/0x150
 [<c01e2472>] load_system_files+0x472/0x2250
 [<c01e4ea6>] ntfs_fill_super+0xc56/0x1a50
 [<c016be6e>] get_sb_bdev+0xde/0x120
 [<c01e030b>] ntfs_get_sb+0x1b/0x30
 [<c016b493>] vfs_kern_mount+0x33/0xa0
 [<c016b556>] do_kern_mount+0x36/0x50
 [<c018195e>] do_mount+0x28e/0x640
 [<c0181d7f>] sys_mount+0x6f/0xb0

this means a "&rl->lock => &ni->mrec_lock" dependency, which stands in 
contrast with the already observed "&ni->mrec_lock => &rl->lock" 
dependency.

The dependencies were observed for the same locks (the MFT's runlist 
lock and mrec_lock), i.e. this is not a confusion of normal inodes vs. 
the MFT inode.

First and foremost, are my observations and interpretations correct? 
Assuming that i made no mistake that invalidates my analysis, why are 
the two MFT inode locks apparently taken in opposite order?

	Ingo
