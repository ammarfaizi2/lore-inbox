Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUI2Ij4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUI2Ij4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 04:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268271AbUI2Ij4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 04:39:56 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:45444 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S268269AbUI2Iju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 04:39:50 -0400
Date: Wed, 29 Sep 2004 01:42:12 -0700
From: Hui Huang <Hui.Huang@Sun.COM>
Subject: Re: heap-stack-gap for 2.6
In-reply-to: <20040928141914.GE2412@dualathlon.random>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Message-id: <415A7564.2090909@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
References: <20040925162252.GN3309@dualathlon.random>
 <415903E4.1030808@sun.com> <20040928141914.GE2412@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, Sep 27, 2004 at 11:25:40PM -0700, Hui Huang wrote:
> 
>>Andrea Arcangeli wrote:
>>
>>>This patch enforces a gap between heap and stack, both on the mmap side
>>>(for heap) and on the growsdown page faults for stack. the gap is in
>>>page units and it's sysctl configurable. Against CVS head.
>>>
>>>This is needed for some critical app, that wants an higher degree of
>>>protection against potential stack overflows from the kernel. This is
>>>mostly a 32bit matter of course, since on 32bit those apps are using
>>>a few gigs of heap and they get as near as they can to the stack (but if
>>>something goes wrong a page fault must happen).
>>>
>>>
>>>the default value of 1 avoids userspace apps like java to break,
>>
>>Ok, I'm a JVM guy and I worked on heap-stack-gap issue many moons ago.
>>The reason that heap-stack-gap on SuSE Linux used to crash Java is
>>because we are explicitly setting up a guard page to prevent heap-stack
>>collision (a stack guard is also required in order to throw stack
>>overflow exception). So in a java program, prev_vma in your patch does
>>not point to regular heap memory but the guard page. The hidden gap
>>would cause SIGSEGV to occur before the thread actually hits the guard,
> 
> 
> this however doesn't offer the protection on the mmap side, but maybe
> you limit the amount of mmaps with another logic.

Hi Andrea,

Java heap is managed by JVM, its address space is reserved upfront
and does not grow or shrink. Our problem is mainly on the stack side.

> 
> 
>>that confused JVM. We had to work around it by reading the gap size from
>>/proc.
> 
> 
> cool, so you're already using this heap-stack-gap API. Then maybe we
> could increase the size to more than 1 page. 1 page is the minimum,
> infact those apps asking for the feature have to increase it by hand in
> /proc.
> 

Should be Ok. But our "fix" only handles heap-stack-gap in a special
case. The problem is we only know the gap size, not its location.
We would have to know if a thread has MAP_GROWSDOWN stack or not to
tell if it has a gap near the stack end. Basically, we assume only
the main thread stack is MAP_GROWSDOWN and every other thread is
created with MAP_FIXED stack (i.e. the gap only exists in main
thread stack). Otherwise we wouldn't be able to tell if a SEGV is
due to stack overflow in the heap-stack-gap or something else.
It's not ideal, but works as long as LinuxThreads or NPTL don't
change back to MAP_GROWSDOWN.

> 
>>I'd recommend adding an extra check to see if prev_vma is read/write,
>>and ignoring heap-stack-gap if prev_vma is guard page. Having a hidden
>>gap does not offer any extra protection, it only confuses an application
>>if it manages stack guard.
> 
> 
> you recommendation is valid, and this should work, the stack cannot be
> read before it's written to. In theory userspace could track the size of
> the stack and know it is supposed to be 0 and avoid a potential
> memset(0) on local variables the first run, but I don't think gcc is
> capable of doing that.
> 

Sorry, I actually meant read _or_ write; that is, disable gap if
prev_vma is PROT_NONE. The heap-stack-gap is essentially a floating
PROT_NONE page. So if you see a PROT_NONE page below a growsdown stack,
you could ignore the gap and allow stack to grow without losing any
protection.

> 
> My only worry is that this mess up things with mprotect, I mean I can't
> just check only for read-only vmas, I've also to trap when this
> read-only vma infact becomes read-write again.

You mean if there's heap memory right below the previously read-only
vma, now it becomes read-write the stack can keep growing down and
it can overwrite heap without a trap? That's a good point. We don't
see that problem because the way we handle stack and heap. But it's
certainly a possibility.

                                                  So for simplicity of the
> implementation I would prefer not to track readonly pages.  If you've a
> strong reason for tracking readonly pages let me know of course. I think
> java already does fine by checking the heap-stack-gap.

Indeed having a special case for PROT_NONE would complicate the
situation, and it's not that simple as you pointed out.

However, my concern is that a hidden gap floating in memory makes it
very hard to manage stacks, while on the other hand applications
need heap-stack-gap protection could simply call mprotect to
explicitly set up a range of memory as PROT_NONE. I can't imagine
java being the only app out there that needs to handle stack
overflows. Other people could see similar problems too (i.e. SEGV
while cr2 is in the gap, not in the guard page).

Now another wish - instead of a system-wide property, a per-process
mechanism to change heap-stack-gap. Applications that need the gap
can set up the appropriate size, while others like Java that manage
heap and stack can simply disable the gap. Is it possible?

thanks,
-hui
