Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbUJ1TPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUJ1TPP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbUJ1TPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:15:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:56233 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262154AbUJ1TO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:14:56 -0400
Date: Thu, 28 Oct 2004 21:16:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041028191605.GA3877@elte.hu>
References: <12917.195.245.190.94.1098890763.squirrel@195.245.190.94> <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu> <33083.192.168.1.5.1098919913.squirrel@192.168.1.5> <20041028063630.GD9781@elte.hu> <20668.195.245.190.93.1098952275.squirrel@195.245.190.93> <20041028085656.GA21535@elte.hu> <26253.195.245.190.93.1098955051.squirrel@195.245.190.93> <20041028093215.GA27694@elte.hu> <43163.195.245.190.94.1098981230.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43163.195.245.190.94.1098981230.squirrel@195.245.190.94>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.2, required 5.9, BAYES_00 -4.90,
	COMPARE_RATES 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> OK. Here are my early consolidated results. Feel free to comment.
> 
>                                     2.6.9     RT-U3   RT-V0.4.3
>                                   --------- --------- ---------
>   XRUN Rate . . . . . . . . . . .     424         8         4    /hour
>   Delay Rate (>spare time)  . . .     496         0         0    /hour
>   Delay Rate (>1000 usecs)  . . .     940         8         4    /hour
>   Maximum Delay . . . . . . . . .    6904       921       721    usecs
>   Maximum Process Cycle . . . . .    1449      1469      1590    usecs
>   Average DSP CPU Load  . . . . .      38        39        40    %
>   Average Context-Switch Rate . .    7480      8929      9726    /sec

looks pretty good, doesnt it?

how is the 'maximum delay' calculated? Could you put in a tracing hook
into jackd whenever such a ~720 usecs maximum is hit? I'd _love_ to see 
how such a latency path looks like, it seems a bit long.

It should be a relatively simple hack to jackd. Firstly, download the 
-V0.5.3 patch and enable LATENCY_TRACE, then do:

	echo 2 > /proc/sys/kernel/trace_enabled

this activates the 'application-triggered kernel tracer' functionality. 

No tracing happens by default, but tracing starts if the application
executes this function:

	gettimeofday(0,1);

and tracing stops if the application does:

	gettimeofday(0,0);

whenever the app does this (0,0) call the trace gets saved and you can
retrieve it from /proc/latency_trace where you can retrieve it. There is
no combination of these parameters that can break the kernel, so it's a
100% safe tracing facility. You can 'ignore' a latency [e.g. if it's not
a maximum] by simply not doing the (0,0) call. The next (0,1) call done
will override the previous, already running trace.

[stupid function but this combination of the syscall parameters is not
used otherwise so the latency tracer hijacks it.]

i dont know how Jackd does things, but i'd suggest to enable tracing the
first time possible when getting an interrupt - in theory this should
happen as soon as the wakeup-latency-tracer says - i.e. at most in like
30 usecs. The bulk of the remaining 700 usecs will be spent in jackd, 
and you can trace those 700 usecs.

or if you would be willing to do a little bit of ALSA hacking, you could
add this to the ALSA interrupt handler:

	#include <linux/syscalls.h>

	...
	sys_gettimeofday(0, 1);

[the attached patch implements this for ali5451.]

and do the gettimeofday(0,0) in jackd [if the latency measured there is
a new maximum]! This way tracing is turned on within the kernel IRQ
handler (i.e. as soon as possible) and turned off within ALSA. This will
enable us to see an even more complete latency path.

NOTE: there can only be one trace active at a time. So if there can be
multiple channels active at a time then this user-triggered tracer might
be less useful. Do these channels have any priority? Or if multiple
channels are necessary then you could modify the patch to only do the
(0,1) call for say channel #0:

	if (channel == 0)
		sys_gettimeofday(0, 1);

in this case the trace-off-save (0,0) call in Jackd must also only do
this for channel 0 processing! (or whichever channel you find the most
interesting.)

also, i looked at the sound/pci/ali5451/ali5451.c driver code and it has
one weird piece of code on line 988:

	udelay(100);

that adds a 100 usecs latency to the main path, for no good reason! It
also spends that time burning CPU time, delaying other processing. Could 
you add an IRQs/sec measurement too if possible, so that we can compare 
the IRQ rates of various kernels?

Also, i'd suggest to simply remove that line (or apply the attached
patch) - does the driver still work fine with that?

plus i've also got questions about how Jackd interfaces with ALSA: does
it use SIGIO, or some direct driver ioctl? If SIGIO is used then how is
it done precisely - is an 'RT' queued signal used or ordinary SIGIO? 
Also, how is the 'channel' information established upon getting a SIGIO,
is it in the siginfo structure?

	Ingo

--- linux/sound/pci/ali5451/ali5451.c.orig
+++ linux/sound/pci/ali5451/ali5451.c
@@ -33,6 +33,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
+#include <linux/syscalls.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
@@ -985,11 +986,11 @@ static void snd_ali_update_ptr(ali_t *co
 	pvoice = &codec->synth.voices[channel];
 	runtime = pvoice->substream->runtime;
 
-	udelay(100);
 	spin_lock(&codec->reg_lock);
 
 	if (pvoice->pcm && pvoice->substream) {
 		/* pcm interrupt */
+		sys_gettimeofday((void *)0, (void *)1); // start the tracer
 #ifdef ALI_DEBUG
 		outb((u8)(pvoice->number), ALI_REG(codec, ALI_GC_CIR));
 		temp = inw(ALI_REG(codec, ALI_CSO_ALPHA_FMS + 2));
