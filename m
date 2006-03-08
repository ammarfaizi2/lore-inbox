Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWCHU0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWCHU0a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWCHU0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:26:30 -0500
Received: from ns1.siteground.net ([207.218.208.2]:31181 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932353AbWCHU03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:26:29 -0500
Date: Wed, 8 Mar 2006 12:26:56 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
       shai@scalex86.org
Subject: Re: [patch 1/4] net: percpufy frequently used vars -- add percpu_counter_mod_bh
Message-ID: <20060308202656.GA4493@localhost.localdomain>
References: <20060308015808.GA9062@localhost.localdomain> <20060308015934.GB9062@localhost.localdomain> <20060307181301.4dd6aa96.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307181301.4dd6aa96.akpm@osdl.org>
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

On Tue, Mar 07, 2006 at 06:13:01PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> >
> > +static inline void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount)
> >  +{
> >  +	local_bh_disable();
> >  +	percpu_counter_mod(fbc, amount);
> >  +	local_bh_enable();
> >  +}
> >  +
> 
> percpu_counter_mod() does preempt_disable(), which is redundant in this
> context.  So just do fbc->count += amount; here.

OK.  Here is the revised patch.


Add percpu_counter_mod_bh for using these counters safely from
both softirq and process context.

Signed-off by: Pravin B. Shelar <pravins@calsoftinc.com>
Signed-off by: Ravikiran G Thirumalai <kiran@scalex86.org>
Signed-off by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc5mm3/include/linux/percpu_counter.h
===================================================================
--- linux-2.6.16-rc5mm3.orig/include/linux/percpu_counter.h	2006-03-07 15:08:00.000000000 -0800
+++ linux-2.6.16-rc5mm3/include/linux/percpu_counter.h	2006-03-08 10:53:13.000000000 -0800
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
+#include <linux/interrupt.h>
 
 #ifdef CONFIG_SMP
 
@@ -40,6 +41,7 @@ static inline void percpu_counter_destro
 
 void percpu_counter_mod(struct percpu_counter *fbc, long amount);
 long percpu_counter_sum(struct percpu_counter *fbc);
+void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount);
 
 static inline long percpu_counter_read(struct percpu_counter *fbc)
 {
@@ -98,6 +100,12 @@ static inline long percpu_counter_sum(st
 	return percpu_counter_read_positive(fbc);
 }
 
+static inline void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount)
+{
+	local_bh_disable();
+	fbc->count += amount;
+	local_bh_enable();
+}
 #endif	/* CONFIG_SMP */
 
 static inline void percpu_counter_inc(struct percpu_counter *fbc)
@@ -110,4 +118,5 @@ static inline void percpu_counter_dec(st
 	percpu_counter_mod(fbc, -1);
 }
 
+
 #endif /* _LINUX_PERCPU_COUNTER_H */
Index: linux-2.6.16-rc5mm3/mm/swap.c
===================================================================
--- linux-2.6.16-rc5mm3.orig/mm/swap.c	2006-03-07 15:08:01.000000000 -0800
+++ linux-2.6.16-rc5mm3/mm/swap.c	2006-03-08 12:11:19.000000000 -0800
@@ -521,11 +521,11 @@ static int cpu_swap_callback(struct noti
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_SMP
-void percpu_counter_mod(struct percpu_counter *fbc, long amount)
+static void __percpu_counter_mod(struct percpu_counter *fbc, long amount)
 {
 	long count;
 	long *pcount;
-	int cpu = get_cpu();
+	int cpu = smp_processor_id();
 
 	pcount = per_cpu_ptr(fbc->counters, cpu);
 	count = *pcount + amount;
@@ -537,9 +537,21 @@ void percpu_counter_mod(struct percpu_co
 	} else {
 		*pcount = count;
 	}
-	put_cpu();
 }
-EXPORT_SYMBOL(percpu_counter_mod);
+
+void percpu_counter_mod(struct percpu_counter *fbc, long amount)
+{
+	preempt_disable();
+	__percpu_counter_mod(fbc, amount);
+	preempt_enable();
+}
+
+void percpu_counter_mod_bh(struct percpu_counter *fbc, long amount)
+{
+	local_bh_disable();
+	__percpu_counter_mod(fbc, amount);
+	local_bh_enable();
+}
 
 /*
  * Add up all the per-cpu counts, return the result.  This is a more accurate
@@ -559,6 +571,9 @@ long percpu_counter_sum(struct percpu_co
 	spin_unlock(&fbc->lock);
 	return ret < 0 ? 0 : ret;
 }
+
+EXPORT_SYMBOL(percpu_counter_mod);
+EXPORT_SYMBOL(percpu_counter_mod_bh);
 EXPORT_SYMBOL(percpu_counter_sum);
 #endif
 
