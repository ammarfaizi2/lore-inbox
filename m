Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSGYQ0K>; Thu, 25 Jul 2002 12:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSGYQ0K>; Thu, 25 Jul 2002 12:26:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:61942 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315266AbSGYQ0K>; Thu, 25 Jul 2002 12:26:10 -0400
Subject: Re: [PATCH] generalized spin_lock_bit, take two
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <3D3F61A2.10661C93@zip.com.au>
References: <1027556989.927.1646.camel@sinai> 
	<3D3F61A2.10661C93@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Jul 2002 09:29:21 -0700
Message-Id: <1027614561.1697.11.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 19:25, Andrew Morton wrote:

> I did some testing yesterday with fork/exec/exit-intensive
> workloads and the contention rate on pte_chain_lock was 0.3%,
> so the efficiency problems which Linus described are unlikely
> to bite us in this particular application.  But if the usage
> of spin_lock_bit() were to widen, some platforms may be impacted.

At this point (with Linus asking me to keep the "pte_chain_lock()"
interface) I do not really care so long as we not compile the actual
locking on UP.

Will you take this patch, then?

	Robert Love

diff -urN linux-2.5.28/include/linux/page-flags.h linux/include/linux/page-flags.h
--- linux-2.5.28/include/linux/page-flags.h	Wed Jul 24 14:03:21 2002
+++ linux/include/linux/page-flags.h	Thu Jul 25 09:27:01 2002
@@ -228,6 +228,8 @@
 #define ClearPageDirect(page)		clear_bit(PG_direct, &(page)->flags)
 #define TestClearPageDirect(page)	test_and_clear_bit(PG_direct, &(page)->flags)
 
+#ifdef CONFIG_SMP
+
 /*
  * inlines for acquisition and release of PG_chainlock
  */
@@ -253,6 +255,20 @@
 	preempt_enable();
 }
 
+#else
+
+static inline void pte_chain_lock(struct page *page)
+{
+	preempt_disable();
+}
+
+static inline void pte_chain_unlock(struct page *page)
+{
+	preempt_enable();
+}
+
+#endif
+
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.

