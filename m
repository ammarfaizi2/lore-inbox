Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbUBYDQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUBYDP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:15:59 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:2450 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S262426AbUBYDPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:15:46 -0500
Date: Tue, 24 Feb 2004 22:05:32 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Christophe Saout <christophe@saout.de>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040225030532.GA313@certainkey.com>
References: <20040219170228.GA10483@leto.cs.pocnet.net> <20040219111835.192d2741.akpm@osdl.org> <20040220171427.GD9266@certainkey.com> <20040221021724.GA8841@leto.cs.pocnet.net> <20040224191142.GT3883@waste.org> <1077675924.9180.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077675924.9180.8.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 03:25:24AM +0100, Christophe Saout wrote:
> Am Di, den 24.02.2004 schrieb Matt Mackall um 20:11:
> 
> > > +	int tfm_size = sizeof(*cc->digest) + cc->digest->__crt_alg->cra_ctxsize;
> > > +	char tfm[tfm_size];
> > > [...]
> > > +	memcpy(tfm, cc->digest, tfm_size);
> > 
> > As this stands, it's rather scary.
> > 
> > - it will quietly break when cryptoapi gets fiddled with
> 
> Yes, and it's already broken. When putting a lot of stress to the
> filesystem data corruption pops up.
> 
> It turned out the hmac code uses an additional scratch pad which is used
> in crypto_hmac_final (the "opad") which was kmalloc'ed. So it isn't even
> inside the context (the one after struct tfm with length cra_ctxsize).
> 
> Why that? That kmalloc could have been avoided and the opad could store
> after the tfm struct too (or on the stack of the crypto_hmac_final or is
> it too large?). Yes, I know, ... but it would really be nice not to put
> locks around the calls.


This is insine, there is no reason to have that outside of function scope at
all.

Here's the fix.
  http://jlcooke.ca/lkml/hmac_reent.patch

Uses the stack now (peak stack usage will not go up)

James - I'll wrap this one up with my other in one patch.  This is a "look
see, say 'OK'" patch.

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
