Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUBYVMo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbUBYVLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:11:09 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:50836 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261539AbUBYVJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:09:55 -0500
Date: Wed, 25 Feb 2004 15:59:52 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Christophe Saout <christophe@saout.de>
Cc: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: cryptoapi OMAC (was: cryptoapi highmem bug)
Message-ID: <20040225205952.GB7140@certainkey.com>
References: <20040224223425.GA32286@certainkey.com> <1077663682.6493.1.camel@leto.cs.pocnet.net> <20040225043209.GA1179@certainkey.com> <20040224220030.13160197.akpm@osdl.org> <20040225153126.GA7395@leto.cs.pocnet.net> <20040225155121.GA7148@leto.cs.pocnet.net> <20040225154453.GB4218@certainkey.com> <1077725621.7221.0.camel@leto.cs.pocnet.net> <20040225160935.GD4218@certainkey.com> <20040225181131.GA8983@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225181131.GA8983@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.

Using a base kernel, apply the scatterwalk change:
  http://jlcooke.ca/lkml/cryptowalk_christophe_25feb2004.patch

Then apply this:
  http://jlcooke.ca/lkml/crypto_omac_hmac_ctr_25feb2004.patch

This is my HMAC/OMAC/CTR patch.  I think I fixed your HMAC issue.
I was giving a scatterlist a stack memory reference (!).  It now more
closely uses the digest.c functions.

JLC

On Wed, Feb 25, 2004 at 07:11:33PM +0100, Christophe Saout wrote:
> On Wed, Feb 25, 2004 at 11:09:35AM -0500, Jean-Luc Cooke wrote:
> 
> > http://jlcooke.ca/lkml/crypto_24feb2004.patch will work.
> 
> It didn't compile. I fixed some compile problems so that it works.
> I have disabled CRYPTO_OMAC though. And it goes boom when calling
> hmac_init (or something like that), the machine halts without Oops.
> 
> I've seen the cit_omac is kmalloc'ed. Hmm. Didn't we want to try
> to avoid that? Well. Perhaps it should be allocated when the
> omac_init is called and freed after omac_final.
> 
> Or what about this:
> If the user wants OMAC he calls omac_init and passes a pointer to
> a buffer where the omac will be computed. omac_init then sets
> the omac_update function so that xxx_process will call it. After
> the encryption is finished the user calls omac_final and finds
> the omac in his buffer.
> 
> And shouldn't the omac functions be put into a separate omac.c?
> 
> Moving the scatterwalk functions seems like a good idea to me.
> 
> Well, here are the compile fixes:
> 
> diff -Nur linux.orig/crypto/cipher.c linux/crypto/cipher.c
> --- linux.orig/crypto/cipher.c	2004-02-25 18:58:22.955601768 +0100
> +++ linux/crypto/cipher.c	2004-02-25 18:59:30.970261968 +0100
> @@ -280,7 +280,7 @@
>  			/* mac = Zeros */
>  			memset((u8*)tfm->crt_u.cipher.cit_omac, 0, crypto_tfm_alg_blocksize(tfm));
>  		}
> -#endif
> +#endif /* CONFIG_CRYPTO_OMAC */
>  
>  		return ret;
>  	}
> @@ -475,9 +475,12 @@
>  	    	ops->cit_iv = kmalloc(ops->cit_ivsize, GFP_KERNEL);
>  		if (ops->cit_iv == NULL)
>  			ret = -ENOMEM;
> +
> +#ifdef CONFIG_CRYPTO_OMAC
>  		ops->cit_omac = kmalloc(ops->cit_ivsize, GFP_KERNEL);
>  		if (ops->cit_omac == NULL)
>  			ret = -ENOMEM;
> +#endif /* CONFIG_CRYPTO_OMAC */
>  	}
>  
>  #ifdef CONFIG_CRYPTO_OMAC
> @@ -499,5 +502,5 @@
>  #ifdef CONFIG_CRYPTO_OMAC
>  	if (tfm->crt_cipher.cit_omac)
>  		kfree(tfm->crt_cipher.cit_omac);
> -#endif
> +#endif /* CONFIG_CRYPTO_OMAC */
>  }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
