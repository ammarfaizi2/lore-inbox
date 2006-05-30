Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWE3U0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWE3U0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWE3U0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:26:34 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:1228 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932401AbWE3U0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:26:33 -0400
Date: Tue, 30 May 2006 22:26:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm1] lock validator: fix RT_HASH_LOCK_SZ
Message-ID: <20060530202654.GA25720@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <adaac8z70yc.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaac8z70yc.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roland Dreier <rdreier@cisco.com> wrote:

> Building 2.6.17-rc5-mm1, I get this:
> 
> 	net/built-in.o: In function `ip_rt_init':
> 	(.init.text+0xb04): undefined reference to `__you_cannot_kmalloc_that_much'

could you try the patch below and set NR_CPUS back to 32?

-----------
Subject: lock validator: fix RT_HASH_LOCK_SZ
From: Ingo Molnar <mingo@elte.hu>

on lockdep we have a quite big spinlock_t, so keep the size down.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 net/ipv4/route.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

Index: linux/net/ipv4/route.c
===================================================================
--- linux.orig/net/ipv4/route.c
+++ linux/net/ipv4/route.c
@@ -212,17 +212,22 @@ struct rt_hash_bucket {
 /*
  * Instead of using one spinlock for each rt_hash_bucket, we use a table of spinlocks
  * The size of this table is a power of two and depends on the number of CPUS.
+ * (on lockdep we have a quite big spinlock_t, so keep the size down there)
  */
-#if NR_CPUS >= 32
-#define RT_HASH_LOCK_SZ	4096
-#elif NR_CPUS >= 16
-#define RT_HASH_LOCK_SZ	2048
-#elif NR_CPUS >= 8
-#define RT_HASH_LOCK_SZ	1024
-#elif NR_CPUS >= 4
-#define RT_HASH_LOCK_SZ	512
+#ifdef CONFIG_LOCKDEP
+# define RT_HASH_LOCK_SZ	256
 #else
-#define RT_HASH_LOCK_SZ	256
+# if NR_CPUS >= 32
+#  define RT_HASH_LOCK_SZ	4096
+# elif NR_CPUS >= 16
+#  define RT_HASH_LOCK_SZ	2048
+# elif NR_CPUS >= 8
+#  define RT_HASH_LOCK_SZ	1024
+# elif NR_CPUS >= 4
+#  define RT_HASH_LOCK_SZ	512
+# else
+#  define RT_HASH_LOCK_SZ	256
+# endif
 #endif
 
 static spinlock_t	*rt_hash_locks;
