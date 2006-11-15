Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965838AbWKOHOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965838AbWKOHOc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965862AbWKOHOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:14:32 -0500
Received: from elvis.mu.org ([192.203.228.196]:56539 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S965838AbWKOHOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:14:31 -0500
Message-ID: <455ABE49.10109@FreeBSD.org>
Date: Tue, 14 Nov 2006 23:14:17 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH 1/1] Make the TSC safe to be used by gettimeofday().
References: <455A512F.6030907@FreeBSD.org> <455A52E9.9030505@FreeBSD.org> <200611150542.14239.ak@suse.de>
In-Reply-To: <200611150542.14239.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 15 November 2006 00:36, Suleiman Souhlal wrote:
> 
>>This is done by a per-cpu vxtime structure that stores the last TSC and HPET
>>values.
>>
>>Whenever we switch to a userland process after a HLT instruction has been
>>executed or after the CPU frequency has changed, we force a new read of the
>>TSC, HPET and xtime so that we know the correct frequency we have to deal
>>with.
>>
>>We also force a resynch once every second, on every CPU.
> 
> 
> Hmm, not sure we want to do it this way. Especially since you
> got unsolved races. But patch review ignoring the 10k foot picture again.
> 

Which unresolved races?
The reason why I do a resynch every CPU is to prevent the HPET timer from
rolling over more than once before reading it again, which could happen
if the CPU doesn't go into HLT for a long time.

>>+
>>+	/*
>>+	 * If we are switching away from a process in vsyscall, touch
>>+	 * the vxtime seq lock so that userland is aware that a context switch
>>+	 * has happened.
>>+	 */
>>+	rip = *(unsigned long *)(prev->rsp0 +
>>+	    offsetof(struct user_regs_struct, rip) - sizeof(struct pt_regs));
>>+	if (unlikely(rip > VSYSCALL_START) && unlikely(rip < VSYSCALL_END)) {
>>+		write_seqlock(&vxtime.vx_seq);
>>+		write_sequnlock(&vxtime.vx_seq);
>>+	}
>>+
> 
> 
> Can't this starve? If a process is unlucky enough (e.g. from 
> lots of interrupts) that it can't go through the vsyscall without at 
> least one context switch it will never finish. Ok maybe it's an 
> unlikely enough livelock, but it still makes me uncomfortable.

I could make it fall back to a full syscall after a certain number of tries.
This, coupled with using a preemption count instead of touching the seq lock
should prevent the livelock (because if we don't touch the seq lock in switch_to
the livelock would not be possible in the full gettimeofday() syscall).
> 
>> 
>>-  .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
>>-  vxtime = VVIRT(.vxtime);
>>-
>>   .vgetcpu_mode : AT(VLOAD(.vgetcpu_mode)) { *(.vgetcpu_mode) }
>>   vgetcpu_mode = VVIRT(.vgetcpu_mode);
>> 
>>@@ -119,6 +116,9 @@ #define VVIRT(x) (ADDR(x) - VVIRT_OFFSET
>>   .vsyscall_2 ADDR(.vsyscall_0) + 2048: AT(VLOAD(.vsyscall_2)) { *(.vsyscall_2) }
>>   .vsyscall_3 ADDR(.vsyscall_0) + 3072: AT(VLOAD(.vsyscall_3)) { *(.vsyscall_3) }
>> 
>>+  .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
>>+  vxtime = VVIRT(.vxtime);
> 
> 
> Why did you move it?

Because otherwise .jiffies (IIRC) collides with .vsyscall_0.

> 
>>+long vgetcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache);
> 
> 
> externs in c code are still forbidden, even if they don't have
> extern


This is just a forward declaration, but I'll get rid of it anyway.

Thanks a lot for the feedback.
I'll try to address these issues and send and a fixed patch.

-- Suleiman

