Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266141AbUFIVCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUFIVCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUFIVCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:02:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45499 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266141AbUFIVAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:00:15 -0400
Date: Wed, 9 Jun 2004 22:59:44 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
Subject: Re: [PATCH] ALSA: Remove subsystem-specific malloc (1/8)
Message-ID: <20040609205944.GA21150@devserv.devel.redhat.com>
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi> <20040609113455.U22989@build.pdx.osdl.net> <1086812001.13026.63.camel@cherry> <1086812486.2810.21.camel@laptop.fenrus.com> <1086814663.13026.70.camel@cherry>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <1086814663.13026.70.camel@cherry>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 09, 2004 at 11:57:43PM +0300, Pekka Enberg wrote:
> On Wed, 2004-06-09 at 23:21, Arjan van de Ven wrote:
> > how about making sure n*size doesn't overflow an int in this function?
> > We had a few security holes due to that happening a while ago; might as
> > well prevent it from happening entirely
> 
> Sure.
> 
> 		Pekka
> 
> diff -urN linux-2.6.6/include/linux/slab.h kcalloc-2.6.6/include/linux/slab.h
> --- linux-2.6.6/include/linux/slab.h	2004-06-09 22:56:11.874249056 +0300
> +++ kcalloc-2.6.6/include/linux/slab.h	2004-06-09 23:03:10.597593432 +0300
> @@ -95,6 +95,7 @@
>  	return __kmalloc(size, flags);
>  }
>  
> +extern void *kcalloc(size_t, size_t, int);
>  extern void kfree(const void *);
>  extern unsigned int ksize(const void *);
>  
> diff -urN linux-2.6.6/mm/slab.c kcalloc-2.6.6/mm/slab.c
> --- linux-2.6.6/mm/slab.c	2004-06-09 22:59:13.081701336 +0300
> +++ kcalloc-2.6.6/mm/slab.c	2004-06-09 23:50:06.592497136 +0300
> @@ -2332,6 +2332,25 @@
>  EXPORT_SYMBOL(kmem_cache_free);
>  
>  /**
> + * kcalloc - allocate memory for an array. The memory is set to zero.
> + * @n: number of elements.
> + * @size: element size.
> + * @flags: the type of memory to allocate.
> + */
> +void *kcalloc(size_t n, size_t size, int flags)
> +{
> +	if (n != 0 && size > INT_MAX / n)
> +		return NULL;
> +
> +	void *ret = kmalloc(n * size, flags);
> +	if (ret)
> +		memset(ret, 0, n * size);
> +	return ret;
> +}

ok I like it ;)

only question is what n==0 means, might as well short-circuit that but it's
optional 
--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAx3pAxULwo51rQBIRAnKFAJ9rOXH1NgCUJabb2nL3N4E2NcaqeACdGLHR
eqLavQOspg2jUvZidGPlCTY=
=Q5p2
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
