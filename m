Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbUCRVpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUCRVpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:45:53 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62124 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262969AbUCRVpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:45:52 -0500
Date: Thu, 18 Mar 2004 22:46:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: sched_setaffinity usability
Message-ID: <20040318214646.GA12865@elte.hu>
References: <20040318182407.GA1287@elte.hu> <Pine.LNX.4.44.0403181302460.8512-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403181302460.8512-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-3.229, required 5.9,
	BAYES_00 -4.90, NO_COST 1.67
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Davide Libenzi <davidel@xmailserver.org> wrote:

> > Right now the VDSO mostly contains code and exception-handling data, but
> > it could contain real, userspace-visible data just as much: info that is
> > only known during the kernel build. There's basically no cost in adding
> > more fields to the VDSO, and it seems to be superior to any of the other
> > approaches. Is there any reason not to do it?
> 
> With /proc/something you can have a single piece of code for all archs
> that exports NR_CPUS. The VDSO should be added to all missing archs.
> IMO performance is not an issue in getting NR_CPUS from userspace.

you just cannot beat the mapping performance of a near-zero-overhead
(V)DSO. No copying. No syscalls to set it up. No runtime dependencies on
having some filesystem mounted in the right spot. Already existing
framework to handle various API issues. Debuggers know the layout.

glibc could in theory boot-time assemble a /etc/vdso.so file and
open()/mmap()/close() it and then pagefault it in, which would be
roughly +10% to the cost of an exec(). I find it hard to accept that if
the best access method to this information by glibc is a DSO, and that
the source of the information is the kernel and only the kernel, that
glibc has to resort to some inferior method to access this information.
[not to mention the practical problem of readonly or remote /etc, so one
would have to mount ramfs, and mount /proc to construct /ram/vdso.so.
Also, nothing runtime-critical can thus be put into the vdso.]

it could also be in /boot/modules/$ver/vdso.so, but this detaches the
vdso from the kernel, breaking the single-image kernel concept (which
concept is quite useful). It also forces glibc to do the uname() syscall
to get to the kernel version in addition to the DSO mapping syscalls -
again an inferior method to access this always-needed DSO.

	Ingo
