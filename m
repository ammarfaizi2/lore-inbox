Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268529AbUI2O2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268529AbUI2O2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268524AbUI2O2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:28:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23183 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268488AbUI2OZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:25:39 -0400
Date: Wed, 29 Sep 2004 16:25:21 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040929142521.GB22928@devserv.devel.redhat.com>
References: <20040925162252.GN3309@dualathlon.random> <1096272553.6572.3.camel@laptop.fenrus.com> <20040927130919.GE28865@dualathlon.random> <20040928194351.GC5037@devserv.devel.redhat.com> <20040928221933.GG4084@dualathlon.random> <20040929060521.GA6975@devserv.devel.redhat.com> <20040929141151.GJ4084@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <20040929141151.GJ4084@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 29, 2004 at 04:11:51PM +0200, Andrea Arcangeli wrote:
> On Wed, Sep 29, 2004 at 08:05:21AM +0200, Arjan van de Ven wrote:
> > oh? you mean that 1Mb gap between stack and topdown? Every ISV I talked to
> > said they could get more VA space with topdown than with the suse
> > mmaped_base hack... :)
> 
> /*
>  * Top of mmap area (just below the process stack).
>  *
>  * Leave an at least ~128 MB hole.
>  */
> #define MIN_GAP (128*1024*1024)
> #define MAX_GAP (TASK_SIZE/6*5)
> 
> where does your 1M comes from? it's a minimum 128Mbytes.

the patch posted recently on this list reduced it to 1Mb.

> > MAP_FIXED is to be used only on things YOU mmaped before. 
> 
> where is that written?

it's basic common sence 

> > wrong; brk() is there which is also used by malloc() and internally by the C
> > library.
> 
> that's malloc, but mmaps don't fit into it.

MAP_FIXED happily will go over an malloc(), it's both just vma's


> > do you have proof for that?
> 
> do I need to write the exploited testcase? just let me know, it'll take
> only a few minutes.

your claim was that existing apps would break.
I know you can write a testcase, one can write a testcase even for your
proposed patch showing breakage.

> small malloc works below the 1G area, but it's the application that has
> to use malloc. 

the application, the C library, the dynamic linker, all shared libs it links
against.

> now the best thing is the ADDR_COMPAT_LAYOUT personality, that is what
> can make it safe, and I hope it's enabled by default on all apps, but
> I'm afraid it's the other way around, i.e. that the application will be
> marked "compatible" after it breaks at runtime. Plus the testing will be
> decreased since most people runs with unlimited stack (which defaults to
> bottomup beahviour).

You are wrong; the default is 8Mb stack limit in the kernel; I absolutely do
not see where you claim from "most people run with unlimited stack" comes
from.

> the single fact you added ADDR_COMPAT_LAYOUT means you're very well
> aware there are apps that will break, or there would be no point for a
> "COMPAT" option, if it was really backwards compatible by default, or do
> I misunderstand the semantics of ADDR_COMPAT_LAYOUT personality?

I am aware of 2 applications breaking. Both did

int ptr;

ptr=malloc(bigchunk);
if (ptr < 0)
	assume_alloc_failure();

Both are open source and since long fixed. Still it made sense to add a
safety net (akpm asked for it; for example in rhel3 or FC2 we do not have one at
all, nor do those kernels have mmaped_base hack). 
--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBWsXQxULwo51rQBIRAghRAJ9g/AiXUamKfLzZewy0CIBaP514GwCfWYf6
KvKOGL+8xNnoIJck8FVGtSg=
=+abh
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
