Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbVKHN0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbVKHN0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbVKHN0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:26:13 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:61967 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S965177AbVKHN0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:26:11 -0500
Message-ID: <4370A771.5060201@vmware.com>
Date: Tue, 08 Nov 2005 05:26:09 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: security@kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/21] i386 Kprobes semaphore fix
References: <20051108074430.GG28201@elte.hu>
In-Reply-To: <20051108074430.GG28201@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2005 13:26:10.0730 (UTC) FILETIME=[FBCE68A0:01C5E467]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>could these bugs lead to local rootholes, if kprobes are enabled?
>
>The threat model we care about is: administrator has a few dozen kprobes 
>activated, which sample various aspects of the system. Unprivileged 
>userspace tries to exploit this fact: it has full control over its own 
>conduct (including the ability to create LDTs, vm86 mode and weird 
>segments), but unprivileged userspace has no ability to 
>activate/deactivate kprobes.
>
>could this cause problems?
>  
>

Good - it was thinking along these lines that led me to this patch.  It 
is still possible to defeat the EIP checking if you are crafty enough, 
because there is a window of opportunity from the time a fault is 
induced until the LDT is read where another CPU can come along and 
modify the LDT.  Note the GDT does not have this problem, as remote 
changes (via ptrace I think I saw code that makes it possible) will not 
take effect until the thread is rescheduled.  But with kernel 
preemption, even GDT based segments have the race.  Pardon my thinking 
out loud - this is a very sticky situation.

Actually, perhaps this window could be closed; we will have a pending 
LDT reload posted by IPI, or a reschedule (and thus TLS reload) pending, 
and we can hold processing of that even while enabling interrupts.  
There is a problem - the LDT will have already been modified, and we 
don't always re-allocate a new page for it, so the old data may be 
gone.  Seems like we could find ways to close the race, but it seems 
difficult to verify as correct, and may cost performance.

So my approach is to ignore the race; instead, I use limit checking.  
Note the limit here is specified in linear (non-segmented) virtual 
memory, and is clamped to MIN(limit,PAGE_OFFSET) for userspace probes.

+
+	/* Don't let userspace races re-address into kernel space */
+	if ((unsigned long)addr > limit)
+		return 0;
+

Also, added this test:

+		if (user_mode(regs))
+			__get_user(instr, (unsigned char __user *) addr);
+		else
+			instr = *addr;
+			


Which saves the kernel from faulting due to "impersonated non-linear 
breakpoints".  Note the OOPs should have been caught and safely dealt 
with anyway.

So there are still a couple of crafty tricks that can cause you to 
re-address into kernel range EIPs, but limit checking protects us, and 
in general, perhaps we need not worry about strict correctness of 
kprobes for these edge cases.  Now that I have the issue at attention, 
is it even possible / useful to set kprobes in a specific userspace 
context, or should only kernel breakpoints be considered for kprobes?  
Reading the code, it was not clear, and I could not find proper 
documentation, so I left the semantics as I saw them.

If indeed, as I suspect, kprobes are only for kernel code, then the code 
here can be greatly simplified by discarding user code segments right 
away and doing flat EIP conversion.

Zach
