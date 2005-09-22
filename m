Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbVIVNR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbVIVNR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVIVNR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:17:56 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:65164 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1030321AbVIVNRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:17:55 -0400
Message-ID: <4332AEFF.1040105@cosmosbay.com>
Date: Thu, 22 Sep 2005 15:17:51 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Harald Welte <laforge@netfilter.org>
CC: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/3] netfilter : 3 patches to boost ip_tables performance
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de> <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de> <433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com> <4331D0A9.3080801@cosmosbay.com> <20050922125724.GJ26520@sunbeam.de.gnumonks.org>
In-Reply-To: <20050922125724.GJ26520@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 22 Sep 2005 15:17:52 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte a écrit :
> On Wed, Sep 21, 2005 at 11:29:13PM +0200, Eric Dumazet wrote:
> 
>>Patch 1/3
>>
>>1) No more one rwlock_t protecting the 'curtain'
> 
> 
> I have no problem with this change "per se", but with the
> implementation.
> 
> As of now, we live without any ugly #ifdef CONFIG_SMP / #endif sections
> in the code - and if possible, I would continue this good tradition.
> 
> For example the get_counters() function.  Wouldn't all the smp specific
> code (for_each_cpu(), ...)  be #defined to nothing anyway?

Well... not exactly, but you are right only the first loop (SET_COUNTER) will 
really do something. The if (cpu == curcpu) will be true but the compiler wont 
  know that, cpu and curcpu are still C variables.


> 
> And if we really need the #ifdef's, I would appreciate if those
> sectionas are as small as possible.  in get_counters() the section can
> definitely be smaller, rather than basically having the whole function
> body separate for smp and non-smp cases.

get_counters() is not critical, so I agree with you we can stick the general 
version (not the UP optimized one)

> 
> Also, how much would we loose in runtime performance if we were using a
> "rwlock_t *" even in the UP case?.  I mean, it's just one more pointer
> dereference of something that is expected to be in cache anyway, isn't
> it?  This gets rid of another huge set of #ifdefs that make the code
> unreadable and prone to errors being introduced later on.
> 

Well, in UP case, the rwlock_t is a nulldef.

I was inspired by another use of percpu data in include/linux/genhd.h
#ifdef  CONFIG_SMP
     struct disk_stats *dkstats;
#else
     struct disk_stats dkstats;
#endif

But if you dislike this, we can use pointer for all cases.

Eric
