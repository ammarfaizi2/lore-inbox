Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVBKVOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVBKVOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVBKVOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:14:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35595 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262342AbVBKVOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:14:12 -0500
Date: Fri, 11 Feb 2005 20:04:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interrupt starvation points
Message-ID: <20050211200424.B28971@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Walker <dwalker@mvista.com>,
	linux-kernel@vger.kernel.org
References: <1108141521.21940.44.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1108141521.21940.44.camel@dhcp153.mvista.com>; from dwalker@mvista.com on Fri, Feb 11, 2005 at 09:05:21AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 09:05:21AM -0800, Daniel Walker wrote:
>         The other patch enabled interrupt before calling up on
> kernel_sem ..This one could use some thinking over. I did this cause
> up() is very expensive on ARM , and combined with the looping above
> interrupts can stay off for a long time .. 

Please substantiate your claim that up() is very expensive on ARM.
I disagree:

#define __up_op(ptr,wake)                       \
        ({                                      \
        __asm__ __volatile__(                   \
        "@ up_op\n"                             \
"       mrs     ip, cpsr\n"                     \
"       orr     lr, ip, #128\n"                 \
"       msr     cpsr_c, lr\n"                   \
"       ldr     lr, [%0]\n"                     \
"       adds    lr, lr, %1\n"                   \
"       str     lr, [%0]\n"                     \
"       msr     cpsr_c, ip\n"                   \
"       movle   ip, %0\n"                       \
"       blle    " #wake                         \
        :                                       \
        : "r" (ptr), "I" (1)                    \
        : "ip", "lr", "cc", "memory");          \
        })

static inline void up(struct semaphore * sem)
{
        __up_op(sem, __up_wakeup);
}

Looks like 9 instructions for the uncontended case to me.  If you're
worried about 9 instructions being expensive, please work on GCC to
improve its optimisation capabilities first.  There's room there for
improvement across the whole kernel than just the above 9 instructions.

Plus, after you've read the above code, wouldn't you think that adding
the "enable interrupts + disable interrupts" around an up() operation
(which itself immediately disables interrupts again) is just adding
extra instructions to the kernel, which corresponds directly to lower
performance?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
