Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270497AbTGSFpg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 01:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270498AbTGSFpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 01:45:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41092 "EHLO
	VL-MO-MR004.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S270497AbTGSFpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 01:45:34 -0400
Date: Sat, 19 Jul 2003 01:59:10 -0400
From: Simon Boulet <simon.boulet@divahost.net>
Subject: Re: 2.6.0-test1+ Alsa + Intel 82801CA/CAM AC'97 Audio OOPS
In-reply-to: <"from Valdis.Kletnieks"@vt.edu>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Message-id: <20030719055910.GA482@i2650>
MIME-version: 1.0
X-Mailer: Balsa 2.0.12
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20030719021012.GA919@i2650>
 <200307190446.h6J4k5bF004659@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excellant work Valdis. My OSS (non-ALSA) is fine now under 2.6.0-test1.

Indeed I have CONFIG_X86_SPEEDSTEP_ICH defined.

Thank you

Simon

On 2003.07.19 00:46, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 18 Jul 2003 22:10:12 EDT, Simon Boulet
> <simon.boulet@divahost.net>  said:
> 
> > Also, the OSS (non-ALSA) Intel ICH (i8xx) loads correctly but the
> sound
> > output is  slow (rate or clocking problem?). My sound was fine under
> 
> > 2.4.21.
> >
> 
> > i810_audio: only 48Khz playback available.
> 
> > i810_audio: setting clocking to 64937
> 
> I was having problems with i810_audio clocking as well.  It turned out
> to be
> the Intel Speedstep support, of all things.  *IF* your kernel
> includes:
> 
> CONFIG_X86_SPEEDSTEP_ICH=y
> 
> it was possible to end up with a broken value for loops_per_jiffie.
> I've
> attached a patch that fixes the bug and does a few cleanups...
> 
> If you don't have the SpeedStep support in your kernel, then your
> problem is elsewhere... Good luck... ;)
> 
> /Valdis
> 
> --- arch/i386/kernel/cpu/cpufreq/speedstep-ich.c.linus	2003-
> 07-03
> 23:31:43.000000000 -0400
> +++ arch/i386/kernel/cpu/cpufreq/speedstep-ich.c	2003-07-04
> 09:57:07.981299808 -0400
> @@ -77,15 +77,17 @@
>  	u8			value;
>  	unsigned long		flags;
>  	struct cpufreq_freqs	freqs;
> +	int			newfreq;
> 
>  	if (!speedstep_chipset_dev || (state > 0x1))
>  		return;
> 
>  	freqs.old = speedstep_get_processor_frequency
> (speedstep_processor);
> -	freqs.new = speedstep_freqs[SPEEDSTEP_LOW].frequency;
> +	freqs.new = speedstep_freqs[state].frequency;
>  	freqs.cpu = 0; /* speedstep.c is UP only driver */
>  	 
> -	if (notify)
> +	/* make sure we've initialized before calling notify */
> +	if (notify && (freqs.new != 0))
>  		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> 
>  	/* get PMBASE */
> @@ -136,13 +138,16 @@
> 
>  	dprintk(KERN_DEBUG "cpufreq: read at pmbase 0x%x + 0x50
> returned 0x%x\n", pmbase, value);
> 
> +	/* freqs.new may not be set yet - need local copy */
> +	newfreq = speedstep_get_processor_frequency
> (speedstep_processor);
>  	if (state == (value & 0x1)) {
> -		dprintk (KERN_INFO "cpufreq: change to %u MHz
> succeeded\n", (freqs.new / 1000));
> +		dprintk (KERN_INFO "cpufreq: change to %u MHz
> succeeded\n", (newfreq / 1000));
>  	} else {
>  		printk (KERN_ERR "cpufreq: change failed - I/O
> error\n");
>  	}
> 
> -	if (notify)
> +	/* Make sure we're initialized before calling notify */
> +	if (notify && (freqs.new != 0))
>  		cpufreq_notify_transition(&freqs,
> CPUFREQ_POSTCHANGE);
> 
>  	return;
> @@ -295,7 +300,7 @@
>  		return -EIO;
> 
>  	dprintk(KERN_INFO "cpufreq: currently at %s speed setting -
> %i MHz\n",
> -		(speed == speedstep_low_freq) ? "low" : "high",
> +		(speed == speedstep_freqs[SPEEDSTEP_LOW].frequency) ?
> "low" : "high",
>  		(speed / 1000));
> 
>  	/* cpuinfo and default policy values */
> 
