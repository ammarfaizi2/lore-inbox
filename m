Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbUCRSXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbUCRSXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:23:31 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4544 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262843AbUCRSX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:23:29 -0500
Date: Thu, 18 Mar 2004 19:24:07 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: sched_setaffinity usability
Message-ID: <20040318182407.GA1287@elte.hu>
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu> <20040318120709.A27841@infradead.org> <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> sysconf() is a user-level implementation issue, and so is something
> like "number of CPU's". Damn, the simplest way to do it is as a
> environment variable, for christ sake! Just make a magic environment
> variable called __SC_ARRAY, and make it be some kind of binary
> encoding if you worry about performance.

i am not arguing for any sysconf() support at all - it clearly belongs
into glibc. Just doing 'man sysconf' shows that it should be in
user-space. No argument about that.

But how about the original issue Ulrich raised: how does user-space
figure out the NR_CPUS value supported by the kernel? (not the current #
of CPUs, that can be figured out using /proc/cpuinfo)

one solution would be what you suggest: to build some sort of /etc/info
file that glibc can access, which file is build during the kernel build
and contains the necessary constants. One problem with this approach is
that a user could boot via any arbitrary kernel, how does glibc (or even
a supposed early-init info-setup mechanism) know what info belongs to
which kernel? Kernel version numbers are not required to be unique. A
single non-modular bzImage can be used to have a fully working
userspace. Right now the kernel and glibc is isolated pretty much and
this gives us flexibility.

an environment variable is a similar solution and has the same problem:
it has to be generated somehow from the kernel's info, just like the
info file. As such it breaks the single-image concept, and the kernel
image and the 'metadata' can get detached.

but there's a clean solution i believe, a convenient object that we
already generate during kernel builds: the VDSO. It's mapped by the
kernel during execve() [or, in current kernels, is inherited via the
kernel mappings], and thus becomes a pretty fast (zero-copy) method of
having a kernel-specific user-space dynamic object. It's structured in
the most convenient (and thus, fastest, and most portable) way for
glibc's purposes. ld.so recognizes and uses it. It cannot be
misconfigured by the user, it comes with the kernel. It is included in a
single bzImage kernel just as much as a kernel rpm.

Right now the VDSO mostly contains code and exception-handling data, but
it could contain real, userspace-visible data just as much: info that is
only known during the kernel build. There's basically no cost in adding
more fields to the VDSO, and it seems to be superior to any of the other
approaches. Is there any reason not to do it?

	Ingo
