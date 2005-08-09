Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVHIH7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVHIH7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 03:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVHIH7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 03:59:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8632 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S932463AbVHIH7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 03:59:01 -0400
Date: Tue, 9 Aug 2005 09:59:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       cpufreq@lists.linux.org.uk
Subject: Re: PowerOP 2/3: Intel Centrino support
Message-ID: <20050809075919.GA18309@elte.hu>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Todd Poynor <tpoynor@mvista.com> wrote:

> +static int
> +powerop_centrino_get_point(struct powerop_point *point)
> +{
> +	unsigned l, h;
> +	unsigned cpu_freq;
> +
> +	rdmsr(MSR_IA32_PERF_STATUS, l, h);
> +	if (unlikely((cpu_freq = ((l >> 8) & 0xff) * 100) == 0)) {
> +		/*
> +		 * On some CPUs, we can see transient MSR values (which are
> +		 * not present in _PSS), while CPU is doing some automatic
> +		 * P-state transition (like TM2). Get the last freq set 
> +		 * in PERF_CTL.
> +		 */
> +		rdmsr(MSR_IA32_PERF_CTL, l, h);
> +		cpu_freq = ((l >> 8) & 0xff) * 100;
> +	}
> +
> +	point->param[POWEROP_CPU + smp_processor_id()] = cpu_freq;
> +	point->param[POWEROP_V + smp_processor_id()] = ((l & 0xff) * 16) + 700;
> +	return 0;
> +}

doesnt seem to be SMP-safe, nor PREEMPT-safe. You probably want to do 
the locking in the highlevel functions.

	Ingo
