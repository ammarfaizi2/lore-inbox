Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266567AbRG1LOw>; Sat, 28 Jul 2001 07:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266574AbRG1LOm>; Sat, 28 Jul 2001 07:14:42 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:24882 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S266567AbRG1LO3>; Sat, 28 Jul 2001 07:14:29 -0400
Date: Sat, 28 Jul 2001 13:11:59 +0200
From: Kurt Garloff <garloff@suse.de>
To: David Lang <dlang@diginsite.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, cw@f00f.org, ppeiffer@free.fr,
        linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
        Chris Brady <crsbrady@earthlink.net>
Subject: Re: VIA KT133A / athlon / MMX
Message-ID: <20010728131159.B23174@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	David Lang <dlang@diginsite.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, cw@f00f.org, ppeiffer@free.fr,
	linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
	Chris Brady <crsbrady@earthlink.net>
In-Reply-To: <E15QEP3-0006TF-00@the-village.bc.nu> <Pine.LNX.4.33.0107271718550.29714-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107271718550.29714-100000@dlang.diginsite.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--YkJPYEFdoxh/AXLE
Content-Type: multipart/mixed; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 27, 2001 at 05:23:07PM -0700, David Lang wrote:
> I have a 1u box at my des that has two MSI boards in it with 1.2G athlons.
> at the moment they are both running 2.4.5 (athlon optimized), one box has
> no problems at all while the other dies (no video, no keyboard, etc)
> within an hour of being booted.

Somebody told he had the same MoBo already replaced a couple of times ...

> if you have any patch you would like me to test on these boxes let me know

Well, no kernel patches.
But some program which does the K7 optmizied copies and zeroing in userspac=
e.
(Attached)

Strange enough it succeeds on the machine that fails to boot a K7 optimized
kernel.=20
So I'm puzzled now.=20
Seems we can trigger problems in kernelspace that we can't have in userspac=
e?
Some problem with non-serialization if an interrupt occurs or something
esoteric like this?

> (I am arranging to ship this one and three others like it that each have
> one working and one failing system in them back to the factory to get the
> MLB swapped out on the one that is failing.

Good luck!
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test_movntq.c"
Content-Transfer-Encoding: quoted-printable

/* test_movntq.c=20
 * Program that tests the K7 optimized routines for copying=20
 * and zeroing pages (which fail on some MoBos in the kernel).
 * gcc -O2 -Wall -g -fomit-frame-pointer -o test_movntq test_movntq.c
 * and run on AMD K7!
 * (c) Kurt Garloff <garloff@suse.de>, 2001-07-28, GNU GPL
 */

#include <stdio.h>
#include <unistd.h>
#include <malloc.h>
#include <stdlib.h>

#define PAGE_SIZE 4096
#define NR_TESTS 4096

void * fpu_ctx;

double c;
void trigger_fpu ()
{

	double a =3D 4.3;
	double b =3D rand()/ (float)RAND_MAX;
	c =3D a/b;
}

void movntq_copy_page0 (void* to, void* from)
{
	//void *d0, *d1;
	//printf ("%p <- %p\n", to, from);
	asm volatile (
		      "\n\t   prefetch (%0)"
		      "\n\t   prefetch 64(%0)"
		      "\n\t   prefetch 128(%0)"
		      "\n\t   prefetch 192(%0)"
		      "\n\t   fxsave (%3)"
		      "\n\t   prefetch 256(%0)"
		      "\n\t   movl %2, %%ecx"
		      "\n\t   fnclex"
		      "\n\t1: prefetch 320(%0)"
		      "\n\t   movq (%0),%%mm0"
		      "\n\t   movntq %%mm0,(%1)"
		      "\n\t   movq 8(%0),%%mm1"
		      "\n\t   movntq %%mm1,8(%1)"
		      "\n\t   movq 16(%0),%%mm2"
		      "\n\t   movntq %%mm2,16(%1)"
		      "\n\t   movq 24(%0),%%mm3"
		      "\n\t   movntq %%mm3,24(%1)"
		      "\n\t   movq 32(%0),%%mm4"
		      "\n\t   movntq %%mm4,32(%1)"
		      "\n\t   movq 40(%0),%%mm5"
		      "\n\t   movntq %%mm5,40(%1)"
		      "\n\t   movq 48(%0),%%mm6"
		      "\n\t   movntq %%mm6,48(%1)"
		      "\n\t   movq 56(%0),%%mm7"
		      "\n\t   movntq %%mm7,56(%1)"
		      /*"\n\t   sfence"*/
		      "\n\t   addl $64,%0"
		      "\n\t   addl $64,%1"
		      "\n\t   loop 1b"
		      "\n\t   movl $5, %%ecx"
		      "\n\t2: movq (%0),%%mm0"
		      "\n\t   movntq %%mm0,(%1)"
		      "\n\t   movq 8(%0),%%mm1"
		      "\n\t   movntq %%mm1,8(%1)"
		      "\n\t   movq 16(%0),%%mm2"
		      "\n\t   movntq %%mm2,16(%1)"
		      "\n\t   movq 24(%0),%%mm3"
		      "\n\t   movntq %%mm3,24(%1)"
		      "\n\t   movq 32(%0),%%mm4"
		      "\n\t   movntq %%mm4,32(%1)"
		      "\n\t   movq 40(%0),%%mm5"
		      "\n\t   movntq %%mm5,40(%1)"
		      "\n\t   movq 48(%0),%%mm6"
		      "\n\t   movntq %%mm6,48(%1)"
		      "\n\t   movq 56(%0),%%mm7"
		      "\n\t   movntq %%mm7,56(%1)"
		      "\n\t   addl $64,%0"
		      "\n\t   addl $64,%1"
		      "\n\t   loop 2b"
		      "\n\t   sfence"
		      "\n\t   fxrstor (%3) \n"
		      :
		      : "r" (from), "r" (to), "i" (PAGE_SIZE/64 - 5), "r" (fpu_ctx)
		      : "memory", "ecx" );
};


void movntq_zero_page0 (void* to)
{
	//void *d0;
	//printf ("%p <- 0\n", to);
	asm volatile (
		      "\n\t   fxsave (%2)"
		      "\n\t   movl %1, %%ecx"
		      "\n\t   fnclex"
		      "\n\t   pxor %%mm0, %%mm0"
		      "\n\t1: "
		      "\n\t   movntq %%mm0,(%0)"
		      "\n\t   movntq %%mm0,8(%0)"
		      "\n\t   movntq %%mm0,16(%0)"
		      "\n\t   movntq %%mm0,24(%0)"
		      "\n\t   movntq %%mm0,32(%0)"
		      "\n\t   movntq %%mm0,40(%0)"
		      "\n\t   movntq %%mm0,48(%0)"
		      "\n\t   movntq %%mm0,56(%0)"
		      /*"\n\t   sfence"*/
		      "\n\t   addl $64,%0"
		      "\n\t   loop 1b"
		      "\n\t   sfence"
		      "\n\t   fxrstor (%2) \n"
		      :
		      : "r" (to), "i" (PAGE_SIZE/64), "r" (fpu_ctx)
		      : "memory", "ecx");
}


void alloc_fpu_ctx ()
{
	fpu_ctx =3D (void*) memalign (256, 1024);
}

void fill_rand_page (void* mem)
{
	int* ptr =3D (int*) mem;
	do {
		*ptr =3D rand();
	} while (( (char*)(++ptr) - (char*)mem) < PAGE_SIZE);
}

void* memzero (void* mem, size_t ln)
{
	int* ptr =3D (int*)mem;
	int i =3D ln / sizeof(int);
	while (i--)
		if (*ptr++ !=3D 0) return (void*)ptr;
	return 0;
}

int main ()
{
	void *b1, *b2, *b3; void* err; int i;
	srand (5);
	alloc_fpu_ctx ();
	trigger_fpu ();
	b3 =3D b1 =3D (void*) memalign (PAGE_SIZE, (NR_TESTS+1)*PAGE_SIZE);
	fill_rand_page (b1);
	for (i =3D 0; i < NR_TESTS; i++) {
		b2 =3D (void*) ((char*)b3 + PAGE_SIZE);
		movntq_copy_page0 (b2, b3);
		if (memcmp (b3, b2, PAGE_SIZE)) {
			printf ("Error (%i)!\n", i);
			exit (1);
		}
		movntq_zero_page0 (b3);
		if ((err =3D memzero (b3, PAGE_SIZE))) {
			printf ("Error! (%i) %p\n", i, err);
			exit (2);
		}
		b3 =3D b2;
	}
	free (b1);
	free (fpu_ctx);
	return 0;
}
			     =20

--pZs/OQEoSSbxGlYw--

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Yp3/xmLh6hyYd04RApmiAKCxiQJtTTrSVKN2so2Qg/ilz/FPlgCeM8u4
LZkb0EQdQhl9ZM04Fc15SI0=
=GaCx
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
