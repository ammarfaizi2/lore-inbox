Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWEZAZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWEZAZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWEZAZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:25:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60049 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932182AbWEZAZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:25:02 -0400
Date: Fri, 26 May 2006 10:24:05 +1000
From: David Chinner <dgc@sgi.com>
To: Balbir Singh <balbir@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]  Per-superblock unused dentry LRU lists V2
Message-ID: <20060526002405.GL8069029@melbourne.sgi.com>
References: <20060524110001.GU1331387@melbourne.sgi.com> <20060525040604.GB25185@in.ibm.com> <20060525061553.GC8069029@melbourne.sgi.com> <20060525063350.GD8069029@melbourne.sgi.com> <20060525065219.GD25185@in.ibm.com> <20060525081312.GE8069029@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525081312.GE8069029@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 06:13:12PM +1000, David Chinner wrote:
> On Thu, May 25, 2006 at 12:22:20PM +0530, Balbir Singh wrote:
> > On Thu, May 25, 2006 at 04:33:50PM +1000, David Chinner wrote:
> > > On Thu, May 25, 2006 at 04:15:53PM +1000, David Chinner wrote:
> > > > 
> > > > FWIW, this create/unlink load has been triggering reliable "Busy
> > > > inodes after unmount" errors that I've slowly been tracking down.
> > > > After I fixed the last problem in XFS late last week, I've
> > > > been getting a failure that i think is the unmount/prune_dcache
> > > > races that you and Neil have recently fixed.
> > > 
> > > I just had all 8 filesystems come up with:
> > > 
> > > May 25 15:55:18 budgie kernel: XFS unmount got error 16
> > > May 25 15:55:18 budgie kernel: xfs_fs_put_super: vfsp/0xe00000b006339280 left dangling!
> > > May 25 15:55:18 budgie kernel: VFS: Busy inodes after unmount of dm-9. Self-destruct in 5 seconds.  Have a nice day...
> 
> .....
> 
> > > On the second test iteration. On 2.6.16, it takes about 10 iterations to get one
> > > filesystem to do this. I'll need to look into this one further. I'm going to
> > > reboot the machine and run some dbench tests (which typically don't trigger
> > > this problem) and then come back to this one with added debugging....
> > 
> > Is this with version 2 of your patch?
> 
> That's with version 2 on -rc4-mm3.
> 
> > Could you also try the -mm tree
> > and see if the problem goes away. We have a set of patches to address
> > exactly this problem. 
> 
> Well, the patches overlap and I thought that I had taken into account
> the fixes that were applied to the -mm tree.
> 
> I'm rerunning on 2.6.16 with the s_umount locking fix so I know that it's
> not something else in -mm that is being tripped over....

2.6.16 ran all night on the above test with the s_umount locking fix in it.
The prune_dcache/unmount race was indeed the cause of the errors I have
been seeing over the last week.

I just found a bug in the -mm patch which broke shrink_dcache_parent().
This is the likely cause of the above problems, and I'm about to retest
the -mm kernel with the fixed patch.....

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
