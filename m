Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272072AbTHNA6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 20:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272073AbTHNA6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 20:58:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:15071 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272072AbTHNA6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 20:58:45 -0400
Date: Wed, 13 Aug 2003 17:44:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mpm@selenic.com, jmorris@intercode.com.au, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cryptoapi: Fix sleeping
Message-Id: <20030813174436.3db7efb1.akpm@osdl.org>
In-Reply-To: <3F3AD5F1.8000901@pobox.com>
References: <20030813233957.GE325@waste.org>
	<3F3AD5F1.8000901@pobox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Matt Mackall wrote:
> > We need in_atomic() so that we can call from regions where preempt is
> > disabled, for instance when using per_cpu crypto tfms.
> > 
> > diff -urN -X dontdiff orig/crypto/internal.h work/crypto/internal.h
> > --- orig/crypto/internal.h	2003-07-13 22:29:11.000000000 -0500
> > +++ work/crypto/internal.h	2003-08-12 14:38:54.000000000 -0500
> > @@ -37,7 +37,7 @@
> >  
> >  static inline void crypto_yield(struct crypto_tfm *tfm)
> >  {
> > -	if (!in_softirq())
> > +	if (!in_atomic())
> >  		cond_resched();
> 
> 
> Do you really want to schedule inside preempt_disable() ?
> 

in_atomic() returns false inside spin_lock() on non-preemptive kernels.

Either this code needs to be removed altogether or it should be changed to

	BUG_ON(in_atomic());
	cond_resched();

and the callers should be fixed up.

