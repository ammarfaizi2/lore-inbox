Return-Path: <linux-kernel-owner+w=401wt.eu-S1422634AbWLUDRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbWLUDRM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWLUDRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:17:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:52878 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422634AbWLUDRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:17:12 -0500
Subject: Re: [PATCH 7/9] atomic.h : powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, paulus@samba.org,
       "Martin J. Bligh" <mbligh@mbligh.org>, linuxppc-dev@ozlabs.org,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20061221001204.GM28643@Krystal>
References: <20061221001204.GM28643@Krystal>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 14:15:05 +1100
Message-Id: <1166670905.6673.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +/**
> + * atomic64_add_unless - add unless the number is a given value
> + * @v: pointer of type atomic64_t
> + * @a: the amount to add to v...
> + * @u: ...unless v is equal to u.
> + *
> + * Atomically adds @a to @v, so long as it was not @u.
> + * Returns non-zero if @v was not @u, and zero otherwise.
> + */
> +static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> +{
> +	long t;
> +
> +	__asm__ __volatile__ (
> +	LWSYNC_ON_SMP
> +"1:	ldarx	%0,0,%1		# atomic_add_unless\n\
> +	cmpd	0,%0,%3 \n\
> +	beq-	2f \n\
> +	add	%0,%2,%0 \n"
> +	PPC405_ERR77(0,%2)
> +"	stdcx.	%0,0,%1 \n\
> +	bne-	1b \n"
> +	ISYNC_ON_SMP
> +"	subf	%0,%2,%0 \n\
> +2:"
> +	: "=&r" (t)
> +	: "r" (&v->counter), "r" (a), "r" (u)
> +	: "cc", "memory");
> +
> +	return t != u;
> +}
> +

You shouldn't try to define those when building 32 bits code... Also,
the PPC405 errata, as it's name implies, is specific to 405 cores which
are all 32 bits.

Ben.


