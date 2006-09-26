Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWIZFD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWIZFD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWIZFD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:03:26 -0400
Received: from gw.goop.org ([64.81.55.164]:44724 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750919AbWIZFDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:03:25 -0400
Message-ID: <4518B4A0.6070509@goop.org>
Date: Mon, 25 Sep 2006 22:03:28 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
References: <20060925233349.GA2352@Krystal> <20060925235617.GA3147@Krystal> <45187146.8040302@goop.org> <20060926002551.GA18276@Krystal> <20060926004535.GA2978@Krystal> <45187C0E.1080601@goop.org> <20060926025924.GA27366@Krystal>
In-Reply-To: <20060926025924.GA27366@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
>> Mathieu Desnoyers wrote:
>>     
>>> To protect code from being preempted, the macros preempt_disable and
>>> preempt_enable must normally be used. Logically, this macro must make sure 
>>> gcc
>>> doesn't interleave preemptible code and non-preemptible code.
>>>  
>>>       
>> No, it only needs to prevent globally visible side-effects from being 
>> moved into/out of preemptable blocks.  In practice that means memory 
>> updates (including the implicit ones that calls to external functions 
>> are assumed to make).
>>
>>     
>>> Which makes me think that if I put barriers around my asm, call, asm trio, 
>>> no
>>> other code will be interleaved. Is it right ?
>>>  
>>>       
>> No global side effects, but code with local side effects could be moved 
>> around without changing the meaning of preempt.
>>
>> For example:
>>
>> 	int foo;
>> 	extern int global;
>>
>> 	foo = some_function();
>>
>> 	foo += 42;
>>
>> 	preempt_disable();
>> 	// stuff
>> 	preempt_enable();
>>
>> 	global = foo;
>> 	foo += other_thing();
>>
>> Assume here that some_function and other_function are extern, and so gcc 
>> has no insight into their behaviour and therefore conservatively assumes 
>> they have global side-effects.
>>
>> The memory barriers in preempt_disable/enable will prevent gcc from 
>> moving any of the function calls into the non-preemptable region. But 
>> because "foo" is local and isn't visible to any other code, there's no 
>> reason why the "foo += 42" couldn't move into the preempt region.  
>>     
>
> I am not sure about this last statement. The same reference :
> http://developer.apple.com/documentation/DeveloperTools/gcc-4.0.1/gcc/Extended-Asm.html
>   
(This is pretty old, and this is an area which changes quite a lot.  You 
should refer to something more recent;
http://www.cims.nyu.edu/cgi-systems/info2html?/usr/local/info(gcc)Top 
for example, though in this case the quoted text looks the same.)

> I am just wondering how gcc can assume that I will not modify variables on the
> stack from within a function with a memory clobber. If I would like to do some
> nasty things in my assembly code, like accessing directly to a local variable by
> using an offset from the stack pointer, I would expect gcc not to relocate this
> local variable around my asm volatile memory clobbered statement, as it falls
> under the category "access memory in an unpredictable fashion".
>   

That not really what it means.  gcc is free to put local variables in 
memory or register, and unless you pass the local to your asm as a 
parameter, your code has no way of knowing how to find the current 
location of the local.  You could trash your stack frame from within the 
asm if you like, but I don't think gcc is under any obligation to behave 
in a deterministic way if you do.

"Unpredictable" in this case means that the memory modified isn't easily 
specified as a normal asm parameter.  For example, if you have an asm 
which does a memset(), the modified memory's size is a runtime variable 
rather than a compile-time constant.  Or perhaps your asm follows a 
linked list and modifies memory as it traverses the list.


    J
