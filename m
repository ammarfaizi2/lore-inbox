Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVC2Hzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVC2Hzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVC2Hzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:55:47 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:10490 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262423AbVC2HxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:53:16 -0500
Message-ID: <4249096B.7020802@comcast.net>
Date: Tue, 29 Mar 2005 02:53:15 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Brandon Hale <brandon@smarterits.com>, ubuntu-hardened@lists.ubuntu.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ubuntu-hardened] Re: Collecting NX information
References: <42484B13.4060408@comcast.net>	 <1112035059.6003.44.camel@laptopd505.fenrus.org>	 <4248520E.1070602@comcast.net>	 <1112036121.6003.46.camel@laptopd505.fenrus.org>	 <424857B0.4030302@comcast.net>	 <1112043246.10117.5.camel@localhost.localdomain>	 <4248828B.20708@comcast.net> <1112080581.6282.1.camel@laptopd505.fenrus.org>
In-Reply-To: <1112080581.6282.1.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
>>You need to consider that in the end I'd need PT_GNU_STACK to do
>>everything PaX wants
> 
> 
> why?
> Why not have independent flags for independent things?
> That way you have both cleanness of design and you don't break anything.
> 

In the end I want to fine-tune for what the best behaviors are, and then
define exactly what the flags should do.

Right now, my rough sketch is:

MF_PAX_PAGEEXEC
  ON:   ET_EXEC enforced.  Stack NX.  Heap NX.  Code PROT_EXEC.
  OFF:  Stack and heap default to +X
  The PAGEEXEC flag will basically mandate the automated non-executable
  setting for the stack and heap.  When off, these areas are executable
  (like when PT_GNU_STACK is on)
MF_PAX_EMUTRAMP:
  ON:  Trampolines (in NX stack) and PLT will be detected and emulated
  OFF: Stack needs to be +X for trampolines to work
  The EMUTRAMP flag will basically allow certain known exceptional
  conditions to be trapped and allowed somehow automatically.  This
  includes mainly nested functions on a non-executable stack, and parisc
  procedural linkage tables (binutils patch can fix these apparently).
  This is off by default in hardmode, but on by default in soft or
  compatibility mode if PAGEEXEC is manually on.
MF_PAX_RANDMMAP:
  ON:  stack, heap, mmap() base randomized
  OFF: Nothing is randomized in memory
  RANDMMAP should probably be called "RANDADDR" instead.  When set, the
  kernel randomizes anything that can be randomized in the address
  space (support determining).
MF_PAX_RANDEXEC:
  ON:  Fixed-position things are also randomized
  OFF: Fixed-position things are at fixed positions
  RANDEXEC allows things that normally can't be placed randomly to be
  placed randomly if hacks exist to do it.  Any hacks 100% safe that
  don't cause excess overhead are for RANDMMAP; any that may cause
  instability or excessive overhead go under RANDEXEC.  OFF BY DEFAULT
  in any mode.
MF_PAX_MPROTECT:
  ON:  Enforce certain mprotect() restrictions
  OFF: Normal mprotect() restrictions
  A certain defined set of transitions and creation states are banned
  when this is on.  PaX has these now, nobody else has them and
  apparently nobody else wants them.
MF_PAX_SEGMEXEC:
  Absolutely no effect, reserved for PaX or anything else that
  implements PaX' specific SEGMEXEC emulation method.

Obviously mainline and ES won't do anything with RANDEXEC, MPROTECT, or
SEGMEXEC.

RANDMMAP will be useful to control ES and mainline ASLR (on-off switch).

PAGEEXEC being OFF will act exactly like PT_GNU_STACK being ON for
mainline and ES.

EMUTRAMP. . . I think I've got a patch for trampoline emulation, which
should let red hat use Exec Shield with fewer PT_GNU_STACK markings.
Mainline should benefit from this too.  It feels like porting this was
way too easy, so I'll ask pipacs to give it a quick look.

I also don't have a soft/hard mode for mainline.  I expect that mainline
will be more into making softmode (compatibility mode) into a
personality, which makes sense for softmode shells (which I've needed
before, i.e. to compile mono without softmoding my whole system).

Soft/Hard mode controls what flags are set by default.  Each flag has
ON/OFF/NEUTRAL settings (thus each is 2 bits).

HARDMODE:
 MF_PAX_PAGEEXEC, MF_PAX_RANDMMAP, MF_PAX_MPROTECT
SOFTMODE:
 (MF_PAX_EMUTRAMP if MF_PAX_PAGEEXEC is ON)
> 
>>The point is
>>to not break anything, yet to still make things easier for those
>>projects and distributions like Hardened Ubuntu.
> 
> 
> to achieve that you need to get the toolchain to omit this stuff
> automatically somehow. 
> 

Emit.

And there's a patch for binutils that Gentoo uses.  Ubuntu can use it too.

Remember that the way I'm doing it, PT_GNU_STACK is used if there is no
PT_PAX_FLAGS header.  Distributions not using PT_PAX_FLAGS will not care
about the kernel's ability to read PT_PAX_FLAGS, because it will still
behave the same with PT_GNU_STACK.  In other words, if Red Hat updated
the kernel with this stuff today (assuming it's non-buggy), it won't do
shit, and Fedora will still work exactly as expected.

> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCSQlqhDd4aOud5P8RAgCIAJ4hGeiHD/wcB+B6u9up4v37CT0bAwCeKgcA
zX00s0dqVkkRhnxmmzQLZq0=
=4EMG
-----END PGP SIGNATURE-----
