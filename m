Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbSJ1IxD>; Mon, 28 Oct 2002 03:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbSJ1Iw7>; Mon, 28 Oct 2002 03:52:59 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:23986 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263207AbSJ1Iw5>;
	Mon, 28 Oct 2002 03:52:57 -0500
Date: Mon, 28 Oct 2002 14:32:20 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.44-mm5
Message-ID: <20021028143220.B4067@in.ibm.com>
References: <1035547268.3db9328488960@kolivas.net> <20021025180921.B14451@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021025180921.B14451@in.ibm.com>; from dipankar@in.ibm.com on Fri, Oct 25, 2002 at 12:36:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 12:36:45PM +0000, Dipankar Sarma wrote:
> ...
> The patch below should fix your problem, hopefully. Although I 
> don't understand why kstat initialization isn't in common code.

My mistake...it should be in common code.  I missed the #endif after 
kernel_flag definition....and was dumb enough to think sched_init
was defined only for CONFIG_SMP || CONFIG_PREEMPT....sheesh..
Here's the fix...moves init_kstat to common code; applies on mm6

Thanks,
Kiran

 
--- mm6.orig/kernel/sched.c	Mon Oct 28 11:36:57 2002
+++ mm6.fix/kernel/sched.c	Mon Oct 28 11:47:39 2002
@@ -2117,6 +2117,18 @@
 #endif
 
 #if CONFIG_SMP || CONFIG_PREEMPT
+/*
+ * The 'big kernel lock'
+ *
+ * This spinlock is taken and released recursively by lock_kernel()
+ * and unlock_kernel().  It is transparently dropped and reaquired
+ * over schedule().  It is used to protect legacy code that hasn't
+ * been migrated to a proper locking design yet.
+ *
+ * Don't use in new code.
+ */
+spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+#endif
 
 static void kstat_init_cpu(int cpu)
 {
@@ -2149,21 +2161,6 @@
 	register_cpu_notifier(&kstat_nb);  
 }
 
-/*
- * The 'big kernel lock'
- *
- * This spinlock is taken and released recursively by lock_kernel()
- * and unlock_kernel().  It is transparently dropped and reaquired
- * over schedule().  It is used to protect legacy code that hasn't
- * been migrated to a proper locking design yet.
- *
- * Don't use in new code.
- */
-spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-#else
-static inline void init_kstat(void) { }
-#endif
-
 void __init sched_init(void)
 {
 	runqueue_t *rq;
