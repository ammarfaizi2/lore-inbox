Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbUB0QFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 11:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbUB0QFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 11:05:21 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:48585 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263013AbUB0QFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 11:05:08 -0500
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
From: Christophe Saout <christophe@saout.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
In-Reply-To: <20040226200244.GH3883@waste.org>
References: <20040219170228.GA10483@leto.cs.pocnet.net>
	 <20040219111835.192d2741.akpm@osdl.org>
	 <20040220171427.GD9266@certainkey.com>
	 <20040221021724.GA8841@leto.cs.pocnet.net>
	 <20040224191142.GT3883@waste.org>
	 <1077651839.11170.4.camel@leto.cs.pocnet.net>
	 <20040224203825.GV3883@waste.org> <20040225214308.GD3883@waste.org>
	 <1077824146.14794.8.camel@leto.cs.pocnet.net>
	 <20040226200244.GH3883@waste.org>
Content-Type: text/plain
Message-Id: <1077897901.29711.44.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 17:05:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 26.02.2004 schrieb Matt Mackall um 21:02:

> User is giving us the size of his buffer, not the size of the tfm
> which we already know. We refuse to copy if buffer is not big enough,
> otherwise return number of bytes copied.

Well, I would usually except the user knows what he does, but okay, if
you think that's safer. It requires the user to carry the size of the
buffer around. Assuming he kmallocs the buffer in one function with the
correct size and wants to use it in another function (a mempool or
something, who knows). He doesn't know the size of the buffer there.

> This may seem a little
> redundant for the on-stack usage of the API, but may make sense in
> other cases.

It may, yes. But I don't think this kind of thing is done elsewhere in
the kernel. It's okay for things like user space libraries where the
libraries and users can be compiled separately to catch problems with
ABI changes, but in the kernel? I think it's overkill.
 
These things should be caught using BUG_ONs if you thing someone might
get them wrong somehow und in the future if something changes. But now
if they add additional parameters.

> > > +void crypto_cleanup_copy_tfm(char *user_tfm)
> > > +{
> > > +	crypto_exit_ops((struct crypto_tfm *)user_tfm);
> > 
> > This looks dangerous. The algorithm might free a buffer. This is only
> > safe if we introduce per-algorithm copy methods that also duplicate
> > external buffers.
> 
> I'm currently working under the assumption that such external buffers
> are unnecessary but I haven't done the audit. If and when such code
> exist, such code should be added, yes. Hence the comment in the copy
> function:
> 
> +       /* currently assumes shallow copy is sufficient */

Ok, I see.

We could add some functions so that everything is symmetric:
(the names with a star are already existing)

*crypto_alloc_tfm
\_ crypto_init_tfm

*crypto_free_tfm
\_ crypto_release_tfm

crypto_clone_tfm
\_ crypto_copy_tfm

crypto_get_alg_size
\_crypto_get_tfm_size

crypto_init_tfm does everything but the kmalloc
crypto_release_tfm everything but the kfree

So crypto_alloc_tfm and crypto_release_tfm can be changed to call
crypto_init_fdm and crypto_release_tfm plus crypto_get_alg_size/kmalloc
and kfree.

crypto_clone_tfm calls crypto_get_tfm_size, kmalloc and crypto_copy_tfm.
crypto_copy_tfm copies the tfm structure, cares about algorithm
reference counting and calls a (new) copy method. This copy method
should copy things in its context like kmalloc'ed structures (or
increment a reference count if it's a static memory structure or
something). (however kmalloc's should be avoided if possible, the
variable sized context provides some flexibility)

crypto_get_alg_size returns the size of the tfm structure when algorithm
name and flags are given, crypto_get_tfm size returns the size of an
existing tfm structure.

So we can also directly initialize a tfm structure on a stack, not only
copy it to a stack. Very flexible.

What do you think?


