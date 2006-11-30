Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935764AbWK3CHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935764AbWK3CHy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 21:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934632AbWK3CHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 21:07:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36244 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S935764AbWK3CHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 21:07:53 -0500
Date: Thu, 30 Nov 2006 13:07:34 +1100
From: David Chinner <dgc@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: David Chinner <dgc@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com, xfs-masters@oss.sgi.com, Keith Owens <kaos@sgi.com>
Subject: Re: XFS internal error xfs_trans_cancel at line 1138 of file fs/xfs/xfs_trans.c (kernel 2.6.18.1)
Message-ID: <20061130020734.GB37654165@melbourne.sgi.com>
References: <9a8748490611280749k5c97d21bx2e499d2209d27dfe@mail.gmail.com> <20061129013214.GH44411608@melbourne.sgi.com> <9a8748490611290117oc0ba880v1a6407bc4f41088f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490611290117oc0ba880v1a6407bc4f41088f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 10:17:25AM +0100, Jesper Juhl wrote:
> On 29/11/06, David Chinner <dgc@sgi.com> wrote:
> >On Tue, Nov 28, 2006 at 04:49:00PM +0100, Jesper Juhl wrote:
> >> Filesystem "dm-1": XFS internal error xfs_trans_cancel at line 1138 of
> >> file fs/xfs/xfs_trans.c.  Caller 0xffffffff8034b47e
> >>
> >> Call Trace:
> >> [<ffffffff8020b122>] show_trace+0xb2/0x380
> >> [<ffffffff8020b405>] dump_stack+0x15/0x20
> >> [<ffffffff80327b4c>] xfs_error_report+0x3c/0x50
> >> [<ffffffff803435ae>] xfs_trans_cancel+0x6e/0x130
> >> [<ffffffff8034b47e>] xfs_create+0x5ee/0x6a0
> >> [<ffffffff80356556>] xfs_vn_mknod+0x156/0x2e0
> >> [<ffffffff803566eb>] xfs_vn_create+0xb/0x10
> >> [<ffffffff80284b2c>] vfs_create+0x8c/0xd0
> >> [<ffffffff802e734a>] nfsd_create_v3+0x31a/0x560
> >> [<ffffffff802ec838>] nfsd3_proc_create+0x148/0x170
> >> [<ffffffff802e19f9>] nfsd_dispatch+0xf9/0x1e0
> >> [<ffffffff8049d617>] svc_process+0x437/0x6e0
> >> [<ffffffff802e176d>] nfsd+0x1cd/0x360
> >> [<ffffffff8020ab1c>] child_rip+0xa/0x12
> >> xfs_force_shutdown(dm-1,0x8) called from line 1139 of file
> >> fs/xfs/xfs_trans.c.  Return address = 0xffffffff80359daa
> >
> >We shut down the filesystem because we cancelled a dirty transaction.
> >Once we start to dirty the incore objects, we can't roll back to
> >an unchanged state if a subsequent fatal error occurs during the
> >transaction and we have to abort it.
> >
> So you are saying that there's nothing I can do to prevent this from
> happening in the future?

Pretty much - we need to work out what is going wrong and
we can't from teh shutdown message above - the error has
occurred in a path that doesn't have error report traps
in it.

Is this reproducable?

> >If I understand historic occurrences of this correctly, there is
> >a possibility that it can be triggered in ENOMEM situations. Was your
> >machine running out of memoy when this occurred?
> >
> Not really. I just checked my monitoring software and, at the time
> this happened, the box had ~5.9G RAM free (of 8G total) and no swap
> used (but 11G available).

Ok. Sounds like we need more error reporting points inserted
into that code so we dump an error earlier and hence have some
hope of working out what went wrong next time.....

OOC, there weren't any I/O errors reported before this shutdown?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
