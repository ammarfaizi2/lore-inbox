Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVBJCOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVBJCOI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 21:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbVBJCOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 21:14:08 -0500
Received: from unused.mind.net ([69.9.134.98]:28620 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262012AbVBJCN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 21:13:57 -0500
Date: Wed, 9 Feb 2005 18:13:47 -0800 (PST)
From: William Weston <weston@lysdexia.org>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
In-Reply-To: <20050209115121.GA13608@elte.hu>
Message-ID: <Pine.LNX.4.58.0502091233360.4599@echo.lysdexia.org>
References: <20050204100347.GA13186@elte.hu> <Pine.LNX.4.58.0502081135340.21618@echo.lysdexia.org>
 <20050209115121.GA13608@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Ingo Molnar wrote:

> > Running wmcube (an impractical, greedy, little CPU meter), even when
> > niced, causes lots of xruns.  It may be good for worst-case-scenario
> > desktop load testing.
> 
> this phenomenon is very weird.
> 
> Firstly, make sure that all relevant threads (including the soundcard
> IRQ thread, jackd threads, jack client thread, etc.) have higher RT
> priority than any other, latency-irrelevant threads in the system.

Thanks for the tip.  I have schedtool installed, and all audio/MIDI IRQ
threads, jack threads, and jack clients are now run with higher priorities
than everything else.  Before I adjusted priorities, I was getting a bunch 
of these when running latencytest (which have since disappeared):

rtc: lost some interrupts at 8192Hz.
bug in rtc_read(): called in state S_IDLE!

IRQ 8 (RTC) is still giving me some issues, even after adjusting 
priorities:

`IRQ 8'[232] is being piggy. need_resched=0, cpu=0
Read missed before next interrupt

Should the RTC IRQ be given a new priority?  If so, should it be lower, 
higher, or equal to the audio/MIDI/jack priorities?

> If everything looks OK on the priority-administration side, could you
> enable wakeup-latency tracing via:
> 
>  CONFIG_WAKEUP_TIMING=y
>  CONFIG_PREEMPT_TRACE=y
>  # CONFIG_CRITICAL_PREEMPT_TIMING is not set
>  # CONFIG_CRITICAL_IRQSOFF_TIMING is not set
>  CONFIG_LATENCY_TIMING=y
>  CONFIG_LATENCY_TRACE=y

<snip>

> what is the longest wakeup latency the tracer shows? You can start the
> measurement anew via:
> 
> 	echo 0 > /proc/sys/kernel/preempt_max_latency

Max latency is in the realm of 13-18 after runs of jack_test4.1.

> every new maximum-latency event will be logged by the kernel, and the
> trace of the latest worst-case latency path can be found under
> /proc/latency_trace.
> 
> (If the trace is very long then most of the time it's OK to just send
> the first 25 and last 10 lines. Putting the trace up to a website is a
> good solution too.)

See http://www.sysex.net/testing/ for the all of the test results and 
system info on a 2.6.11-rc3-RT-V0.7.38-06 kernel.

This is from my most recent run of jack_test4.1 with wmcube and kernel 
compilation running (check /testing/dmesg for more):

(            sshd-5940 |#0): new 4 s maximum-latency wakeup.
(          IRQ 16-1803 |#0): new 5 s maximum-latency wakeup.
(            make-28375|#0): new 6 s maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 6 s maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 7 s maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 8 s maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 8 s maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 9 s maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 10 s maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 10 s maximum-latency wakeup.
(           jackd-29348|#0): new 12 s maximum-latency wakeup.
(           jackd-29348|#0): new 14 s maximum-latency wakeup.
(           jackd-29348|#0): new 15 s maximum-latency wakeup.

> it should not matter how 'greedy' wmcube is. Does it do alot of graphics
> activity (perhaps 3D too?) - that could in theory cause hardware
> latencies - the latency traces will tell.

Wmcube displays a 3D spinning cube, which spins faster (actually performs
larger rotations between updates) when CPU usage goes up.  When running
niced, wmcube uses about 1% to 4% of the CPU, adds about 1000 context
switches per second, and increases X load by 1% to 3% of the total CPU.  

Now that the priorities are tuned, I get no xruns while running wmcube, 
compiling a kernel, and running latencytest or jack_test4.1.

> > MIDI playback through any MPU-401 interface triggers the following
> > BUG, reported once for each outgoing MIDI event (non MPU-401 hw
> > interfaces and sw interfaces not affected):
> 
> the patch below should fix this. (also included in -38-06 and later
> kernels.)
> 
> 	Ingo
> 
> --- linux/sound/drivers/mpu401/mpu401_uart.c.orig
> +++ linux/sound/drivers/mpu401/mpu401_uart.c
> @@ -316,12 +316,12 @@ static void snd_mpu401_uart_input_trigge
>  		/* read data in advance */
>  		/* prevent double enter via rawmidi->event callback */
>  		if (atomic_dec_and_test(&mpu->rx_loop)) {
> -			local_irq_save(flags);
> +			local_irq_save_nort(flags);
>  			if (spin_trylock(&mpu->input_lock)) {
>  				snd_mpu401_uart_input_read(mpu);
>  				spin_unlock(&mpu->input_lock);
>  			}
> -			local_irq_restore(flags);
> +			local_irq_restore_nort(flags);
>  		}
>  		atomic_inc(&mpu->rx_loop);
>  	} else {
> @@ -407,12 +407,12 @@ static void snd_mpu401_uart_output_trigg
>  		/* output pending data */
>  		/* prevent double enter via rawmidi->event callback */
>  		if (atomic_dec_and_test(&mpu->tx_loop)) {
> -			local_irq_save(flags);
> +			local_irq_save_nort(flags);
>  			if (spin_trylock(&mpu->output_lock)) {
>  				snd_mpu401_uart_output_write(mpu);
>  				spin_unlock(&mpu->output_lock);
>  			}
> -			local_irq_restore(flags);
> +			local_irq_restore_nort(flags);
>  		}
>  		atomic_inc(&mpu->tx_loop);
>  	} else {

This patch does fix the MIDI playback BUG I was seeing.


Best Regards,
--William Weston <weston at sysex.net>

