Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbWBARZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWBARZt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWBARZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:25:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:28373 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030386AbWBARZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:25:48 -0500
Date: Wed, 1 Feb 2006 18:24:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
Message-ID: <20060201172413.GA22596@elte.hu>
References: <43E0BBEC.3020209@yahoo.com.au> <43E0BDA3.8040003@yahoo.com.au> <20060201141248.GA6277@elte.hu> <43E0C4CF.8090501@yahoo.com.au> <20060201143727.GA9915@elte.hu> <43E0CBBC.2000002@yahoo.com.au> <20060201151137.GA14794@elte.hu> <43E0D464.2020509@yahoo.com.au> <20060201161035.GA22264@elte.hu> <43E0E0F7.60209@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E0E0F7.60209@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >>But there are still places where interrupts can be held off for 
> >>indefinite periods. I don't see why the scheduler lock is suddenly 
> >>important [...]
> >
> >
> >the scheduler lock is obviously important because it's the most central 
> >lock in existence.
> >
> 
> Now I call that argument much more illogical than any of mine. How can 
> such a fine grained, essentially per-cpu lock be "central", let alone 
> "most central"? [...]

i meant central in the sense that it's the most frequently taken lock, 
in the majority of workloads. Here's the output from the lock validator, 
sorted by number of ops per lock:

 -> (dcache_lock){--} 124233 {
 -> (&rt_hash_locks[i]){-+} 131085 {
 -> (&dentry->d_lock){--} 312431 {
 -> (cpa_lock){++} 507385 {
 -> (__pte_lockptr(new)){--} 660193 {
 -> (kernel/synchro-test.c:&mutex){--} 825023 {
 -> (&rwsem){--} 930501 {
 -> (&rq->lock){++} 2029146 {

the runqueue lock is also central in the sense that it is the most 
spread-out lock in the locking dependencies graph. Toplist of locks, by 
number of backwards dependencies:

     15     -> &cwq->lock
     15     -> nl_table_wait
     15     -> &zone->lock
     17     -> &base->t_base.lock
     32     -> modlist_lock
     38     -> &cachep->spinlock
     46     -> &parent->list_lock
     47     -> &rq->lock

(obviously, as no other lock must nest inside the runqueue lock.)

so the quality of code (including asymptotic behavior) that runs under 
the runqueue lock is of central importance. I didnt think i'd ever have 
to explain this to you, but it is my pleasure to do so ;-) Maybe you 
thought of something else under "central"?

	Ingo
