Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVBBWuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVBBWuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVBBWt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:49:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53144 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262260AbVBBWqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:46:20 -0500
Date: Wed, 2 Feb 2005 17:46:09 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <michal@logix.cz>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <20050130180723.GA2786@ghanima.endorphin.org>
Message-ID: <Xine.LNX.4.44.0502021728140.5000-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005, Fruhwirth Clemens wrote:

> Ok, here comes a reworked scatterwalk patch. Instead of making
> scatterwalk_walk controllable via another additional function or interface,
> I decided to make scatterwalk_walk quickly restartable. Therefore, I had to
> move an initialization responsibility to the client.
> 
> I first planed to this with nice C99 designed structs and compound literals,
> but in fact this C99 extension just sucks. It's useless, as compound
> literals can't be used as initializers, making this concept at least half
> useless. The worst thing of all is, gcc doesn't spill out an error, but just
> does random things to your variables. 
> 
> GCC C99 ranting aside, this patch also fixes some failing test cases for
> chunking across pages.
> 
> James, please test it against ipsec. I'm confident, that everything will
> work as expected and we can proceed to merge padlock-multiblock against this
> scatterwalker, so please Andrew, merge after a successful test of James.

This code tests ok with IPSec, and delivers some good performance
improvements.  e.g. FTP transfers over transport mode AES over GigE sped
up with this patch applied on one side of the connection by 20% for send
and 15% for receive.

There are quite a few coding style and minor issues to be fixed (per 
below), and the code should probably then be tested in the -mm tree for a 
while (2.6.11 is too soon for mainline merge).

> +static int ecb_process_gw(void *_priv, int nsg, void **buf) 

Please just use 'priv', the underscore is not neccessary.

What does _gw mean?

> -static int ecb_decrypt(struct crypto_tfm *tfm,
> +static inline int ecb_template(struct crypto_tfm *tfm,
> +	               struct scatterlist *dst,
> +                       struct scatterlist *src, unsigned int nbytes, cryptfn_t crfn)

Please fix alignment (elsewhere too).

> +	return ecb_template(tfm,dst,src,nbytes,tfm->__crt_alg->cra_cipher.cia_encrypt);


Missing spaces, should be ecb_template(tfm, dst, src...) 

> +struct cbc_process_priv {
> +	struct crypto_tfm *tfm;
> +	int enc;
> +	cryptfn_t *crfn;
> +	u8 *curIV;
> +	u8 *nextIV;
> +};

No caps please, I suggest curr_iv and next_iv.

> +#define scatterwalk_needscratch(walk, nbytes) 						\
> +	((nbytes) <= (walk)->len_this_page &&						\
> +	    (((unsigned long)(walk)->data) & (PAGE_CACHE_SIZE - 1)) + (nbytes) <=	\
> +	    PAGE_CACHE_SIZE)								\

This should be a static inline.

> +#define scatterwalk_info_endtag(winfo) (winfo)->sw.sg = NULL;

Ditto.

> +        for(csg = walk_infos; csg->sw.sg; csg++) {
> +		scatterwalk_map(&csg->sw, csg->ioflag);

Indending + coding style: should be for (...).

> +	while(steps--) {

while ()

> +		
> +		r = pf(priv, nsl, dispatch_list);
> +		if(unlikely(r < 0))
> +			goto out;

Not sure if the unlikely() is justified here, given that this is not a 
fast path.  I guess it doesn't do any harm.

> +		for(csg = walk_infos, cbuf = dispatch_list; csg->sw.sg; csg++, cbuf++) {	
> +			if(csg->ioflag == 1) 

for ()
if ()

> +	for(csg = walk_infos; csg->sw.sg; csg++) {

Ditto.



- James
-- 
James Morris
<jmorris@redhat.com>



