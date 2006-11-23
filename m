Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757260AbWKWBS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757260AbWKWBS2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 20:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757259AbWKWBS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 20:18:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43232 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1757256AbWKWBS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 20:18:26 -0500
Date: Thu, 23 Nov 2006 12:18:09 +1100
From: David Chinner <dgc@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: David Chinner <dgc@sgi.com>, chatz@melbourne.sgi.com,
       LKML <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Message-ID: <20061123011809.GY37654165@melbourne.sgi.com>
References: <200611211027.41971.jesper.juhl@gmail.com> <45637566.5020802@melbourne.sgi.com> <9a8748490611211402xdc2822fqbc95a77fe54d49b1@mail.gmail.com> <20061121233141.GP37654165@melbourne.sgi.com> <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com> <9a8748490611220458w4d94d953v21f7a29a9f1bdb72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490611220458w4d94d953v21f7a29a9f1bdb72@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 01:58:11PM +0100, Jesper Juhl wrote:
> On 22/11/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >On 22/11/06, David Chinner <dgc@sgi.com> wrote:
> >> On Tue, Nov 21, 2006 at 11:02:23PM +0100, Jesper Juhl wrote:
> >> > On 21/11/06, David Chatterton <chatz@melbourne.sgi.com> wrote:
> ...
> >> > >Thanks for traces, I've captured this information.
> >> > >
> >> > You are welcome. If you want/need more traces then I've got ~2.1G
> >> > worth of traces that you can have :)
> >>
> >> Well, we don't need that many, but it would be nice to have a
> >> set of unique traces that lead to overflows - could you process
> >> them in some way just to extract just the unique XFS traces that
> >> occur?
> >>
> >I'll try to extract a copy of each unique trace that involves xfs,
> >sometime tomorrow or the day after, and then send you the result.
> >
> 
> Attached are two files. The one named stack_overflows.txt.gz contains
> one instance of each unique stack overflow + trace that I've got.  The
> other file named kernel_BUG.txt.gz contains a few BUG() messages that
> were also in the logs.

Thank you, Jesper. The common paths through XFS here are:

 [<c0236eec>] generic_make_request+0x14f/0x1b7
 [<c0236fbc>] submit_bio+0x68/0x109
 [<c02257bc>] _xfs_buf_ioapply+0x1cf/0x28d
 [<c02258a3>] xfs_buf_iorequest+0x29/0x6e
 [<c02254a4>] xfs_buf_iostart+0x6d/0x97
 [<c0224e32>] xfs_buf_read_flags+0x8a/0x8c
 [<c021768e>] xfs_trans_read_buf+0x153/0x2fc
 [<c01eb559>] xfs_btree_read_bufs+0x6e/0x84
 [<c01d27d9>] xfs_alloc_lookup+0x10a/0x39e
 [<c01d3d5c>] xfs_alloc_lookup_eq+0x14/0x17
 [<c01ceef8>] xfs_alloc_fixup_trees+0x252/0x2a9
 [<c01cff24>] xfs_alloc_ag_vextent_size+0x318/0x405
 [<c01cf0e5>] xfs_alloc_ag_vextent+0xe2/0x106
 [<c01d13a9>] xfs_alloc_vextent+0x372/0x47a
 [<c01dfcb9>] xfs_bmap_btalloc+0x31f/0x966
 [<c01e031e>] xfs_bmap_alloc+0x1e/0x29
 [<c01e3b92>] xfs_bmapi+0x1134/0x1545
 [<c0206a20>] xfs_iomap_write_allocate+0x2bb/0x509
 [<c020576b>] xfs_iomap+0x357/0x459
 [<c022b02f>] xfs_bmap+0x2e/0x35
 [<c0222bbb>] xfs_map_blocks+0x3c/0x70
 [<c0223b24>] xfs_page_state_convert+0x3cc/0x629
 [<c0223ddd>] xfs_vm_writepage+0x5c/0xd3
 [<c01417a4>] generic_writepages+0x1b9/0x2d5
 [<c0223e78>] xfs_vm_writepages+0x24/0x4a
 [<c01418ea>] do_writepages+0x2a/0x46
 [<c0172c03>] __sync_single_inode+0x5c/0x1de
 [<c0172e0a>] __writeback_single_inode+0x85/0x18f
 [<c01730c7>] sync_sb_inodes+0x1b3/0x2b2


i.e. through the allocator. This is delayed allocation occurring
here during background writeback and we are having to read a
free space btree block while preparing enough free single blocks
to allow btree splits to occur (on top of the extent needed
for the delalloc write).

There are several variations on this (e.g. via write throttling,
from nfsds, inode allocation, etc) which increase the stack usage
before we get to XFS, and the subsequent stack overflow is almost
always during softirq processing when we are deep down in that
stack:

% grep "stack overflow" stack_overflows.txt |wc -l
            35
% grep __do_softirq stack_overflows.txt | wc -l
            29

So part of the problem is softirqs that use a fair bit of stack
space running on stacks that don't have a lot of space free to
 begin with.

I've just checked on a 2.6.17 build on i386 how much stack we
are using (from checkstack.pl with min size reported set to 32 bytes)
here in XFS:

 32 _xfs_buf_ioapply
<32  xfs_buf_iorequest
<32  xfs_buf_iostart
<32  xfs_buf_read_flags
<32  xfs_trans_read_buf
<32  xfs_btree_read_bufs
 44 xfs_alloc_lookup
<32  xfs_alloc_lookup_eq
<32  xfs_alloc_fixup_trees
 36 xfs_alloc_ag_vextent_size
<32  xfs_alloc_ag_vextent
 44  xfs_alloc_vextent
148  xfs_bmap_btalloc
<32  xfs_bmap_alloc
272  xfs_bmapi
160  xfs_iomap_write_allocate
 68  xfs_iomap
<32  xfs_bmap
<32  xfs_map_blocks
128  xfs_page_state_convert
<32  xfs_vm_writepage
<32  generic_writepages
<32  xfs_vm_writepages

So, assuming the stacks less than 32 bytes are 32 bytes, we've got
1380 bytes in the XFS stack there, and very few functions where it
can be reduced further. Still, 1380 bytes is way, way short of 4KB,
so unless there is extra stack usage that checkstack doesn't tell us
about I'm not sure why this amount of usage is causing repeated
stack overflows with very little stack usage on either side of it.

Can someone enlighten me as to where all the rest of the stack
is being used up here?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
