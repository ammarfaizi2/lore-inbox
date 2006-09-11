Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWIKWFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWIKWFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWIKWFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:05:36 -0400
Received: from outbound-mail-78.bluehost.com ([70.103.140.27]:60323 "HELO
	outbound-mail-78.bluehost.com") by vger.kernel.org with SMTP
	id S965029AbWIKWFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:05:35 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] MMIO accessors & barriers documentation
Date: Mon, 11 Sep 2006 15:05:59 -0700
User-Agent: KMail/1.9.4
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
References: <1157947414.31071.386.camel@localhost.localdomain> <200609111139.35344.jbarnes@virtuousgeek.org> <1158011129.3879.69.camel@localhost.localdomain>
In-Reply-To: <1158011129.3879.69.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609111506.01389.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 70.103.140.128 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 11, 2006 2:45 pm, Benjamin Herrenschmidt wrote:
> > These sound fine.  I think PPC64 is the only platform that will need
> > them?
>
> Ah ? What about the comment in e1000 saying that it needs a wmb()
> between descriptor updates in memory and the mmio to kick them ? That
> would typically be a memory_to_io_wb(). Or are your MMIOs ordered cs.
> your cacheable stores ?

I think that's a separate issue?  As Jeff points out, those macros are 
intended to provide memory vs. I/O ordering, but isn't PPC the only platform 
that will reorder accesses so aggressively and independently?  I don't think 
ia64 for example will reorder them separately, so a regular memory barrier 
*should* be enough to ensure ordering in both domains.

> They are, but I was thinking about providing more IO-like examples. I
> suppose I could refer to memory-barriers.txt from here and update it
> with IO-like examples.

Yeah, either way.  Not sure if adding more I/O examples to the existing doc is 
better or worse than an I/O specific document.

> > But isn't this how you'll implement io_to_lock_wb() on PPC anyway?  If
> > so, might be best to name it and document it that way (though keeping the
> > idea of barriering before unlocking prominent in the documentation).
>
> Well, the whole question is what does the linux semantics guarantee to
> driver writers (accross archs), not what PowerPC implements :) I'd
> rather not add guarantees that aren't useful to drivers even if all
> current implementations happen to provide them. I'm trying to find a
> case where ordering MMIO W + memory W is useful and I can't see any
> since the MMIO W will take any time to go to the device anyway. The lock
> rule seems to be the only useful, thus the only I think I'll guarantee.

Sure, that's fair.  If any potential application of the more precise semantics 
is just theoretical, we may as well limit our guarantees to locks only.

> Well, as far as I'm concerned, the whole point is rule #2 and #3 :)
> Those are the ones biting us on PowerPC (we haven't seen the lock
> problem but then it can't happen the way our current accessors are
> written. However, if we change our accessors to provide rule #2 more
> specifically, we'll end up with 2 sync instructions in writel, one for
> rule #2 before the store and one for rule #4, thus we go from expensive
> to very expensive). It's also my understanding that mmiowb is very
> expensive on ia64 and gets worse as the box grows bigger.

Yeah, that's true (I see your point about being more worried about other 
things on PPC as well ;).

> Hence the question: do we provide -fully- ordered accessors in class 1,
> or do we provide -mostly- ordered accessors, ordered in all means except
> rule #4 vs locks. ia64 is afaik by far the platform taking the biggest
> hit if you have to provide #4, so I'm interesting in your point of view
> here.

Either way is fine with me as long as we have a way to get at the fast and 
loose stuff (and required barriers of course) in a portable way.  And that we 
don't regress the existing users of mmiowb().

> We don't need counters, just a flag. We did a test implementation, seems
> to work. We also clear the flag in spin_lock. That means that MMIOs
> issued before a lock aren't ordered vs. the locked section. But because
> of rule #1, they should be ordered vs. other MMIOs inside the locked
> section and thus implicitely get ordered anyway.

Oh right, a flag would be enough.  Is it good enough for -mm yet?  Might be 
fun to run on an Altix machine with a bunch of supported devices (not that I 
work with them anymore...).

> > For ia64 in particular it doesn't matter, though there was speculation
> > several years that it might be necessary.  No actual examples stepped
> > forward though, so the current implementation doesn't take an argument.
>
> Ok. My question is wether it would improve the implementation to take
> it. If we define a new macro with a new name, we can do it....

Right, but unless there's a real need at this point, we probably shouldn't 
bother.  Let the poor sucker with the future machine needing the device 
argument do the work. :)

Thanks,
Jesse
