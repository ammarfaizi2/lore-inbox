Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbUKLTLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbUKLTLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUKLTLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:11:43 -0500
Received: from mx1.elte.hu ([157.181.1.137]:53665 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261362AbUKLTLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:11:39 -0500
Date: Fri, 12 Nov 2004 21:13:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Shane Shrybman <shrybman@aei.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041112201334.GA14785@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <1100269881.10971.6.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100269881.10971.6.camel@mars>
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


* Shane Shrybman <shrybman@aei.ca> wrote:

> V0.7.25-1 has been stable here with the ivtv driver for 11 hrs. No
> sign of the ide dma time out issue either. Out of curiosity, do we
> know what solved that problem?

could you try the attached patch - does it trigger the DMA timeouts
again? There were 3 changes to the IOAPIC code that could have affected
your dma-timeout problem, this patch reverts all of them.

Mark's suggestion sounds quite plausible too - but the question is, your
timeout problems went away previously by tweaking io_apic.c, so it would
be nice to see that they are still gone even with the old 'broken'
io_apic.c logic. (none of the io_apic.c changes fixes any particular
bug, they are only latency optimizations, so i'd be surprised if they
really impacted your timeout problems.)

if the DMA timeouts are still gone even with this patch applied then i
think it's safe to conclude that Mark's explanation is the correct one,
and that it was starvation of the SCHED_OTHER IDE irq-thread that caused
the timeouts: it _really_ was a timeout. (a workaround would be to make
the timeout longer)

	Ingo

--- linux/arch/i386/kernel/io_apic.c.orig2	
+++ linux/arch/i386/kernel/io_apic.c	
@@ -150,7 +150,7 @@ static void update_io_apic_cache(unsigne
 	}
 }
 
-#define IOAPIC_CACHE
+// #define IOAPIC_CACHE
 /*
  * Some systems need a POST flush or else level-triggered interrupts
  * generate lots of spurious interrupts due to the POST-ed write not
@@ -188,7 +188,7 @@ static void __modify_IO_APIC_irq (unsign
 		/*
 		 * Force POST flush by reading:
 	 	 */
-		reg = *(IO_APIC_BASE(entry->apic)+4);
+		reg = io_apic_read(entry->apic, 0x10 + pin*2);
 #endif
 		if (!entry->next)
 			break;
@@ -1940,7 +1940,7 @@ static unsigned int startup_level_ioapic
  * unacked local APIC is dangerous on SMP as it can prevent the
  * delivery of IPIs and can thus cause deadlocks.)
  */
-#if defined(CONFIG_PREEMPT_HARDIRQS) && defined(CONFIG_SMP)
+#if defined(CONFIG_PREEMPT_HARDIRQS)
 
 static void mask_and_ack_level_ioapic_irq(unsigned int irq)
 {
