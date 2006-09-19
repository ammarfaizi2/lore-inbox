Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751873AbWISRSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWISRSx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWISRSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:18:53 -0400
Received: from smtp-out.google.com ([216.239.45.12]:13965 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751873AbWISRSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:18:52 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=oxrBR8cUO7TrvHXNqUZekSnt1AXBJTCM0K3047i8Y24RZG3qrSpndo3Y4O1UBrnJu
	ODI6KdsBba77cDa4Knp3A==
Message-ID: <45102641.7000101@google.com>
Date: Tue, 19 Sep 2006 10:17:53 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com>
In-Reply-To: <20060919063821.GB23836@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>It seems like all we'd need to do
>>>>is "list all references to function, freeze kernel, update all
>>>>references, continue"
>>>
>>>
>>>"overwrite first 5 bytes of old function with `jmp new_function'".
>>
>>Yes, that's simple. but slower, as you have a double jump. Probably
>>a damned sight faster than int3 though.
> 
> 
> The advantage of using int3 over jmp to launch the instrumented
> module is that int3 (or breakpoint in most architectures) is an
> atomic operation to insert.

Ah, good point. Though ... how much do we care what the speed of
insertion/removal actually is? If we can tolerate it being slow,
then just sync everyone up in an IPI to freeze them out whilst
doing the insert.

> I am getting some more ideas...
>                                                                                                                                                
> 1. Copy the original functions, instrument them and insert them as
> a part of kernel module with different name prefix.
> 2. Insert breakpoint only on those routines at runtime.
> 3. When the breakpoint gets hit, change the instruction pointer to
> the instrumented routine.  No need to single step at all.

Surely this still carries the overhead of doing the breakpoint,
which was part of what we were trying to get away from? I suppose
we get more flexibility this way. Or does the slowness not actually
come from the int3, but only the single-stepping?

How about we combine all three ideas together ...

1. Load modified copy of the function in question.
2. overwrite the first instruction of the routine with an int3 that
does what you say (atomically)
3. Then overwrite the second instruction with a jump that's faster
4. Now atomically overwrite the int3 with a nop, and let the jump
take over.

> Adv:
> Can be enabled/disabled dynamically by inserting/removing
> breakpoints.  No overhead of single stepping.
> No restriction of running the handler in interrupt context.
> You can have pre-compiled instrumented routines.
> This mechanism can be used for pre-defined set of routines and for
> arbiratory probe points, you can use kprobes/jprobes/systemtap.
> No need to be super-user for predefined breakpoints.
>                                                                                                                                                
> Dis:
> Maintainence of the code, since it can code base need to be
> duplicated and instrumented.

CONFIG_FOO_BAR .... turn it on or off to turn on the instrumentation.
compiled out by default. Compiled in when making the tracing functions.

> The above idea is similar to runtime or dynamic patching, but here we
> use int3(breakpoint) rather than jump instruction.

Depends what we're trying to fix. I was trying to fix two things:

1. Flexibility - kprobes seem unable to access all local variables etc
easily, and go anywhere inside the function. Plus keeping low overhead
for doing things like keeping counters in a function (see previous
example I mentioned for counting pages in shrink_list).

2. Overhead of the int3, which was allegedly 1000 cycles or so, though
faster after Ingo had played with it, it's still significant.

M.
