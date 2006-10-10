Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWJJGuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWJJGuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWJJGuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:50:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:23246 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965040AbWJJGuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:50:22 -0400
Date: Tue, 10 Oct 2006 08:42:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Neil Brown <neilb@suse.de>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: md deadlock (was Re: 2.6.18-mm2)
Message-ID: <20061010064228.GA6311@elte.hu>
References: <20060928014623.ccc9b885.akpm@osdl.org> <6bffcb0e0609280454n34d40c0la8786e1eba6dcdf3@mail.gmail.com> <1159531923.28131.80.camel@taijtu> <17693.5913.393686.223172@cse.unsw.edu.au> <1159538597.28131.97.camel@taijtu> <1159796858.28131.149.camel@taijtu> <17707.6447.329255.930851@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17707.6447.329255.930851@cse.unsw.edu.au>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Neil Brown <neilb@suse.de> wrote:

> --- .prev/include/linux/mutex.h	2006-10-10 12:37:04.000000000 +1000
> +++ ./include/linux/mutex.h	2006-10-10 12:40:20.000000000 +1000
> @@ -125,8 +125,9 @@ extern int fastcall mutex_lock_interrupt
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
> +extern int mutex_lock_interruptible_nested(struct mutex *lock, unsigned int subclass);
>  #else
> -# define mutex_lock_nested(lock, subclass) mutex_lock(lock)
> +# define mutex_lock_interruptible_nested(lock, subclass) mutex_interruptible_lock(lock)
>  #endif

>  EXPORT_SYMBOL_GPL(mutex_lock_nested);
> +int __sched
> +mutex_lock_interruptible_nested(struct mutex *lock, unsigned int subclass)
> +{
> +	might_sleep();
> +	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, subclass);
> +}
> +
> +EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);

looks good to me. (small style nit: maybe insert a newline after the 
first EXPORT_SYMBOL_GPL line)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
