Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWADOL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWADOL5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 09:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWADOL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 09:11:57 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:52416 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751257AbWADOL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 09:11:56 -0500
Subject: Re: [patch 4/9] slab: cache_estimate cleanup
From: Steven Rostedt <rostedt@goodmis.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, clameter@sgi.com
In-Reply-To: <1136339242.12468.17.camel@localhost.localdomain>
References: <1136319948.8629.19.camel@localhost>
	 <1136336416.12468.11.camel@localhost.localdomain>
	 <1136339242.12468.17.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 09:11:39 -0500
Message-Id: <1136383899.12468.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 20:47 -0500, Steven Rostedt wrote:

> > 
> > I've also been looking at this and I've realized that we can even remove
> > the "while" and make it into an "if".  It works just as well. I created
> > the attached test program to see if there would be any difference
> > testing all sizes from 8 to PAGE_SIZE >> 1 (where PAGE_SIZE = 1<<12),
> > and all alignments of 4 to size, and I tried this with two orders of
> > pages.  The "if" should make the assembly a little better.
> > 
> >
[...]
> +static size_t slab_mgmt_size(size_t nr_objs, size_t align)
>  {

[ delete deletion ]

> +	return ALIGN(sizeof(struct slab)+nr_objs*sizeof(kmem_bufctl_t), align);
> +}
> +
> +/* Calculate the number of objects and left-over bytes for a given
> +   object size. */
> +static void cache_estimate(unsigned long gfporder, size_t obj_size,
> +			   size_t align, int flags, size_t *left_over,
> +			   unsigned int *num)
> +{
> +

[...]

> +		/* Ignore padding for the initial guess.  The padding
> +		 * is at most @align-1 bytes, and @size is at least
> +		 * @align. In the worst case, this result will be one
> +		 * greater than the number of objects that fit into
> +		 * the memory allocation when taking the padding into
> +		 * account.
> +		 */
> +		nr_objs = (slab_size - sizeof(struct slab)) /
> +			  (obj_size + sizeof(kmem_bufctl_t));
> +
> +		/*
> +		 * This calculated number will be either the right
> +		 * amount, or one greater than what we want.
> +		 */
> +		if (slab_mgmt_size(nr_objs, align) + nr_objs*obj_size
> +		       > slab_size)
> +			nr_objs--;

No while is needed!  slab_mgmt_size(nr_objs, align) will end up being:

(sizeof(struct slab)+nr_objs*sizeof(kmem_bufctl_t)+align-1)&~(align-1)

lets say:
  S = sizeof(struct slab)
  K = sizeof(kmem_bufctl_t)
  n = nr_objs
  z = slab_size
  o = objsize
  a = align

	nr_objs = (slab_size - sizeof(struct slab)) /
		(size + sizeof(kmem_bufctl_t));

will be  n = (z - S) / (o + K)

looking at the if:

	if (slab_mgmt_size(nr_objs, align) + nr_objs*size
	       > slab_size)

and slab_mgmt_size:

   static size_t slab_mgmt_size(size_t nr_objs, size_t align)
   {
	return ALIGN(sizeof(struct slab)+nr_objs*sizeof(kmem_bufctl_t), align);
   }

and ALIGN:

   #define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))

slab_mgmt_size is the same as:

    ALIGN(S + nK, a)

so this will not be greater than:

S + nK + a - 1


add this to the if:

if (S + nK + a-1 + no > z)

proof by contradiction: can the left side be greater than z + o?

S + nK + a-1 + no = z+o+1 ?

S + (o+K)n + a-1 = z+o+1

n = (z - S) / (o + K) so:

S + (o+K)(z-S)/(o+K) + a-1 = z+o+1

S + (z-S) + a-1 = z+o+1

removing the z and S

a-1 = o+1

We know that a can be at most o so:

o-1 = o+1

and thus we get:

-1 = 1

So I believe this is the proof by contradiction.  Might want to check
this, since I just woke up ;)

-- Steve



