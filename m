Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272038AbRIDR27>; Tue, 4 Sep 2001 13:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272034AbRIDR2t>; Tue, 4 Sep 2001 13:28:49 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:19208 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272003AbRIDR2g>; Tue, 4 Sep 2001 13:28:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jan Harkes <jaharkes@cs.cmu.edu>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Tue, 4 Sep 2001 19:35:51 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20010904112629.A27988@cs.cmu.edu> <Pine.LNX.4.33L.0109041320271.7626-100000@imladris.rielhome.conectiva> <20010904131349.B29711@cs.cmu.edu>
In-Reply-To: <20010904131349.B29711@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010904172850Z16487-32383+3458@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 4, 2001 07:13 pm, Jan Harkes wrote:
> On Tue, Sep 04, 2001 at 01:27:50PM -0300, Rik van Riel wrote:
> > I've been working on a CPU and memory efficient reverse
> > mapping patch for Linux, one which will allow us to do
> > a bunch of optimisations for later on (infrastructure)
> > and has as its short-term benefit the potential for
> > better page aging.
> 
> Yes, I can see that using reverse mappings would be a way of correcting
> the aging if you call page_age_up from try_to_swap_out, in which case
> there probably needs to be a page_age_down on virtual mappings as well
> to correctly balance things.

There is.  1) Unreferenced process space page gets unmapped, goes on to LRU 
lists 2) page aged down to zero until it gets deactivated 3) page deactivated 
and evicted soon after.  If the page is referenced during (2) or (3) it will 
be mapped back in, no IO because it's still in the swap cache (minor fault).

But this is lopsided and hard to balance.  Also, unmapping/remapping is an 
expensive way to check for short-term page activity.

> > It seems the balancing FreeBSD does (up aging +3, down
> > aging -1, inactive list in LRU order as extra stage) is
> 
> One other observation, we should add anonymously allocated memory to the
> active-list as soon as they are allocated in do_nopage. At the moment a
> large part of memory is not aged at all until we start swapping things
> out.

This is useless without rmap because the page will just be aged down, not up. 
With rmap, yes, that's what needs to be done.

--
Daniel
