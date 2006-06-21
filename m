Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWFUIUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWFUIUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 04:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWFUIUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 04:20:48 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:23526 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932487AbWFUIUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 04:20:46 -0400
Date: Wed, 21 Jun 2006 10:15:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Message-ID: <20060621081539.GA14227@elte.hu>
References: <200606210329_MC3-1-C305-E008@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606210329_MC3-1-C305-E008@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5010]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chuck Ebbert <76306.1226@compuserve.com> wrote:

> Use a GDT entry's limit field to store per-cpu data for fast access 
> from userspace, and provide a vsyscall to access the current CPU 
> number stored there.

very nice idea! I thought of doing sys_get_cpu() too, but my idea was to 
use the scheduler to keep a writable [and permanently pinned, 
per-thread] VDSO data page uptodate with the current CPU# [and other 
interesting data]. Btw., do we know how fast LSL is on modern CPUs?

> Questions:
>  1. Will the vdso relocation patch break this?

no - why should it?

>  2. Should the version number of the vsyscall .so be incremented?

i've Cc:-ed the glibc folks.

but my gut feeling is that we should add a proper sys_get_cpu() syscall 
as well, and thus make this a transparent syscall, not dependent on the 
availability of the vDSO.

> +__vgetcpu:
> +.LSTART_vgetcpu:
> +	movl $-EFAULT,%eax
> +	movl $((27<<3)|3),%edx
> +	lsll %edx,%eax
> +	jnz 1f
> +	andl $0xff,%eax
> +1:
> +	ret

this needs unwinder annotations as well to make this a proper DSO, so 
that for example a breakpoint here does not confuse gdb.

also, would be nice to do something like this in 64-bit mode too.

	Ingo
