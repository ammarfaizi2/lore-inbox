Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272142AbTHNCDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 22:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272143AbTHNCDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 22:03:37 -0400
Received: from waste.org ([209.173.204.2]:62929 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272142AbTHNCDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 22:03:36 -0400
Date: Wed, 13 Aug 2003 21:03:23 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, jmorris@intercode.com.au,
       davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cryptoapi: Fix sleeping
Message-ID: <20030814020323.GI325@waste.org>
References: <20030813233957.GE325@waste.org> <3F3AD5F1.8000901@pobox.com> <20030813174436.3db7efb1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813174436.3db7efb1.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 05:44:36PM -0700, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > Matt Mackall wrote:
> > > We need in_atomic() so that we can call from regions where preempt is
> > > disabled, for instance when using per_cpu crypto tfms.
> > > 
> > > diff -urN -X dontdiff orig/crypto/internal.h work/crypto/internal.h
> > > +++ work/crypto/internal.h	2003-08-12 14:38:54.000000000 -0500
> > > @@ -37,7 +37,7 @@
> > >  
> > >  static inline void crypto_yield(struct crypto_tfm *tfm)
> > >  {
> > > -	if (!in_softirq())
> > > +	if (!in_atomic())
> > >  		cond_resched();
> > 
> > 
> > Do you really want to schedule inside preempt_disable() ?
> > 
> 
> in_atomic() returns false inside spin_lock() on non-preemptive kernels.
> 
> Either this code needs to be removed altogether or it should be changed to
> 
> 	BUG_ON(in_atomic());
> 	cond_resched();
> 
> and the callers should be fixed up.

Cryptoapi probably needs a flag for skipping the yield. I'll look into it.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
