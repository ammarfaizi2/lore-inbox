Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbUD2ENJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUD2ENJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUD2ENJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 00:13:09 -0400
Received: from florence.buici.com ([206.124.142.26]:62342 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263174AbUD2ENE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 00:13:04 -0400
Date: Wed, 28 Apr 2004 21:13:03 -0700
From: Marc Singer <elf@buici.com>
To: Andrew Morton <akpm@osdl.org>
Cc: riel@redhat.com, brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429041302.GA26845@buici.com>
References: <20040428180038.73a38683.akpm@osdl.org> <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com> <20040428185720.07a3da4d.akpm@osdl.org> <20040429022944.GA24000@buici.com> <20040428193541.1e2cf489.akpm@osdl.org> <20040429031059.GA26060@buici.com> <20040428201924.719dfb68.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428201924.719dfb68.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 08:19:24PM -0700, Andrew Morton wrote:
> Marc Singer <elf@buici.com> wrote:
> >
> > > That's what people have been asking for.  What are you suggesting should
> > > happen instead?
> > 
> > I'm thinking that the problem is that the page cache is greedier that
> > most people expect.  For example, if I could hold the page cache to be
> > under a specific size, then I could do some performance measurements.
> > E.g, compile kernel with a 768K page cache, 512K, 256K and 128K.  On a
> > machine with loads of RAM, where's the optimal page cache size?
> 
> Nope, there's no point in leaving free memory floating about when the
> kernel can and will reclaim clean pagecache on demand.

It could work differently from that.  For example, if we had 500M
total, we map 200M, then we do 400M of IO.  Perhaps we'd like to be
able to say that a 400M page cache is too big.  The problem isn't
about reclaiming pagecache it's about the cost of swapping pages back
in.  The page cache can tend to favor swapping mapped pages over
reclaiming it's own pages that are less likely to be used.  Of course,
it doesn't know that...which is the rub.

If I thought I had an method for doing this, I'd write code to try it
out.

> What you discuss above is just an implementation detail.  Forget it.  What
> are the requirements?  Thus far I've seen

The requirement is that we'd like to see pages aged more gracefully.
A mapped page that is used continuously for ten minutes and then left
to idle for 10 minutes is more valuable than an IO page that was read
once and then not used for ten minutes.  As the mapped page ages, it's
value decays.

> a) updatedb causes cache reclaim
> 
> b) updatedb causes swapout
> 
> c) prefer that openoffice/mozilla not get paged out when there's heavy
>    pagecache demand.
> 
> For a) we don't really have a solution.  Some have been proposed but they
> could have serious downsides.
> 
> For b) and c) we can tune the pageout-vs-cache reclaim tendency with
> /proc/sys/vm/swappiness, only nobody seems to know that.

I've read the source for where swappiness comes into play.  Yet I
cannot make a statement about what it means.  Can you?
