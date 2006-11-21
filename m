Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756787AbWKUXcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbWKUXcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 18:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755483AbWKUXcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 18:32:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:65438 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1755478AbWKUXb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 18:31:57 -0500
Date: Wed, 22 Nov 2006 10:31:41 +1100
From: David Chinner <dgc@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: chatz@melbourne.sgi.com, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com, xfs-masters@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Message-ID: <20061121233141.GP37654165@melbourne.sgi.com>
References: <200611211027.41971.jesper.juhl@gmail.com> <45637566.5020802@melbourne.sgi.com> <9a8748490611211402xdc2822fqbc95a77fe54d49b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490611211402xdc2822fqbc95a77fe54d49b1@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 11:02:23PM +0100, Jesper Juhl wrote:
> On 21/11/06, David Chatterton <chatz@melbourne.sgi.com> wrote:
> >Jesper,
> >
> >In the short term, the best workaround is to use 8K stacks.
> 
> Yeah, that's what I'm currently doing and the box seems more stable
> (at least it has not crashed yet, but with 4K stacks it usually would
> have by now).
> 
> >We do not see stack
> >overflow problems with NFS + XFS + volume managers + disk devices.
> >
> Could the size of my devices be part of the cause? some of the logical
> volumes I have mounted are multiple TB in size?

No.

> >Audits have been done in the past and will again be done in the future to 
> >try to
> >identify areas where XFS could use less stack space by reducing/avoid large
> >local variables. Reducing the code path is far more difficult.
> >
> I realize that fixing the problem may be difficult. I just wanted to
> make sure that people were informed that there is an actual problem
> and provide as much info as possible so that perhaps in the future it
> can be fixed... :)

I've got one that prevents gcc from inlining single use functions in XFS
that I need to finish off, and that results in some significant stack
usage reductions in some XFS functions.

However, XFS is only one part of the picture - when you put NFS on top,
DM+md then scsi/FC below and then you nest a soft irq that might go
20 functions deep as well - then 4k stacks simply aren't big enough.

> I'm reading through the XFS code myself at the moment and I'll be sure
> to submit patches if I spot something that could help reduce stack
> usage.

Most of the low hanging fruit is already gone. The problem we are
facing now for further reductions in stack usage is the fact that we
need to factor code. That is a major undertaking and has a _lot_ of
risk associated with it....

> >There is active discussion about reducing inlining:
> >http://bugzilla.kernel.org/show_bug.cgi?id=7364
> 
> Thanks, I'll check that out.

That's one of the few remaining low hanging fruit, and that's fixed
in the patches I already have.

> >Thanks for traces, I've captured this information.
> >
> You are welcome. If you want/need more traces then I've got ~2.1G
> worth of traces that you can have :)

Well, we don't need that many, but it would be nice to have a
set of unique traces that lead to overflows - could you process
them in some way just to extract just the unique XFS traces that
occur?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
