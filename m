Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268169AbUHFQqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268169AbUHFQqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268181AbUHFQkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:40:52 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:63130 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S268182AbUHFQfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:35:17 -0400
Date: Fri, 6 Aug 2004 18:34:28 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, wli@holomorphy.com
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040806163428.GA31285@k3.hellgate.ch>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org, wli@holomorphy.com
References: <1091754711.1231.2388.camel@cube> <20040806094037.GB11358@k3.hellgate.ch> <1091797122.1231.2452.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091797122.1231.2452.camel@cube>
X-Operating-System: Linux 2.6.8-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2004 08:58:43 -0400, Albert Cahalan wrote:
> > Hardly. All I was asking this time was to have a documentation fix
> > merged, though.
> 
> Just delete the documentation. I certainly never use it.

It wasn't written for you.

> Since you need the kernel source to get the documentation
> anyway, you might as well examine the fs/proc/*.c files.

Some users may prefer written documentation over reading the kernel
source. In addition, in the case of statm, there is nothing to document
the expected behavior in the source, either. Which is precisely why
statm has been utterly broken forever.

> > * statm is broken. It was broken in 2.4 as well, but _differently_. Every
> >   application that relies on statm forwards wrong information, or at
> >   the very least needs special casing because the information provided
> >   in various fields differs between kernel versions.
> 
> The kernel has multiple stat() syscalls. At times, they have been
> broken when dealing with UID values that overflow. Should these
> system calls have been eliminated? If not, how is this different?

stat is a well-defined POSIX call.

> > * Nobody can really tell exactly how broken statm is because there is
> >   no canonical documentation of what it is supposed to do. That implies
> >   that it is kinda hard to properly fix statm.
> 
> Nah. Just look at the 2.2.xx and 2.4.xx kernels.

2.4 was (is?) broken as well.

> > * I hate the format. I like my proc files human readable. An important
> >   reason that statm could linger around in a broken state for so long
> >   is the lack of labels. It's hard to find bugs if there's nothing to
> >   indicate what the values are supposed to be. (and yes, /proc/pid/stat
> >   is awful, too, but it has the excuse of providing valuable information)
> 
> Nobody has been screwing with the statm formatting. There is
> no temptation. The same can not be said of the "readable" files.

Agreed, and I'd be interested in solutions. OTOH, it is harder to
discover if the _content_ is broken in statm.

> Is is SigCgt or SigCat? That would depend on kernel version.
> What about /proc/cpuinfo? An old file gets parsed on whitespace.
> A recent one has ':' characters that you must use.

I wish there were some written guidelines to prevent things like that in
the future. I'd be willing to write them up if there was some agreement
on those rules.

> > The only reason I could see for keeping statm around is that it
> > is cheaper than status for parsers in top & Co. Having written one
> > of them myself, I have spent quite some time thinking about better
> > alternatives. If you want to talk about that, count me in.
> 
> The statm format rules, assuming you don't go binary.

The statm format could only work if there was a clear understanding
what the fields mean. But there isn't.

> >> + size     total program size (pages)  (same as VmSize in status)
> >> + resident size of memory portions (pages) (same as VmRSS in status)
> >>
> >> There was a distinction here that has been lost. One of these
> >> included memory-mapped hardware. You could see this with the
> >> X server video memory.
> >
> > You can definitely not rely on that distinction being there. Feel free to
> > add a comment "may or may not include memory-mapped hardware, depending
> > on the kernel". This makes statm even worse, because even the seemingly
> > well-defined, redundant fields aren't.
> 
> This is merely a kernel bug. Hey, bugs happen.

How can you tell it's a bug? It looks correct to me.

> Why? If statm is broken, it should be fixed. Putting the statm
> data into the status file was dumb, but it's too late now.

It was not dumb. Some people actually prefer human-readable output when
working with proc.

> On AIX:  ps -eo trs
> On BSD:  ps axo trss

I trust they take that information from /proc/pid/statm, too?

> Text size is "tsiz". We have that in the stat file, as the difference
> between end_code and start_code. We don't need second copy of tsiz.
> 
> >> + dt       number of dirty pages   (always 0 on 2.6)
> >>
> >> This one would be useful.
> >
> > Agreed. It would be nice to have it somewhere else.
> 
> No, it's not nice to go moving things around. How about you go

This field is 0 on 2.6. Zero. Always. I am suggesting to have the
information available somewhere. That sure ought to count as an
improvement.

> >> These would be really useful too:
> >> 1. swap space used
> >> 2. swap space that would be used if fully paged out
> >
> > There are many values that could be interesting or useful. But that
> > has nothing to do with the abomination that is statm.
> 
> These values belong in statm.

I thought there was no screwing around with the statm format!?

> > Hey, I am all _for_ improving proc. But rather than adding more values,
> > I'd like to address some design problems first: For example, I'd
> > like to have a reserved value for N/A (currently, kernels just set
> > obsolete fields to 0 and parsers must guess whether it's truly 0 or not
> > available).
> 
> Don't even think of changing this.

Why not? Got a better solution?

> > [ fixed linux-mm address ]
> 
> This should have been on linux-kernel in the first place.
> The linux-mm list is kind of obscure, and doubly so because
> it isn't on vger.kernel.org.

This _was_ on linux-kernel in the first place. _You_ added the wrong
linux-mm address. I don't get your humor.

> No, statm is the proper and only place for this data.
> I certainly don't claim that statm is bug-free code.
> That's not a reason to discard the whole statm concept.

The current state of statm code clearly demonstrates the level of
interest in this concept.

Roger
