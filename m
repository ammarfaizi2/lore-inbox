Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132135AbRCVSeR>; Thu, 22 Mar 2001 13:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132140AbRCVSeJ>; Thu, 22 Mar 2001 13:34:09 -0500
Received: from zeus.kernel.org ([209.10.41.242]:23272 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132135AbRCVSd6>;
	Thu, 22 Mar 2001 13:33:58 -0500
Date: Thu, 22 Mar 2001 18:18:08 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        arjanv@redhat.com, Rik van Riel <riel@nl.linux.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Thinko in kswapd?
Message-ID: <20010322181808.B7756@redhat.com>
In-Reply-To: <20010322145810.A7296@redhat.com> <Pine.LNX.4.31.0103220931330.18728-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.31.0103220931330.18728-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Mar 22, 2001 at 09:36:48AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 22, 2001 at 09:36:48AM -0800, Linus Torvalds wrote:
> On Thu, 22 Mar 2001, Stephen C. Tweedie wrote:
> >
> > There is what appears to be a simple thinko in kswapd.  We really
> > ought to keep kswapd running as long as there is either a free space
> > or an inactive page shortfall; but right now we only keep going if
> > _both_ are short.
> 
> Hmm.. The comment definitely says "or", so changing it to "and" in the
> sources makes the comment be non-sensical.

Indeed.  
 
> I suspect that the comment and the code were true at some point. The
> behaviour of "do_try_to_free_pages()" has changed, though, and I suspect
> your suggested change makes more sense now (it certainly seems to be
> logical to have the reverse condition for sleeping and for when to call
> "do_try_to_free_pages()").

> The only way to know is to test the behaviour. My only real worry is that
> kswapd might end up eating too much CPU time and make the system feel bad,
> but on the other hand the same can certainly be true from _not_ doing this

Yes, it's more the inconsistency between the tests than the tests that
prompted me to try it, and the scale of the interactive performance
improvement was quite a surprise.

On the other hand, Alan is now reporting that on one of his workloads
it does cause erratic behaviour for interactive loads.  So this is
definitely not a cure-all.

We already do have some problems with excessive swap time being
consumed under some loads: I can reproduce stalls of several seconds
on a PAE box with simple "dd > /dev/sd*".  That's something I need to
follow up further once we've found the source of some SMP data
corruption we're still seeing on big boxes (I'll be sending patches
for a shm race shortly that we found while chasing this.)

I suspect we'll need to instrument the activity of the various lrus in
the VM more accurately before we'll ever understand _why_ the VM works
well or badly in any given situation.

Cheers,
 Stephen
