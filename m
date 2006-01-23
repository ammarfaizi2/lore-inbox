Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWAWUbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWAWUbW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWAWUbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:31:13 -0500
Received: from mail.gmx.net ([213.165.64.21]:35041 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964955AbWAWUam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:30:42 -0500
X-Authenticated: #428038
Date: Mon, 23 Jan 2006 21:30:10 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060123203010.GB1820@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	arjan@infradead.org, linux-kernel@vger.kernel.org
References: <20060123105634.GA17439@merlin.emma.line.org> <1138014312.2977.37.camel@laptopd505.fenrus.org> <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43D530CC.nailC4Y11KE7A@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-23:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > On Mon, 23 Jan 2006, Arjan van de Ven wrote:
> >
> > > hmm... curious that mlockall() succeeds with only a 32kb rlimit....
> >
> > It's quite obvious with the seteuid() shuffling behind the scenes of the
> > app, for the mlockall() runs with euid==0, and the later mmap() with euid!=0.
> >
> > Clearly the application should do both with the same privilege or raise
> > the RLIMIT_MEMLOCK while running with privileges.
> >
> > The question that's open is one for the libc guys: malloc(), valloc()
> > and others seem to use mmap() on some occasions (for some allocation
> > sizes) - at least malloc/malloc.c comments as of 2.3.4 suggest so -, and
> > if this isn't orthogonal to mlockall() and set[e]uid() calls, the glibc
> > is pretty deeply in trouble if the code calls mlockall(MLC_FUTURE) and
> > then drops privileges.
> 
> If the behavior described by Matthias is true for current Linuc kernels,
> then there is a clean bug that needs fixing.

Jörg elided my lines that said valloc() was the function in question.

Jörg, if we're talking about valloc(), this hasn't much to do with the
kernel, but is a library issue.

There is _no_ documentation that says valloc() or memalign() or
posix_memalign() is required to use mmap(). It works on some systems and
for some allocation sizes as a side effect of the valloc()
implementation.

And because this requirement is not specified in the relevant standards,
it is wrong to assume valloc() returns locked pages. You cannot rely on
mmap() returning locked pages after mlockall() either, because you might
be exceeding resource limits.

> If the Linux kernel is not willing to accept the contract by 
> mlockall(MLC_FUTURE), then it should now accept the call at all.

If the application wants locked pages, it either needs to call mmap()
explicitly, or use mlock() on the valloc()ed region. Even then,
allocation or mlock may fail due to resource constraints. I checked
FreeBSD 6-STABLE i386, Solaris 8 FCS SPARC and SUSE Linux 10.0 i386 on
this.

> In our case, the kernel did accept the call to mlockall(MLC_FUTURE), but later 
> ignores this contract. This bug should be fixed.

The complete story is, condensed, and with return values, for a
setuid-root application:

  geteuid() == 0;
  mlockall(MLC_CURRENT|MLC_FUTURE) == (success);
  seteuid(500) == (success);
  valloc(64512 + pagesize) == NULL (failure);

Jörg, correct me if the valloc() figure is wrong.

valloc() called mmap() internally, tried to grab 1 MB, and failed with
EAGAIN - as we were able to see from the strace.

SuSE Linux 10.0, kernel 2.6.13-15.7-default #1 Tue Nov 29 14:32:29 UTC 2005
on i686 athlon i386 GNU/Linux

-- 
Matthias Andree
