Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbUKKJTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbUKKJTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 04:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUKKJTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 04:19:22 -0500
Received: from mx1.elte.hu ([157.181.1.137]:28569 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262054AbUKKJSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 04:18:55 -0500
Date: Thu, 11 Nov 2004 11:20:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
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
Message-ID: <20041111102057.GA18801@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <4192F244.7020103@cybsft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <4192F244.7020103@cybsft.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* K.R. Foley <kr@cybsft.com> wrote:

> Here is the updated rtc-debug patch. This version unlike previous
> versions doesn't change the way the rtc driver works. The output of
> /dev/rtc is preserved also so it doesn't break the existing
> functionality of rtc. By the same token it won't produce output usable
> by amlat, but it works for measuring the latency from interrupt to
> read.  It doesn't measure when a poll is satisfied yet because I
> didn't need that yet. It doesn't trigger the end until the read.

i've done some further cleanups: made it .config configurable
(CONFIG_RTC_HISTOGRAM), moved the latency-histogram construction code
into separate functions to make it more apparent that there is no impact
to the normal codepaths. Patch attached.

	Ingo

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rtc-hist-2.6.10-rc1-mm3-A0"

--- linux/drivers/char/Kconfig.orig
+++ linux/drivers/char/Kconfig
@@ -729,6 +729,15 @@ config RTC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rtc.
 
+config RTC_HISTOGRAM
+	tristate "Real Time Clock Histogram Support"
+	default y
+	depends on RTC
+	---help---
+	  If you say Y here then the kernel will track the delivery and
+	  wakeup latency of /dev/rtc using tasks and will report a
+	  histogram to the kernel log when the application closes /dev/rtc.
+
 config SGI_DS1286
 	tristate "SGI DS1286 RTC support"
 	depends on SGI_IP22
--- linux/drivers/char/rtc.c.orig
+++ linux/drivers/char/rtc.c
@@ -86,6 +86,28 @@
 #include <asm/hpet.h>
 #endif
 
+#ifdef CONFIG_RTC_HISTOGRAM
+
+static int rtc_running;
+static cycles_t last_interrupt_time;
+
+#include <asm/timex.h>
+
+#define CPU_MHZ		(cpu_khz / 1000)
+
+#define HISTSIZE	10000
+static int histogram[HISTSIZE];
+
+static int rtc_state;
+
+enum rtc_states {
+	S_IDLE,			/* Waiting for an interrupt */
+	S_WAITING_FOR_READ,	/* Signal delivered. waiting for rtc_read() */
+	S_READ_MISSED,		/* Signal delivered, read() deadline missed */
+};
+
+#endif
+
 #ifdef __sparc__
 #include <linux/pci.h>
 #include <asm/ebus.h>
@@ -205,6 +227,132 @@ static inline unsigned char rtc_is_updat
 }
 
 #ifdef RTC_IRQ
+
+static inline void rtc_open_event(void)
+{
+#ifdef CONFIG_RTC_HISTOGRAM
+	int i;
+
+	last_interrupt_time = 0;
+	rtc_state = S_IDLE;
+	rtc_irq_data = 0;
+
+	rtc_running = 1;
+	for (i = 0; i < HISTSIZE; i++)
+		histogram[i] = 0;
+#endif
+}
+
+static inline void rtc_wake_event(void)
+{
+#ifndef CONFIG_RTC_HISTOGRAM
+	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
+#else
+	if (!(rtc_status & RTC_IS_OPEN))
+		return;
+
+	switch (rtc_state) {
+	case S_IDLE:			/* Waiting for an interrupt */
+		last_interrupt_time = get_cycles();
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
+#endif
+}
+
+static inline void rtc_read_event(void)
+{
+#ifdef CONFIG_RTC_HISTOGRAM
+	cycles_t now = get_cycles();
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
+			cycles_t latency = now - last_interrupt_time;
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
+#endif
+}
+
+static inline void rtc_close_event(void)
+{
+#ifdef CONFIG_RTC_HISTOGRAM
+	int i = 0;
+	unsigned long total = 0;
+	printk("rtc histogram:\n");
+	for (i = 0; i < HISTSIZE; i++) {
+		if (histogram[i]) {
+			total += histogram[i];
+			printk("%d %d\n", i, histogram[i]);
+		}
+	}
+	printk("\nTotal samples: %lu\n", total);
+	rtc_running = 0;
+#endif
+}
+
 /*
  *	A very tiny interrupt handler. It runs with SA_INTERRUPT set,
  *	but there is possibility of conflicting with the set_rtc_mmss()
@@ -250,7 +398,7 @@ irqreturn_t rtc_interrupt(int irq, void 
 	spin_unlock(&rtc_task_lock);
 	wake_up_interruptible(&rtc_wait);	
 
-	kill_fasync (&rtc_async_queue, SIGIO, POLL_IN);
+	rtc_wake_event();
 
 	return IRQ_HANDLED;
 }
@@ -354,6 +502,8 @@ static ssize_t rtc_read(struct file *fil
 		schedule();
 	} while (1);
 
+	rtc_read_event();
+
 	if (count < sizeof(unsigned long))
 		retval = put_user(data, (unsigned int __user *)buf) ?: sizeof(int); 
 	else
@@ -692,6 +848,7 @@ static int rtc_open(struct inode *inode,
 	rtc_status |= RTC_IS_OPEN;
 
 	rtc_irq_data = 0;
+	rtc_open_event();
 	spin_unlock_irq (&rtc_lock);
 	return 0;
 
@@ -744,6 +901,7 @@ no_irq:
 	rtc_irq_data = 0;
 	rtc_status &= ~RTC_IS_OPEN;
 	spin_unlock_irq (&rtc_lock);
+	rtc_close_event();
 	return 0;
 }
 

--fUYQa+Pmc3FrFX/N--
