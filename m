Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315468AbSEHAKY>; Tue, 7 May 2002 20:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSEHAKX>; Tue, 7 May 2002 20:10:23 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:20486 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315468AbSEHAKV>;
	Tue, 7 May 2002 20:10:21 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Tue, 07 May 2002 19:48:48 -0400."
             <200205072348.g47NmmU19152@buggy.badula.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 May 2002 10:10:07 +1000
Message-ID: <2658.1020816607@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the thoughtful reply, it makes a change to get a response
from somebody who has actually considered the problems.

Reading your reply, I get the impression that you might subscribe to
the "every kernel builder is an expert who never makes mistakes" model.
If that is the case then we will have to agree to disagree, kbuild 2.5
was designed to be safe when not used by an expert.  Otherwise, read on.

On Tue, 7 May 2002 19:48:48 -0400, 
Ion Badulescu <ionut@cs.columbia.edu> wrote:
>On Tue, 07 May 2002 09:54:29 +1000, Keith Owens <kaos@ocs.com.au> wrote:
>
>> The documentation is correct, but incomplete.  It is correct for an end
>> user kernel build, i.e. for people who do not change the code or apply
>> patches, they just configure the kernel and build it.  It is incomplete
>> for developers and for anybody who gets a patch and applies it.
>
>So update the documentation if it's incomplete. Seriously.

Yes, the documentation should be updated.  But that will not fix the
problem.  Users do not read documentation, they misunderstand it or
they forget about it.  kbuild 2.5 is designed to work for people who do
not read the documentation.

>This is more of the "world will come to an end if we don't adopt kbuild25
>as-is" rhetoric...

I don't see how you get from incomplete documentation to an end of the
world scenario.

>> Add or delete #include in a source, add or delete a source, 
>
>Of course it's not nearly as bad as you make it appear. You're still
>touching source code which will cause a recompile of that source code.
>
>You have to make one of the changes above, compile, then change an 
>included header file _only_, then compile again, and only then the 
>missing dependency will create a problem.

I absolutely agree.  Except you missed the most common cause of
problems with patches.  Users apply a patch, build once, make *config
and adjust a config that the change introduced.  Code affected by the
config change is not rebuilt because make dep was not run.

>As for removing CONFIG_FOO, you'll get missing dependencies if
>include/config/foo.h disappears after make *config.

Not true.  kbuild 2.4 uses $(wildcard) so disappearing config files are
ignored.  It has to use $(wildcard) because the source code already
contains references to non-existent CONFIG variables.

>> Modversions are even
>> worse, after any change that might affect an exported symbol or
>> structure, you must make mrproper (not dep) to calculate and apply the
>> new hashes to the entire kernel.
>
>1. kbuild25 doesn't even support modversions yet

Agreed, I was talking about the 2.4 documentation being incomplete.

>2. you are (almost) contradicting yourself. You've stated earlier that
>modversions are irrelevant for a development kernel; in that case, they
>are equally irrelevant for any kernel compiled by a developer.

What is a developer?  Is it a full blown kernel hacker, is it somebody
just starting on their first update or is it somebody who is following
instructions to apply a bug fix or install a driver that is not in the
kernel yet?

The first category always turn off modversions.  When I asked the
audience at the 2.5 kernel developers conference if they used
modversions, only 2-3 out of 80 did.  AFAIK they only use it for
distributions, not for day to day work.

It is the person starting on their first update or just following
instructions that gets bitten by modversions.  They are the least
likely to read the documentation or to rebuild the kernel from scratch
to turn off modversions first.

My aim in kbuild 2.5 is to support everybody, not just the full blown
hackers.

>3. you have control over modutils so you could easily make the
>modversions mismatch case clearer by printing some helpful advise.
>Something like "you have a modversions conflict between module XXX
>and the kernel, you should recompile both by running this and that
>command (make mrproper, whatever)".

Yes I could, but by then it is too late.  The user has already done the
compile, installed and booted.  Then they find out that kernel build
was stuffed, reboot back to original system and rebuild.

I want to fix the cause, not the symptom.

>> The default for kernel build must be a safe and accurate build.
>
>Perhaps, but this is overkill. It's irrelevant for non-developers,
>it's almost irrelevant for wannabe patch testers who can't read the 
>documentation

On the contrary, it is exactly these people who most need a safe and
accurate build.  They are the ones that get it wrong now, either
because they do not read documentation or because they are just
following instructions.

>and it's getting in developers' way by slowing them
>down unnecessarily:
>
>$ time make -f Makefile-2.5 drivers/net/starfire.o 
>Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/kgcc' CPP='/usr/bin/kgcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
>Generating global Makefile
>  phase 1 (find all inputs)
>  phase 2 (convert all Makefile.in files)
>  phase 3 (evaluate selections)
>  phase 4 (integrity checks, write global makefile)
>Starting phase 5 (build) for drivers/net/starfire.o
>Phase 5 complete for drivers/net/starfire.o
>
>real    0m32.941s
>user    0m30.940s
>sys     0m1.640s
>
>It takes 32 seconds to do nothing -- and this is a P4/1400...

The pre-processing code is currently unoptimized and has full debugging
turned on.  In scripts/Makefile-2.5, Add -O2 -DNDEBUG=1 to PP_CC_FLAGS
and those times will drop by 30%.

>$ time make -f Makefile-2.5 NO_MAKEFILE_GEN=1 drivers/net/starfire.o 
>Starting phase 5 (build) for drivers/net/starfire.o
>  Updating global makefile with last set of commands
>Phase 5 complete for drivers/net/starfire.o
>
>real    0m21.505s
>user    0m17.800s
>sys     0m0.280s
>
>First run with NO_MAKEFILE_GEN=1 takes 21 seconds to do nothing... and
>still insists on updating the global makefile.

For NO_MAKEFILE_GEN I generate a partial set of dependency information
to give make a better chance of detecting changes to headers and
configs.  There is no point in generating that data for every build, it
is only used in NO_MAKEFILE_GEN mode.  That is why I have to update the
global makefile the first time you switch from normal mode to
NO_MAKEFILE_GEN mode.  I will change the message to say

  Preparing build system for NO_MAKEFILE_GEN mode

>$ time make -f Makefile-2.5 NO_MAKEFILE_GEN=1 drivers/net/starfire.o 
>Starting phase 5 (build) for drivers/net/starfire.o
>Phase 5 complete for drivers/net/starfire.o
>
>real    0m0.674s
>user    0m0.390s
>sys     0m0.280s
>
>Second run is more acceptable.
>
>I like the non-recursive make, and I like the ability to easily compile
>only the target I need/want. So I won't even try to compare the times 
>with those for a 2.4-style build, it's like comparing apples and oranges.
>However, 30+ seconds is *slow* no matter how you look at it.

I agree.  Optimize PP_CC_FLAGS and it will go down a bit.  I am working
on speeding up the database code.  But I will not sacrifice build
accuracy for speed.

>If something like the current kbuild25 gets into the kernel, I'll end up
>doing the same thing I'm currently for 2.4: running gcc by hand, with all
>the required arguments. Surely it's no worse than 2.4, but it will have
>had the opportunity to get better, and missed it...

Accuracy first, speed later.

>At the very least, give me the option of create a 
>I_DONT_WANT_NO_STINKING_MAKEFILES_TO_BE_REGENERATED
>file which does the equivalent of NO_MAKEFILE_GEN=1, preferrably without
>the slowdown associated with the first run.

See above, 'Preparing build system for NO_MAKEFILE_GEN mode'.

>Also try to remember that solving 100% of the reported problems, at any
>cost, is not necessarily a desirable goal. Many people here would be
>happy to get only the more annoying ones fixed, and have reasonable
>workarounds for the rest.

But will people get the workarounds right?  The default has to be
something that works every time.  I am not aiming for Aunt Tillie's
level but kbuild 2.4 has proven that relying on human action does not
work, even for people who understand computers.

>- it would be nice if CFLAGS were also printed.

make ... PP_MAKEFILE5_FLAGS=-v gives you the exact command used for
each compile.  Ready for cut and paste if that is what you want to do.

>- I think looking for kgcc before gcc is a bad idea. If you really
>want something like that, make it look for kgcc-2.5 instead.

That came from one of the -ac trees.  No matter which order I use,
somebody will want a different order and complain.  At least kbuild 2.5
tells you what it is using, instead of silently defaulting to an
unexpected value.


