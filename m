Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUJYI0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUJYI0e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 04:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbUJYI0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 04:26:32 -0400
Received: from cs181087074.pp.htv.fi ([82.181.87.74]:42477 "EHLO
	Unusual.Internal.Linux-SH.ORG") by vger.kernel.org with ESMTP
	id S261726AbUJYIWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 04:22:42 -0400
Date: Mon, 25 Oct 2004 11:22:33 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Andreas Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 13/17] 4level support for sh
Message-ID: <20041025082232.GA1419@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andreas Kleen <ak@suse.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <417CAA06.mail3ZK11VJ7Y@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <417CAA06.mail3ZK11VJ7Y@wotan.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 25, 2004 at 09:23:50AM +0200, Andreas Kleen wrote:
> 4level support for sh
>=20
> Converted, but doesn't compile for other reasons
>=20
> Signed-off-by: Andi Kleen <ak@suse.de>
>=20
I'll see about fixing up the build. On another note, it looks like these
got grouped in accidentally:

> diff -urpN -X ../KDIFX linux-2.6.10rc1/drivers/macintosh/via-pmu.c linux-=
2.6.10rc1-4level/drivers/macintosh/via-pmu.c
> --- linux-2.6.10rc1/drivers/macintosh/via-pmu.c	2004-10-19 01:55:14.00000=
0000 +0200
> +++ linux-2.6.10rc1-4level/drivers/macintosh/via-pmu.c	2004-10-25 04:48:1=
0.000000000 +0200
> @@ -2504,7 +2504,7 @@ powerbook_sleep_grackle(void)
>   		_set_L2CR(save_l2cr);
>  =09
>  	/* Restore userland MMU context */
> -	set_context(current->active_mm->context, current->active_mm->pgd);
> +	set_context(current->active_mm->context, (pml4_t *)current->active_mm->=
pml4);
> =20
>  	/* Power things up */
>  	pmu_unlock();
> @@ -2604,7 +2604,7 @@ powerbook_sleep_Core99(void)
>   		_set_L3CR(save_l3cr);
>  =09
>  	/* Restore userland MMU context */
> -	set_context(current->active_mm->context, current->active_mm->pgd);
> +	set_context(current->active_mm->context, (pgd_t *)current->active_mm->p=
ml4);
> =20
>  	/* Tell PMU we are ready */
>  	pmu_unlock();
> diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-parisc/cacheflush.h li=
nux-2.6.10rc1-4level/include/asm-parisc/cacheflush.h
> --- linux-2.6.10rc1/include/asm-parisc/cacheflush.h	2004-10-19 01:55:33.0=
00000000 +0200
> +++ linux-2.6.10rc1-4level/include/asm-parisc/cacheflush.h	2004-10-25 04:=
48:10.000000000 +0200
> @@ -113,7 +113,7 @@ static inline void flush_cache_range(str
>  static inline pte_t *__translation_exists(struct mm_struct *mm,
>  					  unsigned long addr)
>  {
> -	pgd_t *pgd =3D pgd_offset(mm, addr);
> +	pgd_t *pgd =3D pml4_pgd_offset(pml4_offset(mm, addr), addr);
>  	pmd_t *pmd;
>  	pte_t *pte;
> =20
> @@ -155,7 +155,7 @@ flush_user_cache_page_non_current(struct
>  	preempt_disable();
> =20
>  	/* make us current */
> -	mtctl(__pa(vma->vm_mm->pgd), 25);
> +	mtctl(__pa(vma->vm_mm->pml4), 25);
>  	mtsp(vma->vm_mm->context, 3);
> =20
>  	flush_user_dcache_page(vmaddr);
> diff -urpN -X ../KDIFX linux-2.6.10rc1/include/asm-s390/tlbflush.h linux-=
2.6.10rc1-4level/include/asm-s390/tlbflush.h
> --- linux-2.6.10rc1/include/asm-s390/tlbflush.h	2004-03-21 21:11:56.00000=
0000 +0100
> +++ linux-2.6.10rc1-4level/include/asm-s390/tlbflush.h	2004-10-25 04:48:1=
0.000000000 +0200
> @@ -105,7 +105,7 @@ static inline void __flush_tlb_mm(struct
>  	if (MACHINE_HAS_IDTE) {
>  		asm volatile (".insn rrf,0xb98e0000,0,%0,%1,0"
>  			      : : "a" (2048),
> -			      "a" (__pa(mm->pgd)&PAGE_MASK) : "cc" );
> +			      "a" (__pa(mm->pml4)&PAGE_MASK) : "cc" );
>  		return;
>  	}
>  	preempt_disable();

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBfLfI1K+teJFxZ9wRAq1sAJ9egdVh8wh7q2uqWwt8AZdPOZbxWACcCjPr
EhB/1Iyp7nKOESxwJ7zqROE=
=7a3a
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
