Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbUKILoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUKILoC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbUKILoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:44:02 -0500
Received: from mx1.elte.hu ([157.181.1.137]:9425 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261477AbUKILnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:43:47 -0500
Date: Tue, 9 Nov 2004 13:45:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] little schedule() cleanup: use cached current value
Message-ID: <20041109124553.GA25663@elte.hu>
References: <4190ADD7.CE7EFB7C@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4190ADD7.CE7EFB7C@tv-sign.ru>
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


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> @@ -2636,7 +2636,7 @@ switch_tasks:
>  	} else
>  		spin_unlock_irq(&rq->lock);
>  
> -	reacquire_kernel_lock(current);
> +	reacquire_kernel_lock(next);
>  	preempt_enable_no_resched();
>  	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
>  		goto need_resched;

nack. We switch the kernel stack in switch_to() so 'next' here is the
old task we switched to before we went off the CPU. The value of 'next'
doesnt get carried over a context-switch. (we do carry 'prev' over via
assembly trickery because we need it, but not 'next'.) This change would
most likely result in rare, hard-to-track-down BKL-related crashes all
around the place.

the other bits are OK, please resend them.

	Ingo
