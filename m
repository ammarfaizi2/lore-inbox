Return-Path: <linux-kernel-owner+w=401wt.eu-S1422660AbWLUDe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWLUDe0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbWLUDe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:34:26 -0500
Received: from tomts40.bellnexxia.net ([209.226.175.97]:61980 "EHLO
	tomts40-srv.bellnexxia.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1422660AbWLUDeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:34:25 -0500
Date: Wed, 20 Dec 2006 22:34:23 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, paulus@samba.org
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, linuxppc-dev@ozlabs.org,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Ltt-dev] [PATCH 7/10] local_t : powerpc
Message-ID: <20061221033423.GC14930@Krystal>
References: <20061221001545.GP28643@Krystal> <20061221002705.GW28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061221002705.GW28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 22:29:51 up 120 days, 37 min,  4 users,  load average: 0.72, 0.68, 0.59
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca) wrote:
> --- a/include/asm-powerpc/local.h
> +++ b/include/asm-powerpc/local.h
> +/**
> + * local_add_unless - add unless the number is a given value
> + * @l: pointer of type local_t
> + * @a: the amount to add to l...
> + * @u: ...unless l is equal to u.
> + *
> + * Atomically adds @a to @l, so long as it was not @u.
> + * Returns non-zero if @l was not @u, and zero otherwise.
> + */
> +static __inline__ int local_add_unless(local_t *l, long a, long u)
> +{
> +	long t;
> +
> +	__asm__ __volatile__ (
> +"1:	ldarx	%0,0,%1		# local_add_unless\n\
> +	cmpd	0,%0,%3 \n\
> +	beq-	2f \n\
> +	add	%0,%2,%0 \n"
> +	PPC405_ERR77(0,%2)

Sorry, the previous line is unnecessary : PPC405 is a 32 bits arch errata and
this code is compiled on 64 bits arch only.

> +"	stdcx.	%0,0,%1 \n\
> +	bne-	1b \n"
> +"	subf	%0,%2,%0 \n\
> +2:"
> +	: "=&r" (t)
> +	: "r" (&(l->a.counter)), "r" (a), "r" (u)
> +	: "cc", "memory");
> +
> +	return t != u;
> +}
> +

Mathieu

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
