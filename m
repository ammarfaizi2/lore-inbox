Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVBILv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVBILv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 06:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVBILv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 06:51:58 -0500
Received: from mx1.elte.hu ([157.181.1.137]:38021 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261809AbVBILvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 06:51:53 -0500
Date: Wed, 9 Feb 2005 12:51:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050209115121.GA13608@elte.hu>
References: <20050204100347.GA13186@elte.hu> <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org>
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


* William Weston <weston@sysex.net> wrote:

> Jackd (-R -P64 -dalsa -dhw:0 -r44100 -p64 -n3 -i2 -o2) w/ one
> soft-synth client (using 15% to 30% of the CPU) will run for over 12
> hours without any xruns, even during kernel compiles and nightly
> updatedb runs.
> 
> Running wmcube (an impractical, greedy, little CPU meter), even when
> niced, causes lots of xruns.  It may be good for worst-case-scenario
> desktop load testing.

this phenomenon is very weird.

Firstly, make sure that all relevant threads (including the soundcard
IRQ thread, jackd threads, jack client thread, etc.) have higher RT
priority than any other, latency-irrelevant threads in the system.

If everything looks OK on the priority-administration side, could you
enable wakeup-latency tracing via:

 CONFIG_WAKEUP_TIMING=y
 CONFIG_PREEMPT_TRACE=y
 # CONFIG_CRITICAL_PREEMPT_TIMING is not set
 # CONFIG_CRITICAL_IRQSOFF_TIMING is not set
 CONFIG_LATENCY_TIMING=y
 CONFIG_LATENCY_TRACE=y

It should look like this in the Kernel Hacking menu of menuconfig:

       [*] Wakeup latency timing
       [ ] Non-preemptible critical section latency timing
       [ ] Interrupts-off critical section latency timing
       [*]   Latency tracing

what is the longest wakeup latency the tracer shows? You can start the
measurement anew via:

	echo 0 > /proc/sys/kernel/preempt_max_latency

every new maximum-latency event will be logged by the kernel, and the
trace of the latest worst-case latency path can be found under
/proc/latency_trace.

(If the trace is very long then most of the time it's OK to just send
the first 25 and last 10 lines. Putting the trace up to a website is a
good solution too.)

it should not matter how 'greedy' wmcube is. Does it do alot of graphics
activity (perhaps 3D too?) - that could in theory cause hardware
latencies - the latency traces will tell.

> MIDI playback through any MPU-401 interface triggers the following
> BUG, reported once for each outgoing MIDI event (non MPU-401 hw
> interfaces and sw interfaces not affected):

the patch below should fix this. (also included in -38-06 and later
kernels.)

	Ingo

--- linux/sound/drivers/mpu401/mpu401_uart.c.orig
+++ linux/sound/drivers/mpu401/mpu401_uart.c
@@ -316,12 +316,12 @@ static void snd_mpu401_uart_input_trigge
 		/* read data in advance */
 		/* prevent double enter via rawmidi->event callback */
 		if (atomic_dec_and_test(&mpu->rx_loop)) {
-			local_irq_save(flags);
+			local_irq_save_nort(flags);
 			if (spin_trylock(&mpu->input_lock)) {
 				snd_mpu401_uart_input_read(mpu);
 				spin_unlock(&mpu->input_lock);
 			}
-			local_irq_restore(flags);
+			local_irq_restore_nort(flags);
 		}
 		atomic_inc(&mpu->rx_loop);
 	} else {
@@ -407,12 +407,12 @@ static void snd_mpu401_uart_output_trigg
 		/* output pending data */
 		/* prevent double enter via rawmidi->event callback */
 		if (atomic_dec_and_test(&mpu->tx_loop)) {
-			local_irq_save(flags);
+			local_irq_save_nort(flags);
 			if (spin_trylock(&mpu->output_lock)) {
 				snd_mpu401_uart_output_write(mpu);
 				spin_unlock(&mpu->output_lock);
 			}
-			local_irq_restore(flags);
+			local_irq_restore_nort(flags);
 		}
 		atomic_inc(&mpu->tx_loop);
 	} else {

