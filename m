Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWBFLWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWBFLWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWBFLWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:22:06 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:43634 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751085AbWBFLWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:22:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=UFbXFiBmJpj6uyXOgmYGvZ9O0QHL03uC8hRShklSXikJsqfr/XG8lT3Z7J4ZHYY0yaoIC5lZmAOYP7Jg+/SzBiwaKekGAx8LjVANieuzS9x5y3KOMUZiJ+IE1UCcDBg7P2T8WXHYLhm6XwkTcSDide7Zh8YDh73E7VPgK0E4XJc=  ;
Message-ID: <43E73157.50300@yahoo.com.au>
Date: Mon, 06 Feb 2006 22:21:59 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
References: <43E0BBEC.3020209@yahoo.com.au> <43E0BDA3.8040003@yahoo.com.au> <20060201141248.GA6277@elte.hu> <43E0C4CF.8090501@yahoo.com.au> <20060201143727.GA9915@elte.hu> <43E0CBBC.2000002@yahoo.com.au> <20060201151137.GA14794@elte.hu> <43E0D464.2020509@yahoo.com.au> <20060201161035.GA22264@elte.hu> <43E0E0F7.60209@yahoo.com.au> <20060201172413.GA22596@elte.hu>
In-Reply-To: <20060201172413.GA22596@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>>But there are still places where interrupts can be held off for 
>>>>indefinite periods. I don't see why the scheduler lock is suddenly 
>>>>important [...]
>>>
>>>
>>>the scheduler lock is obviously important because it's the most central 
>>>lock in existence.
>>>
>>
>>Now I call that argument much more illogical than any of mine. How can 
>>such a fine grained, essentially per-cpu lock be "central", let alone 
>>"most central"? [...]
> 
> 
> i meant central in the sense that it's the most frequently taken lock, 
> in the majority of workloads. Here's the output from the lock validator, 
> sorted by number of ops per lock:
> 
>  -> (dcache_lock){--} 124233 {
>  -> (&rt_hash_locks[i]){-+} 131085 {
>  -> (&dentry->d_lock){--} 312431 {
>  -> (cpa_lock){++} 507385 {
>  -> (__pte_lockptr(new)){--} 660193 {
>  -> (kernel/synchro-test.c:&mutex){--} 825023 {
>  -> (&rwsem){--} 930501 {
>  -> (&rq->lock){++} 2029146 {
> 
> the runqueue lock is also central in the sense that it is the most 
> spread-out lock in the locking dependencies graph. Toplist of locks, by 
> number of backwards dependencies:
> 
>      15     -> &cwq->lock
>      15     -> nl_table_wait
>      15     -> &zone->lock
>      17     -> &base->t_base.lock
>      32     -> modlist_lock
>      38     -> &cachep->spinlock
>      46     -> &parent->list_lock
>      47     -> &rq->lock
> 
> (obviously, as no other lock must nest inside the runqueue lock.)
> 
> so the quality of code (including asymptotic behavior) that runs under 
> the runqueue lock is of central importance. I didnt think i'd ever have 
> to explain this to you, but it is my pleasure to do so ;-) Maybe you 
> thought of something else under "central"?
>

That's all very interesting, but is purely based on some statistical
analysis of some workload of your choice, and ignores other possible
measures like contention or average/max hold times.

One could concoct a workload for which some other lock is the "*most*
central", strangely enough.

Anyway I'm not trying to say that the runqueue locks are not important,
nor that large latencies should not be avoided in the mainline kernel..
But we've known about this theoretical latency for years, ditto for
rwsem latency (which can also be a central lock in some workloads). I
was simply surprised that you just now jump into action when you see
an equally theoretical workload show you what you already know.

Enough talk from me. I'm looking at a couple of ideas which might help
to improve this too.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
