Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318350AbSHEJal>; Mon, 5 Aug 2002 05:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSHEJal>; Mon, 5 Aug 2002 05:30:41 -0400
Received: from ppp-217-133-218-75.dialup.tiscali.it ([217.133.218.75]:16818
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318350AbSHEJak>; Mon, 5 Aug 2002 05:30:40 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Luca Barbieri <ldb@ldb.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028540954.16550.26.camel@irongate.swansea.linux.org.uk>
References: <1028471237.1294.515.camel@ldb>  <20020804185952.GC1670@junk> 
	<1028492596.1293.535.camel@ldb> 
	<1028498075.15200.29.camel@irongate.swansea.linux.org.uk> 
	<1028493814.26332.9.camel@ldb> 
	<1028505732.15495.38.camel@irongate.swansea.linux.org.uk> 
	<1028535126.1572.48.camel@ldb> 
	<1028540954.16550.26.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-j5UN9qJjRvoE3C6/lmJx"
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Aug 2002 11:31:17 +0200
Message-Id: <1028539877.1572.108.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-j5UN9qJjRvoE3C6/lmJx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-08-05 at 11:49, Alan Cox wrote:
> On Mon, 2002-08-05 at 09:12, Luca Barbieri wrote:
> > So I'm only replacing the lock; addl $0,0(%%esp) with the Xfence
> > instructions which are more efficient.
> 
> The original code has rmb not doing any kind of CPU operation, and wmb
> likewise. (Quoting 2.4 and 2.5.29 here)
No. As you quote below, it does a lock addl which is a serializing
operation.

lfence is the same but doesn't serialize write operations and is
probably more efficient since it is designed for the purpose of
serializing load operations.
mfence is like lfence but also serializes writes.

However I don't have a Pentium 4 so I haven't done any checking or
benchmarks.

> You don't need stronger barriers except on the Pentium Pro or the
> Winchip because of the guarantees already made by the processor and by
> the PCI interface.
> 
> The only case you need a store fence with non buggy/weird processors is
> when you do non temporal stores. In that situation the barriers are
> still not needed because the non temporal using functions already have
> their own sfence instructions and need them.
I agree and the patch only adds sfence _if_ CONFIG_X86_OOSTORE is
defined (and CONFIG_X86_MMXEXT is also defined).

> 
> #define mb()    __asm__ __volatile__ ("lock; addl $0,0(%%esp)":
> :"memory")
> #define rmb()   mb()
> 
> #ifdef CONFIG_X86_OOSTORE
> #define wmb()   __asm__ __volatile__ ("lock; addl $0,0(%%esp)": :
> :"memory")
> #else
> #define wmb()   __asm__ __volatile__ ("": : :"memory")
> #endif
> 
> 
> For the PPro a lock addl is the most efficient one I know of for working
> around the store order errata. If you want to optimise it further then
> the winchip appears to be fractionally faster using an rdmsr() but that
> impacts registers so wants more profiling
This isn't changed.



--=-j5UN9qJjRvoE3C6/lmJx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9TkXldjkty3ft5+cRAhwMAJ4r6Y/3JBiaP3N5fTyoRHMfqAhupQCgzUmr
EGXQmzcVDe9Sb4hFSkNoT6M=
=/qap
-----END PGP SIGNATURE-----

--=-j5UN9qJjRvoE3C6/lmJx--
