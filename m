Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbUB0UNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 15:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbUB0UNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 15:13:48 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:54232 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263105AbUB0UNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 15:13:38 -0500
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
From: Christophe Saout <christophe@saout.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Jean-Luc Cooke <jlcooke@certainkey.com>, linux-kernel@vger.kernel.org,
       James Morris <jmorris@intercode.com.au>
In-Reply-To: <20040227200214.GK3883@waste.org>
References: <20040219111835.192d2741.akpm@osdl.org>
	 <20040220171427.GD9266@certainkey.com>
	 <20040221021724.GA8841@leto.cs.pocnet.net>
	 <20040224191142.GT3883@waste.org>
	 <1077651839.11170.4.camel@leto.cs.pocnet.net>
	 <20040224203825.GV3883@waste.org> <20040225214308.GD3883@waste.org>
	 <1077824146.14794.8.camel@leto.cs.pocnet.net>
	 <20040226200244.GH3883@waste.org>
	 <1077897901.29711.44.camel@leto.cs.pocnet.net>
	 <20040227200214.GK3883@waste.org>
Content-Type: text/plain
Message-Id: <1077912813.2505.8.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 21:13:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, den 27.02.2004 schrieb Matt Mackall um 21:02:

> > We could add some functions so that everything is symmetric:
> > (the names with a star are already existing)
> > 
> > *crypto_alloc_tfm
> > \_ crypto_init_tfm
> > 
> > *crypto_free_tfm
> > \_ crypto_release_tfm
> > 
> > crypto_clone_tfm
> > \_ crypto_copy_tfm
> > 
> > crypto_get_alg_size
> > \_crypto_get_tfm_size
> > 
> > crypto_init_tfm does everything but the kmalloc
> > crypto_release_tfm everything but the kfree
> > 
> > So crypto_alloc_tfm and crypto_release_tfm can be changed to call
> > crypto_init_fdm and crypto_release_tfm plus crypto_get_alg_size/kmalloc
> > and kfree.
> > 
> > crypto_clone_tfm calls crypto_get_tfm_size, kmalloc and crypto_copy_tfm.
> > crypto_copy_tfm copies the tfm structure, cares about algorithm
> > reference counting and calls a (new) copy method. This copy method
> > should copy things in its context like kmalloc'ed structures (or
> > increment a reference count if it's a static memory structure or
> > something). (however kmalloc's should be avoided if possible, the
> > variable sized context provides some flexibility)
> > 
> > crypto_get_alg_size returns the size of the tfm structure when algorithm
> > name and flags are given, crypto_get_tfm size returns the size of an
> > existing tfm structure.
> > 
> > So we can also directly initialize a tfm structure on a stack, not only
> > copy it to a stack. Very flexible.
> 
> My original proposal was something like this. Downside with
> _initializing_ on stack is that it's much more heavy-weight. We can
> end having to sleep on pulling in an algorithm. The copy stuff,
> hopefully, can be done in any context.

This was just for completeness reasons. Why being able to copy onto the
stack but not to create on the stack. It doesn't have to be on the
stack. Assuming you want to handle a lot of context and use a mempool.
You might want to have your structure and a tfm to the end of that
structure so they are allocated together. Yes, you could also create a
kmalloc'ed tfm once and copy it to every other structure. Perhaps that's
not even so bad, because in my implementation there is one problem:

You have to know the size of the structure before initializing it. So
the user might change the underlying module why querying the size and
initializing the structure. Hmm. That can be dropped if it doesn't make
sense.

> I'd like to keep it to the minimal three new external functions until
> we have a case that really demonstrates a need for the other stuff.
> Let's keep it simple, get it merged, and go from there. The API I
> posted will work for the three other users I'm aware of, if it works
> for dm-crypt let's go with it.

I've added methods for copying the tfm context because it will fail very
badly for everything that has a pointer in the private context.
Use-after-free and these things. Ugly.

> I also want to hold off on adding ->copy until we find an algorithm
> that can't be cleanly fixed not to need it.

Hmm. It should be there, but could return -EOPNOTSUPP. Copying a
compress tfm doesn't make much sense. We need a way to detect things
that are bad in a generic way, everything else is hacky.


