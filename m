Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135626AbRAVXor>; Mon, 22 Jan 2001 18:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135605AbRAVXoh>; Mon, 22 Jan 2001 18:44:37 -0500
Received: from ha1.rdc1.md.home.com ([24.2.2.66]:16092 "EHLO
	mail.rdc1.md.home.com") by vger.kernel.org with ESMTP
	id <S135722AbRAVXo1>; Mon, 22 Jan 2001 18:44:27 -0500
Message-Id: <4.3.2.7.2.20010122183536.00b0b810@cockrum.net>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 22 Jan 2001 18:44:28 -0500
To: linux-kernel@vger.kernel.org
From: Chris K Cockrum <kernel@cockrum.net>
Subject: Module Profiling Problem
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been developing a driver for an audio card and encountered a problem 
which I have duplicated in the test code below.  My problem is that when 
trying to profile a section of code in a kernel module I get erratic 
results.  My cycle counts are sometimes 73xxx cycles more that I expect 
them to be.  Does anyone know what could be causing this?

Thanks in Advance,
Chris K Cockrum
iBiquity Digital Corp.
http://www.ibiquity.com


Running Linux 2.4.0 on a Tyan Tiger Dual 800MHz Motherboard w/133MHz Bus

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/sched.h>
#include <asm/smplock.h>

/* Declare Spinlock */
spinlock_t testlock;

int init_module(void)
{
    unsigned long long starttime,stoptime;

    unsigned int lockflags,n,tempval=20000;

    spin_lock_init(&testlock);

    for (n=0;n<40;n++)
    {
       spin_lock_irqsave(&testlock,lockflags);

       /* Clear Interrupt Flag */
       __asm__ __volatile__ ("cli");

       /* Get CPU Clock */
       __asm__ __volatile__ ("rdtsc\n\t" \
                             "movl %%eax, (%%ecx)\n\t" \
                             "movl %%edx, 4(%%ecx)"\
                             ::"c" (&starttime));

       /* Waste Time-Register Moves Looped tempval Times */
       __asm__ __volatile__ ("loop: movl %%ecx,%%eax\t\n" \
                             "      decl %%ecx\t\n" \
                             "      jnz loop" \
                             :: "c" (tempval) : "%eax");

       /* Get CPU Clock */
       __asm__ __volatile__ ("rdtsc\n\t" \
                             "movl %%eax, (%%ecx)\n\t" \
                             "movl %%edx, 4(%%ecx)"\
                             ::"c" (&stoptime));

       spin_unlock_irqrestore(&testlock,lockflags);

       printk(KERN_DEBUG "Test: 0x%08X:%08X - %d Cycles\n", \
             (unsigned int) (((stoptime-starttime)>>32)&0xFFFFFFFF), \
             (unsigned int)  ((stoptime-starttime)     &0xFFFFFFFF), \
             (unsigned int)  ((stoptime-starttime)     &0xFFFFFFFF)  );

    }
    return 0;
}

void cleanup_module(void)
{
printk(KERN_DEBUG "Unloaded\n");
}


Results:

Test: 0x00000000:0000EA94 - 60052 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:00020977 - 133495 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:00020997 - 133527 Cycles
Test: 0x00000000:0002098F - 133519 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:00020976 - 133494 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0002098A - 133514 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0002098E - 133518 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles
Test: 0x00000000:0002098A - 133514 Cycles
Test: 0x00000000:0000EA87 - 60039 Cycles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
