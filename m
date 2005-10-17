Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbVJQSBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVJQSBz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVJQSBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:01:55 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:13985 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751345AbVJQSBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:01:54 -0400
Message-ID: <4353E6F1.8030206@cosmosbay.com>
Date: Mon, 17 Oct 2005 20:01:21 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Linus Torvalds <torvalds@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com>
In-Reply-To: <20051017162930.GC13665@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040500060200060309070101"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 17 Oct 2005 20:01:23 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040500060200060309070101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Dipankar Sarma a écrit :
> On Mon, Oct 17, 2005 at 09:16:25AM -0700, Linus Torvalds wrote:
> 
>>>Absolutely. Keeping a count of (percpu) queued items is basically free if kept
>>>in the cache line used by list head, so the 'queue length on this cpu' is a
>>>cheap metric.
>>
>>The only downside to TIF_RCUUPDATE is that those damn TIF-flags are 
>>per-architecture (probably largely unnecessary, but while most 
>>architectures don't care at all, others seem to have optimized their 
>>layout so that they can test the work bits more efficiently). So it's a 
>>matter of each architecture being updated with its TIF_xyz flag and their 
>>work function.
>>
>>Anybody willing to try? Dipankar apparently has a lot on his plate, this 
>>_should_ be fairly straightforward. Eric?
> 
> 
> I *had*, when this hit me :) It was one those spurt things. I am going to
> look at this, but I think we will need to do this with some careful
> benchmarking.
> 
> At the moment however I do have another concern - open/close taking too
> much time as I mentioned in an earlier email. It is nearly 4 times
> slower than 2.6.13. So, that is first up in my list of things to
> do at the moment.
> 

<lazy_mode=ON>
Do we really need a TIF_RCUUPDATE flag, or could we just ask for a resched ?
</lazy_mode>

This patch only take care of call_rcu(), I'm unsure of what can be done inside 
call_rcu_bh()

The two stress program dont hit OOM anymore with this patch applied (even with 
maxbatch=10)

Eric


--------------040500060200060309070101
Content-Type: text/plain;
 name="rcu_patch.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rcu_patch.1"

--- linux-2.6.14-rc4/kernel/rcupdate.c	2005-10-11 03:19:19.000000000 +0200
+++ linux-2.6.14-rc4-ed/kernel/rcupdate.c	2005-10-17 21:52:18.000000000 +0200
@@ -109,6 +109,10 @@
 	rdp = &__get_cpu_var(rcu_data);
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
+
+	if (unlikely(++rdp->count > 10000))
+		set_need_resched();
+
 	local_irq_restore(flags);
 }
 
@@ -140,6 +144,12 @@
 	rdp = &__get_cpu_var(rcu_bh_data);
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
+	rdp->count++;
+/*
+ *  Should we directly call rcu_do_batch() here ?
+ *  if (unlikely(rdp->count > 10000))
+ *      rcu_do_batch(rdp);
+ */
 	local_irq_restore(flags);
 }
 
@@ -157,6 +167,7 @@
 		next = rdp->donelist = list->next;
 		list->func(list);
 		list = next;
+		rdp->count--;
 		if (++count >= maxbatch)
 			break;
 	}
--- linux-2.6.14-rc4/include/linux/rcupdate.h	2005-10-11 03:19:19.000000000 +0200
+++ linux-2.6.14-rc4-ed/include/linux/rcupdate.h	2005-10-17 21:02:25.000000000 +0200
@@ -94,6 +94,7 @@
 	long  	       	batch;           /* Batch # for current RCU batch */
 	struct rcu_head *nxtlist;
 	struct rcu_head **nxttail;
+	long            count; /* # of queued items */
 	struct rcu_head *curlist;
 	struct rcu_head **curtail;
 	struct rcu_head *donelist;

--------------040500060200060309070101--
