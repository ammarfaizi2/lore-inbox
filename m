Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWFPJO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWFPJO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 05:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWFPJO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 05:14:59 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:53740 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750766AbWFPJO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 05:14:58 -0400
Message-ID: <4492768C.1010703@bull.net>
Date: Fri, 16 Jun 2006 11:14:52 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: light weight counters: race free through local_t?
References: <Pine.LNX.4.64.0606092212200.4875@schroedinger.engr.sgi.com> <449033B0.1020206@bull.net> <Pine.LNX.4.64.0606140928500.4030@schroedinger.engr.sgi.com> <44915110.2050100@bull.net> <Pine.LNX.4.64.0606150855410.9137@schroedinger.engr.sgi.com> <44918EE5.2060302@bull.net> <Pine.LNX.4.64.0606151110100.9618@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606151110100.9618@schroedinger.engr.sgi.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/06/2006 11:18:44,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/06/2006 11:18:45,
	Serialize complete at 16/06/2006 11:18:45
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's put it in another way:
Do the statistics need to be absolutely precise?
I guess they do not.
By the time you can display them, they have already been changed.

Let's take an example:

zone_statistics(struct zonelist *zonelist, struct zone *z)
{
...
//	local_irq_save(flags);		// No IRQ lock out
	cpu = smp_processor_id();	// Can become another CPU
	p = &z->pageset[cpu];		// Can count for someone else
	if (pg == orig) {
		stat_incr(&z->pageset[cpu].numa_hit);	// Unsafe
	} else {
...
//	local_irq_restore(flags);
}

Where "stat_incr()" is arch. dependent and possibly unsafe routine.

For IA64:

// Unsafe statistics
static inline void stat_incr(int *addr){
        int tmp;

	// Obtain immediately the cache line exclusivity, do not touch L1
        asm volatile ("ld4.bias.nt1 %0=[%1]" : "=r"(tmp) : "r" (addr));
        tmp++;
        asm volatile ("st4 [%1] = %0" :: "r"(tmp), "r"(addr) : "memory");
}

It takes 10 clock cycles.

Regards,

Zoltan
