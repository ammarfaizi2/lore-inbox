Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWH3QjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWH3QjP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWH3QjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:39:15 -0400
Received: from gw.goop.org ([64.81.55.164]:36516 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751146AbWH3QjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:39:15 -0400
Message-ID: <44F5BF29.7080004@goop.org>
Date: Wed, 30 Aug 2006 09:39:05 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for  i386.
References: <200608300838_MC3-1-C9C6-CA79@compuserve.com>
In-Reply-To: <200608300838_MC3-1-C9C6-CA79@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> Nevermind.  I thought because you changed struct pt_regs in ptrace_abi.h
> it meant a user ABI change.
>   

Yes, that header seems pretty badly misnamed.  The user-visible 
structure is user_pt_regs.

> But they can get out of sync, e.g. when switch_to() restores the new
> task's esp, the PDA still contains the old pcurrent and they don't get
> synchronized until the write_pda() in __switch_to().
>   

Yes, that's true, but the window is fairly small.  More importantly, the 
question of "what task is currently running" is fundamentally 
ill-defined while you're in the middle of a context switch, so I don't 
think this is a big issue.  __switch_to runs on the new task's stack, so 
that's effectively where current_thread_info()->task changes value 
(aside from the few instructions in switch_to() between the %esp update 
and the jmp to __switch_to).  I could put the write_pda() earlier in 
__switch_to so the window is smaller.  But again, for it to make a 
difference, someone would want to be using current *within* __switch_to, 
which is just silly.

>> To be honest, I haven't looked at percpu.h in great detail.  I was 
>> making assumptions about how it works, but it looks like they were wrong.
>>     
>
> Would it make any sense to replace the 'cpu' field in thread_info with
> a pointer to a PDA-like structure?  We could even embed the static per_cpu
> data directly into that struct instead of chasing pointers...
>   

I don't think so.  The whole point is to make the pda easily accessible 
with simple addressing modes based on %gs:.   I have been wondering if 
we can modify the percpu mechanism to get the linker to construct the 
layout of the pda, so that all the existing percpu stuff can be 
transparently moved into the pda and accessed efficiently.  I think it 
would be pretty tricky to get it all working though...

But the PDA isn't really intended for *all* per-cpu data; its mostly for 
stuff which is accessed often, or needs to be quickly and easily 
accessibly.  My specific motivation is to use the PDA for easy access to 
Xen per-cpu data, which needs to be accessible with short instructions 
which can be inlined.

    J
