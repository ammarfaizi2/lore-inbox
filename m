Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbTHURCL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbTHURCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:02:11 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:3974 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262701AbTHURCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:02:09 -0400
Message-ID: <3F44FAF3.8020707@colorfullife.com>
Date: Thu, 21 Aug 2003 19:01:39 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: TeJun Huh <tejun@aratech.co.kr>
CC: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: Possible race condition in i386 global_irq_lock handling.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TeJun wrote:
> static inline void irq_enter(int cpu, int irq)
> {
> 	++local_irq_count(cpu);
> 
> 	while (test_bit(0,&global_irq_lock)) {
> 		cpu_relax();
> 	}
> }
> 
>  Is it a race condition or am I getting it horribly wrong?  Thx in
> advance.

Yes, it's a race. Actually a variant of the race that lead to the introduction of set_current_state():

test_bit is a simple read instruction. i386 cpus are free to execute it early, i.e. they can execute it before the write part of "++local_irq_count(cpu)".

I think smp_rmb() is the right barrier - could you write a patch and send it to Marcelo?

--
	Manfred



