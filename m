Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbUBZUFs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUBZUFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:05:47 -0500
Received: from waste.org ([209.173.204.2]:23016 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262960AbUBZUDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:03:10 -0500
Date: Thu, 26 Feb 2004 14:02:45 -0600
From: Matt Mackall <mpm@selenic.com>
To: Christophe Saout <christophe@saout.de>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040226200244.GH3883@waste.org>
References: <20040219170228.GA10483@leto.cs.pocnet.net> <20040219111835.192d2741.akpm@osdl.org> <20040220171427.GD9266@certainkey.com> <20040221021724.GA8841@leto.cs.pocnet.net> <20040224191142.GT3883@waste.org> <1077651839.11170.4.camel@leto.cs.pocnet.net> <20040224203825.GV3883@waste.org> <20040225214308.GD3883@waste.org> <1077824146.14794.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077824146.14794.8.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 08:35:46PM +0100, Christophe Saout wrote:
> Am Mi, den 25.02.2004 schrieb Matt Mackall um 22:43:
> 
> > Ok, here's my proposed API extension (currently untested). Christophe,
> > care to give it a spin?
> >
> > diff -puN crypto/api.c~crypto-copy crypto/api.c
> > --- tiny/crypto/api.c~crypto-copy	2004-02-25 15:12:43.000000000 -0600
> > +++ tiny-mpm/crypto/api.c	2004-02-25 15:37:39.000000000 -0600
> > @@ -161,6 +161,27 @@ void crypto_free_tfm(struct crypto_tfm *
> >  	kfree(tfm);
> >  }
> >  
> > +int crypto_copy_tfm(char *dst, const struct crypto_tfm *src, unsigned size)
> > +{
> > +	int s = crypto_tfm_size(src);
> > +
> > +	if (size < s)
> > +		return 0;
> 
> Why the extra check?

User is giving us the size of his buffer, not the size of the tfm
which we already know. We refuse to copy if buffer is not big enough,
otherwise return number of bytes copied. This may seem a little
redundant for the on-stack usage of the API, but may make sense in
other cases.
 
> > +void crypto_cleanup_copy_tfm(char *user_tfm)
> > +{
> > +	crypto_exit_ops((struct crypto_tfm *)user_tfm);
> 
> This looks dangerous. The algorithm might free a buffer. This is only
> safe if we introduce per-algorithm copy methods that also duplicate
> external buffers.

I'm currently working under the assumption that such external buffers
are unnecessary but I haven't done the audit. If and when such code
exist, such code should be added, yes. Hence the comment in the copy
function:

+       /* currently assumes shallow copy is sufficient */

> I'd like to avoid a kmalloc in crypto_copy_tfm.

Well you're in luck because there isn't one.

> This function also does the same as crypto_free_tfm except for the
> final kfree(tfm). So crypto_free_tfm could call this function. 

Yes.

> And it could have a better name.

Just about everything could have a better name if the poets among us
were to speak up.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
