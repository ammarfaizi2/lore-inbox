Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVC2Iam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVC2Iam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVC2INR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:13:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37537 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262179AbVC2IJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:09:32 -0500
Subject: Re: [ubuntu-hardened] Re: Collecting NX information
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Brandon Hale <brandon@smarterits.com>, ubuntu-hardened@lists.ubuntu.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <4249096B.7020802@comcast.net>
References: <42484B13.4060408@comcast.net>
	 <1112035059.6003.44.camel@laptopd505.fenrus.org>
	 <4248520E.1070602@comcast.net>
	 <1112036121.6003.46.camel@laptopd505.fenrus.org>
	 <424857B0.4030302@comcast.net>
	 <1112043246.10117.5.camel@localhost.localdomain>
	 <4248828B.20708@comcast.net>
	 <1112080581.6282.1.camel@laptopd505.fenrus.org>
	 <4249096B.7020802@comcast.net>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 10:09:21 +0200
Message-Id: <1112083762.6282.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 02:53 -0500, John Richard Moser wrote:

> Right now, my rough sketch is:
> 
> MF_PAX_PAGEEXEC
>   ON:   ET_EXEC enforced.  Stack NX.  Heap NX.  Code PROT_EXEC.
>   OFF:  Stack and heap default to +X
>   The PAGEEXEC flag will basically mandate the automated non-executable
>   setting for the stack and heap.  When off, these areas are executable
>   (like when PT_GNU_STACK is on)

how is this one different from PT_GNU_STACK

> MF_PAX_EMUTRAMP:
>   ON:  Trampolines (in NX stack) and PLT will be detected and emulated
>   OFF: Stack needs to be +X for trampolines to work
>   The EMUTRAMP flag will basically allow certain known exceptional
>   conditions to be trapped and allowed somehow automatically.  This
>   includes mainly nested functions on a non-executable stack, and parisc
>   procedural linkage tables (binutils patch can fix these apparently).
>   This is off by default in hardmode, but on by default in soft or
>   compatibility mode if PAGEEXEC is manually on

do you actually need this? the number of apps that have actual
trampolines is *really really* low. At that point you get to a balance
between complexity and very limited added security. And the answer is
really not straight forward since complexity is a security risk in
itself; or more direct, by allowing this at all you in theory can open
other security holes. (note the "can" here. I'm not saying the
implementation does, but there sure is added complexity which in turn
means added chances for bugs. If the number of things that need this is
really low (and it should be) the balance isn't so clear).

> .
> MF_PAX_RANDMMAP:
>   ON:  stack, heap, mmap() base randomized
>   OFF: Nothing is randomized in memory
>   RANDMMAP should probably be called "RANDADDR" instead.  When set, the
>   kernel randomizes anything that can be randomized in the address
>   space (support determining).

This one could in theory be useful. However need info on what breaks. I
know that if you do full blown ES/PaX level randomisation the build
process of some older emacsen, and build process won't benefit from such
a flag unless you can make the toolchain insert it automatic (I suspect
that will be hard); once it's manual and during build only using setarch
is sufficient to cover that one.


> MF_PAX_RANDEXEC:
>   ON:  Fixed-position things are also randomized
>   OFF: Fixed-position things are at fixed positions
>   RANDEXEC allows things that normally can't be placed randomly to be
>   placed randomly if hacks exist to do it.  Any hacks 100% safe that
>   don't cause excess overhead are for RANDMMAP; any that may cause
>   instability or excessive overhead go under RANDEXEC.  OFF BY DEFAULT
>   in any mode.

Is this what PIE would be for? Eg if you change binaries why not just
change them to be PIE ?

> MF_PAX_MPROTECT:
>   ON:  Enforce certain mprotect() restrictions
>   OFF: Normal mprotect() restrictions
>   A certain defined set of transitions and creation states are banned
>   when this is on.  PaX has these now, nobody else has them and
>   apparently nobody else wants them.
> MF_PAX_SEGMEXEC:
>   Absolutely no effect, reserved for PaX or anything else that
>   implements PaX' specific SEGMEXEC emulation method.

Actually SELinux currently has stuff for this. Does this need to be in
the binary or would SELinux policy be enough (I assume that any hardened
linux distro nowadays also enables selinux so this question is quite
relevant).



> EMUTRAMP. . . I think I've got a patch for trampoline emulation, which
> should let red hat use Exec Shield with fewer PT_GNU_STACK markings.

actually fc4 and such don't have that many markings so I wonder what the
usefulness is. (most of the spurious markings we had in the past were
due to assembly files not being correctly marked, not due to recursive
functions)

> > to achieve that you need to get the toolchain to omit this stuff
> > automatically somehow. 
> > 
> 
> Emit.

eh yeah need coffee ;)

> 
> And there's a patch for binutils that Gentoo uses.  Ubuntu can use it too.
> 
> Remember that the way I'm doing it, PT_GNU_STACK is used if there is no
> PT_PAX_FLAGS header.

since you duplicate PT_GNU_STACK exactly it seems (well inverse meaning
but a ! in C is cheap) I think there's no point in obsoleting
PT_GNU_STACK. I realize some people see PT_GNU_STACK as an Exec-Shield
thing and thus evil, but lets ignore all that politics and stick to
facts here: No need to obsolete/remove existing things if they're not
broken and are good enough.


