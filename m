Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318334AbSHEIKK>; Mon, 5 Aug 2002 04:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318335AbSHEIKK>; Mon, 5 Aug 2002 04:10:10 -0400
Received: from ppp-217-133-218-75.dialup.tiscali.it ([217.133.218.75]:7833
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318334AbSHEIKJ>; Mon, 5 Aug 2002 04:10:09 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Luca Barbieri <ldb@ldb.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028505732.15495.38.camel@irongate.swansea.linux.org.uk>
References: <1028471237.1294.515.camel@ldb>  <20020804185952.GC1670@junk> 
	<1028492596.1293.535.camel@ldb> 
	<1028498075.15200.29.camel@irongate.swansea.linux.org.uk> 
	<1028493814.26332.9.camel@ldb> 
	<1028505732.15495.38.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-zF1t6eH5zD5Nfip+7UKc"
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Aug 2002 10:12:06 +0200
Message-Id: <1028535126.1572.48.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zF1t6eH5zD5Nfip+7UKc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> I'm trying to understand why you think they are needed at all. Except
> for code that specifically does non-temporal we don't need fences on an
> X86, and the code that uses non temporal stores has its own fences built
> in.
> 
> So as far as I can see the only cases we ever have to care about are
> 
> PPro - processor bug
> IDT Winchip - because we run it in oostore module not strict x86 mode
> 
> I don't see why you are generating extra fence instructions for other
> cases
> 

__volatile__ and : : :"memory" omitted from asm statements

Both without and with patch:
- barrier(): asm("")

Without patch:
- mb(): asm("lock; addl $0,0(%%esp)")
- rmb(): asm("lock; addl $0,0(%%esp)")
- wmb: if(OOSTORE) asm("lock; addl $0,0(%%esp)") else barrier()

With patch:
- mb(): if(SSE2) asm("mfence") else asm("lock; addl $0,0(%%esp)")
- rmb(): if(SSE2) asm("lfence") else asm("lock; addl $0,0(%%esp)")
- wmb: if(OOSTORE) {if(MMXEXT) asm("sfence") else asm("lock; addl
$0,0(%%esp)")} else barrier()

So I'm only replacing the lock; addl $0,0(%%esp) with the Xfence
instructions which are more efficient.

As for the need for fences, based on the Intel documentation it seems
that we need read fences to read all hardware locations not mapped as
uncacheable and write fences for all memory locations mapped as write
combining.

Since drivers often map cacheable memory and then use rmb(), rmb()
cannot be made a nop.


--=-zF1t6eH5zD5Nfip+7UKc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9TjNWdjkty3ft5+cRAuhwAKDWRMbzEhH0RN3sMjECeeebHyTKeACfQ3jG
K8B8g3g1Xv/EOWtsVZgWRjc=
=x5L8
-----END PGP SIGNATURE-----

--=-zF1t6eH5zD5Nfip+7UKc--
