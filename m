Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSECOsR>; Fri, 3 May 2002 10:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314223AbSECOsQ>; Fri, 3 May 2002 10:48:16 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:8399 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314149AbSECOsN>; Fri, 3 May 2002 10:48:13 -0400
Date: Fri, 3 May 2002 09:48:04 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: <802.1020382834@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0205030853090.32217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Keith Owens wrote:

> Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
> >Well Keith's statement (as I read it) is: modversions are broken, I don't 
> >support them. My statement is: modversions work 95% of the time, why throw 
> >them out?
> 
> Build a complete kernel with modversions.  Apply a patch or change a
> config option that changes a structure size.  make bzImage, reboot.
> modversions are _not_ rebuilt.  The kernel and modules were built using
> different ABIs but modversions claims that they are identical.

Well, my experience is that modversions change, but only parts of the 
object files get rebuild, so what you end up with won't link. Anyway, no 
doubt we agree that this is broken (and I said so).

> Third party code is built using a copy of .config and modversions.h.
> This assumes that modversions.h was generated using the same .config,
> but it is not checked.  The module _may_ have used a different config
> but asserts it was built using the same ABI as the kernel (same
> modversions).  Result is a module that appears to match the kernel,
> when really all you know is that the user claims it matches the kernel.

True, that's one of my "5%" where modversions doesn't do the job - if you 
build, then change .config, then build extra stuff, it won't work. Anyway, 
how would you handle that stupidity, I don't see a way to do it without 
enclosing a copy of .config with every module (or a hash thereof). Which 
then means you have to rebuild everything if you change just any option in 
the .config.

> Modversions only detect ABI changes if you make mrproper after any
> change that affects the symbol versions.  That has to be done manually,
> it cannot be automated.  Generation of new symbol versions requires a
> recompile of everything marked export-objs after any source or config
> change.  But there is no way of telling where the versioned symbols are
> consumed, so any change to any versioned symbol requires a complete
> kernel rebuild to ensure that every consumer picks up the new version.
> 
> 95% working?  More like 95% broken!

Well, you did not quote all I said. My point was that the concept of
modversions catches incompatible ABI changes in 95% of the cases. I also
agreed with you that the build process is currently broken. (and I don't
think it's worth arguing if it's in 95% of the cases or whatever, it needs
fixing).

The dependencies you're describing above are wrong though, maybe that's 
why you couldn't get it right in kbuild-2.5? The dependencies are: If any 
of the objects in $(export-objs) are changed, you need to recalculate the 
checksum. If any checksum changes, you need to rebuild everything that 
includes modversions.h (i.e. every module). 

Yeah, that means a lot of recompilations, fortunately only a fraction of
all sources is in $(export-objs), so it doesn't happen all that often. It
may be possible to speed it up by figuring out which files actually used
the changed symbols, kind a like we currently do with dependencies on
CONFIG_XXX. But I think correctness goes first, the user asked for
modversions, so he may have to take the increased build time.

> Changing from a recursive to non-recursive make is the big change in
> kbuild 2.5.  If you think that you can do non-recursive make without
> significant changes to the Makefiles, show me the code.

Well, we had this thread a couple of months ago, I resurrected a 
(proof-of-concept only) patch I had to do so. You were on the CC list - 
why do I even bother talking to you when you don't listen anyway?

(The patch was not at all production quality, but yes, I check if the
things I'm claiming are doable, and it turns out they are. It's actually
fairly easy for Makefiles which only have standard rules (obj-... +=, etc)
Special cases are harder to handle, that's why I'm currently going through
the Makefiles, trying to remove them as far as possible).

However, there's two reasons to go to a non-recursive build:
o it may be faster than forking make for every subdir
o it handles the case where changes local to one subdir have global 
  effects

W.r.t. the first point, I'm not actually sure that's true for all cases. 
the recursive build doesn't even enter directories you didn't select in 
your .config, for most people, the kernel build never even descends into 
drivers/isdn.

In the non-recursive build, make ends up with a database for all potential 
objects, and has to build the dependency tree from that. Considering that 
every single source file has in the order of 100 files it depends on, 
that's a huge job. Even with a pretty small .config, I noticed make 
growing to >64M of RAM, so I suspect this approach may cause serious 
problems on small boxes - I didn't check that, though.

The second point is a serious one, as it affects correctness. However, the 
only case I'm aware of which is hard to handle with the recursive build is
modversions (here we go again), since changing a local file (list in 
$(export-objs)) will change a file in another subdir 
(include/linux/modules/xxx).

If I'm right that this is the only such case, it can actually be handled 
be adding a recursive pass through all Makefiles which regenerates the 
checksums. Considering that it's possible to get rid of the second pass 
for building modules, this gets us back to two passes for 
CONFIG_MODVERSIONS=y and only one pass otherwise.

However, let me state that I don't know what's the best solution here. I 
can see options like
o recursive build
o non-recursive build all handled within make
o using some external program that will generate a non-recursive Makefile
  to be used with make (note that this however, could be more or less a
  trivial parser which only adds the appropriate paths to object/source
  names in the individual Makefile fragments)

I think it would be worth figuring out what works best for the majority of 
people, though.

> If you think that you can fix all the problems listed in
> http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-history.tar.bz2
> without making significant changes to the entire kbuild system, show me
> the code.

I'm not claiming to have solved all the problems, I'm claiming to be able
to solve the important ones. - in particular, correctness, i.e.
dependencies done right and clean Makefiles. I didn't look into providing
a separate tree to put the built objects into, but I think it's doable. I 
won't even try to add shadow tree capabilities, as I don't believe that's 
something which is really needed - people probably are better off learning 
how to use a SCM anyway.

> I have no patience with people who pick the small problems out of
> kbuild and fiddle with the Makefiles without considering the entire
> problem list.  That is a classic case of ignoring the big problem and
> concentrating on the little problem that you know how to fix.

Actually, I'm not doing that. I don't think getting dependencies right is
a small problem, by the way, as you seem to (assuming you mean the big
problem is the non-recursive make). Even if I was, when I have N+1
orthogonal problems, I think solving the first N one in the usual
step-by-step approach isn't a bad idea at all, it means I can actually 
concentrate on the very problem when solving the last one.

> kbuild 2.5 fixes _all_ the problems listed in the history file, except
> for modversions which will be done later.  Once you decide to fix the
> big problems, you will realise that fiddling with the old system to fix
> the little problems is a waste of time and effort.

In one paragraph you claim that leaving the hard problem for later is a 
bad idea, in the next one you do it yourself?

--Kai


