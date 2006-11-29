Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758162AbWK2B40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162AbWK2B40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758051AbWK2B40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:56:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6839 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1757831AbWK2B4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:56:25 -0500
Date: Wed, 29 Nov 2006 12:56:04 +1100
From: David Chinner <dgc@sgi.com>
To: David Chinner <dgc@sgi.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, chatz@melbourne.sgi.com,
       LKML <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org, kaos@sgi.com
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Message-ID: <20061129015604.GA33919298@melbourne.sgi.com>
References: <200611211027.41971.jesper.juhl@gmail.com> <45637566.5020802@melbourne.sgi.com> <9a8748490611211402xdc2822fqbc95a77fe54d49b1@mail.gmail.com> <20061121233141.GP37654165@melbourne.sgi.com> <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com> <9a8748490611220458w4d94d953v21f7a29a9f1bdb72@mail.gmail.com> <20061123011809.GY37654165@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123011809.GY37654165@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 12:18:09PM +1100, David Chinner wrote:
> On Wed, Nov 22, 2006 at 01:58:11PM +0100, Jesper Juhl wrote:
> > 
> > Attached are two files. The one named stack_overflows.txt.gz contains
> > one instance of each unique stack overflow + trace that I've got.  The
> > other file named kernel_BUG.txt.gz contains a few BUG() messages that
> > were also in the logs.
....
> I've just checked on a 2.6.17 build on i386 how much stack we
> are using (from checkstack.pl with min size reported set to 32 bytes)
> here in XFS:
....
> So, assuming the stacks less than 32 bytes are 32 bytes, we've got
> 1380 bytes in the XFS stack there, and very few functions where it
> can be reduced further. Still, 1380 bytes is way, way short of 4KB,
> so unless there is extra stack usage that checkstack doesn't tell us
> about I'm not sure why this amount of usage is causing repeated
> stack overflows with very little stack usage on either side of it.
> 
> Can someone enlighten me as to where all the rest of the stack
> is being used up here?

FYI.

With some help from Keith Owens, we've determined that gcc 3.3.5
resulted in XFS stack usage of about 1.9KB through the writeback and
allocation path with another ~800 bytes of stack usage in generic
code in this path.

The big difference between the numbers I was getting from checkstack
and reality was CONFIG_CC_OPTIMISE_FOR_SIZE=y being set on the
kernels I was stack checking. IOWs, CONFIG_CC_OPTIMISE_FOR_SIZE=y
appears to reduce XFS stack usage by at least 20% and so probably
should be used with XFS on 4k stacks.

Keith also confirmed that gcc-4.1's aggressive inlining of static
functions substantially increases stack usage (by ~15%) through this
call chain.  Given that many of the inlined static functions are not
required by the critical path (i.e. they'd previously been factored
out to reduce stack usage), gcc is effectively undoing past mods
that had substantially reduced XFS's stack usage.

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
