Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLORqb>; Fri, 15 Dec 2000 12:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQLORqM>; Fri, 15 Dec 2000 12:46:12 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:40972 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129521AbQLORqJ>; Fri, 15 Dec 2000 12:46:09 -0500
Date: Fri, 15 Dec 2000 09:15:23 -0800 (PST)
From: ferret@phonewave.net
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
cc: Alexander Viro <viro@math.psu.edu>, LA Walsh <law@sgi.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
In-Reply-To: <20001215152137.K599@almesberger.net>
Message-ID: <Pine.LNX.3.96.1001215090857.16439A-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, Werner Almesberger wrote:

> Alexander Viro wrote:
> > In the situation above they should have -I<wherever_the_tree_lives>/include
> > in CFLAGS. Always had to. No links, no pain in ass, no interference with
> > userland compiles.
> 
> As long as there's a standard location for "<wherever_the_tree_lives>",
> this is fine. In most cases, the tree one expects to find is "roughly
> the kernel we're running". Actually, maybe a script to provide the
> path would be even better (*). Such a script could also complain if
> there's an obvious problem.
> 
> I think there are three possible directions wrt visibility of kernel
> headers:
> 
>  - non at all - anything that needs kernel headers needs to provide them
>    itself
>  - kernel-specific extentions only; libc is self-contained, but user
>    space can get items from .../include/linux (the current glibc
>    approach)
>  - share as much as possible; libc relies on kernel for "standard"
>    definitions (the libc5 approach, and also reasonably feasible
>    today)
> 
> My personal preference is the third direction, because it simplifies the
> deployment of new "standard" elements, and changes to existing interfaces.
> The first direction would effectively discourage any new interfaces or
> changes to existing ones, while the second direction allows at least a
> moderate amount of flexibility for kernel-specific interfaces. In my
> experiments with newlib, I was largely able to use the third approach.
> 
> I don't want to re-open the discussion on which way is better for glibc,
> but I think we can agree that "clean" kernel headers are always a good
> idea.
> 
> So we get at least the following levels of visibility:
> 
>  0) kernel-internal interfaces; should only be visible to "base" kernel
>  1) public kernel interfaces; should be visible to modules (exposing
>     type 0 interfaces to modules may create ways to undermine the GPL)
>  2) interfaces to kernel-specific user space tools (modutils, mount,
>     etc.); should be visible to user space that really wants them
>  3) interface to common non-POSIX extensions (BSD system calls, etc.);
>     should be visible to user space on request, or on an opt-out basis
>  4) interfaces to POSIX elements (e.g. struct stat, mode_t); should be
>     visible unconditionally (**)
> 
> Distinguishing level 0 and 1 is always a little difficult. It seems
> that a "kmodcc" that inserts the necessary flags would be useful there
> (*). There needs to be a clear distinction between level 1 and 2 (the
> current #ifdef __KERNEL__). This boundary could certainly be improved
> be moving user-space-visible header files to a separate directory.
> 
> Levels 2, 3, and 4 are more difficult to separate, because the people
> who know what should go where are not always the ones writing the
> kernel headers. Perhaps some more input from libc hackers could help.
> 
> (*) Crude examples for such scripts (for newlib): newlib-flags and
>     newlib-cc in
>     ftp://icaftp.epfl.ch/pub/people/almesber/misc/newlib-linux/
>       newlib-linux-20.tar.gz
> 
> (**) Multiple versions of the interface can be a problem here, e.g.
>      struct oldold_utsname vs. struct old_utsname vs.
>      struct new_utsname. It would be nice to have them prefixed at
>      least with __. Maybe a __LATEST_utsname macro would be useful
>      too ;-) (I know, breaks binary compatibility, hence the
>      smiley.)
> 
> So ... what's the opinion on slowly introducing a redirection via
> scripts ?

Just out of curiosity, what would happen with redirection if your source
tree for 'the currently running kernel' version happens to be configured
for a different 'the currently running kernel', perhaps a machine of a
foreign arch that you are cross-compiling for?

I do this: I use ONE machine to compile kernels for five: four i386 and
one SUN4C. My other machines don't even HAVE /usr/src/linux, so where does
this redirection leave them?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
