Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbUJ0Rht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbUJ0Rht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbUJ0RfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:35:13 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11174 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262529AbUJ0R07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:26:59 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <417FD915.304@cybsft.com>
References: <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com>
	 <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com>
	 <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com>
	 <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com>
	 <20041027150548.GA11233@elte.hu>
	 <1098889994.1448.14.camel@krustophenia.net>
	 <20041027151701.GA11736@elte.hu> <1098897241.8596.5.camel@krustophenia.net>
	 <417FD915.304@cybsft.com>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 13:26:54 -0400
Message-Id: <1098898017.8596.9.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 12:21 -0500, K.R. Foley wrote:
> > 
> > Anyway I am generating a cleaned up version of the patch agaqinst
> > 2.6.9-mm1.
> > 
> > Lee
> > 
> 
> Actually if you are cleaning it up anyway, could you fix it to work with 
> Ingo's changes to rtc.c? If not I will be glad to do it. Up until one of 
> the last couple of versions of RT PREEMPT it applied cleanly, but I just 
> tried it and it failed.

Yup, here it is against 2.6.9-mm1-V0.4.1.  Not yet tested (building now)
but should work.  I took out the show_trace_smp part because that never
worked, I always get "Stack pointer is garbage".  So now the patch is
smaller and only touches rtc.c.

--- linux-2.6.9-mm1/drivers/char/rtc.c	2004-10-27 13:19:04.000000000 -0400
+++ linux-2.6.9-mm1-V0.4.1/drivers/char/rtc.c	2004-10-27 12:55:23.000000000 -0400
@@ -86,6 +86,18 @@
 #include <asm/hpet.h>
 #endif
 
+static unsigned long long last_interrupt_time;
+
+#include <asm/timex.h>
+
+
+#define CPU_MHZ	(cpu_khz / 1000)
+#define HISTSIZE	10000
+static int histogram[HISTSIZE];
+
+int rtc_debug;
+int rtc_running;
+
 #ifdef __sparc__
 #include <linux/pci.h>
 #include <asm/ebus.h>
@@ -191,6 +203,14 @@
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
 /*
  * Returns true if a clock update is in progress
  */
@@ -259,7 +279,36 @@
 	spin_unlock_irqrestore(&rtc_task_lock, flags);
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
+			/* show_trace_smp(); */
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
@@ -319,8 +368,74 @@
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
@@ -375,6 +490,19 @@
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
@@ -692,6 +820,8 @@
  * needed here. Or anywhere else in this driver. */
 static int rtc_open(struct inode *inode, struct file *file)
 {
+	int i;
+
 	spin_lock_irq (&rtc_lock);
 
 	if(rtc_status & RTC_IS_OPEN)
@@ -699,7 +829,16 @@
 
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
 
@@ -753,6 +892,19 @@
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
+	}
 	return 0;
 }
 
@@ -1127,6 +1279,7 @@
 	wake_up_interruptible(&rtc_wait);
 
 	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
+	return;
 }
 #endif
 




