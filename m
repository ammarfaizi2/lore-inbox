Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWC1RjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWC1RjO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWC1RjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:39:14 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:63651 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751211AbWC1RjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:39:13 -0500
Message-ID: <442974BC.30304@cosmosbay.com>
Date: Tue, 28 Mar 2006 19:39:08 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, roe@sgi.com, steiner@sgi.com,
       clameter@sgi.com
Subject: Re: [PATCH] Call get_time() only when necessary in run_hrtimer_queue
References: <20060324175136.GA10186@sgi.com> <20060324142849.5cc27edb.akpm@osdl.org> <20060328165127.GC10411@sgi.com>
In-Reply-To: <20060328165127.GC10411@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich a écrit :
> 
> The hrtimer work in -mm does improve on the situation, although there
> appears to be some occasional cache line contention for xtime.  The
> following patch (which is similiar to my previously submitted patch)
> is applicable to 2.6.16-mm1 and does take care of at least a good
> portion of that.

I am not sure your patch is correct.

> 
> Index: linux/kernel/hrtimer.c
> ===================================================================
> --- linux.orig/kernel/hrtimer.c	2006-03-27 09:43:40.000000000 -0600
> +++ linux/kernel/hrtimer.c	2006-03-27 12:35:47.416054373 -0600
> @@ -604,14 +604,17 @@ int hrtimer_get_res(const clockid_t whic
>   */
>  static inline void run_hrtimer_queue(struct hrtimer_base *base)
>  {
> -	struct rb_node *node;
> +	struct rb_node *node = base->first;
> +
> +	if (!node)
> +		return;
>  
>  	if (base->get_softirq_time)
>  		base->softirq_time = base->get_softirq_time();
>  
>  	spin_lock_irq(&base->lock);
>  
> -	while ((node = base->first)) {
> +	while (node) {

Are you sure of this change ?

base->first may have changed just before you locked the base->lock 
(spin_lock_irq(&base->lock);)

Eric

