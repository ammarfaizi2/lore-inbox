Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWGEGk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWGEGk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 02:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGEGk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 02:40:28 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51594 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751093AbWGEGk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 02:40:27 -0400
Date: Wed, 5 Jul 2006 08:35:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
Message-ID: <20060705063550.GA28004@elte.hu>
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5003]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> ===================================================================
> --- MM-2.6.17-mm6.orig/kernel/mutex.c	2006-07-04 14:37:43.000000000 +1000
> +++ MM-2.6.17-mm6/kernel/mutex.c	2006-07-04 14:38:12.000000000 +1000
> @@ -51,6 +51,16 @@ __mutex_init(struct mutex *lock, const c
>  
>  EXPORT_SYMBOL(__mutex_init);
>  
> +static inline void inc_mutex_count(void)
> +{
> +	current->mutexes_held++;
> +}
> +
> +static inline void dec_mutex_count(void)
> +{
> +	current->mutexes_held--;
> +}
> +

NACK! This whole patch is way too intrusive for such a relatively small 
gain.

also, if something doesnt hold a mutex, it might still be unsafe to 
background it! For example if it holds a semaphore. Or an rwsem. Or any 
other kernel resource that has exclusion semantics.

so unless this patch gets _much_ less complex and much less intrusive, 
we'll have to stay with SCHED_BATCH and nice +19.

	Ingo
