Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbSI2TEE>; Sun, 29 Sep 2002 15:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261748AbSI2TEE>; Sun, 29 Sep 2002 15:04:04 -0400
Received: from ns.suse.de ([213.95.15.193]:26886 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261746AbSI2TED>;
	Sun, 29 Sep 2002 15:04:03 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
References: <20020929152731.GA10631@averell.suse.lists.linux.kernel> <20020929182643.C8564@infradead.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Sep 2002 21:09:26 +0200
In-Reply-To: Christoph Hellwig's message of "29 Sep 2002 19:31:26 +0200"
Message-ID: <p733crssjdl.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Sun, Sep 29, 2002 at 05:27:31PM +0200, Andi Kleen wrote:
> > -extern pgd_t *pgd_alloc(struct mm_struct *);
> > +extern pgd_t *pgd_alloc(struct mm_struct *) malloc_function;
> 
> Anz chance you could make that __malloc?  That how the other
> atrributes in the kernel (e.g. __init/__exit) work.

No.

> 
> > +/* Function allocates new memory and return cannot alias with anything */
> > +#define malloc_function __attribute__((malloc))
> > +/* Never inline */
> > +#define noinline __attribute__((noinline))
> > +#else
> > +#define malloc_function
> > +#define noinline
> > +#endif
> 
> Dito for __noinline?  And IMHO compiler.h is the better place for this.

Because I dislike all the __. It's just useless visual clutter and doesn't 
follow the usual convention of prefixing only low level functions with this.
Also now that the kernel has given up on ANSI/POSIX name space cleanliness
it is double plus useless.

Same thing for __get_cpu_var for example. The __ is completely useless.

I will move it into linux/compiler.h to add some more clutter to include hell,
because it requires even more #include <linux/compiler.h>

> BTW, do you have any stats on the better optimization?

With this it sings twice as loud and dances twice and a half times as fast.

No, with gcc 3.2 it doesn't seem to make much difference.

More important is that will allow better optimization by gcc in the future.
In kernel land the gcc optimizer is already a bit crippled because of 
the -fno-strict-aliasing use. This will hopefully help a bit.

-Andi
