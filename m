Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292967AbSCDXLx>; Mon, 4 Mar 2002 18:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292982AbSCDXLq>; Mon, 4 Mar 2002 18:11:46 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:50957 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292967AbSCDXLi>;
	Mon, 4 Mar 2002 18:11:38 -0500
Date: Mon, 4 Mar 2002 20:11:21 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020305000102.S20606@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203042007240.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
> On Mon, Mar 04, 2002 at 06:36:47PM -0300, Rik van Riel wrote:
> > On Mon, 4 Mar 2002, Andrea Arcangeli wrote:
> >
> > > > 2) We can do local per-node scanning - no need to bounce
> > > > information to and fro across the interconnect just to see what's
> > > > worth swapping out.
> > >
> > > the lru lists are global at the moment, so for the normal swapout
> > > activitiy rmap won't allow you to do what you mention above
> >
> > Actually, the lru lists are per zone and have been for a while.
>
> They're not in my tree

Yeah, but you shouldn't judge rmap by what's in your tree ;))

Balancing is quite simple, too.

> > The thing which was lacking up to now is a pagecache_lru_lock
> > per zone, because this clashes with truncate().  Arjan came up
> > with a creative solution to fix this problem and I'll integrate
> > it into -rmap soon...
>
> making it a per-lru spinlock is natural scalability optimization, but
> anyways pagemap_lru_lock isn't a very critical spinlock.

That's what I used to think, too.  The folks at IBM showed
me I was wrong and the pagemap_lru_lock is critical.


> > I'd appreciate it if you could look at the implementation and
> > look for areas to optimise. However, note that I don't believe
>
> I didn't had time to look too much into that yet (I had only a short
> review so far), but I will certainly do that in some more time, looking
> at it with a 2.5 long term prospective. I didn't liked too much that you
> resurrected some of the old code that I don't think pays off. I would
> preferred if you had rmap on top of my vm patch without reintroducing
> the older logics. I still don't see the need of inactive_dirty and the
> fact you dropped classzone and put the unreliable "plenty stuff" that
> reintroduces design bugs that will lead kswapd go crazy again. But ok, I
> don't worry too much about that, the rmap bits that maintains the
> additional information are orthogonal with the other changes and that's
> the interesting part of the patch after all.

OK, lets try to put classzone on top of a Hammer "NUMA" system.

You'll have one CPU starting to allocate from zone A, falling
back to zone B and then further down.

Another CPU starts allocating at zone B, falling back to A
and then further down.

How would you express this in classzone ?  I've looked at it
for quite a while and haven't found a clean way to get this
situation right with classzone, which is why I have removed
it.

As for kswapd going crazy, that is nicely fixed by having
per zone lru lists... ;)

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

