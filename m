Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266640AbUGKURA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266640AbUGKURA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 16:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUGKURA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 16:17:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55252 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266640AbUGKUQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 16:16:58 -0400
Date: Sun, 11 Jul 2004 22:17:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck kernel mailing list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ck] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040711201753.GA11073@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org> <40F016D9.8070300@kolivas.org> <20040711064730.GA11254@elte.hu> <40F14E53.2030300@kolivas.org> <20040711143853.GA6555@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711143853.GA6555@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> it was reporting more accurate latencies, except that there were
> strange spikes of latencies. It turned out that for whatever reason,
> userspace RDTSC is not always reliable on my box (!).
> 
> I've attached two fixes against latencytest - one makes rdtsc
> timestamps more reliable, the other one fixes an SMP bug in the kernel
> module (it would lock up under SMP otherwise.).

>  static inline unsigned long long int rdtsc(void)
>  {
> -	unsigned long long int x;
> -	__asm__ volatile ("rdtsc" : "=A" (x));
> -	return x;
> +	unsigned long long int x, y;
> +	for (;;) {
> +		__asm__ volatile ("rdtsc" : "=A" (x));
> +		__asm__ volatile ("rdtsc" : "=A" (y));
> +		if (y - x < 1000)
> +			return y;
> +	}
>  }

the same fix should be done to latencytest0.42 too.

	Ingo
