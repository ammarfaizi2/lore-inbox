Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTJKTsv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 15:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTJKTsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 15:48:51 -0400
Received: from fmr09.intel.com ([192.52.57.35]:3517 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S263380AbTJKTss convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 15:48:48 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH][BUGFIX] Bug in timer_tsc cpufreq callback
Date: Sat, 11 Oct 2003 12:48:45 -0700
Message-ID: <7F740D512C7C1046AB53446D37200173341517@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][BUGFIX] Bug in timer_tsc cpufreq callback
Thread-Index: AcOQLPRsvyKwqDeSS1yO5OaQDRkzXQAA4Oow
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       <torvalds@osdl.org>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Oct 2003 19:48:46.0029 (UTC) FILETIME=[AEB2CFD0:01C39030]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a theory, but we were really caught by this bug.

	Jun
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Pallipadi, Venkatesh
> Sent: Saturday, October 11, 2003 12:22 PM
> To: torvalds@osdl.org; akpm@osdl.org
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH][BUGFIX] Bug in timer_tsc cpufreq callback
> 
> 
> Hi,
> 
> There is a bug in cpufreq call back funtion in timer_tsc routines,
> that can result in system deadlock. The issue is: grabbing the
> write_lock on xtime_lock without disabling the interrupts. So,
> if we happen to get a timer interrupt while we are in this code,
> system will go into a deadlock.
> 
> This bug only effects the kernels that have CONFIG_CPU_FREQ enabled.
> Attached patch fixes it. Please apply.
> 
> 
> Thanks,
> -Venkatesh
> 
> 
> --- linux-2.6.0-test6/arch/i386/kernel/timers/timer_tsc.c.org
> 2003-10-10 14:01:02.000000000 -0700
> +++ linux-2.6.0-test6/arch/i386/kernel/timers/timer_tsc.c
> 2003-10-10 14:01:24.000000000 -0700
> @@ -321,7 +321,7 @@ time_cpufreq_notifier(struct notifier_bl
>  {
>  	struct cpufreq_freqs *freq = data;
> 
> -	write_seqlock(&xtime_lock);
> +	write_seqlock_irq(&xtime_lock);
>  	if (!ref_freq) {
>  		ref_freq = freq->old;
>  		loops_per_jiffy_ref =
> cpu_data[freq->cpu].loops_per_jiffy;
> @@ -342,7 +342,7 @@ time_cpufreq_notifier(struct notifier_bl
>  		}
>  #endif
>  	}
> -	write_sequnlock(&xtime_lock);
> +	write_sequnlock_irq(&xtime_lock);
> 
>  	return 0;
>  }
