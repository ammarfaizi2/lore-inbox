Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272128AbTHNByU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 21:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272130AbTHNByU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 21:54:20 -0400
Received: from waste.org ([209.173.204.2]:36817 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272128AbTHNByT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 21:54:19 -0400
Date: Wed, 13 Aug 2003 20:54:04 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Morris <jmorris@intercode.com.au>,
       "David S. Miller" <davem@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cryptoapi: Fix sleeping
Message-ID: <20030814015404.GG325@waste.org>
References: <20030813233957.GE325@waste.org> <3F3AD5F1.8000901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3AD5F1.8000901@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 08:21:05PM -0400, Jeff Garzik wrote:
> Matt Mackall wrote:
> >We need in_atomic() so that we can call from regions where preempt is
> >disabled, for instance when using per_cpu crypto tfms.
> >
> >diff -urN -X dontdiff orig/crypto/internal.h work/crypto/internal.h
> >+++ work/crypto/internal.h	2003-08-12 14:38:54.000000000 -0500
> >@@ -37,7 +37,7 @@
> > 
> > static inline void crypto_yield(struct crypto_tfm *tfm)
> > {
> >-	if (!in_softirq())
> >+	if (!in_atomic())
> > 		cond_resched();
> 
> 
> Do you really want to schedule inside preempt_disable() ?

No, that's the point. Cryptoapi has hidden scheduling points and the
above code is what's used to check that it doesn't do so when it ought
not. But it was broken inside of no-preempt sections.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
