Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268051AbUIIWv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbUIIWv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267999AbUIIWv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:51:26 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:24019 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266705AbUIIWuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:50:01 -0400
Subject: Updated rtc-debug patch
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Message-Id: <1094770200.1396.18.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 18:50:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, this is an updated version of your rtc-debug patch with some
minor changes:

    - Histogram bins are 1 usec instead of 10
 
    - Histogram displays one bin per line rather than 5.  You may prefer the 
      other way, but I think this makes it easier to gnuplot the results.

    - Line numbers tweaked to apply cleanly

This should make it easy to measure the much improved latencies we are
getting now.  I have never posted a kernel patch before, apologies if I
got the 'Signed-Off-By' wrong.

For anyone unfamiliar this patch is designed to be used with amlat:

http://www.zip.com.au/~akpm/linux/schedlat.html#amlat

amlat itself does not need to be modified to use with recent kernels.

Example output with the voluntary-preempt-S0:

rtc histogram:
31 3152
32 2654
33 2895
34 1673934
35 631584
36 59189
37 62070
38 57622
39 40790
40 28464
41 17503
42 8406
43 3457
44 1586
45 1194
46 1175
47 520
48 439
49 457
50 493
51 413
52 329
53 258
54 4041
55 1638
56 659
57 23485
58 13043
59 41537
60 31171
61 1475
62 1208
63 1318
64 1303
65 1424
66 1515
67 1451
68 1208
69 1053
70 919
71 696
72 440
73 311
74 192
75 114
76 83
77 89
78 59
79 58
80 46
81 60
82 32
83 19
84 27
85 16
86 8
87 6
88 10
89 7
90 8
91 5
92 6
93 6
94 2
95 2
96 1
97 3
98 1
99 1
100 1
101 2
105 3
106 1
107 1
108 3
109 2
110 1
116 1
117 1
132 1
135 1
136 1

Total samples: 2729359

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

diff -puN arch/i386/kernel/traps.c~rtc-debug arch/i386/kernel/traps.c
--- 25/arch/i386/kernel/traps.c~rtc-debug	2004-07-10 21:27:15.210032360 -0700
+++ 25-akpm/arch/i386/kernel/traps.c	2004-07-10 21:27:15.216031448 -0700
@@ -197,14 +197,51 @@ void show_stack(struct task_struct *task
 	for(i = 0; i < kstack_depth_to_print; i++) {
 		if (kstack_end(stack))
 			break;
-		if (i && ((i % 8) == 0))
-			printk("\n       ");
+		if (i && ((i % 8) == 0)) {
+			printk("\n");
+			printk("       ");
+		}
 		printk("%08lx ", *stack++);
 	}
 	printk("\nCall Trace:\n");
 	show_trace(task, esp);
 }
 
+static void show_trace_local(void)
+{
+	printk("CPU %d:\n", smp_processor_id());
+	show_trace(0, 0);
+}
+
+#ifdef CONFIG_SMP
+static atomic_t trace_cpu;
+
+static void show_trace_one(void *dummy)
+{
+	while (atomic_read(&trace_cpu) != smp_processor_id())
+		;
+	show_trace_local();
+	atomic_inc(&trace_cpu);
+	while (atomic_read(&trace_cpu) != num_online_cpus())
+		;
+}
+
+void show_trace_smp(void)
+{
+	atomic_set(&trace_cpu, 0);
+	smp_call_function(show_trace_one, 0, 1, 0);
+	show_trace_one(0);
+}
+
+#else
+
+void show_trace_smp(void)
+{
+	show_trace_local();
+}
+
+#endif
+
 /*
  * The architecture-independent dump_stack generator
  */
diff -puN drivers/char/rtc.c~rtc-debug drivers/char/rtc.c
--- 25/drivers/char/rtc.c~rtc-debug	2004-07-10 21:27:15.212032056 -0700
+++ 25-akpm/drivers/char/rtc.c	2004-07-10 21:27:15.218031144 -0700
@@ -86,6 +86,18 @@
 #include <asm/hpet.h>
 #endif
 
+static unsigned long long last_interrupt_time;
+
+#include <asm/timex.h>
+
+
+#define CPU_MHZ	(cpu_khz / 1000)
+#define HISTSIZE	1000
+static int histogram[HISTSIZE];
+
+int rtc_debug;
+int rtc_running;
+
 #ifdef __sparc__
 #include <linux/pci.h>
 #include <asm/ebus.h>
@@ -191,6 +204,16 @@ static unsigned long epoch = 1900;	/* ye
 static const unsigned char days_in_mo[] = 
 {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
 
+static int rtc_state;
+
+enum rtc_states {
+	S_IDLE,			/* Waiting for an interrupt */
+	S_WAITING_FOR_READ,	/* Signal delivered. waiting for rtc_read() */
+	S_READ_MISSED,		/* Signal delivered, read() deadline missed */
+};
+
+void show_trace_smp(void);
+
 /*
  * Returns true if a clock update is in progress
  */
@@ -223,7 +246,6 @@ irqreturn_t rtc_interrupt(int irq, void 
 	 *	low byte and the number of interrupts received since
 	 *	the last read in the remainder of rtc_irq_data.
 	 */
-
 	spin_lock (&rtc_lock);
 	rtc_irq_data += 0x100;
 	rtc_irq_data &= ~0xff;
@@ -250,7 +272,36 @@ irqreturn_t rtc_interrupt(int irq, void 
 	spin_unlock(&rtc_task_lock);
 	wake_up_interruptible(&rtc_wait);	
 
-	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
+	if (!(rtc_status & RTC_IS_OPEN))
+		goto tata;
+
+	switch (rtc_state) {
+	case S_IDLE:			/* Waiting for an interrupt */
+		rdtscll(last_interrupt_time);
+		kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
+		rtc_state = S_WAITING_FOR_READ;
+		break;
+	case S_WAITING_FOR_READ:	/* Signal has been delivered. waiting for rtc_read() */
+		/*
+		 * Well foo.  The usermode application didn't schedule and read in time.
+		 */
+		rtc_state = S_READ_MISSED;
+		if (strcmp(current->comm, "amlat") != 0) {
+			printk("`%s'[%d] is being piggy.  "
+					"need_resched=%d, cpu=%d\n",
+				current->comm, current->pid,
+				need_resched(), smp_processor_id());
+			show_trace_smp();
+		}
+		break;
+	case S_READ_MISSED:		/* Signal has been delivered, read() deadline was missed */
+		/*
+		 * Not much we can do here.  We're waiting for the usermode
+		 * application to read the rtc
+		 */
+		break;
+	}
+tata:
 
 	return IRQ_HANDLED;
 }
@@ -310,8 +361,74 @@ static void __exit cleanup_sysctl(void)
  *	Now all the various file operations that we export.
  */
 
-static ssize_t rtc_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t ll_rtc_read(struct file *file, char *buf,
+				size_t count, loff_t *ppos)
+{
+	ssize_t retval;
+	unsigned long long now;
+
+	rdtscll(now);
+
+	switch (rtc_state) {
+	case S_IDLE:			/* Waiting for an interrupt */
+		/*
+		 * err...  This can't be happening
+		 */
+		printk("ll_rtc_read(): called in state S_IDLE!\n");
+		break;
+	case S_WAITING_FOR_READ:	/*
+					 * Signal has been delivered.
+					 * waiting for rtc_read()
+					 */
+		/*
+		 * Well done
+		 */
+	case S_READ_MISSED:		/*
+					 * Signal has been delivered, read()
+					 * deadline was missed
+					 */
+		/*
+		 * So, you finally got here.
+		 */
+		if (last_interrupt_time == 0)
+			printk("ll_rtc_read(): we screwed up.  "
+					"last_interrupt_time = 0\n");
+		rtc_state = S_IDLE;
+		{
+			unsigned long long latency = now - last_interrupt_time;
+			unsigned long delta;	/* Nocroseconds */
+
+			delta = latency;
+			delta /= CPU_MHZ;
+			if (delta > 1000 * 1000) {
+				printk("rtc: eek\n");
+			} else {
+				unsigned long slot = delta;
+				if (slot >= HISTSIZE)
+					slot = HISTSIZE - 1;
+				histogram[slot]++;
+				if (delta > 2000)
+					printk("wow!  That was a "
+							"%ld millisec bump\n",
+						delta / 1000);
+			}
+		}
+		rtc_state = S_IDLE;
+		break;
+	}
+
+	if (count < sizeof(last_interrupt_time))
+		return -EINVAL;
+
+	retval = -EIO;
+	if (copy_to_user(buf, &last_interrupt_time,
+				sizeof(last_interrupt_time)) == 0)
+		retval = sizeof(last_interrupt_time);
+	return retval;
+}
+
+static ssize_t orig_rtc_read(struct file *file, char *buf,
+  			size_t count, loff_t *ppos)
 {
 #ifndef RTC_IRQ
 	return -EIO;
@@ -366,6 +483,19 @@ static ssize_t rtc_read(struct file *fil
 #endif
 }
 
+/*
+ * If anyone reads this, please send me an email describing
+ * the superlative elegance of this conception
+ */
+static ssize_t rtc_read(struct file *file, char *buf,
+			size_t count, loff_t *ppos)
+{
+	if (strcmp(current->comm, "amlat") == 0)
+		return ll_rtc_read(file, buf, count, ppos);
+	else
+		return orig_rtc_read(file, buf, count, ppos);
+}
+
 static int rtc_do_ioctl(unsigned int cmd, unsigned long arg, int kernel)
 {
 	struct rtc_time wtime; 
@@ -684,6 +814,8 @@ static int rtc_ioctl(struct inode *inode
  * needed here. Or anywhere else in this driver. */
 static int rtc_open(struct inode *inode, struct file *file)
 {
+	int i;
+
 	spin_lock_irq (&rtc_lock);
 
 	if(rtc_status & RTC_IS_OPEN)
@@ -691,7 +823,16 @@ static int rtc_open(struct inode *inode,
 
 	rtc_status |= RTC_IS_OPEN;
 
-	rtc_irq_data = 0;
+	if (strcmp(current->comm, "amlat") == 0) {
+		last_interrupt_time = 0;
+		rtc_state = S_IDLE;
+		rtc_irq_data = 0;
+	}
+
+	rtc_running = 1;
+	for (i = 0; i < HISTSIZE; i++)
+		histogram[i] = 0;
+
 	spin_unlock_irq (&rtc_lock);
 	return 0;
 
@@ -744,6 +885,22 @@ no_irq:
 	rtc_irq_data = 0;
 	rtc_status &= ~RTC_IS_OPEN;
 	spin_unlock_irq (&rtc_lock);
+	{
+		int i = 0;
+		unsigned long total = 0;
+		printk("rtc histogram:\n");
+		for (i = 0; i < HISTSIZE; i++) {
+			if (histogram[i]) {
+				total += histogram[i];
+				printk("%d %d\n", i, histogram[i]);
+			}
+		}
+		printk("\nTotal samples: %lu\n", total);
+		rtc_running = 0;
+#if LOWLATENCY_DEBUG
+		show_lolat_stats();
+#endif
+	}
 	return 0;
 }
 
@@ -1112,6 +1274,7 @@ static void rtc_dropped_irq(unsigned lon
 	wake_up_interruptible(&rtc_wait);
 
 	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
+	return;
 }
 #endif
 
_


