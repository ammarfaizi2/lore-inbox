Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbTFLXbu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265068AbTFLXbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:31:49 -0400
Received: from dp.samba.org ([66.70.73.150]:39627 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265065AbTFLXbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:31:48 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16105.3943.510055.309447@nanango.paulus.ozlabs.org>
Date: Fri, 13 Jun 2003 09:40:23 +1000 (EST)
To: Patrick Mochel <mochel@osdl.org>
Cc: Robert Love <rml@tech9.net>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@digeo.com>, <sdake@mvista.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
In-Reply-To: <Pine.LNX.4.44.0306121629590.11379-100000@cherise>
References: <1055460564.662.339.camel@localhost>
	<Pine.LNX.4.44.0306121629590.11379-100000@cherise>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel writes:

> It seems like the following should work. Would someone mind commenting on
> it?

> +/**
> + * atomic_inc_and_read - increment atomic variable and return new value
> + * @v: pointer of type atomic_t
> + * 
> + * Atomically increments @v by 1.  Note that the guaranteed
> + * useful range of an atomic_t is only 24 bits.
> + */ 
> +static inline int atomic_inc_and_read(atomic_t *v)
> +{
> +	__asm__ __volatile__(
> +		LOCK "incl %0"
> +		:"=m" (v->counter)
> +		:"m" (v->counter));
> +	return v->counter;
> +}

BZZZT.  If another CPU is also doing atomic_inc_and_read you could end
up with both calls returning the same value.

You can't do atomic_inc_and_read on 386.  You can on cpus that have
cmpxchg (e.g. later x86).  You can also on machines with load-locked
and store-conditional instructions (alpha, ppc, probably most other
RISCs).

Paul.

