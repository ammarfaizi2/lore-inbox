Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWAWWFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWAWWFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWAWWFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:05:47 -0500
Received: from mail.gmx.net ([213.165.64.21]:5351 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964954AbWAWWFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:05:46 -0500
X-Authenticated: #428038
Date: Mon, 23 Jan 2006 23:05:41 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060123220541.GA16114@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org, arjan@infradead.org
References: <20060123105634.GA17439@merlin.emma.line.org> <1138014312.2977.37.camel@laptopd505.fenrus.org> <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org> <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <20060123203010.GB1820@merlin.emma.line.org> <43D5496A.nailC6M11I8M8@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43D5496A.nailC6M11I8M8@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-23:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > > If the behavior described by Matthias is true for current Linuc kernels,
> > > then there is a clean bug that needs fixing.
> >
> > Jörg elided my lines that said valloc() was the function in question.
> >
> > Jörg, if we're talking about valloc(), this hasn't much to do with the
> > kernel, but is a library issue.
> 
> From my understanding, the problem is that Linux first grants the 
> mlockall(MLC_FUTURE) call and later ignores this contract.
...
> Inside the kernel handler for this call, the permission to lock the new 
> memory _again_ checks for permission and this is wrong as the request
> for locking all future pages of the process already has been granted.

I *do* think that the kernel refused our mmap() request on grounds of
the RLIMIT_MEMLOCK (32 kB) and not any other reason, because running the
same allocation code as root succeeds, and Linux 2.6.13 is documented to
ignore RLIMIT_MEMLOCK for the super-user.

And I do believe Linux is entirely on IEEE Std 1003.1-2001 grounds here.

> > There is _no_ documentation that says valloc() or memalign() or
> > posix_memalign() is required to use mmap(). It works on some systems and
> > for some allocation sizes as a side effect of the valloc()
> > implementation.
> 
> The problem seems to be independend how valloc() is implemented.

As far as the kernel is concerned, yes.

As far as your application is concerned, valloc() does not provide
"mapped" or "locked" pages, but "allocated".

> > And because this requirement is not specified in the relevant standards,
> > it is wrong to assume valloc() returns locked pages. You cannot rely on
> > mmap() returning locked pages after mlockall() either, because you might
> > be exceeding resource limits.
> 
> If there were such resource limits, then they would need to be honored
> regardless of the privileges of the process.

That's a different story.

> > > If the Linux kernel is not willing to accept the contract by 
> > > mlockall(MLC_FUTURE), then it should now accept the call at all.
> >
> > If the application wants locked pages, it either needs to call mmap()
> > explicitly, or use mlock() on the valloc()ed region. Even then,
> > allocation or mlock may fail due to resource constraints. I checked
> > FreeBSD 6-STABLE i386, Solaris 8 FCS SPARC and SUSE Linux 10.0 i386 on
> > this.
> 
> What did you check?

The mlockall() documentation. Any OS allows later mappings to fail if
they cannot be locked, and this is what happens.

The only troublesome spot that remains is valloc() using mmap()
internally, which inherits the mlockall()/mmap() failure modes and
causes bogus "out of memory" returns by valloc().

1. valloc is not required to lock pages
2. yet it can fail if it cannot lock pages

This is a problem from the applications POV, albeit one that is in
glibc's memory allocator.

mlockall() does NOT make promises HOW MUCH memory may be allocated in
the future, and that is the problem at hand. Linux allows us 32 kB (as
unprivileged user even, we don't get that with Solaris or FreeBSD!), but
we want 63 kB and Linux says "Sorry, you can't have that. EAGAIN"

> Returning EAGAIN seems to be a result of missunderstanding the POSIX
> standard. The POSIX standard means real hardware resources when talking about

Well... mlockall() allows for, "other implementation-defined limit[s]",
so POSIX is not supportive of your argument here.

> EAGAIN] 
>         [ML]  The mapping could not be locked in memory, if required by 
> 	mlockall(), due to a lack of resources.  
> 
> If linux likes to ass a new RLIMIT_MEMLOCK resource, it would be needed to 
> honor this resource independent from the user id in order to prevent being 
> contradictory.

This is irrelevant to cdrecord, because it does not trip over this
contradiction.

If I were the cdrecord maintainer, I'd forget about mlockall()
altogether because it's just too broad and doesn't allow something like
"no more auto locking" without unlocking all locked pages (see also Lee
Revell's earlier post), lock the FIFO, command data buffers and
everything explicitly through mlock(), set the scheduler, open the
device and then call setuid() to get rid of the saved set-user-id as
well. This may be narrow-minded, but given mlock() is present in the BSD
world (FreeBSD, NetBSD), in the SysV world (Solaris) and Linux, there's
reason to support it, as these constitute a large user base.

If anything then still fails (command filter), I'd ask the kernel guys
how the restriction can be lifted so that cdrecord can work without ANY
root privileges, in the most portable way.

-- 
Matthias Andree
