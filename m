Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVCPIaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVCPIaW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 03:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVCPIaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 03:30:22 -0500
Received: from mx1.elte.hu ([157.181.1.137]:29339 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262291AbVCPIaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 03:30:09 -0500
Date: Wed, 16 Mar 2005 09:28:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050316082851.GB10260@elte.hu>
References: <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu> <20050315112712.GA3497@elte.hu> <20050315130046.GK7699@opteron.random> <20050315150526.GA14744@elte.hu> <20050315164420.GT7699@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315164420.GT7699@opteron.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@cpushare.com> wrote:

> Oe Tue, Mar 15, 2005 at 04:05:26PM +0100, Ingo Molnar wrote:
> > ugh? Where do i claim any such thing?
> 
> You never said such a thing, but you said you believe it's not
> provable that sys_read/write and hardware irq processing is secure in
> linux, so I wanted to get some statistical significance about your
> claim from you just in case I was missing something.  I obviously
> can't have in memory every single bug since 2.4.0.

in fact, we had bugs on x86 where if userspace set up a specific value
for %ebx the kernel would crash, because the irq entry code was
incorrect. (this might even have been exploitable) So yes, if seccomp
would be backported to that kernel, seccomp would be vulnerable too.

but this is not what i meant, what i meant was this:

> > [...] It is also intentionally simple,
> > and hence maybe even provably secure from a Comp-Sci POV.
> > (assuming sys_read()/sys_write() and hardware-irq processing itself 
> > is secure, which quite likely wont be provable in the foreseeable 
> > future).

'provable' here means provable mathematically, as done in computer
science. Not 'provable via good track record'. So what i said was in
fact a compliment towards seccomp: i believe that as long as we assume
certain external mechanisms (the whole hardware environment, and all
irq/rest-of-kernel and read/write mechanisms) to be secure, the basic
seccomp code itself (those 100-200 lines of code), _may_ be provably
secure, mathematically. That would be a nice thing to have.

obviously the irq and sys_read/sys_write code is way too complex to be
mathematically provable in the near future.

> > while we are at it, please mention a single ptrace bug in the same
> > timeframe that could allow a bytecode 'client' to escape a ptrace
> > TRACE_SYSCALL jail at will.
> 
> There was this bug around 2.4.10, IIRC a SIGCONT could let the ptraced
> task to continue executing. I don't want to depend on other
> applications not to send a signal by mistake to the ptraced task.

sorry, but if an attacker can cause arbitrary signals to be sent to your
secure application (and the signals pass the security checks!) then you
have much bigger problems!

this is what i feel is unfair: you are (unintentionally, i presume)
mixing the security of the 'totality of ptrace APIs' with the security
model that 'untrusted bytecode' is in.

> The interesting point is that no app out there (except uml) becomes
> exploitable if you find some hole in TRACE_SYSCALL (at worse strace
> will screwup a bit). I don't think an huge amount of research has been
> done in those code paths (unlike it happened in mremap and many other
> kernel APIs). [...]

so your solution is to introduce a whole new API that duplicates much of
what ptrace can already do, with just about the same amount of risk? So
your solution is to leave UML out in the cold (and thus increasing risks
altogether), by having a crippled mechanism that UML could never use?
That i call a selfish NIH syndrome, not a security accomplishment.

but, i dont mind your code being in the kernel, for the reasons i
stated, as long as the anti-ptrace fallacy is clearly understood. So you
might have partly succeeded in social engineering your security feature
into the kernel (feel the irony?), but i'm trying to counter what i
believe to be false premises. Ptrace has its fundamental security
problems, but PTRACE_TRACE is not nearly as bad and should not be
confused with the kernel holes caused by other, security-independent
ptrace debug mechanisms.

	Ingo
