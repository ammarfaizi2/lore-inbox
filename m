Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWGDHtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWGDHtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWGDHtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:49:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21648 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751195AbWGDHtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:49:24 -0400
Message-ID: <44AA1D7A.2060202@sgi.com>
Date: Tue, 04 Jul 2006 09:49:14 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Keith Owens <kaos@sgi.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
References: <21169.1151991139@kao2.melbourne.sgi.com>
In-Reply-To: <21169.1151991139@kao2.melbourne.sgi.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
>> static void invalidate_bh_lrus(void)
>> {
>> -	on_each_cpu(invalidate_bh_lru, NULL, 1, 1);
>> +	/*
>> +	 * Need to hand down a copy of the mask or we wouldn't be run
>> +	 * anywhere due to the original mask being cleared
>> +	 */
>> +	cpumask_t mask = lru_in_use;
>> +	cpus_clear(lru_in_use);
>> +	schedule_on_each_cpu_mask(invalidate_bh_lru, NULL, mask);
>> }
> 
> Racy?  Start with an empty lru_in_use.
> 
> Cpu A                         Cpu B
> invalidate_bh_lrus()
> mask = lru_in_use;
> preempted
>                               block I/O
> 			      bh_lru_install()
> 			      cpu_set(cpu, lru_in_use);
> resume
> cpus_clear(lru_in_use);
> schedule_on_each_cpu_mask() - does not send IPI to cpu B

I guess the real question is whether the device is still valid for new
IO by the time we hit the invalidate function. If not, and that was my,
possibly flawed, assumption, then it's not an issue. Whatever bh's are
left in the lrus from other devices will be handled on the next hit.

Cheers,
Jes
