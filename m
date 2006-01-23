Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWAWVYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWAWVYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWAWVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:24:54 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:45229 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S964825AbWAWVYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:24:54 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 23 Jan 2006 22:23:54 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <43D5496A.nailC6M11I8M8@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner>
 <20060123203010.GB1820@merlin.emma.line.org>
In-Reply-To: <20060123203010.GB1820@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> > If the behavior described by Matthias is true for current Linuc kernels,
> > then there is a clean bug that needs fixing.
>
> Jörg elided my lines that said valloc() was the function in question.
>
> Jörg, if we're talking about valloc(), this hasn't much to do with the
> kernel, but is a library issue.

>From my understanding, the problem is that Linux first grants the 
mlockall(MLC_FUTURE) call and later ignores this contract.

The fact that valloc() works in a way that is not comprehensible
seems to be another issue. Libscg calls valloc(size) where size is less than
64 KB. From the strace output from Matthias, it looks like valloc first calls 
brk() to extend the size of the data segment (probably to aproach the next
pagesize aligned border) and later calls mmap() to get 1 MB or memory.
Well first it seems that valloc() tries to get too much memory but this 
is another story.

Inside the kernel handler for this call, the permission to lock the new 
memory _again_ checks for permission and this is wrong as the request
for locking all future pages of the process already has been granted.

This looks similar to when I open() a file that may only be opened as root
and late switch my uid to some other id. If read() would be implemented the 
same way as Linux implements the locking, each read() call would again check
whether the current uid would have permission to get access to the fd from a 
filename. This is obviously wrong. The _process_ has been granted the rights 
to mlock all future pages and this is something that needs to be nonored until 
the process dies.

> There is _no_ documentation that says valloc() or memalign() or
> posix_memalign() is required to use mmap(). It works on some systems and
> for some allocation sizes as a side effect of the valloc()
> implementation.

The problem seems to be independend how valloc() is implemented.


> And because this requirement is not specified in the relevant standards,
> it is wrong to assume valloc() returns locked pages. You cannot rely on
> mmap() returning locked pages after mlockall() either, because you might
> be exceeding resource limits.

If there were such resource limits, then they would need to be honored
regardless of the privileges of the process.


> > If the Linux kernel is not willing to accept the contract by 
> > mlockall(MLC_FUTURE), then it should now accept the call at all.
>
> If the application wants locked pages, it either needs to call mmap()
> explicitly, or use mlock() on the valloc()ed region. Even then,
> allocation or mlock may fail due to resource constraints. I checked
> FreeBSD 6-STABLE i386, Solaris 8 FCS SPARC and SUSE Linux 10.0 i386 on
> this.

What did you check?

Solaris does not check for any privileges whan calling mmap()

Solaris implements mlockall() via memcntl which contains the only 
place where a check for secpolicy_lock_memory(CRED()) takes place.

> > In our case, the kernel did accept the call to mlockall(MLC_FUTURE), but later 
> > ignores this contract. This bug should be fixed.
>
> The complete story is, condensed, and with return values, for a
> setuid-root application:
>
>   geteuid() == 0;
>   mlockall(MLC_CURRENT|MLC_FUTURE) == (success);
>   seteuid(500) == (success);
>   valloc(64512 + pagesize) == NULL (failure);
>
> Jörg, correct me if the valloc() figure is wrong.
>
> valloc() called mmap() internally, tried to grab 1 MB, and failed with
> EAGAIN - as we were able to see from the strace.

This is correct.

Returning EAGAIN seems to be a result of missunderstanding the POSIX
standard. The POSIX standard means real hardware resources when talking about

EAGAIN] 
        [ML]  The mapping could not be locked in memory, if required by 
	mlockall(), due to a lack of resources.  

If linux likes to ass a new RLIMIT_MEMLOCK resource, it would be needed to 
honor this resource independent from the user id in order to prevent being 
contradictory.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
