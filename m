Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbRC0GF2>; Tue, 27 Mar 2001 01:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130532AbRC0GFS>; Tue, 27 Mar 2001 01:05:18 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:36868 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130531AbRC0GFF>; Tue, 27 Mar 2001 01:05:05 -0500
Date: Mon, 26 Mar 2001 22:03:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <Andries.Brouwer@cwi.nl>
cc: <alan@lxorguk.ukuu.org.uk>, <hpa@transmeta.com>,
        <linux-kernel@vger.kernel.org>, <tytso@MIT.EDU>
Subject: Re: Larger dev_t
In-Reply-To: <UTC200103251231.OAA10795.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.31.0103262154200.23611-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Mar 2001 Andries.Brouwer@cwi.nl wrote:
>
> Now what I wrote is that *I* am strongly in favor of sizeof(dev_t) = 8.
> You think that I want bloat - in reality sizeof(dev_t) = 8 makes life
> simpler.
>
> My system here has for example in super.c:
>
> static dev_t next_unnamed_device = 0x10000000000ULL;
>
> kdev_t get_unnamed_dev(void) {
>         return to_kdev_t(next_unnamed_device++);
> }

Fine.

You'e now forced every piece of code that needs a dev_t to carry along the
overhead of having a 64-bit field, for the advantage of making
"get_unnamed_dev()" smaller and faster.

The thing is, I have _never_ EVER seen "get_unnamed_dev()" on any kernel
profile.

And I don't remember when (if ever) we had a bug in it.

So the advantage of making it smaller/faster/simpler seems to be a purely
theoretical one.

> a large name space allows one to omit checking what part can be
> reused - reuse is unnecessary. That is also why I use a 64-bit pid:
> upon a fork one does not have to search for pids, pgrps, sessions
> with a given pid, and getpid() can be

Hey, 5 years ago we could have said the same for a 32-bit pid.

The fact is, that there are programs out there that use "int" for pids.

It's equally true that changing "pid_t" will require that you recompile
every single app that might have a kernel interface to the current 32-bit
pid_t.

AND you just created tons of problems for things like the non-obvious
stuff like

	ioctl(fd, FASETOWN, arg);

because "arg" is defined to be a single word.

In short, you've just broken existing binaries in ways that will be _damn_
hard to debug (they magically start breaking only after the pid-space has
wrapped the first 32 bits).

And that's a DOCUMENTED interface. Never mind all the undocumented stuff
that assumes (for all the reasonable historical reasons) that "pid" fits
in an "int". Tell me there aren't applications like that, and I'll laugh
in your face.

In short, both your arguments are totally bogus. Your "simpler" function
is in fact a horrible rats nest and a source of subtle bugs that you
apparently never even thought about.

And that's without ever actually mentioning the word "bloat" and "data
cache usage".

		Linus

