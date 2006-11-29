Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758687AbWK2Bcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758687AbWK2Bcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758689AbWK2Bce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:32:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24756 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1758687AbWK2Bce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:32:34 -0500
Date: Wed, 29 Nov 2006 12:32:14 +1100
From: David Chinner <dgc@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, Keith Owens <kaos@sgi.com>
Subject: Re: XFS internal error xfs_trans_cancel at line 1138 of file fs/xfs/xfs_trans.c (kernel 2.6.18.1)
Message-ID: <20061129013214.GH44411608@melbourne.sgi.com>
References: <9a8748490611280749k5c97d21bx2e499d2209d27dfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490611280749k5c97d21bx2e499d2209d27dfe@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 04:49:00PM +0100, Jesper Juhl wrote:
> Hi,
> 
> One of my NFS servers just gave me a nasty surprise that I think it is
> relevant to tell you about:

Thanks, Jesper.

> Filesystem "dm-1": XFS internal error xfs_trans_cancel at line 1138 of
> file fs/xfs/xfs_trans.c.  Caller 0xffffffff8034b47e
> 
> Call Trace:
> [<ffffffff8020b122>] show_trace+0xb2/0x380
> [<ffffffff8020b405>] dump_stack+0x15/0x20
> [<ffffffff80327b4c>] xfs_error_report+0x3c/0x50
> [<ffffffff803435ae>] xfs_trans_cancel+0x6e/0x130
> [<ffffffff8034b47e>] xfs_create+0x5ee/0x6a0
> [<ffffffff80356556>] xfs_vn_mknod+0x156/0x2e0
> [<ffffffff803566eb>] xfs_vn_create+0xb/0x10
> [<ffffffff80284b2c>] vfs_create+0x8c/0xd0
> [<ffffffff802e734a>] nfsd_create_v3+0x31a/0x560
> [<ffffffff802ec838>] nfsd3_proc_create+0x148/0x170
> [<ffffffff802e19f9>] nfsd_dispatch+0xf9/0x1e0
> [<ffffffff8049d617>] svc_process+0x437/0x6e0
> [<ffffffff802e176d>] nfsd+0x1cd/0x360
> [<ffffffff8020ab1c>] child_rip+0xa/0x12
> xfs_force_shutdown(dm-1,0x8) called from line 1139 of file
> fs/xfs/xfs_trans.c.  Return address = 0xffffffff80359daa

We shut down the filesystem because we cancelled a dirty transaction.
Once we start to dirty the incore objects, we can't roll back to
an unchanged state if a subsequent fatal error occurs during the
transaction and we have to abort it.

If I understand historic occurrences of this correctly, there is
a possibility that it can be triggered in ENOMEM situations. Was your
machine running out of memoy when this occurred?

> Filesystem "dm-1": Corruption of in-memory data detected.  Shutting
> down filesystem: dm-1
> Please umount the filesystem, and rectify the problem(s)
> nfsd: non-standard errno: 5

EIO gets returned in certain locations once the filesystem has
been shutdown.

> I unmounted the filesystem, ran xfs_repair which told me to try an
> mount it first to replay the log, so I did, unmounted it again, ran
> xfs_repair (which didn't find any problems) and finally mounted it and
> everything is good - the filesystem seems intact.

Yeah, the above error report typically is due to an in-memory
problem, not an on disk issue.

> The server in question is running kernel 2.6.18.1

Can happen to XFS on any kernel version - got a report of this from
someone running a 2.4 kernel a couple of weeks ago....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
