Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbUKKFCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbUKKFCT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 00:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbUKKFCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 00:02:19 -0500
Received: from relay03.pair.com ([209.68.5.17]:59666 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S262098AbUKKFB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 00:01:58 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <4192F244.7020103@cybsft.com>
Date: Wed, 10 Nov 2004 23:01:56 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
References: <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu>
In-Reply-To: <20041109160544.GA28242@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020208000805090006080709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020208000805090006080709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the -V0.7.23 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 

Here is the updated rtc-debug patch. This version unlike previous 
versions doesn't change the way the rtc driver works. The output of 
/dev/rtc is preserved also so it doesn't break the existing 
functionality of rtc. By the same token it won't produce output usable 
by amlat, but it works for measuring the latency from interrupt to read. 
It doesn't measure when a poll is satisfied yet because I didn't need 
that yet. It doesn't trigger the end until the read.

kr

--------------020208000805090006080709
Content-Type: text/x-patch;
 name="rtc-debug2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtc-debug2.patch"

--- linux-2.6.10-rc1-mm3/drivers/char/rtc.c.orig	2004-11-10 21:27:39.106900807 -0600
+++ linux-2.6.10-rc1-mm3/drivers/char/rtc.c	2004-11-10 20:45:39.000000000 -0600
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
@@ -259,7 +279,37 @@
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
+		printk("Read missed before next interrupt\n");
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
@@ -328,6 +378,7 @@
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long data;
 	ssize_t retval;
+	unsigned long long now;
 	
 	if (rtc_has_irq == 0)
 		return -EIO;
@@ -363,6 +414,56 @@
 		schedule();
 	} while (1);
 
+	rdtscll(now);
+
+	switch (rtc_state) {
+	case S_IDLE:			/* Waiting for an interrupt */
+		/*
+		 * err...  This can't be happening
+		 */
+		printk("rtc_read(): called in state S_IDLE!\n");
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
+			printk("rtc_read(): we screwed up.  "
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
 	if (count < sizeof(unsigned long))
 		retval = put_user(data, (unsigned int __user *)buf) ?: sizeof(int); 
 	else
@@ -692,6 +793,8 @@
  * needed here. Or anywhere else in this driver. */
 static int rtc_open(struct inode *inode, struct file *file)
 {
+	int i;
+
 	spin_lock_irq (&rtc_lock);
 
 	if(rtc_status & RTC_IS_OPEN)
@@ -700,6 +803,14 @@
 	rtc_status |= RTC_IS_OPEN;
 
 	rtc_irq_data = 0;
+	last_interrupt_time = 0;
+	rtc_state = S_IDLE;
+	rtc_irq_data = 0;
+
+	rtc_running = 1;
+	for (i = 0; i < HISTSIZE; i++)
+		histogram[i] = 0;
+
 	spin_unlock_irq (&rtc_lock);
 	return 0;
 
@@ -753,6 +864,19 @@
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
 
@@ -1127,6 +1251,7 @@
 	wake_up_interruptible(&rtc_wait);
 
 	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
+	return;
 }
 #endif
 

--------------020208000805090006080709--
