Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbUBYV5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbUBYVzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:55:44 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:63892 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261634AbUBYVvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:51:47 -0500
Date: Wed, 25 Feb 2004 16:41:41 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, adam@yggdrasil.com
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225214141.GA7731@certainkey.com>
References: <20040224220030.13160197.akpm@osdl.org> <Xine.LNX.4.44.0402250825110.28907-100000@thoron.boston.redhat.com> <20040225115027.580cc2ed.akpm@osdl.org> <20040225212641.GA6587@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225212641.GA6587@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Read my mind Christophe!

This...
  http://jlcooke.ca/lkml/crypto_omac_hmac_ctr_25feb2004.patch

...and C.Saout's latest patch in single serving form:
  http://jlcooke.ca/lkml/crypto_omac_hmac_ctr_25feb2004_b.patch

JLC

On Wed, Feb 25, 2004 at 10:27:08PM +0100, Christophe Saout wrote:
> On Wed, Feb 25, 2004 at 11:50:27AM -0800, Andrew Morton wrote:
> 
> > Or maybe it's sufficient for crypt() to pass a simple boolean down to the
> > prfn() callout which says "this is in-place encryption".
> 
> Yes, this works. As usual I was simply thinking too complicated. ;)
> 
> It looks like this now. It's on top of Jean-Luc's patch. Jean-Luc, can
> update your patch and use this one instead? It's much simpler this way
> and it keeps the whole voodoo in cipher.c.
> 
> diff -ur linux.orig/crypto/cipher.c linux/crypto/cipher.c
> --- linux.orig/crypto/cipher.c	2004-02-25 17:26:06.000000000 +0100
> +++ linux/crypto/cipher.c	2004-02-25 22:11:03.000000000 +0100
> @@ -26,7 +26,7 @@
>  
>  typedef void (cryptfn_t)(void *, u8 *, const u8 *);
>  typedef void (procfn_t)(struct crypto_tfm *, u8 *,
> -                        u8*, cryptfn_t, int enc, void *);
> +                        u8*, cryptfn_t, int enc, void *, int);
>  
>  static inline void xor_64(u8 *a, const u8 *b)
>  {
> @@ -81,7 +81,9 @@
>  
>  		scatterwalk_copychunks(src_p, &walk_in, bsize, 0);
>  
> -		prfn(tfm, dst_p, src_p, crfn, enc, info);
> +		prfn(tfm, dst_p, src_p, crfn, enc, info,
> +		     scatterwalk_samebuf(&walk_in, &walk_out,
> +					 src_p, dst_p));
>  
>  		scatterwalk_done(&walk_in, 0, nbytes);
>  
> @@ -185,8 +187,8 @@
>  }
>  #endif /* CONFIG_CRYPTO_OMAC */
>  
> -static void cbc_process(struct crypto_tfm *tfm,
> -                        u8 *dst, u8 *src, cryptfn_t fn, int enc, void *info)
> +static void cbc_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
> +			cryptfn_t fn, int enc, void *info, int in_place)
>  {
>  	u8 *iv = info;
>  	
> @@ -202,9 +204,8 @@
>  		fn(crypto_tfm_ctx(tfm), dst, iv);
>  		memcpy(iv, dst, crypto_tfm_alg_blocksize(tfm));
>  	} else {
> -		const int need_stack = (src == dst);
> -		u8 stack[need_stack ? crypto_tfm_alg_blocksize(tfm) : 0];
> -		u8 *buf = need_stack ? stack : dst;
> +		u8 stack[in_place ? crypto_tfm_alg_blocksize(tfm) : 0];
> +		u8 *buf = in_place ? stack : dst;
>  		
>  		fn(crypto_tfm_ctx(tfm), buf, src);
>  		tfm->crt_u.cipher.cit_xor_block(buf, iv);
> @@ -214,13 +215,12 @@
>  	}
>  }
>  
> -static void ctr_process(struct crypto_tfm *tfm,
> -                        u8 *dst, u8 *src, cryptfn_t fn, int enc, void *info)
> +static void ctr_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
> +			cryptfn_t fn, int enc, void *info, int in_place)
>  {
>  	u8 *iv = info;
> -	const int need_stack = (src == dst);
> -	u8 stack[need_stack ? crypto_tfm_alg_blocksize(tfm) : 0];
> -	u8 *buf = need_stack ? stack : dst;
> +	u8 stack[in_place ? crypto_tfm_alg_blocksize(tfm) : 0];
> +	u8 *buf = in_place ? stack : dst;
>  	int i;
>  
>  	/* Null encryption */
> @@ -255,7 +255,7 @@
>  
>  
>  static void ecb_process(struct crypto_tfm *tfm, u8 *dst, u8 *src,
> -                        cryptfn_t fn, int enc, void *info)
> +			cryptfn_t fn, int enc, void *info, int in_place)
>  {
>  	/* we can use dst as scratch space since we overwrite it later */
>  	omac_update(tfm, dst, src);
> diff -ur linux.orig/crypto/scatterwalk.h linux/crypto/scatterwalk.h
> --- linux.orig/crypto/scatterwalk.h	2004-02-25 17:26:06.000000000 +0100
> +++ linux/crypto/scatterwalk.h	2004-02-25 22:10:15.000000000 +0100
> @@ -38,6 +38,14 @@
>  	return sg + 1;
>  }
>  
> +static inline int scatterwalk_samebuf(struct scatter_walk *walk_in,
> +				      struct scatter_walk *walk_out,
> +				      void *src_p, void *dst_p)
> +{
> +	return walk_in->page == walk_out->page &&
> +	       walk_in->data == src_p && walk_out->data == dst_p;
> +}
> +
>  void *scatterwalk_whichbuf(struct scatter_walk *walk, unsigned int nbytes, void *scratch);
>  void scatterwalk_start(struct scatter_walk *walk, struct scatterlist *sg);
>  int scatterwalk_copychunks(void *buf, struct scatter_walk *walk, size_t nbytes, int out);

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
