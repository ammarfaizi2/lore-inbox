Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSEGXsv>; Tue, 7 May 2002 19:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSEGXsu>; Tue, 7 May 2002 19:48:50 -0400
Received: from bgp401130bgs.jersyc01.nj.comcast.net ([68.36.96.125]:26118 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S315457AbSEGXss>;
	Tue, 7 May 2002 19:48:48 -0400
Date: Tue, 7 May 2002 19:48:48 -0400
Message-Id: <200205072348.g47NmmU19152@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <cs.lists.linux-kernel/18740.1020729269@ocs3.intra.ocs.com.au>
X-Newsgroups: cs.lists.linux-kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 May 2002 09:54:29 +1000, Keith Owens <kaos@ocs.com.au> wrote:

> The documentation is correct, but incomplete.  It is correct for an end
> user kernel build, i.e. for people who do not change the code or apply
> patches, they just configure the kernel and build it.  It is incomplete
> for developers and for anybody who gets a patch and applies it.

So update the documentation if it's incomplete. Seriously.

This is more of the "world will come to an end if we don't adopt kbuild25
as-is" rhetoric...

> Add or delete #include in a source, add or delete a source, 

Of course it's not nearly as bad as you make it appear. You're still
touching source code which will cause a recompile of that source code.

You have to make one of the changes above, compile, then change an 
included header file _only_, then compile again, and only then the 
missing dependency will create a problem.

> add or delete a config option and you must run make dep to
> ensure that the changes rebuild what is required.

"add or delete" as in "create/remove a CONFIG_FOO definition and make use
of it in the source code", or "select/unselect CONFIG_FOO in .config"?

If the former, again you need to make use of that definition somewhere
so you're changing source which will get recompiled. Only after making 
a second round of changes you start running into missing dependencies. 
As for removing CONFIG_FOO, you'll get missing dependencies if
include/config/foo.h disappears after make *config.

If the latter, I'm at a loss as to how the current system fails to
handle this correctly.

> Modversions are even
> worse, after any change that might affect an exported symbol or
> structure, you must make mrproper (not dep) to calculate and apply the
> new hashes to the entire kernel.

1. kbuild25 doesn't even support modversions yet

2. you are (almost) contradicting yourself. You've stated earlier that
modversions are irrelevant for a development kernel; in that case, they
are equally irrelevant for any kernel compiled by a developer.

3. you have control over modutils so you could easily make the
modversions mismatch case clearer by printing some helpful advise.
Something like "you have a modversions conflict between module XXX
and the kernel, you should recompile both by running this and that
command (make mrproper, whatever)".

> The default for kernel build must be a safe and accurate build.

Perhaps, but this is overkill. It's irrelevant for non-developers,
it's almost irrelevant for wannabe patch testers who can't read the 
documentation, and it's getting in developers' way by slowing them
down unnecessarily:

$ time make -f Makefile-2.5 drivers/net/starfire.o 
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/kgcc' CPP='/usr/bin/kgcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
  phase 2 (convert all Makefile.in files)
  phase 3 (evaluate selections)
  phase 4 (integrity checks, write global makefile)
Starting phase 5 (build) for drivers/net/starfire.o
Phase 5 complete for drivers/net/starfire.o

real    0m32.941s
user    0m30.940s
sys     0m1.640s

It takes 32 seconds to do nothing -- and this is a P4/1400...

$ time make -f Makefile-2.5 NO_MAKEFILE_GEN=1 drivers/net/starfire.o 
Starting phase 5 (build) for drivers/net/starfire.o
  Updating global makefile with last set of commands
Phase 5 complete for drivers/net/starfire.o

real    0m21.505s
user    0m17.800s
sys     0m0.280s

First run with NO_MAKEFILE_GEN=1 takes 21 seconds to do nothing... and
still insists on updating the global makefile.

$ time make -f Makefile-2.5 NO_MAKEFILE_GEN=1 drivers/net/starfire.o 
Starting phase 5 (build) for drivers/net/starfire.o
Phase 5 complete for drivers/net/starfire.o

real    0m0.674s
user    0m0.390s
sys     0m0.280s

Second run is more acceptable.

I like the non-recursive make, and I like the ability to easily compile
only the target I need/want. So I won't even try to compare the times 
with those for a 2.4-style build, it's like comparing apples and oranges.
However, 30+ seconds is *slow* no matter how you look at it.

If something like the current kbuild25 gets into the kernel, I'll end up
doing the same thing I'm currently for 2.4: running gcc by hand, with all
the required arguments. Surely it's no worse than 2.4, but it will have
had the opportunity to get better, and missed it...

At the very least, give me the option of create a 
I_DONT_WANT_NO_STINKING_MAKEFILES_TO_BE_REGENERATED
file which does the equivalent of NO_MAKEFILE_GEN=1, preferrably without
the slowdown associated with the first run.

Also try to remember that solving 100% of the reported problems, at any
cost, is not necessarily a desirable goal. Many people here would be
happy to get only the more annoying ones fixed, and have reasonable
workarounds for the rest.

Don't get me wrong, there are many nice things in kbuild25 which I'd like
to see in the official tree. Makefile regeneration is not one of them,
though. Make a system that even a fool can use and only a fool will want
to use it...

Just MHO, of course.

---------------

Other minor things, not related to the discussion above:

- it would be nice if CFLAGS were also printed.
- I think looking for kgcc before gcc is a bad idea. If you really
want something like that, make it look for kgcc-2.5 instead.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
