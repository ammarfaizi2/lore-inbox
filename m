Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290230AbSAXBpi>; Wed, 23 Jan 2002 20:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290231AbSAXBp2>; Wed, 23 Jan 2002 20:45:28 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:5008 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290230AbSAXBpQ>;
	Wed, 23 Jan 2002 20:45:16 -0500
Date: Wed, 23 Jan 2002 17:43:43 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: mingo@elte.hu
cc: linux-kernel@vger.kernel.org
Subject: Ingo's O(1) scheduler vs. wait_init_idle
Message-ID: <119440000.1011836623@flay>
In-Reply-To: <Pine.LNX.4.33.0201211626030.12418-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201211626030.12418-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and due to popular demand there is also a patch against 2.4.18-pre4:
> 
>    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.18-pre4-J4.patch

I was trying to test this in my 8 way NUMA box, but this patch
seems to have lost half of the wait_init_idle fix that I put
in a while back. I'm not sure if this is deliberate or not, but
I suspect not, as you only removed part of it, and from your 
comment below (from a previous email), I think you understand 
the reasoning behind it:

> the new rules are this: no schedule() must be called before all bits in
> wait_init_idle are clear. I'd suggest for you to add this to the top of
> schedule():
>
>	if (wait_init_idle)
>		BUG();

Anyway, the machine won't boot without this fix, so I tried adding
it back in, and now it boots just fine. Patch is attached below.

If the removal was accidental, please could you add it back in 
as below ... if not, could we discuss why this was removed, and
maybe we can find another way to fix the problem?

Meanwhile, I'll try to knock out some benchmark figures with the
new scheduler code in place on the 8 way NUMA and a 16 way
NUMA ;-)

Martin.



diff -urN linux-2.4.18-pre4.old/init/main.c linux-2.4.18-pre4.new/init/main.c
--- linux-2.4.18-pre4.old/init/main.c	Wed Jan 23 18:26:56 2002
+++ linux-2.4.18-pre4.new/init/main.c	Wed Jan 23 18:27:04 2002
@@ -508,6 +508,14 @@
 
 	smp_threads_ready=1;
 	smp_commence();
+
+	/* Wait for the other cpus to set up their idle processes */
+	printk("Waiting on wait_init_idle (map = 0x%lx)\n", wait_init_idle);
+	while (wait_init_idle) {
+		cpu_relax();
+		barrier();
+	}
+	printk("All processors have done init_idle\n");
 }
 
 #endif
diff -urN linux-2.4.18-pre4.old/kernel/sched.c linux-2.4.18-pre4.new/kernel/sched.c
--- linux-2.4.18-pre4.old/kernel/sched.c	Wed Jan 23 18:26:56 2002
+++ linux-2.4.18-pre4.new/kernel/sched.c	Wed Jan 23 18:27:09 2002
@@ -1221,6 +1221,8 @@
 		spin_unlock(&rq2->lock);
 }
 
+extern unsigned long wait_init_idle;
+
 void __init init_idle(void)
 {
 	runqueue_t *this_rq = this_rq(), *rq = current->array->rq;
@@ -1237,6 +1239,7 @@
 	current->state = TASK_RUNNING;
 	double_rq_unlock(this_rq, rq);
 	current->need_resched = 1;
+	clear_bit(cpu(), &wait_init_idle);
 	__restore_flags(flags);
 }
 

