Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWA2HLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWA2HLs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWA2HLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:11:47 -0500
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:59756 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750859AbWA2HLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:11:45 -0500
Date: Sun, 29 Jan 2006 07:12:42 +0000
From: Stuart Brady <sdbrady@ntlworld.com>
To: Grant Grundler <grundler@parisc-linux.org>,
       Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060129071242.GA24624@miranda.arrow>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060126000618.GA5592@twiddle.net> <20060126085540.GA15377@flint.arm.linux.org.uk> <20060126161849.GA13632@colo.lackof.org> <20060126164020.GA27222@flint.arm.linux.org.uk> <20060126230443.GC13632@colo.lackof.org> <20060126230353.GC27222@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126230353.GC27222@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 11:03:54PM +0000, Russell King wrote:
> Me too - already solved this problem once.  However, I'd rather not
> needlessly take a step backwards in the name of generic bitops.

Indeed.  However, I think we can actually improve bitops for some
architectures.  Here's what I've found so far:

Versions of Alpha, ARM, MIPS, PowerPC and SPARC have bit counting
instructions which we're using in most cases.  I may have missed some:

  Alpha may have:
    ctlz, CounT Leading Zeros
    cttz, CounT Trailing Zeros

  ARM (since v5) has:
    clz, Count Leading Zeros

  MIPS may have:
    clz, Count Leading Zeros
    clo, Count Leading Ones

  PowerPC has:
    cntlz[wd], CouNT Leading Zeros (for Word/Double-word)

  SPARC v9 has:
    popc, POPulation Count

PA-RISC has none.  I've not checked any others.

The Alpha, ARM and PowerPC functions look fine to me.

On MIPS, fls() and flz() should probably use CLO.  Curiously, MIPS is
the only arch with a flz() function.

On SPARC, the implementation of ffz() appears to be "cheese", and the
proposed generic versions would be better.  ffs() looks quite generic,
and fls() uses the linux/bitops.h implementation.

There are versions of hweight*() for sparc64 which use POPC when
ULTRA_HAS_POPULATION_COUNT is defined, but AFAICS, it's never defined.

The SPARC v9 arch manual recommends using popc(x ^ ~-x) for functions
like ffs().  ffz() would return ffs(~x).

I've had an idea for fls():

static inline int fls(unsigned long x)
{
	x |= x >> 1;
	x |= x >> 2;
	x |= x >> 4;
	x |= x >> 8;
	x |= x >> 16;
	return popc(x);
}

I'm not sure how that compares to the generic fls(), but I suspect it's
quite a bit faster.  Unfortunately, I don't have any MIPS or SPARC v9
hardware to test this on.

I'm not sure if this is of any use:

static inline int __ffs(unsigned long x)
{
	return (int)hweight_long(x ^ ~-x) - 1;
}

The idea being that the generic hweight_long has no branches.
-- 
Stuart Brady
