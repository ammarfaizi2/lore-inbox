Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWC1R27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWC1R27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWC1R27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:28:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:12967 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750756AbWC1R27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:28:59 -0500
Subject: Re: kernel BUG at fs/direct-io.c:916!
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       lkml <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
In-Reply-To: <20060328050135.GA2177@frodo>
References: <20060326230206.06C1EE083AAB@knarzkiste.dyndns.org>
	 <20060326180440.GA4776@charite.de> <20060326184644.GC4776@charite.de>
	 <20060327080811.D753448@wobbly.melbourne.sgi.com>
	 <20060326230358.GG4776@charite.de> <20060327060436.GC2481@frodo>
	 <20060327110342.GX21946@charite.de>  <20060328050135.GA2177@frodo>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 09:30:44 -0800
Message-Id: <1143567049.26106.2.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 16:01 +1100, Nathan Scott wrote:
> On Mon, Mar 27, 2006 at 01:03:42PM +0200, Ralf Hildebrandt wrote:
> > * Nathan Scott <nathans@sgi.com>:
> > > On Mon, Mar 27, 2006 at 01:03:59AM +0200, Ralf Hildebrandt wrote:
> > > > * Nathan Scott <nathans@sgi.com>:
> > > > 
> > > > > Hmm, there were XFS patches in -mm last week, but they also got
> > > > > merged to mainline last week, not clear whether your git kernel
> > > > > had those changes or not.  I think there's probably some direct
> > > > > I/O (generic) changes in -mm too based on list traffic from the
> > > > > last couple of weeks (I'm an -mm lamer, sorry, couldn't easily
> > > > > tell you exactly what patches those might be) - could you retry
> > > > > with todays git snapshot and see if mainline is affected?  Else
> > > > > we'll need to find and analyse any -mm fs/direct-io.c patches.
> > > > 
> > > > 2.6.16-git12 also fails utterly:
> > > 
> > > Could you also try reverting this patch:
> > > 
> > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=1d8fa7a2b9a39d18727acc5c468e870df606c852
> > > 
> > > and let me know if the problem still happens?
> > 
> > Reverting this particular patch does ELIMINATE the problem.
> > Excellent!
> 
> OK, I think I see whats gone wrong here now.  Ralf, could you try
> the patch below and check that it fixes your test case?
> 
> Badari, it looks like a regression from the "remove ->get_blocks()
> support" patch - can you look over the fix below and confirm/deny
> please?  
> 
> I'm definately seeing block mapping requests that are smaller than
> the filesystem block size coming into XFS from direct-io.c - and it
> looks like that eventually blows up in do_direct_IO if dio_remainder
> becomes set and we could only map one block (if dio->blocks_available
> was 1 after get_more_blocks).  We'll reduce that to zero right at the
> end of the branch that calls get_more_blocks in do_direct_IO... and
> mayhem ensues further on.
> 
> I have a couple of other .17 changes pending, if you could ACK this
> I'll get it merged in for ya.
> 
> cheers.
> 
Nathan,

Thanks for working this out. You may want to add a description
to the patch. Like:

"inode->i_blkbits should be used instead of dio->blkbits, as
it may not indicate the filesystem block size all the time".

Acked-by: Badari Pulavarty <pbadari@us.ibm.com>

Thanks,
Badari

