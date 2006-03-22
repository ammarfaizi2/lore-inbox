Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWCVHaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWCVHaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWCVHaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:30:12 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:38798 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751068AbWCVHaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:30:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=eIazice8qBcN9gk3lAm/95DxiOUMdJNd/ScqFo6ZMM0CFn1lWchx645klz13dcoW4wQGWHKwbOouZvXwdgxXp4aJZHwaAZIue5K62oazMXhvvuimOHN37RKw4ICVNy+bABxxou3OFo3zeJqGGqlyDskGr9Kv3TPQOPeYGAO7Q3g=  ;
Message-ID: <4420FCFD.3060401@yahoo.com.au>
Date: Wed, 22 Mar 2006 18:30:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "Li, Shaohua" <shaohua.li@intel.com>,
       "'lkml'" <linux-kernel@vger.kernel.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: [PATCH] less tlb flush in unmap_vmas
References: <200603220715.k2M7F1g04936@unix-os.sc.intel.com>
In-Reply-To: <200603220715.k2M7F1g04936@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Nick Piggin wrote on Tuesday, March 21, 2006 8:53 PM
> 
>>Shaohua Li wrote:
>>
>>>In unmaping region, if current task doesn't need reschedule, don't do a
>>>tlb_finish_mmu. This can reduce some tlb flushes.
>>>
>>>In the lmbench tests, this patch gives 2.1% improvement on exec proc
>>>item and 4.2% on sh proc item.
>>
>>The problem with this is that by the time we _do_ determine that a
>>reschedule is needed, we might have built up a huge amount of work
>>to do (which can probably be as much if not more exensive per-page
>>as the unmapping), so scheduling latency can still be unacceptable
>>so I'm afraid I don't think we can include this patch.
> 
> 
> Interesting. In the old day, since mm->page_table_lock is held for the
> entire unmap_vmas function, it was beneficial to introduce periodic
> reschedule point and to drop the spin lock under pressure. Now that the
> page table lock is fine-grained and is pushed into zap_pte_range(), I
> would think scheduling latency would improve from lock contention
> avoidance point of view.  It is not the case?
> 

Well mmu_gather uses a per-cpu data structure and is non preemptible,
which I guess is one of the main reasons why we have this preemption
here.

You're right that another good reason would be ptl lock contention,
however I don't think that alleviating that problem alone would allow
longer mmu_gather scheduling latencies, because the longest latency
is still the mmu_gather <--> mmu_finish span.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
