Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWISPNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWISPNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWISPN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:13:29 -0400
Received: from smtp-out.google.com ([216.239.33.17]:39558 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750832AbWISPN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:13:29 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=mYVAvoW9HrvAVJ/DGmclkwswNx8Cx+bRh/awtXO5nQOYCbagkEOVghq3YeVM1JKvX
	gwAhGLW4HesiJx6qli+5g==
Message-ID: <451008AC.6030006@google.com>
Date: Tue, 19 Sep 2006 08:11:40 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu>
In-Reply-To: <20060919081124.GA30394@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
>> +choice
>> +	prompt "MARK code marker behavior"
> 
>> +config MARK_KPROBE
>> +config MARK_JPROBE
>> +config MARK_FPROBE
>> +	Change markers for a function call.
>> +config MARK_PRINT
> 
> as indicated before in great detail, NACK on this profileration of 
> marker options, especially the function call one. I'd like to see _one_ 
> marker mechanism that distros could enable, preferably with zero (or at 
> most one NOP) in-code overhead. (You can of course patch whatever 
> extension ontop of it, in out-of-tree code, to gain further performance 
> advantage by generating direct system-calls.)
> 
> There might be a hodgepodge of methods and tools in userspace to do 
> debugging, but in the kernel we should get our act together and only 
> take _one_ (or none at all), and then spend all our efforts on improving 
> that primary method of debug instrumentation. As kprobes/SystemTap has 
> proven, it is possible to have zero-overhead inactive probes.
> 
> Furthermore, for such a patch to make sense in the upstream kernel, 
> downstream tracing code has to make actual use of that NOP-marker. I.e. 
> a necessary (but not sufficient) requirement for upstream inclusion (in 
> my view) would be for this mechanism to be used by LTT and LKST. (again, 
> you can patch LTT for your own purposes in your own patchset if you 
> think the performance overhead of probes is too much)

You know ... it strikes me that there's another way to do this, that's
zero overhead when not enabled, and gets rid of the inflexibility in
kprobes. It might not work well in all cases, but at least for simple
non-inlined functions, it'd seem to.

Why don't we just copy the whole damned function somewhere else, and
make an instrumented copy (as a kernel module)? Then reroute all the
function calls through it, instead of the original version. OK, it's
not completely trivial to do, but simpler than kprobes (probably
doing the switchover atomically is the hard part, but not impossible).
There's NO overhead when not using, and much lower than probes when
you are.

That way we can do whatever the hell we please with internal variables,
however GCC optimises it, can write flexible instrumenting code to just
about anything, program in C as God intended, etc, etc. No, it probably
won't fix every case under the sun, but hopefully most of them, and we
can still use kprobes/djprobes/bodilyprobes for the rest of the cases.

M.
