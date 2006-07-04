Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWGDJNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWGDJNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWGDJNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:13:33 -0400
Received: from mercury.realtime.net ([205.238.132.86]:29085 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S1751220AbWGDJNc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:13:32 -0400
Mime-Version: 1.0 (Apple Message framework v624)
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net> <21169.1151991139@kao2.melbourne.sgi.com> <20060703234134.786944f1.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <49ec8bf1c51da1b651be8a630b4dd1f8@bga.com>
Content-Transfer-Encoding: 7bit
Cc: Anton Blanchard <anton@samba.org>, LKML <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
Date: Tue, 4 Jul 2006 04:13:13 -0500
To: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>
X-Mailer: Apple Mail (2.624)
X-Server: High Performance Mail Server - http://surgemail.com r=-1092531819
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 4, 2006, at 1:39 AM, Andrew Morton wrote:

>
> I expect raw_smp_processor_id() is used here as a a microoptimisation -
> avoid a might_sleep() which obviously will never trigger.
>
> But I think it'd be better to do just a single raw_smp_processor_id() 
> for this entire function:
>
> static void bh_lru_install(struct buffer_head *bh)
> {
> struct buffer_head *evictee = NULL;
> struct bh_lru *lru;
> + int cpu;
>
> check_irqs_on();
> bh_lru_lock();
> + cpu = raw_smp_processor_id();
> - lru = &__get_cpu_var(bh_lrus);
> + lru = per_cpu(bh_lrus, cpu);
>

The problem with this style is that it is an disoptimizatoin for 
architectures who hold their per-cpu data offset in a register, put the 
smp_processor_id in the per-cpu data (or similar) and per_cpu data 
offsets in a global lookup.

Do we need a new macro? (what is that gcc macro function syntax?)

#ifdef PER_CPU_IS_SLOW
#define my_cpu_var(bh_lrus, cpu) \
	({ BUG_ON(cpu != smp_processor_id()); 	&__get_cpu_var(bh_lrus); })
#else
#define my_cpu_var(bh_lrus, cpu) \
	({ BUG_ON(cpu != smp_processor_id()); per_cpu(bh_lrus, cpu); })
#endif

(and yes, the BUG_ON would be for debug checking).

milton

