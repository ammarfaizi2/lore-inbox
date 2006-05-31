Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965250AbWEaXOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbWEaXOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWEaXOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:14:46 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:3758 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965250AbWEaXOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:14:46 -0400
Date: Thu, 1 Jun 2006 01:15:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, mbligh@google.com,
       linux-kernel@vger.kernel.org, apw@shadowen.org, ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531231502.GA9560@elte.hu>
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org> <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org> <20060531230710.GA7484@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531230710.GA7484@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5009]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> Martin, is the box still somewhat operational after such a crash? If 
> yes then we could use my crash-tracer to see the kernel function call 
> history leading up to the crash:
> 
>   http://redhat.com/~mingo/lockdep-patches/latency-tracing-lockdep.patch
> 
> just apply the patch, accept the offered Kconfig defaults and it will 
> be configured to do the trace-crashes thing. Reproduce the crash and 
> save /proc/latency_trace - it contains the execution history leading 
> up to the crash. (on the CPU that crashes) Should work on i386 and 
> x86_64.
> 
> the trace is saved upon the first crash or lockdep assert that occurs 
> on the box. (but you'll have lockdep disabled, so it's the crash that 
> matters)

i just provoked a NULL pointer dereference with the tracer applied, and 
/proc/latency_trace contained the proper trace, leading up to the crash:

gettimeo-2333  0D... 2210us : trace_hardirqs_on (restore_nocheck)
gettimeo-2333  0.... 2210us > sys_gettimeofday (00000000 00000000 0000007b)
gettimeo-2333  0.... 2210us : sys_gettimeofday (sysenter_past_esp)
gettimeo-2333  0D... 2211us : do_page_fault (error_code)
gettimeo-2333  0D... 2211us : do_page_fault (c0123238 0 2)
gettimeo-2333  0D... 2211us : do_page_fault (10202 202 7b)
gettimeo-2333  0D... 2211us : trace_hardirqs_on (do_page_fault)
gettimeo-2333  0.... 2211us : lockdep_acquire (do_page_fault)

for best trace output you should have KALLSYMS and KALLSYMS_ALL enabled.

of course it could happen that tracing makes your crash go away ...

	Ingo
