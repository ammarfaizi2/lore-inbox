Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315467AbSEBXks>; Thu, 2 May 2002 19:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSEBXkr>; Thu, 2 May 2002 19:40:47 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:62213 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315467AbSEBXkr>;
	Thu, 2 May 2002 19:40:47 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Thu, 02 May 2002 10:40:49 EST."
             <Pine.LNX.4.44.0205021027340.32217-100000@chaos.physics.uiowa.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 09:40:34 +1000
Message-ID: <802.1020382834@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002 10:40:49 -0500 (CDT), 
Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> wrote:
>Well Keith's statement (as I read it) is: modversions are broken, I don't 
>support them. My statement is: modversions work 95% of the time, why throw 
>them out?

Build a complete kernel with modversions.  Apply a patch or change a
config option that changes a structure size.  make bzImage, reboot.
modversions are _not_ rebuilt.  The kernel and modules were built using
different ABIs but modversions claims that they are identical.

Third party code is built using a copy of .config and modversions.h.
This assumes that modversions.h was generated using the same .config,
but it is not checked.  The module _may_ have used a different config
but asserts it was built using the same ABI as the kernel (same
modversions).  Result is a module that appears to match the kernel,
when really all you know is that the user claims it matches the kernel.

People think that modversions gives a strong check on ABI compatibility
for third party modules.  Wrong!  What it really gives is a weak
assumption that the user copied two files that are in sync.

Modversions only detect ABI changes if you make mrproper after any
change that affects the symbol versions.  That has to be done manually,
it cannot be automated.  Generation of new symbol versions requires a
recompile of everything marked export-objs after any source or config
change.  But there is no way of telling where the versioned symbols are
consumed, so any change to any versioned symbol requires a complete
kernel rebuild to ensure that every consumer picks up the new version.

Make any change, make mrproper, rebuild from scratch, it is the only
way to ensure that modversions are correct.  Modversions are fine for
distributors, a pain in the neck for everybody else.

95% working?  More like 95% broken!

I know how to do ABI versioning right.  But there is no chance of me
starting work on the correct method of ABI versioning until kbuild 2.5
is in.

>If Keith went like fixing issues one at a time, he wouldn't have that huge 
>patch now, which replaces everything and is hard to keep up-to-date. 
>There's a lot of orthogonal issues with kbuild which can be solved one at 
>a time, e.g. correct dependency generation, cleaning up Makefiles (like 
>getting rid of the explicit list-multi link rules), spurious rebuilds, 
>building built-in and modular objects in one pass, non-recursive make, ...

I have been waiting for somebody to raise the "why not do one bit a
time" argument for kbuild.  That is exactly what I have done!

Modversions are completely broken but are not required for a
development kernel, they will be done later.  There are 89 'FIXME'
comments in the Makefile.in files where changes to source code should
be done to clean up the include mess, those changes will be done later.

Changing from a recursive to non-recursive make is the big change in
kbuild 2.5.  If you think that you can do non-recursive make without
significant changes to the Makefiles, show me the code.

If you think that you can fix all the problems listed in
http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-history.tar.bz2
without making significant changes to the entire kbuild system, show me
the code.

I have no patience with people who pick the small problems out of
kbuild and fiddle with the Makefiles without considering the entire
problem list.  That is a classic case of ignoring the big problem and
concentrating on the little problem that you know how to fix.

kbuild 2.5 fixes _all_ the problems listed in the history file, except
for modversions which will be done later.  Once you decide to fix the
big problems, you will realise that fiddling with the old system to fix
the little problems is a waste of time and effort.

