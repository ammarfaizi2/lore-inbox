Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbUJ1AO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbUJ1AO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUJ1AON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:14:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:49844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262699AbUJ1ALk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:11:40 -0400
Date: Wed, 27 Oct 2004 17:11:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove some divide instructions
In-Reply-To: <41801DE1.6000007@vmware.com>
Message-ID: <Pine.LNX.4.58.0410271704520.28839@ppc970.osdl.org>
References: <417FC982.7070602@vmware.com> <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
 <41801DE1.6000007@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Oct 2004, Zachary Amsden wrote:
> 
> Backed out everything but i386 and generic.  For the generic version, I 
> compiled and tested this code outside of the kernel.  Actually, I found 
> that at least for my tool chain, the generic version
> 
> +# define do_div(n,base) ({                                             \
> +       uint32_t __rem;                                                 \
> +       if (__builtin_constant_p(base) && !((base) & ((base)-1))) {     \
> +               __rem = ((uint64_t)(n)) % (base);                       \
> +               (n) = ((uint64_t)(n)) / (base);                         \
> +       } else {                                                        \
> +               uint32_t __base = (base);                               \
> +               __rem = ((uint64_t)(n)) % __base;                       \
> +               (n) = ((uint64_t)(n)) / __base;                         \
> +       }                                                               \
> +       __rem;          
> 
> Does indeed generate different code for the constant case - without it, 
> due to the assignment to __base, the shift / mask optimization does not 
> take place.

Oh, damn. That's a separate issue, apparently, and there you just use 
"__builtin_constant_p()" as a way to check that there are no side effects 
on "base".

Might as well drop the check for the value, since it doesn't matter.

Alternatively, we could just document the fact that neither "base" nor "n"
are normal arguments to a function. After all, we already _do_ change "n", 
and the strange calling convention is already documented as nothing but a 
sick hack to make architectures able to use inline assembly efficiently.

I could add a sparse check for "no side effects", if anybody cares (so 
that you could do

	__builtin_warning(
		!__builtin_nosideeffects(base),
		"expression has side effects");

in macros like these.. Sparse already has the logic internally..

		Linus
