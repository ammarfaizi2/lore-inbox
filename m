Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268219AbUHFR2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268219AbUHFR2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUHFR0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:26:18 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:30860 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268210AbUHFRWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:22:42 -0400
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
From: Albert Cahalan <albert@users.sf.net>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, wli@holomorphy.com
In-Reply-To: <20040806163428.GA31285@k3.hellgate.ch>
References: <1091754711.1231.2388.camel@cube>
	 <20040806094037.GB11358@k3.hellgate.ch> <1091797122.1231.2452.camel@cube>
	 <20040806163428.GA31285@k3.hellgate.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1091803883.1231.2502.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Aug 2004 10:51:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 12:34, Roger Luethi wrote:
> On Fri, 06 Aug 2004 08:58:43 -0400, Albert Cahalan wrote:
> > > Hardly. All I was asking this time was to have a documentation fix
> > > merged, though.
> > 
> > Just delete the documentation. I certainly never use it.
> 
> It wasn't written for you.

OK, but the statm file was. (well, for the maintainer
of procps a decade ago)

Everybody else can parse ps output.

> > Since you need the kernel source to get the documentation
> > anyway, you might as well examine the fs/proc/*.c files.
> 
> Some users may prefer written documentation over reading the kernel
> source. In addition, in the case of statm, there is nothing to document
> the expected behavior in the source, either. Which is precisely why
> statm has been utterly broken forever.

A correct proc.txt would not have avoided this.
The source code needs a few comments.

> > > * statm is broken. It was broken in 2.4 as well, but _differently_. Every
> > >   application that relies on statm forwards wrong information, or at
> > >   the very least needs special casing because the information provided
> > >   in various fields differs between kernel versions.
> > 
> > The kernel has multiple stat() syscalls. At times, they have been
> > broken when dealing with UID values that overflow. Should these
> > system calls have been eliminated? If not, how is this different?
> 
> stat is a well-defined POSIX call.

Sure, and the currently version with wide UID values was
working just fine. POSIX only defines the library interface
anyway. This made the old stat syscalls be non-POSIX crud.

They were part of the ABI. They were fixed.

> > Why? If statm is broken, it should be fixed. Putting the statm
> > data into the status file was dumb, but it's too late now.
> 
> It was not dumb. Some people actually prefer human-readable output when
> working with proc.

These people shouldn't be working in /proc. It's easier and
more portable to use "ps" for their scripts. You can select
which fields you want, get a header if you like, have the
processes filtered for you, and so on. Look:

ps -U root -u root -o pid= -o ppid= -o args

What's not to like about that? It's portable even.

> > On AIX:  ps -eo trs
> > On BSD:  ps axo trss
> 
> I trust they take that information from /proc/pid/statm, too?

The point is that the name "trs" has a specific meaning.
The statm file was created to support ps. It wouldn't exist
if ps didn't need to display a TRS column. So the proper
behavior of ps is what defines the meaning. Run these two
commands to see where TRS should be used:

ps v
CMD_ENV=old ps m

Right now, TSIZ is being substituted. That's wrong.
(this is part of the reason why "ps m" was changed)

The top command still tries to display the real trs.

> > >> + dt       number of dirty pages   (always 0 on 2.6)
> > >>
> > >> This one would be useful.
> > >
> > > Agreed. It would be nice to have it somewhere else.
> > 
> > No, it's not nice to go moving things around. How about you go
> 
> This field is 0 on 2.6. Zero. Always. I am suggesting to have the
> information available somewhere. That sure ought to count as an
> improvement.

Sure. That "somewhere" should be where it was before.

> > >> These would be really useful too:
> > >> 1. swap space used
> > >> 2. swap space that would be used if fully paged out
> > >
> > > There are many values that could be interesting or useful. But that
> > > has nothing to do with the abomination that is statm.
> > 
> > These values belong in statm.
> 
> I thought there was no screwing around with the statm format!?

Adding on to the end is always allowed.

You can't change a value to hex, insert a field in the middle,
delete a field, add comments, change the units, and so on.

> > > Hey, I am all _for_ improving proc. But rather than adding more values,
> > > I'd like to address some design problems first: For example, I'd
> > > like to have a reserved value for N/A (currently, kernels just set
> > > obsolete fields to 0 and parsers must guess whether it's truly 0 or not
> > > available).
> > 
> > Don't even think of changing this.
> 
> Why not? Got a better solution?

Old tools need a value that will best make them work. (zero)
New tools can examine the kernel version number.

> > > [ fixed linux-mm address ]
> > 
> > This should have been on linux-kernel in the first place.
> > The linux-mm list is kind of obscure, and doubly so because
> > it isn't on vger.kernel.org.
> 
> This _was_ on linux-kernel in the first place. _You_ added the wrong
> linux-mm address. I don't get your humor.

I'm referring to your original post. I added back linux-mm
because that's where you first brought this up.

> > No, statm is the proper and only place for this data.
> > I certainly don't claim that statm is bug-free code.
> > That's not a reason to discard the whole statm concept.
> 
> The current state of statm code clearly demonstrates the level of
> interest in this concept.

It demonstrates that misleading data is hard to spot.
It demonstrates that people hacking on the kernel are
often unconcerned with providing correct stats for others.
For example, the LRS field should have been fixed when
the ELF binary format support was introduced.


