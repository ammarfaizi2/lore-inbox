Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUIIL4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUIIL4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 07:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUIIL4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 07:56:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:39879 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266479AbUIIL4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 07:56:16 -0400
Subject: Re: vDSO for ppc64 : Preliminary release #3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <20040909091208.GY31909@devserv.devel.redhat.com>
References: <1094719382.2543.62.camel@gaston>
	 <20040909091208.GY31909@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1094730900.2543.73.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 21:55:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 19:12, Jakub Jelinek wrote:
> On Thu, Sep 09, 2004 at 06:43:03PM +1000, Benjamin Herrenschmidt wrote:
> >  - The current glibc code for dealing with vdso's is not completely
> > appropriate for ppc64 in particular since we do need relocations to be
> > performed on the OPD section (thanks mprotect + COW, it actually works)
> > if the library is ever mapped at a differnet address than it's native
> > 0x100000 (via the new phdr for example).
> > The current glibc code forces l_relocated to 1 for all vdso's (which is
> > fine for archs without need to relocate function descriptors).
> 
> That is on purpose, even if vDSO location is randomized (e.g. on IA-32),
> no relocations should happen, so that the vDSO can be shared (unless
> written into by the debugger, that is).  ld.so knows how to deal with
> .dynamic section relocation of vDSOs.

But not with function descriptors... on archs like ppc64, a function
symbol is actually a descriptor containing the absolute address of
the actual code and the TOC pointer. (For the vDSO, the TOC pointer
is always 0 though, routines in there don't need a TOC).

So those descriptors (in the OPD section) need to be relocated if
the vDSO is mapped at it's non-native address. It works fine since
ld.so will do mprotect() on it, and the kernel implementation I've
done on ppc do support COW when mprotect enables write access. It's
also not a default case as I only expect a few apps, like emulators
and/or maybe the JVM, to request a different location because they
need finer control on their address space (unless we want randomizing
though).

So unless we change the ABI to those calls, we have to allow
relocation to happen, on ppc64.

Ulrich proposed that instead, I export the vDSO symbols as absolute
symbols containing an offset from the start of the vDSO itself. I
have to check how to generate those, but that would mean we lose the
nice "feature" of the vDSO beeing just a normal library and require
special jump trampolines to call the routines in there...

Ben.


