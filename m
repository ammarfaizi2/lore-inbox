Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315455AbSFTRVd>; Thu, 20 Jun 2002 13:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSFTRVc>; Thu, 20 Jun 2002 13:21:32 -0400
Received: from holomorphy.com ([66.224.33.161]:25791 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315455AbSFTRV3>;
	Thu, 20 Jun 2002 13:21:29 -0400
Date: Thu, 20 Jun 2002 10:20:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
Message-ID: <20020620172059.GW22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@suse.de>, Ingo Molnar <mingo@elte.hu>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20020619112308.GA11631@suse.de> <Pine.LNX.4.44.0206200123470.25434-100000@e2> <20020620014729.X29373@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020620014729.X29373@suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 01:47:29AM +0200, Dave Jones wrote:
> I'll take a look at this tomorrow, unless William "no sleep `til 2.6" Irwin
> beats me to it 8-)  (he did this part of the patch iirc).

How does this look? (compiles, boots, & runs on UP i386)

Cheers,
Bill


diff -urN linux-2.5.23-virgin/include/linux/sched.h linux-2.5.23-wli/include/linux/sched.h
--- linux-2.5.23-virgin/include/linux/sched.h	Thu Jun 20 00:10:26 2002
+++ linux-2.5.23-wli/include/linux/sched.h	Thu Jun 20 08:21:30 2002
@@ -144,6 +144,7 @@
 typedef struct task_struct task_t;
 
 extern void sched_init(void);
+extern void pidhash_init(void);
 extern void init_idle(task_t *idle, int cpu);
 extern void show_state(void);
 extern void cpu_init (void);
diff -urN linux-2.5.23-virgin/init/main.c linux-2.5.23-wli/init/main.c
--- linux-2.5.23-virgin/init/main.c	Thu Jun 20 00:10:27 2002
+++ linux-2.5.23-wli/init/main.c	Thu Jun 20 08:21:04 2002
@@ -347,6 +347,7 @@
 	trap_init();
 	init_IRQ();
 	sched_init();
+	pidhash_init();
 	softirq_init();
 	time_init();
 
diff -urN linux-2.5.23-virgin/kernel/fork.c linux-2.5.23-wli/kernel/fork.c
--- linux-2.5.23-virgin/kernel/fork.c	Thu Jun 20 00:10:27 2002
+++ linux-2.5.23-wli/kernel/fork.c	Thu Jun 20 08:20:33 2002
@@ -27,7 +27,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/jiffies.h>
-
+#include <linux/bootmem.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -49,6 +49,25 @@
 
 list_t *pidhash;
 unsigned long pidhash_size;
+
+void __init pidhash_init(void)
+{
+	int i, size = PAGE_SIZE*sizeof(list_t);
+
+	do {
+		pidhash = (list_t *)alloc_bootmem(size);
+		if (!pidhash)
+			size >>= 1;
+	} while (!pidhash && size >= sizeof(list_t));
+
+	if (!pidhash)
+		panic("Failed to allocated pid hash table!\n");
+
+	pidhash_size = size/sizeof(list_t);
+
+	for (i = 0; i < pidhash_size; ++i)
+		INIT_LIST_HEAD(&pidhash[i]);
+}
 
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
 
diff -urN linux-2.5.23-virgin/kernel/sched.c linux-2.5.23-wli/kernel/sched.c
--- linux-2.5.23-virgin/kernel/sched.c	Thu Jun 20 00:10:27 2002
+++ linux-2.5.23-wli/kernel/sched.c	Thu Jun 20 08:20:47 2002
@@ -1662,21 +1662,7 @@
 void __init sched_init(void)
 {
 	runqueue_t *rq;
-	int i, j, k, size = PAGE_SIZE*sizeof(list_t);
-
-	do {
-		pidhash = (list_t *)alloc_bootmem(size);
-		if (!pidhash)
-			size >>= 1;
-	} while (!pidhash && size >= sizeof(list_t));
-
-	if (!pidhash)
-		panic("Failed to allocated pid hash table!\n");
-
-	pidhash_size = size/sizeof(list_t);
-
-	for (i = 0; i < pidhash_size; ++i)
-		INIT_LIST_HEAD(&pidhash[i]);
+	int i, j, k;
 
 	for (i = 0; i < NR_CPUS; i++) {
 		prio_array_t *array;
