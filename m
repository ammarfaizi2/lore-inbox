Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266068AbUBCTZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 14:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbUBCTYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 14:24:21 -0500
Received: from waste.org ([209.173.204.2]:37289 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266116AbUBCSv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 13:51:28 -0500
Date: Tue, 3 Feb 2004 12:51:12 -0600
From: Matt Mackall <mpm@selenic.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib routines
Message-ID: <20040203185111.GA31138@waste.org>
References: <yquj4qu8je1m.fsf@chaapala-lnx2.cisco.com> <Xine.LNX.4.44.0402031213120.939-100000@thoron.boston.redhat.com> <20040203175006.GA19751@chaapala-lnx2.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203175006.GA19751@chaapala-lnx2.cisco.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 11:50:06AM -0600, Clay Haapala wrote:

> +void crypto_exit_chksum_ops(struct crypto_tfm *tfm)
> +{
> +	return;
> +}

It'd be nice to come up with a way to avoid null funcs just for the
sake of satisfying function pointers, there's quite a few of them
around.

> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option) 
> + * any later version.
...
> +MODULE_LICENSE("GPL and additional rights");

"additional rights?"

> +#if __GNUC__ >= 3	/* 2.x has "attribute", but only 3.0 has "pure */
> +#define attribute(x) __attribute__(x)
> +#else
> +#define attribute(x)
> +#endif

This sort of thing ought to be added to linux/compiler.h if it's not
there already.

> +/*
> + * Haven't generated a big-endian table yet, but the bit-wise version
> + * should at least work.
> + */

Big-endian in this context means, of course, the order of the bits in
the byte rather than bytes in a word, and as this CRC polynomial was
chosen especially for its robustness on noise bursts in little-endian
transmission (aka standard serial and network *bit* transmission
ordering), I think we should intentionally omit BE support and make
note of it.

> +static inline void crypto_chksum_final(struct crypto_tfm *tfm, u32 *out)
> +{
> +	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CHKSUM);

A lot of these BUG_ONs seem to be overkill. You're not going to get
here by someone accidentally misusing the interface. You can only get
here by some very willful abuse of the interface or by extremely
unlikely fandango on core, neither of which is worth trying to defend
against.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
