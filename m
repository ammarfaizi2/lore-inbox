Return-Path: <linux-kernel-owner+w=401wt.eu-S932533AbWLMR4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWLMR4Z (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWLMR4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:56:25 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46123 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932533AbWLMR4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:56:24 -0500
Date: Wed, 13 Dec 2006 18:54:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Ulrich Drepper <drepper@redhat.com>, Darren Hart <dvhltc@us.ibm.com>,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 2.6.19-rt12][RFC] - futex_requeue_pi implementation (requeue from futex1 to PI-futex2)
Message-ID: <20061213175405.GB32441@elte.hu>
References: <45801FA4.8040403@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45801FA4.8040403@bull.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pierre Peiffer <pierre.peiffer@bull.net> wrote:

> With the introduction of the PI-futex (used for the PI-pthread_mutex 
> in the glibc), the current futex_requeue optimization (*) can not be 
> used any more if the pthread_mutex used with the pthread-condvar is a 
> PI-mutex.
> 
> (*) this optimization is used in pthread_cond_broadcast.
> 
> To use this optimization with PI-mutex, we need a function that
> re-queues some threads from a normal futex  to a PI-futex (see why in
> this discussion:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115020355126851&w=2 )
> 
> Here is a proposal of an implementation of futex_requeue_pi.
> (Only the 32-bits version has been implemented for now)

the kernel patch looks straightforward and desirable to me. (modulo some 
minor style-nitpicking observations below.) I'd suggest to implement the 
64-bit and compat versions too, unless Jakub can see a hole in the 
concept or in the implementation.

> -#define FUTEX_TID_MASK		0x3fffffff
> +#define FUTEX_TID_MASK		0x1fffffff

ABI change but tthis should be fine i think ... right now we dont let 
PIDs go above 0xffff anyway. It might make sense to lower it to 
0x0fffffff, to have one more bit in that word ... just in case.

> +	/* This waiter is used in case of requeue from a
> +	   normal futex to a PI-futex */

please use proper comment style.

> +	if (key->both.offset & 1)
> +		/* shared mapping */
> +		uaddr = (void*)((key->shared.pgoff << PAGE_SHIFT)
> +				+ key->shared.offset - 1);
> +	else
> +		/* private mapping */
> +		uaddr = (void*)(key->private.address + key->private.offset);

such multi-line branches need curly braces.

> +static inline int lookup_pi_state_for_requeue(u32 __user *uaddr,
> +					      struct futex_hash_bucket *hb,
> +					      union futex_key *key,
> +					      struct futex_pi_state 
> **pi_state)

patch line wrap problem? Also, if the function name is so long, you can 
do:

static inline int
lookup_pi_state_for_requeue(u32 __user *uaddr, struct futex_hash_bucket *hb,

	Ingo
