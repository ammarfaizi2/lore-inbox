Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbUBXUWP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbUBXUWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:22:15 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:27030 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262298AbUBXUWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:22:10 -0500
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
From: Christophe Saout <christophe@saout.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Morris <jmorris@intercode.com.au>
In-Reply-To: <20040224191142.GT3883@waste.org>
References: <20040219170228.GA10483@leto.cs.pocnet.net>
	 <20040219111835.192d2741.akpm@osdl.org>
	 <20040220171427.GD9266@certainkey.com>
	 <20040221021724.GA8841@leto.cs.pocnet.net>
	 <20040224191142.GT3883@waste.org>
Content-Type: text/plain
Message-Id: <1077651839.11170.4.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 20:43:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 24.02.2004 schrieb Matt Mackall um 20:11:

> As this stands, it's rather scary.
> 
> - it will quietly break when cryptoapi gets fiddled with
> - it subverts the module reference counting rules
> - for a given cipher/digest, tfm_size might be large
>
> Subverting the API this way is bad. On the other hand,

Right. That's why I repeated several times that this is a hack and Cc'ed
James. I was either misunderstood or ignored.

> I tend to think
> the API does need a way to deal with problem cases like these, so I'd
> support extending the API in some fashion to handle it. Related (but
> not identical) issues have cropped up with a few other things that
> want to avoid serializing around a single or per-cpu context.

If you call encrypt/decrypt without the iv parameter but use cbc mode
you will run into the same problem. This is right.

BTW: I think there's a bug in the ipv6 code, it uses spin_lock to
protect itself, this will cause a sleep-inside-spinlock warning. (found
while grepping through the source for other cryptoapi users)

> Something like:
> 
>  /* calculate the size of a tfm so that users can manage their own
>  copies */
> 
>  int crypto_alg_size(const char *name);

crypto_tfm_size?

>  /* copy a TFM to a user-managed buffer, possibly on stack, with proper
>  internal reference counting and any other necessary magic, size checks
>  against boneheaded buffer sizing */
> 
>  crypto_copy_tfm(char *dst, const struct crypto_tfm *src, int size);
> 
>  /* do all the necessary bookkeeping to release a user-managed TFM, use
>  char pointer to avoid alloc/free mismatch */
> 
>  crypto_copy_cleanup_tfm(char *usertfm);

Yes, I thought of something like this.


