Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270958AbRIJRmG>; Mon, 10 Sep 2001 13:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271333AbRIJRl5>; Mon, 10 Sep 2001 13:41:57 -0400
Received: from ns.caldera.de ([212.34.180.1]:48616 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S270958AbRIJRlm>;
	Mon, 10 Sep 2001 13:41:42 -0400
Date: Mon, 10 Sep 2001 19:41:58 +0200
Message-Id: <200109101741.f8AHfwx17136@ns.caldera.de>
From: hch@caldera.de (Christoph Hellwig)
To: andrea@suse.de (Andrea Arcangeli)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre7aa1
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010910175416.A714@athlon.random>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010910175416.A714@athlon.random> you wrote:
> Only in 2.4.10pre4aa1: 00_paride-max_sectors-1
> Only in 2.4.10pre7aa1: 00_paride-max_sectors-2
>
> 	Rediffed (also noticed the gendisk list changes deleted too much stuff
> 	here so resurrected it).

Do you plan to submit the max_sectors changes to Linus & Alan?
Otherwise I will do as they seem to be needed for reliable operation.


> Only in 2.4.10pre7aa1: 00_rcu-1
>
> 	wait_for_rcu and call_rcu implementation (from IBM). I did some
> 	modifications with respect to the original version from IBM.
> 	In particular I dropped the vmalloc_rcu/kmalloc_rcu, the
> 	rcu_head must always be allocated in the data structures, it has
> 	to be a field of a class, rather than hiding it in the allocation
> 	and playing dirty and risky with casts on a bigger allocation.

Do we really need yet-another per-CPU thread for this?  I'd prefer to have
the context thread per-CPU instead (like in Ben's asynchio patch) and do
this as well.

BTW, do you plan to merge patches that actually _use_ this into your tree?

> Only in 2.4.10pre4aa1: 10_prefetch-4
> Only in 2.4.10pre7aa1: 10_prefetch-5
>
> 	Part of prefetch in mainline, rediffed the architectural parts.

In my tree I also have an ia64 prefetch patch (I think it's from redhat,
not sure though), it's appended if you want to take it.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

--- linux/include/asm-ia64/processor.h.org	Thu Jun 28 12:43:20 2001
+++ linux/include/asm-ia64/processor.h	Thu Jun 28 12:48:28 2001
@@ -958,6 +958,25 @@
 	return result;
 }
 
+
+#define ARCH_HAS_PREFETCH
+#define ARCH_HAS_PREFETCHW
+#define ARCH_HAS_SPINLOCK_PREFETCH
+#define PREFETCH_STRIDE 256
+
+extern inline void prefetch(const void *x)
+{
+         __asm__ __volatile__ ("lfetch [%0]" : : "r"(x));
+}
+         
+extern inline void prefetchw(const void *x)
+{
+	__asm__ __volatile__ ("lfetch.excl [%0]" : : "r"(x));
+}
+
+#define spin_lock_prefetch(x)   prefetchw(x)
+
+                  
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_IA64_PROCESSOR_H */
