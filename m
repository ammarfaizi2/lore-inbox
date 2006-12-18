Return-Path: <linux-kernel-owner+w=401wt.eu-S1753624AbWLRJ1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbWLRJ1A (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbWLRJ1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:27:00 -0500
Received: from [85.204.20.254] ([85.204.20.254]:38462 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753617AbWLRJ07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:26:59 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <20061218011801.04ec66be.akpm@osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org>
	 <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>
	 <45861E68.3060403@yahoo.com.au> <20061217214308.62b9021a.akpm@osdl.org>
	 <458641C2.5010807@yahoo.com.au>  <20061218011801.04ec66be.akpm@osdl.org>
Content-Type: text/plain
Organization: I-NEO
Date: Mon, 18 Dec 2006 11:26:54 +0200
Message-Id: <1166434014.6911.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2006-12-18 at 01:18 -0800, Andrew Morton wrote:
> On Mon, 18 Dec 2006 18:22:42 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > Andrew Morton wrote:
> > > On Mon, 18 Dec 2006 15:51:52 +1100
> > > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > > 
> > > 
> > >>I think the problem Andrew identified is real.
> > > 
> > > 
> > > I don't.  In fact I don't think I described any problem (well, I tried to,
> > > but then I contradicted myself).
> > 
> > By saying that there shouldn't be any dirty ptes if there are no
> > dirty buffers? But in that case the _page_ shouldn't be dirty either,
> > so that clear_page_dirty would be redundant. But presumably it isn't.
> 
> I don't follow that.
> 
> The linkage between pte-dirtiness and buffer_heads is a bit hard to follow
> without also considering page-dirtiness.
> 
> > > Six hours here of fsx-linux plus high memory pressure on SMP on 1k
> > > blocksize ext3, mainline.  Zero failures.  It's unlikely that this testing
> > > would pass, yet people running normal workloads are able to easily trigger
> > > failures.  I suspect we're looking in the wrong place.
> > 
> > Yes I could believe it the corruption is caused by something else
> > completely.
> 
> Think so.  We do have a problem here, but only on threaded apps, I believe.
> rtorrent doesn't appear to be threaded, and the bug is hit on non-preempt
> UP.


ierdnac ~ # uname -a
Linux ierdnac 2.6.20-rc1 #2 SMP PREEMPT Mon Dec 18 11:01:52 EET 2006
i686 Genuine Intel(R) CPU           T2050  @ 1.60GHz GenuineIntel
GNU/Linux


and the other person who had corruption with rtorrent has also SMP and
PREEMPT.


> 
> > >>The issue is the disconnect between the pte dirtiness and a filesystem
> > >>bringing buffers clean.
> > > 
> > > 
> > > Really?  The dirtying direction goes pte_dirty->PG_dirty->BH_Dirty and the
> > > cleaning direction goes !BH_Dirty->!PG_dirty->!pte_dirty.  That's pretty
> > > simple, setting aside races.
> > > 
> > > In the try_to_free_buffers case there's a large time inverval between
> > > !BH_Dirty and !PG_dirty, but that shouldn't affect anything.
> > 
> > After try_to_free_buffers detaches the buffers from the page, a
> > pagefault can come in, and mark the pte writeable, then set_page_dirty
> > (which finds no buffers, so only sets PG_dirty).
> > 
> > The page can now get dirtied through this mapping.
> > 
> > try_to_free_buffers then goes on to clean the page and ptes.
> 
> try_to_free_buffers() isn't called against a page which doesn't have
> buffers.  It'll oops.
> 
> > Were you testing with preempt?
> 
> nope, just SMP.
> 

