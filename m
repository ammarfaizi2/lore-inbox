Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422777AbWA1BKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbWA1BKG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422779AbWA1BKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:10:06 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:1134 "EHLO smtp.cegetel.net")
	by vger.kernel.org with ESMTP id S1422777AbWA1BKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:10:04 -0500
Message-ID: <43DAC46B.3010200@cosmosbay.com>
Date: Sat, 28 Jan 2006 02:10:03 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: kiran@scalex86.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
References: <20060126185649.GB3651@localhost.localdomain>	<20060126190357.GE3651@localhost.localdomain>	<43D9DFA1.9070802@cosmosbay.com>	<20060127195227.GA3565@localhost.localdomain>	<20060127121602.18bc3f25.akpm@osdl.org>	<20060127224433.GB3565@localhost.localdomain>	<43DAA586.5050609@cosmosbay.com>	<20060127151635.3a149fe2.akpm@osdl.org>	<43DABAA4.8040208@cosmosbay.com> <20060127164308.1ea4c3e5.akpm@osdl.org>
In-Reply-To: <20060127164308.1ea4c3e5.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030001050404050803000506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030001050404050803000506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton a écrit :
> Eric Dumazet <dada1@cosmosbay.com> wrote:
>>> An advantage of retaining a spinlock in percpu_counter is that if accuracy
>>> is needed at a low rate (say, /proc reading) we can take the lock and then
>>> go spill each CPU's local count into the main one.  It would need to be a
>>> very low rate though.   Or we make the cpu-local counters atomic too.
>> We might use atomic_long_t only (and no spinlocks)
> 
> Yup, that's it.
> 
>> Something like this ?
>>
> 
> It'd be a lot neater if we had atomic_long_xchg().

You are my guest :)

[PATCH] Add atomic_long_xchg() and atomic_long_cmpxchg() wrappers

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>



--------------030001050404050803000506
Content-Type: text/plain;
 name="atomic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic.patch"

--- a/include/asm-generic/atomic.h	2006-01-28 02:59:49.000000000 +0100
+++ b/include/asm-generic/atomic.h	2006-01-28 02:57:36.000000000 +0100
@@ -66,6 +66,18 @@
 	atomic64_sub(i, v);
 }
 
+static inline long atomic_long_xchg(atomic_long_t *l, long val)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	return atomic64_xchg(v, val);
+}
+
+static inline long atomic_long_cmpxchg(atomic_long_t *l, long old, long new)
+{
+	atomic64_t *v = (atomic64_t *)l;
+	return atomic64_cmpxchg(v, old, new);
+}
+
 #else
 
 typedef atomic_t atomic_long_t;
@@ -113,5 +125,17 @@
 	atomic_sub(i, v);
 }
 
+static inline long atomic_long_xchg(atomic_long_t *l, long val)
+{
+	atomic_t *v = (atomic_t *)l;
+	return atomic_xchg(v, val);
+}
+
+static inline long atomic_long_cmpxchg(atomic_long_t *l, long old, long new)
+{
+	atomic_t *v = (atomic_t *)l;
+	return atomic_cmpxchg(v, old, new);
+}
+
 #endif
 #endif

--------------030001050404050803000506--
