Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWFOMWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWFOMWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWFOMWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:22:49 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:41614 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030318AbWFOMWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:22:48 -0400
Message-ID: <44915110.2050100@bull.net>
Date: Thu, 15 Jun 2006 14:22:40 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: light weight counters: race free through local_t?
References: <Pine.LNX.4.64.0606092212200.4875@schroedinger.engr.sgi.com> <449033B0.1020206@bull.net> <Pine.LNX.4.64.0606140928500.4030@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606140928500.4030@schroedinger.engr.sgi.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/06/2006 14:26:32,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/06/2006 14:26:33,
	Serialize complete at 15/06/2006 14:26:33
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

> Could you do a clock cycle comparision of an 
> 
> atomic_inc(__get_per_cpu(var))
> (the fallback of local_t on ia64)
> 
> vs.
> 
> local_irq_save(flags)
> __get_per_cpu(var)++
> local_irq_restore(flags)
> (ZVC like implementation)
> 
> vs.
> 
> get_per_cpu(var)++
> put_cpu()
> (current light weight counters)

The only thing I have at hand is a small test for the 1st case:


#include <stdio.h>
#include <asm/atomic.h>
#define GET_ITC()                                               \
({                                                              \
        unsigned long ia64_intri_res;                           \
                                                                \
        asm volatile ("mov %0=ar.itc" : "=r"(ia64_intri_res));  \
        ia64_intri_res;                                         \
})

#define N       (1000 * 1000 * 100L)

atomic_t data;

main(int c, char *v[])
{
        unsigned long cycles;
        int i;

        cycles = GET_ITC();
        for (i = 0; i < N; i++)
                ia64_fetchadd4_rel(&data, 1);
        cycles = GET_ITC() - cycles;
        printf("%ld %d\n", cycles / N, atomic_read(&data));
}


It gives 11 clock cycles.
(The loop organizing instructions are "absorbed".)

"atomic_inc(__get_per_cpu(var))" compiles into:

	mov	rx = 0xffffffffffffxxxx	// &__get_per_cpu(var)
	;;
	fetchadd4.rel ry = [rx], 1

It _should_ take 11 clock cycles, too. (Assuming it is in L2.)

For the 2nd case:
With a bit of modification, I can measure what
"__get_per_cpu(var)++" costs: 7 or 10 clock cycles, depending on
if the chance to find the counter in L1 is 100% or 0%:


int data;

static inline void store(int *addr, int data){
        asm volatile ("st4 [%1] = %0" :: "r"(data), "r"(addr) : "memory");
}

static inline int load_nt1(int *addr)
{
        int tmp;
        asm volatile ("ld4.nt1 %0=[%1]" : "=r"(tmp) : "r" (addr));
        return tmp;
}

main(int c, char *v[])
{
        unsigned long cycles;
        int i, d;

        cycles = GET_ITC();
        for (i = 0; i < N; i++)
                // Avoid optimizing out the "st4"
                store(&data, data + 1);
        cycles = GET_ITC() - cycles;
        printf("%ld %d\n", cycles / N, data);
        cycles = GET_ITC();
        for (i = 0; i < N; i++){
                // Do not use L1
                d = load_nt1(&data);
                store(&data, d + 1);
        }
        cycles = GET_ITC() - cycles;
        printf("%ld %d\n", cycles / N, data);
}


"local_irq_save(flags)" compiles into:

	mov rx = psr ;;		// 13 clock cycles
	rsm 0x4000 ;;		// 5 clock cycles

"local_irq_restore(flags)" compiles into (at least):

	ssm 0x4000		// 5 clock cycles

For the 3dr case:
If CONFIG_PREEMPT, then you need to add 2 * 7 clock cycles
for inc_preempt_count() / dec_preempt_count() + some more
for preempt_check_resched().

My conclusion: let's stick to atomic counters.

Regards,

Zoltan
