Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRC0SuJ>; Tue, 27 Mar 2001 13:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131320AbRC0SuA>; Tue, 27 Mar 2001 13:50:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57611 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131317AbRC0Stq>; Tue, 27 Mar 2001 13:49:46 -0500
Date: Tue, 27 Mar 2001 10:48:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <Andries.Brouwer@cwi.nl>
cc: <alan@lxorguk.ukuu.org.uk>, <hpa@transmeta.com>,
        <linux-kernel@vger.kernel.org>, <tytso@MIT.EDU>
Subject: Re: Larger dev_t
In-Reply-To: <UTC200103270929.LAA29224.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.31.0103271028280.24734-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Mar 2001 Andries.Brouwer@cwi.nl wrote:
>
> Let me repeat: there is no such code. In user space dev_t already is
> 64 bits, whether you like it or not. We cannot go back to libc5.

Now you're back to the argument that "glibc is bloated, so we might as
well be too".

The fact is, that I don't like that argument. I don't buy into that kind
of philosophy. If somebody else made a mistake, that doesn't force me to
do the same mistake.

> In kernel space we all want to use pointers to a device struct,
> and major and minor are fields in that struct. There is no advantage
> in making those fields narrow. And what is carried around is the
> pointer, a 32-bit object.

Agreed. I'm not worried about that part.

But I have a holy crusade. I dislike waste. I dislike over-engineering. I
absolutely detest the "because we can" mentality. I think small is
beautiful, and the guildeline should always be that performance and size
are more important than features.

>		Of course, making it 32-bit is an improvement
> but I can really not see any reason to make things difficult for
> ourselves by widening this straw to 32-bits only.

I don't see the "difficulty".

The fact is, that there are two uses for dev_t's:
 - the "unnamed" ones. Where we've had 8 bits of namespace for ten years,
   and even now it's only mildly painful (ie most people never notice). We
   probably don't need more than 10-11 bits in practice (even with
   automounting on large sites, I doubt you'll find a site that needs to
   have mroe than a few thousand mounts active at the same time). 20 bits
   is _plenty_.

 - /dev.

And let's take a look at /dev. Do a "ls -l /dev" and think about it. Every
device needs a unique number. Do you ever envision seeing that "ls -l"
taking about 500 billion years to complete? I don't. I don't think you do.
But that's how ludicrous a 64-bit device number is.

So in /dev, there are two problems: we are getting painfully close to
major numbers with 8 bits, and we've run out of minors several times. In
fact, a lot of the reason for the dearthness of major numbers is the fact
that we use multiple majors for some stuff that really wants many minors.

So 8 bits for major is actually fairly close to perfectly livable - or
at least would be if we had more minors. And there is no question about
it: you need a lookup table for major numbers. Which means that 32 bits of
major numbers is ridiculous. As is 20. Which is why I suggested 12. A nice
size, that is reasonable in real life, and that can easily be used for
table lookups. It's also sixteen times larger than what we have today,
which would probably be acceptable in itself.

For minors, we have the problem of "dynamic" devices. The main one
probably being pty's, in fact. It's easily conceivable to have thousands
of pty's - I suspect that for various other reasons most system
administrators would prefer to farm things out so that it isn't _needed_,
but clearly we want at _least_ 16 bits here. 20 bits is reasonable.

And remember: for the future, what we want to move towards is _name_
lookup, not device number lookup. Stupid SCSI people have wanted to
partition the minor number for a long time, and that's always been
idiotic. If you have a sparse name-space, you should use names, not
numbers.

So people who want to see /dev/scsi/bus0/dev12/lun4/part0, use devfs or
something, don't try to make the number space be sparse. Sparse numbers
are a stupid idea for _anything_ but maybe CPU design (I'm willing to
concede that a 256-bit address space might be useful on a CPU level,
because a CPU really cannot afford to do name lookups when looking up
addresses, even if it has been tried).

In short, a 64-bit dev_t is unnecessary. And according to the maxim of
"don't go overboard just because you _can_", I don't want to see it.

Also, I have looked at your argument for "simplicity", and I dismiss it. I
do not believe that the cases you claim are "simpler" are really simpler.
I showed that your pid_t example was completely unrealistic, and as far as
I can tell your "dev_t" example absolutely _hinges_ on the fact that it
makes anonymous dev_t allocation simpler.

And that falls flat on its face simply because it's _already_ so simple
that it doesn't matter.

		Linus

