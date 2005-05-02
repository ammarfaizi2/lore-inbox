Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVEBXXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVEBXXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 19:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVEBXXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 19:23:53 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:9101 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261221AbVEBXXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 19:23:33 -0400
Message-ID: <4276B667.2050905@yahoo.com.au>
Date: Tue, 03 May 2005 09:23:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: dino@in.ibm.com
CC: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
References: <20050501190947.GA5204@in.ibm.com> <4275F665.1010101@yahoo.com.au> <20050502171619.GA4418@in.ibm.com>
In-Reply-To: <20050502171619.GA4418@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala wrote:
> On Mon, May 02, 2005 at 07:44:05PM +1000, Nick Piggin wrote:
> 
>>Dinakar Guniguntala wrote:
>>
>>
>>>+void rebuild_sched_domains(cpumask_t span1, cpumask_t span2)
>>>+{
>>>+	cpumask_t change_map;
>>>+
>>>+	cpus_or(change_map, span1, span2);
>>>+
>>>+	preempt_disable();
>>
>>Oh, you can't do this here, attach_domains does a synchronize_kernel.
>>So take it out, it doesn't do anything anyway, does it?
> 
> 
> I put that in to prevent hangs with CONFIG_PREEMPT turned on, but
> clearly didn't test it with preempt turned on. Looks like all I need to 
> do here is a local_irq_disable
> 

What are you protecting against, though? synchroinze_kernel can
sleep, so local_irq_disable is probably the wrong thing to do as well.

AFAIKS, you don't need anything here - so long as you have mutual
exclusion from other sched-domain building then this can take as long
as it wants / be preempted as many times as we like.

> 
>>I suggest you also use some sort of locking to prevent concurrent rebuilds
>>and rebuilds racing with cpu hotplug. You could probably have a static
>>semaphore around rebuild_sched_domains, and take lock_cpu_hotplug here too.
> 
> 
> I already do a lock_cpu_hotplug() in cpuset.c before calling 
> rebuild_sched_domains and also am holding cpuset_sem, so that should take
> care of both hotplug and concurrent rebuilds
> 

OK.

But if we want this to be a respectable interface (possibly for more than
just cpusets) then it should probably do some locking itself. It isn't
performance critical, so I think taking a semaphore wouldn't hurt.

-- 
SUSE Labs, Novell Inc.

