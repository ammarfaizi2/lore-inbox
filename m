Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288780AbSAIEXk>; Tue, 8 Jan 2002 23:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288781AbSAIEXa>; Tue, 8 Jan 2002 23:23:30 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:51470 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id <S288780AbSAIEXR>;
	Tue, 8 Jan 2002 23:23:17 -0500
Date: Wed, 9 Jan 2002 05:23:31 +0100
From: Felix von Leitner <felix-dietlibc@fefe.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, andersen@codepoet.org
Subject: Re: [RFC] klibc requirements
Message-ID: <20020109042331.GB31644@codeblau.de>
Mail-Followup-To: felix-dietlibc@fefe.de, linux-kernel@vger.rutgers.edu
In-Reply-To: <20020108192450.GA14734@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020108192450.GA14734@kroah.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Greg KH (greg@kroah.com):
> First off, I do not want to fork off yet another tiny libc
> implementation,

It's good to hear that.

> Now that people are riled up, and want to talk about it, let's try to
> describe the problem and see if any of the existing libc implementations
> help solve them.  Here's what I see as a list of requirements for a
> klibc like library that can be used by initramfs programs (please,
> everyone else jump in here with their requirements too):

My understanding of what "initramfs programs" actually means is vague at
best.  Are these just programs that are intended to work in an initial
ram disk?  Or is it a special collection that is included in the kernel
distribution?

I don't see why we would need to include those programs with the kernel.
The kernel tries hard to provide backwards compatibility to old versions
of syscalls that have changed over the years.  That's why we _have_ a
standard.  Also, we don't ship glibc with the kernel sources, and we
didn't when our libc was Linux specific.

If we follow that argumentation and are talking here about programs that
aren't included in the kernel, why demand a specific libc for them at
all?  Of course glibc is out of the question, but both the kernel API
_and_ the libc API are standardized.  It does not make sense to write
code that demands a specific libc if it can be avoided.  If you need
any special syscall supported that is not yet part of the diet libc or
uClibc, Eric and I will probably be glad to add support for it.

> 	- portable, runs on all platforms that the kernel currently
> 	  works on, but doesn't have to run on any non-Linux based OS.
> 	- tiny.  If we link statically it should be _small_.  Both
> 	  dietLibc and uClibc are good examples of the size goal.  We do
> 	  not need to support all of POSIX here, only what we really
> 	  need.

When you link statically, it does not matter whether the libc also
supports the rest of POSIX.  The size of libc.a does not matter.  It
only matters which parts are referenced.  Since we are talking about new
software specifically written for Linux and with the goal to be small,
there are no legacy requirements to cater to.  We can write code without
printf and stdio, for example.  Also, we probably don't need regular
expressions or DNS.  Those are the big space hogs when linking
statically against a libc.  In the diet libc, all of the above are very
small, but avoiding them in the first place is better then optimizing
them for small size.

And if we don't use all that bloaty code, it does not matter if we use
diet libc, uClibc or tomorrow's next great small libc.

> 	- If we end up having a lot of different programs in initramfs,
> 	  a dynamic version of the library should be available.  This
> 	  shared library should be _small_ and only contain the symbols
> 	  that are needed by the programs to run.  This should be able
> 	  to be determined at build time.

This may look like a good idea, but dynamic linking should be avoided.
Trust me on this.  While it is possible to squeeze the dynamic loader
down to below 10k, 10k really is a lot of code.  And empty program with
the diet libc is way below 1k on x86.  So to reap the benefit of dynamic
linking, you would need a lot of programs.  Also please note that -fPIC
makes code larger.  And we need to keep symbols around, which makes up a
substantial part of the shared diet libc.

How many programs are we talking about here?  And what should they do?

You can make a libc.so that only contains the superset of the symbols
used by your initramdisk programs.  But then you have to remake the
libc.so if you add another program, so that's not very flexible.

What I want to say here is: don't make rash decisions.  Profile, don't
speculate.  Also, don't underestimate the amount of time dynamic linking
takes.  It may seem insignificant on today's monster CPUs, but it isn't.
I optimized my boot sequence to below 3 seconds from the start of init
to the shell prompt on tty1 (the other ttys are spawned immediately).
All the dynamic linking and shell script overhead adds up quickly.

Please read http://www.fefe.de/dietlibc/talk.pdf for some more info
(slightly less than 100k).

> 	- It has to "not suck" :)  This is a lovely relative feeling
> 	  about the quality of the code base, ease at building the
> 	  library, ease at understanding the code, and responsiveness of
> 	  the developers of the library.

While I am of course sure to be the libc developer that sucks least ;),
I again would advise not to rush to any hasty decisions.  Don't bind
yourself to a libc unless you have to or there are any benefits to be
gained.  I fail to see the benefits.  Currently, the diet libc produces
the smallest binaries by a healthy margin, but binding yourself to the
diet libc does not gain you anything over using APIs that are portable
across all libcs.  In fact, I avoided offering any diet libc specific
APIs at all (with the exception of write12.h).

> I had asked the dietLibc authors about the ability of tweaking their
> library into something that resembles the above, but didn't get a
> response.

Huh?
What email are you talking about here?

Your initial email asked whether you could use parts of the diet libc
for diethotplug and for tweaking, and I said OK.

> Hence my post.  I would love to work with the authors of an
> existing libc to build such a library, as I have other things I would
> rather work on than a libc :)

Before doing any real work, we need to get the specification straight.
What exactly do we need?  The initrd stuff is too vague for my taste.
How many programs do we want to have?  What should those programs do?

> Comments from the various libc authors?  Comments from other kernel
> developers about requirements and goals they would like to see from such
> a libc?

I think you need to ask initrd users.
My understanding was that people want to use the IP autoconfiguration
stuff from the kernel to initrd.  Is that still so?  What other programs
are needed?

Felix
