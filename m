Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWAZORo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWAZORo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWAZORo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:17:44 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:12733 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932329AbWAZORn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:17:43 -0500
Message-ID: <43D8D9FF.1050409@cosmosbay.com>
Date: Thu, 26 Jan 2006 15:17:35 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Avoid use of spinlock for percpu_counter
References: <20060125231654.GB3658@localhost.localdomain>
In-Reply-To: <20060125231654.GB3658@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 26 Jan 2006 15:17:35 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai a écrit :
> The spinlock in struct percpu_counter protects just one counter.  It's
> not obvious why it was done this way (I am guessing it was because earlier,
> atomic_t was guaranteed 24 bits only on some arches).  Since we have
> atomic_long_t now, I don't see why this cannot be replaced with an atomic_t.
> 
> Comments?

Yes this makes sense.

Furthermore, we could try to fix 'struct percpu_counter' management (if SMP) 
if alloc_percpu(long) call done in percpu_counter_init() fails. This is 
currently ignored and can crash.

Something like (hybrid patch, to get the idea) :

--- a/mm/swap.c 2006-01-26 15:58:42.000000000 +0100
+++ b/mm/swap.c 2006-01-26 16:00:54.000000000 +0100
@@ -472,9 +472,12 @@
  {
         long count;
         long *pcount;
-       int cpu = get_cpu();

-       pcount = per_cpu_ptr(fbc->counters, cpu);
+       if (unlikely(fbc->counters == NULL)) {
+               atomic_long_add(amount, &fbc->count);
+               return;
+       }
+       pcount = per_cpu_ptr(fbc->counters, get_cpu());
         count = *pcount + amount;
         if (count >= FBC_BATCH || count <= -FBC_BATCH) {
                 atomic_long_add(count, &fbc->count);
--- a/include/linux/percpu_counter.h    2006-01-26 16:02:31.000000000 +0100
+++ b/include/linux/percpu_counter.h    2006-01-26 16:02:53.000000000 +0100
@@ -35,7 +35,8 @@

  static inline void percpu_counter_destroy(struct percpu_counter *fbc)
  {
-       free_percpu(fbc->counters);
+       if (fbc->counters)
+               free_percpu(fbc->counters);
  }

  void percpu_counter_mod(struct percpu_counter *fbc, long amount);


Eric
