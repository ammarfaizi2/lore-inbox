Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWEYG4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWEYG4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 02:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWEYG4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 02:56:44 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:26269 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965054AbWEYG4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 02:56:43 -0400
Date: Thu, 25 May 2006 12:22:20 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]  Per-superblock unused dentry LRU lists V2
Message-ID: <20060525065219.GD25185@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060524110001.GU1331387@melbourne.sgi.com> <20060525040604.GB25185@in.ibm.com> <20060525061553.GC8069029@melbourne.sgi.com> <20060525063350.GD8069029@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060525063350.GD8069029@melbourne.sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 04:33:50PM +1000, David Chinner wrote:
> On Thu, May 25, 2006 at 04:15:53PM +1000, David Chinner wrote:
> > On Thu, May 25, 2006 at 09:36:04AM +0530, Balbir Singh wrote:
> > > > +/*
> > > > + * Shrink the dentry LRU on æ given superblock.
> > > 			      ^^^
> > > This character (ae) looks strange.
> > 
> > Fixed. It slipped through when I switched to the -mm tree.
> > 
> > > The other changes look fine. Do you have any performance numbers, any
> > > results from stress tests (for version 2 of the patch)?
> > 
> > Not yet - I've just started the stress tests now. I had to wait for
> > the storage and then reconfigure it which took some time.  It's
> > currently running a create/unlink workload across 8 filesystems in
> > parallel.  I'll run some dbench loads after this has run for a few
> > hours.
> > 
> > FWIW, this create/unlink load has been triggering reliable "Busy
> > inodes after unmount" errors that I've slowly been tracking down.
> > After I fixed the last problem in XFS late last week, I've
> > been getting a failure that i think is the unmount/prune_dcache
> > races that you and Neil have recently fixed.
> 
> I just had all 8 filesystems come up with:
> 
> May 25 15:55:18 budgie kernel: XFS unmount got error 16
> May 25 15:55:18 budgie kernel: xfs_fs_put_super: vfsp/0xe00000b006339280 left dangling!
> May 25 15:55:18 budgie kernel: VFS: Busy inodes after unmount of dm-9. Self-destruct in 5 seconds.  Have a nice day...
> May 25 15:55:19 budgie kernel: XFS: Invalid device [/dev/mapper/dm8], error=-16
> May 25 15:55:35 budgie kernel: XFS unmount got error 16
> May 25 15:55:35 budgie kernel: xfs_fs_put_super: vfsp/0xe000003015a18c80 left dangling!
> May 25 15:55:35 budgie kernel: VFS: Busy inodes after unmount of dm-15. Self-destruct in 5 seconds.  Have a nice day...
> May 25 15:55:35 budgie kernel: XFS unmount got error 16
> May 25 15:55:35 budgie kernel: xfs_fs_put_super: vfsp/0xe000003015ea6280 left dangling!
> May 25 15:55:35 budgie kernel: VFS: Busy inodes after unmount of dm-13. Self-destruct in 5 seconds.  Have a nice day...
> May 25 15:55:36 budgie kernel: XFS: Invalid device [/dev/mapper/dm14], error=-16
> May 25 15:55:36 budgie kernel: XFS: Invalid device [/dev/mapper/dm12], error=-16
> May 25 15:55:42 budgie kernel: XFS unmount got error 16
> May 25 15:55:42 budgie kernel: xfs_fs_put_super: vfsp/0xe00000b00633b580 left dangling!
> May 25 15:55:42 budgie kernel: VFS: Busy inodes after unmount of dm-5. Self-destruct in 5 seconds.  Have a nice day...
> May 25 15:55:44 budgie kernel: XFS: Invalid device [/dev/mapper/dm4], error=-16
> May 25 15:55:44 budgie kernel: XFS unmount got error 16
> May 25 15:55:44 budgie kernel: xfs_fs_put_super: vfsp/0xe00000b00633bc80 left dangling!
> May 25 15:55:44 budgie kernel: VFS: Busy inodes after unmount of dm-11. Self-destruct in 5 seconds.  Have a nice day...
> May 25 15:55:44 budgie kernel: XFS: Invalid device [/dev/mapper/dm10], error=-16
> May 25 15:55:55 budgie kernel: XFS unmount got error 16
> May 25 15:55:55 budgie kernel: xfs_fs_put_super: vfsp/0xe000003015d4a080 left dangling!
> May 25 15:55:55 budgie kernel: VFS: Busy inodes after unmount of dm-7. Self-destruct in 5 seconds.  Have a nice day...
> May 25 15:55:56 budgie kernel: XFS: Invalid device [/dev/mapper/dm6], error=-16
> May 25 15:56:16 budgie kernel: XFS unmount got error 16
> May 25 15:56:16 budgie kernel: xfs_fs_put_super: vfsp/0xe00000b9edeacf80 left dangling!
> May 25 15:56:16 budgie kernel: VFS: Busy inodes after unmount of dm-3. Self-destruct in 5 seconds.  Have a nice day...
> May 25 15:56:16 budgie kernel: XFS unmount got error 16
> May 25 15:56:16 budgie kernel: xfs_fs_put_super: vfsp/0xe000003015a2a280 left dangling!
> May 25 15:56:16 budgie kernel: VFS: Busy inodes after unmount of dm-1. Self-destruct in 5 seconds.  Have a nice day...
> 
> On the second test iteration. On 2.6.16, it takes about 10 iterations to get one
> filesystem to do this. I'll need to look into this one further. I'm going to
> reboot the machine and run some dbench tests (which typically don't trigger
> this problem) and then come back to this one with added debugging....
>

Is this with version 2 of your patch? Could you also try the -mm tree
and see if the problem goes away. We have a set of patches to address
exactly this problem. 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
