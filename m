Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVD1WmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVD1WmA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVD1Wly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:41:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37131 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262313AbVD1WkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:40:14 -0400
Date: Thu, 28 Apr 2005 23:40:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] unify semaphore implementations
Message-ID: <20050428234005.A19778@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin LaHaise <bcrl@kvack.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050428182926.GC16545@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050428182926.GC16545@kvack.org>; from bcrl@kvack.org on Thu, Apr 28, 2005 at 02:29:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 02:29:26PM -0400, Benjamin LaHaise wrote:
> Please review the following series of patches for unifying the 
> semaphore implementation across all architectures (not posted as 
> they're about 350K), as they have only been tested on x86-64.  The 
> code generated is functionally identical to the earlier i386 
> variant, but since gcc has no way of taking condition codes as 
> results, there are two additional instructions inserted from the 
> use of generic atomic operations.  All told the >6000 lines of code 
> deleted makes for a much easier job for subsequent patches changing 
> semaphore functionality.  Cheers,

I'm not sure why we're doing this, apart from a desire to unify stuff.
What happened to efficiency and performance?

It is my understanding that the inline part of the semaphore
implementation was one of the critical areas - critical enough to
warrant coding it in assembly for some people.

So, I set about testing this implementation against the ARM
implementation.  For this, I used this code:

void it(struct semaphore *sem, int *val)
{
        down(sem);
        *val = *val + 1;
        up(sem);
}

which is a relatively simple test case.

The ARM assembly implementation for this gave:

        str     lr, [sp, #-4]!
        @ down_op
        mrs     ip, cpsr		@ local_irq_save
        orr     lr, ip, #128
        msr     cpsr_c, lr
        ldr     lr, [r0]
        subs    lr, lr, #1
        str     lr, [r0]
        msr     cpsr_c, ip		@ local_irq_restore
        movmi   ip, r0
        blmi    __down_failed
        ldr     r3, [r1, #0]
        add     r3, r3, #1
        str     r3, [r1, #0]
        @ up_op
        mrs     ip, cpsr		@ local_irq_save
        orr     lr, ip, #128
        msr     cpsr_c, lr
        ldr     lr, [r0]
        adds    lr, lr, #1
        str     lr, [r0]
        msr     cpsr_c, ip		@ local_irq_restore
        movle   ip, r0
        blle    __up_wakeup
        ldr     pc, [sp], #4

Stack: 1 location
Registers: 3 on top of the two arguments
Instructions: 23, 23 in the common execution path.

The atomic-op based implementation gave:

        stmfd   sp!, {r4, r5, lr}
        mov     r5, r1
        mov     r4, r0
        mrs     r2, cpsr                @ local_irq_save
        orr     r1, r2, #128
        msr     cpsr_c, r1
        ldr     r3, [r0, #0]
        sub     r3, r3, #1
        str     r3, [r0, #0]
        msr     cpsr_c, r2              @ local_irq_restore
        cmp     r3, #0
        blt     .L8
.L4:    ldr     r3, [r5, #0]
        add     r3, r3, #1
        str     r3, [r5, #0]
        mrs     r2, cpsr                @ local_irq_save
        orr     r1, r2, #128
        msr     cpsr_c, r1
        ldr     r3, [r4, #0]
        add     r3, r3, #1
        str     r3, [r4, #0]
        msr     cpsr_c, r2              @ local_irq_restore
        cmp     r3, #0
        mov     r0, r4
        ldmgtfd sp!, {r4, r5, pc}
        ldmfd   sp!, {r4, r5, lr}
        b       up_wakeup
.L8:    bl      down_failed
        b       .L4

Stack: 3 locations
Registers: 5 on top of the two arguments
Instructions: 29, 27 in the common execution path.

So, Ben's implementation is more expensive in terms of stack usage,
register usage, and number of instructions.

Why is this?  The answer is that gcc is unable to properly optimise
for ARM - I've no idea why.  One such simple thing is that the
sequence:

	blt	.L8
.L4:
...
.L8:	bl	down_failed
	b	.L4

can be easily rewritten as:

	bllt	down_failed

Another reason for the extra code bloat is that GCC can't propagate
PSR flags between the sub/add instructions across a memory barrier
(which local_irq_restore is.)

This makes the ARM assembly code implementation superior to any unified
version, no matter how you look at it from efficiency or performance
points of view.  The _only_ win is that of unification.

However, given that the kernel has bloated itself by 300K per stable
kernel series on ARM for the same functionality, I'd prefer to keep
my more efficient higher performance smaller code size semaphores
please.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
