Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269990AbRHGWkf>; Tue, 7 Aug 2001 18:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270066AbRHGWkZ>; Tue, 7 Aug 2001 18:40:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58764 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269990AbRHGWkL>;
	Tue, 7 Aug 2001 18:40:11 -0400
Date: Tue, 7 Aug 2001 18:40:19 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] parser for mount options
In-Reply-To: <200108072151.VAA25091@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0108071753190.18565-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001 Andries.Brouwer@cwi.nl wrote:

> +       struct mount_option opts[] = {
> +         { "check", OPT_STRING,
> +             &(C){"relaxed", "normal", "strict", 0}, &opt.check},

Sorry, no. That's exceptionally bad interface. It's not only hard to read,
it breeds global variables for no good reason _and_ it will get
more and more irregular.

> Also, you still have a lot of code for each filesystem
> that calls strtok() and math_token() and does a switch().
> I only have this single call parse_mount_options()
> for each filesystem.

Yes. And you end up mixing a lot of control flow into the data structures.
What will you do when somebody will want -o foo_range=40:65? Add new
sort of entry? Put a pointer to structure of two ints in the last field?

There are two different tasks - one of them is to decide which option we
are dealing with and another - decode and act upon it.  Mixing parsing
and data conversion in that kind of situations is a Bad Thing(tm).  We
already have a couple of such cases and both had grown into a horrible
mess - proc_dir_entry (which was hell to clean up) and sysctls.  Both
had started reasonably small and well-defined, but kept growing new
and new warts.

In other words, IMNSHO we need something well-defined, so that it wouldn't
turn into complete mess two years down the road.  Using explicit C for the
second part (we know what it is, now we want to process it) is OK, provided
that access to results of parsing is easy and visible.  If you need something
tricky (couple of integers, integer that happens to be a multiple of 42 or
69, whatever) - you can express it in a small and readable chunk of C that
sits _right_ _there_.  In a language that is fixed and known to everyone
who deals with the kernel.  On the other hand, when one stumbles upon the
new OPT_... he has to go and look into the huge switch in your single
parser just to figure out what syntax do we expect, let alone what happens.
Switch that will keep growing, BTW.

> (And in the past strtok() has caused bugs because it modifies
> the string it is called with. Sometimes, as in the case of vfat/msdos,
> several filesystems might want to have a look.)

Oh, definitely.  strtok() is a mess and I suspect that a clean way to
deal with that is to pass a pair of the same kind as we use for
matched substrings.  It's very easy to switch and we probably will be
better off doing that.
 
> If you don't have any devastating comments I might brush off
> this 1.3.61 patch and move it to 2.4.

Well, basically all comments boil down to one: if we define a mini-language
(and that's precisely what such structures are) we'd better make it
simple _and_ get it right from the very beginning.  Otherwise we will
end up with ever-growing mess a-la BASIC.  Especially ironic with
something that is used for parsing, since we are risking to end up
with a beast that will be hard to parse itself ;-)

I consider separation of pattern-matching side from handling the
results of parsing (which includes data conversion and any assignments,
checks, etc.) as a feature.

Well, actually there is another thing - I like having options syntax easy to
grasp from the source.  Scanf-like patterns are compact _and_ familiar to
pretty much every C programmer, so that variant is about as self-documenting
as it gets.

