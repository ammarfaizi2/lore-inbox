Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263802AbUFFQpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263802AbUFFQpd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUFFQpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:45:33 -0400
Received: from holomorphy.com ([207.189.100.168]:49842 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263802AbUFFQp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:45:29 -0400
Date: Sun, 6 Jun 2004 09:44:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: pj@sgi.com, Simon.Derr@bull.net, ak@muc.de, akpm@osdl.org,
       ashok.raj@intel.com, colpatch@us.ibm.com, hch@infradead.org,
       jbarnes@sgi.com, joe.korty@ccur.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040606164436.GW21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, pj@sgi.com,
	Simon.Derr@bull.net, ak@muc.de, akpm@osdl.org, ashok.raj@intel.com,
	colpatch@us.ibm.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, linux-kernel@vger.kernel.org,
	manfred@colorfullife.com, nickpiggin@yahoo.com.au,
	rusty@rustcorp.com.au
References: <200406061507.i56F7xdS029391@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406061507.i56F7xdS029391@harpo.it.uu.se>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 05:07:59PM +0200, Mikael Pettersson wrote:
> Notice how it emits the high int before the low int.
> (Which btw also is the native big-endian storage order,
> so the memcpy() would have done the same.)
> Now consider the location of bit 0, with mask value 1(*),
> on a 64-bit big-endian machine. The code above puts this
> in the second int, as bit 0 in *((char*)dst + 7).
> But a 32-bit user-space, or a 64-bit user-space that sees
> an array of ints not longs, wants it in the first int,
> as bit 0 in *((char*)dst + 3).

Feh. So swap the assignments.


On Sun, Jun 06, 2004 at 05:07:59PM +0200, Mikael Pettersson wrote:
> Perfctr's marshalling procedure for cpumask_t values
> (drivers/perfctr/init.c:cpus_copy_to_user() in recent -mm)
> is endian-neutral and converts each long by emitting the
> ints from least significant to most significant.
> Considering the API for retrieving an array of unknown size,
> perfctr's marshalling procedure does the following:
> >	const unsigned int k_nrwords = PERFCTR_CPUMASK_NRLONGS*(sizeof(long)/sizeof(int));
> >	unsigned int u_nrwords;
> >	if (get_user(u_nrwords, &argp->nrwords))
> >		return -EFAULT;
> >	if (put_user(k_nrwords, &argp->nrwords))
> >		return -EFAULT;
> >	if (u_nrwords < k_nrwords)
> >		return -EOVERFLOW;
> That is, it always tells user-space how much space is needed,
> and if user-space provided too little, it gets EOVERFLOW.
> Knowing the number of words in the encoded cpumask_t also
> avoids having to know the exact value of NR_CPUS in user-space.
> /Mikael
> (*) Normal bit order, not IBM POWER's reversed bit order.

I don't really care about the particular format exported to userspace,
but cpus_addr() is not a legitimate API. cpus_copy_to_user() is, but it
should belong to the core. Just shove the stuff that's doing cpus_addr()
for internals of cpumask_t into lib/bitmap.c etc. and it should be fine.


-- wli
