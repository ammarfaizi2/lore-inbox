Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbWEaXGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbWEaXGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWEaXGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:06:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:24810 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965229AbWEaXGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:06:52 -0400
Date: Thu, 1 Jun 2006 01:07:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, mbligh@google.com,
       linux-kernel@vger.kernel.org, apw@shadowen.org, ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060531230710.GA7484@elte.hu>
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org> <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531144310.7aa0e0ff.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5012]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > >>The x86_65 panic in LTP has changed a bit. Looks more useful now.
> > >>Possibly just unrelated new stuff. Possibly we got lucky.
> > > 
> > > What are you doing to make this happen?
> > 
> > runalltests on LTP
> > 
> 
> We have to get to the bottom of this - there's a shadow over about 500 
> patches and we don't know which.
> 
> iirc I tried to reproduce this a couple of weeks back and failed.

Martin, is the box still somewhat operational after such a crash? If yes 
then we could use my crash-tracer to see the kernel function call 
history leading up to the crash:

  http://redhat.com/~mingo/lockdep-patches/latency-tracing-lockdep.patch

just apply the patch, accept the offered Kconfig defaults and it will be 
configured to do the trace-crashes thing. Reproduce the crash and save 
/proc/latency_trace - it contains the execution history leading up to 
the crash. (on the CPU that crashes) Should work on i386 and x86_64.

the trace is saved upon the first crash or lockdep assert that occurs on 
the box. (but you'll have lockdep disabled, so it's the crash that 
matters)

if the box dies after a crash then there's a possibility to print the 
execution history to the serial console - but that takes around 10-15 
minutes even on 115200 baud. If you want/need to do this then edit 
kernel/latency.c and change "trace_print_at_crash = 0" to 
"trace_print_at_crash = 1".

(btw., the tracer has another neat feature as well: if a kernel crashes 
or triple faults (and reboots) early during bootup, then the tracer can 
be configured to print all function calls to the serial console, via 
early_printk() - right when the function calls happen. I debugged 
numerous nasty boot-time bugs via this. To set it, change 
"print_functions = 0" to "print_functions = 1" in kernel/latency.c.)

	Ingo
