Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUBYCZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 21:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUBYCZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 21:25:24 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:56737 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262356AbUBYCZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 21:25:18 -0500
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
Message-Id: <1077675924.9180.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 03:25:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 24.02.2004 schrieb Matt Mackall um 20:11:

> > +	int tfm_size = sizeof(*cc->digest) + cc->digest->__crt_alg->cra_ctxsize;
> > +	char tfm[tfm_size];
> > [...]
> > +	memcpy(tfm, cc->digest, tfm_size);
> 
> As this stands, it's rather scary.
> 
> - it will quietly break when cryptoapi gets fiddled with

Yes, and it's already broken. When putting a lot of stress to the
filesystem data corruption pops up.

It turned out the hmac code uses an additional scratch pad which is used
in crypto_hmac_final (the "opad") which was kmalloc'ed. So it isn't even
inside the context (the one after struct tfm with length cra_ctxsize).

Why that? That kmalloc could have been avoided and the opad could store
after the tfm struct too (or on the stack of the crypto_hmac_final or is
it too large?). Yes, I know, ... but it would really be nice not to put
locks around the calls.


