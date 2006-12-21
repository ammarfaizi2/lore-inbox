Return-Path: <linux-kernel-owner+w=401wt.eu-S1422652AbWLUD3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWLUD3b (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422656AbWLUD3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:29:31 -0500
Received: from tomts22.bellnexxia.net ([209.226.175.184]:55102 "EHLO
	tomts22-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422652AbWLUD3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:29:30 -0500
Date: Wed, 20 Dec 2006 22:29:28 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, paulus@samba.org,
       "Martin J. Bligh" <mbligh@mbligh.org>, linuxppc-dev@ozlabs.org,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 7/9] atomic.h : powerpc
Message-ID: <20061221032928.GB14930@Krystal>
References: <20061221001204.GM28643@Krystal> <1166670905.6673.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <1166670905.6673.33.camel@localhost.localdomain>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 22:25:18 up 120 days, 32 min,  4 users,  load average: 1.21, 0.74, 0.58
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:
> 
> > +
> > +/**
> > + * atomic64_add_unless - add unless the number is a given value
> > + * @v: pointer of type atomic64_t
> > + * @a: the amount to add to v...
> > + * @u: ...unless v is equal to u.
> > + *
> > + * Atomically adds @a to @v, so long as it was not @u.
> > + * Returns non-zero if @v was not @u, and zero otherwise.
> > + */
> > +static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> > +{
> > +	long t;
> > +
> > +	__asm__ __volatile__ (
> > +	LWSYNC_ON_SMP
> > +"1:	ldarx	%0,0,%1		# atomic_add_unless\n\
> > +	cmpd	0,%0,%3 \n\
> > +	beq-	2f \n\
> > +	add	%0,%2,%0 \n"
> > +	PPC405_ERR77(0,%2)
> > +"	stdcx.	%0,0,%1 \n\
> > +	bne-	1b \n"
> > +	ISYNC_ON_SMP
> > +"	subf	%0,%2,%0 \n\
> > +2:"
> > +	: "=&r" (t)
> > +	: "r" (&v->counter), "r" (a), "r" (u)
> > +	: "cc", "memory");
> > +
> > +	return t != u;
> > +}
> > +
> 
> You shouldn't try to define those when building 32 bits code... Also,
> the PPC405 errata, as it's name implies, is specific to 405 cores which
> are all 32 bits.
> 
> Ben.
> 
> 

Hi Ben,

It is within a 
#ifdef __powerpc64__
...
#endif /* __powerpc64__ */

so it should only build on 64 bits.

You are right about the PPC405 errata, it seems unnecessary.

The same is true for my asm-powerpc/local.h modification.

Thanks,

Mathieu

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
