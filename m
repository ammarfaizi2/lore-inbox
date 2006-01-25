Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWAYXQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWAYXQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWAYXQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:16:58 -0500
Received: from ns1.siteground.net ([207.218.208.2]:36019 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932212AbWAYXQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:16:57 -0500
Date: Wed, 25 Jan 2006 15:16:54 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] Avoid use of spinlock for percpu_counter
Message-ID: <20060125231654.GB3658@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The spinlock in struct percpu_counter protects just one counter.  It's
not obvious why it was done this way (I am guessing it was because earlier,
atomic_t was guaranteed 24 bits only on some arches).  Since we have
atomic_long_t now, I don't see why this cannot be replaced with an atomic_t.

Comments?

Index: linux-2.6.16-rc1/include/linux/percpu_counter.h
===================================================================
--- linux-2.6.16-rc1.orig/include/linux/percpu_counter.h	2006-01-24 13:52:24.000000000 -0800
+++ linux-2.6.16-rc1/include/linux/percpu_counter.h	2006-01-24 14:10:26.000000000 -0800
@@ -15,8 +15,7 @@
 #ifdef CONFIG_SMP
 
 struct percpu_counter {
-	spinlock_t lock;
-	long count;
+	atomic_long_t count;
 	long *counters;
 };
 
@@ -28,8 +27,7 @@ struct percpu_counter {
 
 static inline void percpu_counter_init(struct percpu_counter *fbc)
 {
-	spin_lock_init(&fbc->lock);
-	fbc->count = 0;
+	atomic_long_set(&fbc->count, 0);
 	fbc->counters = alloc_percpu(long);
 }
 
@@ -42,7 +40,7 @@ void percpu_counter_mod(struct percpu_co
 
 static inline long percpu_counter_read(struct percpu_counter *fbc)
 {
-	return fbc->count;
+	return atomic_long_read(&fbc->count);
 }
 
 /*
@@ -51,7 +49,7 @@ static inline long percpu_counter_read(s
  */
 static inline long percpu_counter_read_positive(struct percpu_counter *fbc)
 {
-	long ret = fbc->count;
+	long ret = atomic_long_read(&fbc->count);
 
 	barrier();		/* Prevent reloads of fbc->count */
 	if (ret > 0)
Index: linux-2.6.16-rc1/mm/swap.c
===================================================================
--- linux-2.6.16-rc1.orig/mm/swap.c	2006-01-17 14:12:17.000000000 -0800
+++ linux-2.6.16-rc1/mm/swap.c	2006-01-24 14:23:20.000000000 -0800
@@ -449,9 +449,7 @@ void percpu_counter_mod(struct percpu_co
 	pcount = per_cpu_ptr(fbc->counters, cpu);
 	count = *pcount + amount;
 	if (count >= FBC_BATCH || count <= -FBC_BATCH) {
-		spin_lock(&fbc->lock);
-		fbc->count += count;
-		spin_unlock(&fbc->lock);
+		atomic_long_add(count, &fbc->count);
 		count = 0;
 	}
 	*pcount = count;
