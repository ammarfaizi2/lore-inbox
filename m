Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbUBXTMw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUBXTMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:12:52 -0500
Received: from waste.org ([209.173.204.2]:2484 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262282AbUBXTMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:12:49 -0500
Date: Tue, 24 Feb 2004 13:11:42 -0600
From: Matt Mackall <mpm@selenic.com>
To: Christophe Saout <christophe@saout.de>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Morris <jmorris@intercode.com.au>
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
Message-ID: <20040224191142.GT3883@waste.org>
References: <20040219170228.GA10483@leto.cs.pocnet.net> <20040219111835.192d2741.akpm@osdl.org> <20040220171427.GD9266@certainkey.com> <20040221021724.GA8841@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040221021724.GA8841@leto.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 03:17:25AM +0100, Christophe Saout wrote:
> 
> And I'm memcpy'ing the tfm onto the stack now to have a local copy.
> So I don't need to lock and it makes HMAC precomputation possible
> because I don't destroy the original tfm context.
> 
> +static int crypt_iv_hmac(struct crypt_config *cc, u8 *iv, sector_t sector)
> +{
> +	struct scatterlist sg = {
> +		.page = virt_to_page(iv),
> +		.offset = offset_in_page(iv),
> +		.length = sizeof(u64) / sizeof(u8)
> +	};
> +	int i;
> +	int tfm_size = sizeof(*cc->digest) + cc->digest->__crt_alg->cra_ctxsize;
> +	char tfm[tfm_size];
> +
> +	*(u64 *)iv = cpu_to_le64((u64)sector);
> +
> +	/* HMAC has already been initialized, finish it on private copy */
> +	memcpy(tfm, cc->digest, tfm_size);

As this stands, it's rather scary.

- it will quietly break when cryptoapi gets fiddled with
- it subverts the module reference counting rules
- for a given cipher/digest, tfm_size might be large

Subverting the API this way is bad. On the other hand, I tend to think
the API does need a way to deal with problem cases like these, so I'd
support extending the API in some fashion to handle it. Related (but
not identical) issues have cropped up with a few other things that
want to avoid serializing around a single or per-cpu context.

Something like:

 /* calculate the size of a tfm so that users can manage their own
 copies */

 int crypto_alg_size(const char *name);

 /* copy a TFM to a user-managed buffer, possibly on stack, with proper
 internal reference counting and any other necessary magic, size checks
 against boneheaded buffer sizing */

 crypto_copy_tfm(char *dst, const struct crypto_tfm *src, int size);

 /* do all the necessary bookkeeping to release a user-managed TFM, use
 char pointer to avoid alloc/free mismatch */

 crypto_copy_cleanup_tfm(char *usertfm);


James, thoughts?

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
