Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbSJYQ17>; Fri, 25 Oct 2002 12:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261474AbSJYQ17>; Fri, 25 Oct 2002 12:27:59 -0400
Received: from [62.81.160.128] ([62.81.160.128]:5636 "EHLO smtp08.eresmas.com")
	by vger.kernel.org with ESMTP id <S261472AbSJYQ1s>;
	Fri, 25 Oct 2002 12:27:48 -0400
Subject: Re: [CFT] faster athlon/duron memory copy implementation
From: "Jorge Bernal \"Koke\"" <koke@fablagnu.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-haYed/C6giwMgg48QyOK"
X-Mailer: Ximian Evolution 1.0.5 
Date: 25 Oct 2002 18:29:08 +0200
Message-Id: <1035563354.5842.7.camel@tuxland.servebeer.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-haYed/C6giwMgg48QyOK
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

El jue, 24-10-2002 a las 19:15, Manfred Spraul escribi=F3:
> AMD recommends to perform memory copies with backward read operations=20
> instead of prefetch.
>=20
> http://208.15.46.63/events/gdc2002.htm
>=20
> Attached is a test app that compares several memory copy
implementations.
> Could you run it and report the results to me, together with cpu,=20
> chipset and memory type?
>=20
> Please run 2 or 3 times.
>=20

My machine: Athlon 1600XP, 512MB DDR, KT226A??

koke@tuxland:~/src/testing$ ./athlon=20
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $=20

copy_page() tests=20
copy_page function 'warm up run'         took 15408 cycles per page
copy_page function '2.4 non MMX'         took 16805 cycles per page
copy_page function '2.4 MMX fallback'    took 16695 cycles per page
copy_page function '2.4 MMX version'     took 15424 cycles per page
copy_page function 'faster_copy'         took 9481 cycles per page
copy_page function 'even_faster'         took 9354 cycles per page
copy_page function 'no_prefetch'         took 6635 cycles per page
koke@tuxland:~/src/testing$ ./athlon=20
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $=20

copy_page() tests=20
copy_page function 'warm up run'         took 15418 cycles per page
copy_page function '2.4 non MMX'         took 16792 cycles per page
copy_page function '2.4 MMX fallback'    took 16754 cycles per page
copy_page function '2.4 MMX version'     took 15495 cycles per page
copy_page function 'faster_copy'         took 9426 cycles per page
copy_page function 'even_faster'         took 9490 cycles per page
copy_page function 'no_prefetch'         took 6591 cycles per page
koke@tuxland:~/src/testing$ ./athlon=20
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $=20

copy_page() tests=20
copy_page function 'warm up run'         took 16485 cycles per page
copy_page function '2.4 non MMX'         took 16759 cycles per page
copy_page function '2.4 MMX fallback'    took 16769 cycles per page
copy_page function '2.4 MMX version'     took 15377 cycles per page
copy_page function 'faster_copy'         took 9732 cycles per page
copy_page function 'even_faster'         took 12125 cycles per page
copy_page function 'no_prefetch'         took 9439 cycles per page
koke@tuxland:~/src/testing$


> --
>     Manfred
> ----
>=20

> /*
>=20
> (C) 2000 Arjan van de Ven and others  licensed under the terms of the
GPL
>=20
>=20
> $Revision: 1.6 $
> */
>=20
> static char cvsid[] =3D "$Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp
$";
> #include <unistd.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
>=20
> /* The 2.4 kernel one, adapted for userspace */
>=20
> static void fast_clear_page(void *page)
> {
>       int i;
>       char fpu_save[108];
>=20
>       __asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );
>      =20
>       __asm__ __volatile__ (
>               "  pxor %%mm0, %%mm0\n" : :
>       );
>=20
>       for(i=3D0;i<4096/128;i++)
>       {
>               __asm__ __volatile__ (
>               "  movq %%mm0, (%0)\n"
>               "  movq %%mm0, 8(%0)\n"
>               "  movq %%mm0, 16(%0)\n"
>               "  movq %%mm0, 24(%0)\n"
>               "  movq %%mm0, 32(%0)\n"
>               "  movq %%mm0, 40(%0)\n"
>               "  movq %%mm0, 48(%0)\n"
>               "  movq %%mm0, 56(%0)\n"
>               "  movq %%mm0, 64(%0)\n"
>               "  movq %%mm0, 72(%0)\n"
>               "  movq %%mm0, 80(%0)\n"
>               "  movq %%mm0, 88(%0)\n"
>               "  movq %%mm0, 96(%0)\n"
>               "  movq %%mm0, 104(%0)\n"
>               "  movq %%mm0, 112(%0)\n"
>               "  movq %%mm0, 120(%0)\n"
>               : : "r" (page) : "memory");
>               page+=3D128;
>       }
>       __asm__ __volatile__ (
>               "  femms\n" : :
>       );
>       __asm__ __volatile__ ( " frstor %0;\n"::"m"(fpu_save[0]) );
>      =20
> }
>=20
> /* modified version for Athlon-family processors */
> static void faster_clear_page(void *page)
> {
>       int i;
>       char fpu_save[108];
>=20
>       __asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );
>       __asm__ __volatile__ (
>               "  pxor %%mm0, %%mm0\n" : :
>       );
>=20
>       for(i=3D0;i<4096/64;i++)
>       {
>               __asm__ __volatile__ (
>               "  movntq %%mm0, (%0)\n"
>               "  movntq %%mm0, 8(%0)\n"
>               "  movntq %%mm0, 16(%0)\n"
>               "  movntq %%mm0, 24(%0)\n"
>               "  movntq %%mm0, 32(%0)\n"
>               "  movntq %%mm0, 40(%0)\n"
>               "  movntq %%mm0, 48(%0)\n"
>               "  movntq %%mm0, 56(%0)\n"
>               : : "r" (page) : "memory");
>               page+=3D64;
>       }
>       __asm__ __volatile__ (
>               " sfence \n "
>               " femms\n" : :
>       );
>       __asm__ __volatile__ ( " frstor %0;\n"::"m"(fpu_save[0]) );
>=20
> }
>=20
> /* test version to go even faster... this might be the same as faster_
>  * but serves as my playground.
>  */
> static void even_faster_clear_page(void *page)
> {
>       int i;
>       char fpu_save[108];
>       __asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );
>=20
>       __asm__ __volatile__ (
>               "  pxor %%mm0, %%mm0\n" : :
>       );
>=20
>       for(i=3D0;i<4096/64;i++)
>       {
>               __asm__ __volatile__ (
>               "  movntq %%mm0, (%0)\n"
>               "  movntq %%mm0, 8(%0)\n"
>               "  movntq %%mm0, 16(%0)\n"
>               "  movntq %%mm0, 24(%0)\n"
>               "  movntq %%mm0, 32(%0)\n"
>               "  movntq %%mm0, 40(%0)\n"
>               "  movntq %%mm0, 48(%0)\n"
>               "  movntq %%mm0, 56(%0)\n"
>               : : "r" (page) : "memory");
>               page+=3D64;
>       }
>       __asm__ __volatile__ (
>               " sfence \n "
>               " femms\n" : :
>       );
>       __asm__ __volatile__ ( " frstor %0;\n"::"m"(fpu_save[0]) );
>=20
> }
>=20
> /* The "fallback" one as used by the kernel */
> static void slow_zero_page(void * page)
> {
>       int d0, d1;
>       __asm__ __volatile__( \
>               "cld\n\t" \
>               "rep ; stosl" \
>               : "=3D&c" (d0), "=3D&D" (d1)
>               :"a" (0),"1" (page),"0" (1024)
>               :"memory");
> }
>=20
> static void slow_copy_page(void *to, void *from)
> {
>       int d0, d1, d2;
>       __asm__ __volatile__( \
>               "cld\n\t" \
>               "rep ; movsl" \
>               : "=3D&c" (d0), "=3D&D" (d1), "=3D&S" (d2) \
>               : "0" (1024),"1" ((long) to),"2" ((long) from) \
>               : "memory");
> }
>=20
>=20
> /* 2.4 kernel mmx copy_page function */
> static void fast_copy_page(void *to, void *from)
> {
>       int i;
>       char fpu_save[108];
>       __asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );
>=20
>       __asm__ __volatile__ (
>               "1: prefetch (%0)\n"
>               "   prefetch 64(%0)\n"
>               "   prefetch 128(%0)\n"
>               "   prefetch 192(%0)\n"
>               "   prefetch 256(%0)\n"
>               : : "r" (from) );
>=20
>       for(i=3D0; i<4096/64; i++)
>       {
>               __asm__ __volatile__ (
>               "1: prefetch 320(%0)\n"
>               "2: movq (%0), %%mm0\n"
>               "   movq 8(%0), %%mm1\n"
>               "   movq 16(%0), %%mm2\n"
>               "   movq 24(%0), %%mm3\n"
>               "   movq %%mm0, (%1)\n"
>               "   movq %%mm1, 8(%1)\n"
>               "   movq %%mm2, 16(%1)\n"
>               "   movq %%mm3, 24(%1)\n"
>               "   movq 32(%0), %%mm0\n"
>               "   movq 40(%0), %%mm1\n"
>               "   movq 48(%0), %%mm2\n"
>               "   movq 56(%0), %%mm3\n"
>               "   movq %%mm0, 32(%1)\n"
>               "   movq %%mm1, 40(%1)\n"
>               "   movq %%mm2, 48(%1)\n"
>               "   movq %%mm3, 56(%1)\n"
>               : : "r" (from), "r" (to) : "memory");
>               from+=3D64;
>               to+=3D64;
>       }
>       __asm__ __volatile__ (
>               " femms\n" : :
>       );
>       __asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );
>=20
> }
>=20
>=20
> /* Athlon improved version */
> static void faster_copy_page(void *to, void *from)
> {
>       int i;
>       char fpu_save[108];
>=20
>       __asm__ __volatile__ (
>               "1: prefetchnta (%0)\n"
>               "   prefetchnta 64(%0)\n"
>               "   prefetchnta 128(%0)\n"
>               "   prefetchnta 192(%0)\n"
>               : : "r" (from) );
>=20
>       __asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );
>=20
>       for(i=3D0; i<4096/64; i++)
>       {
>               __asm__ __volatile__ (
>               "1: prefetchnta 320(%0)\n"
>               "2: movq (%0), %%mm0\n"
>               "   movq 8(%0), %%mm1\n"
>               "   movq 16(%0), %%mm2\n"
>               "   movq 24(%0), %%mm3\n"
>               "   movq 32(%0), %%mm4\n"
>               "   movq 40(%0), %%mm5\n"
>               "   movq 48(%0), %%mm6\n"
>               "   movq 56(%0), %%mm7\n"
>               "   movntq %%mm0, (%1)\n"
>               "   movntq %%mm1, 8(%1)\n"
>               "   movntq %%mm2, 16(%1)\n"
>               "   movntq %%mm3, 24(%1)\n"
>               "   movntq %%mm4, 32(%1)\n"
>               "   movntq %%mm5, 40(%1)\n"
>               "   movntq %%mm6, 48(%1)\n"
>               "   movntq %%mm7, 56(%1)\n"
>               : : "r" (from), "r" (to) : "memory");
>               from+=3D64;
>               to+=3D64;
> }
>       __asm__ __volatile__ (
>               " femms \n "
>               " sfence\n" : :
>       );
>       __asm__ __volatile__ ( " frstor %0;\n"::"m"(fpu_save[0]) );
>=20
> }
>=20
> /* test version to go even faster... this might be the same as faster_
>  * but serves as my playground.
>  */
> static void even_faster_copy_page(void *to, void *from)
> {
>       int i;
>       char fpu_save[108];
>=20
>       __asm__ __volatile__ (
>               "1: prefetchnta (%0)\n"
>               "   prefetchnta 64(%0)\n"
>               "   prefetchnta 128(%0)\n"
>               "   prefetchnta 192(%0)\n"
>               : : "r" (from) );
>=20
>       __asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );
>=20
>       for(i=3D0; i<4096/64; i++)
>       {
>               __asm__ __volatile__ (
>               "   prefetchnta 256(%0)\n"
>               "   movq (%0), %%mm0\n"
>               "   movntq %%mm0, (%1)\n"
>               "   movq 8(%0), %%mm1\n"
>               "   movntq %%mm1, 8(%1)\n"
>               "   movq 16(%0), %%mm2\n"
>               "   movntq %%mm2, 16(%1)\n"
>               "   movq 24(%0), %%mm3\n"
>               "   movntq %%mm3, 24(%1)\n"
>               "   movq 32(%0), %%mm4\n"
>               "   movntq %%mm4, 32(%1)\n"
>               "   movq 40(%0), %%mm5\n"
>               "   movntq %%mm5, 40(%1)\n"
>               "   movq 48(%0), %%mm6\n"
>               "   movntq %%mm6, 48(%1)\n"
>               "   movq 56(%0), %%mm7\n"
>               "   movntq %%mm7, 56(%1)\n"
>               : : "r" (from), "r" (to) : "memory");
>               from+=3D64;
>               to+=3D64;
>       }
>       __asm__ __volatile__ (
>               " femms \n "
>               " sfence\n" : :
>       );
>       __asm__ __volatile__ ( " frstor %0;\n"::"m"(fpu_save[0]) );
>      =20
> }
>=20
>=20
> /*
>  * This looks horribly ugly, but the compiler can optimize it totally,
>  * as the count is constant.
>  */
> static inline void * __constant_memcpy(void * to, const void * from,
size_t n)
> {
>       switch (n) {
>               case 0:
>                       return to;
>               case 1:
>                       *(unsigned char *)to =3D *(const unsigned char
*)from;
>                       return to;
>               case 2:
>                       *(unsigned short *)to =3D *(const unsigned short
*)from;
>                       return to;
>               case 3:
>                       *(unsigned short *)to =3D *(const unsigned short
*)from;
>                       *(2+(unsigned char *)to) =3D *(2+(const unsigned
char *)from);
>                       return to;
>               case 4:
>                       *(unsigned long *)to =3D *(const unsigned long
*)from;
>                       return to;
>               case 6: /* for Ethernet addresses */
>                       *(unsigned long *)to =3D *(const unsigned long
*)from;
>                       *(2+(unsigned short *)to) =3D *(2+(const unsigned
short *)from);
>                       return to;
>               case 8:
>                       *(unsigned long *)to =3D *(const unsigned long
*)from;
>                       *(1+(unsigned long *)to) =3D *(1+(const unsigned
long *)from);
>                       return to;
>               case 12:
>                       *(unsigned long *)to =3D *(const unsigned long
*)from;
>                       *(1+(unsigned long *)to) =3D *(1+(const unsigned
long *)from);
>                       *(2+(unsigned long *)to) =3D *(2+(const unsigned
long *)from);
>                       return to;
>               case 16:
>                       *(unsigned long *)to =3D *(const unsigned long
*)from;
>                       *(1+(unsigned long *)to) =3D *(1+(const unsigned
long *)from);
>                       *(2+(unsigned long *)to) =3D *(2+(const unsigned
long *)from);
>                       *(3+(unsigned long *)to) =3D *(3+(const unsigned
long *)from);
>                       return to;
>               case 20:
>                       *(unsigned long *)to =3D *(const unsigned long
*)from;
>                       *(1+(unsigned long *)to) =3D *(1+(const unsigned
long *)from);
>                       *(2+(unsigned long *)to) =3D *(2+(const unsigned
long *)from);
>                       *(3+(unsigned long *)to) =3D *(3+(const unsigned
long *)from);
>                       *(4+(unsigned long *)to) =3D *(4+(const unsigned
long *)from);
>                       return to;
>       }
> #define COMMON(x) \
> __asm__ __volatile__( \
>       "rep ; movsl" \
>       x \
>       : "=3D&c" (d0), "=3D&D" (d1), "=3D&S" (d2) \
>       : "0" (n/4),"1" ((long) to),"2" ((long) from) \
>       : "memory");
> {
>       int d0, d1, d2;
>       switch (n % 4) {
>               case 0: COMMON(""); return to;
>               case 1: COMMON("\n\tmovsb"); return to;
>               case 2: COMMON("\n\tmovsw"); return to;
>               default: COMMON("\n\tmovsw\n\tmovsb"); return to;
>       }
> }
>  =20
> #undef COMMON
> }
>=20
>=20
> static void normal_copy_page(void *to, void *from)
> {
>       __constant_memcpy(to,from,4096);
> }
>=20
>=20
> /*
>  * This looks horribly ugly, but the compiler can optimize it totally,
>  * as we by now know that both pattern and count is constant..
>  */
> static inline void * __constant_c_and_count_memset(void * s, unsigned
long pattern, size_t count)
> {
>       switch (count) {
>               case 0:
>                       return s;
>               case 1:
>                       *(unsigned char *)s =3D pattern;
>                       return s;
>               case 2:
>                       *(unsigned short *)s =3D pattern;
>                       return s;
>               case 3:
>                       *(unsigned short *)s =3D pattern;
>                       *(2+(unsigned char *)s) =3D pattern;
>                       return s;
>               case 4:
>                       *(unsigned long *)s =3D pattern;
>                       return s;
>       }
> #define COMMON(x) \
> __asm__  __volatile__( \
>       "rep ; stosl" \
>       x \
>       : "=3D&c" (d0), "=3D&D" (d1) \
>       : "a" (pattern),"0" (count/4),"1" ((long) s) \
>       : "memory")
> {
>       int d0, d1;
>       switch (count % 4) {
>               case 0: COMMON(""); return s;
>               case 1: COMMON("\n\tstosb"); return s;
>               case 2: COMMON("\n\tstosw"); return s;
>               default: COMMON("\n\tstosw\n\tstosb"); return s;
>       }
> }
>  =20
> #undef COMMON
> }
>=20
> static void normal_clear_page(void *to)
> {
>        __constant_c_and_count_memset(to,0,4096);
> }
>=20
> /* test version to see if we can go even faster */
> static void no_prefetch_copy_page(void *to, void *from) {
>       int i, d1;
>         char fpu_save[108];
>=20
>       for (i=3D4096-256;i>=3D0;i-=3D256)
>               __asm__ __volatile(
>                       "movl 192(%1,%2),%0\n"
>                       "movl 128(%1,%2),%0\n"
>                       "movl 64(%1,%2),%0\n"
>                       "movl 0(%1,%2),%0\n"
>                       : "=3D&r" (d1)
>                       : "r" (from), "r" (i));
>=20
>         __asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0])
);
>=20
>       for(i=3D0; i<4096/64; i++) {
>               __asm__ __volatile__ (
>               "   movq (%0), %%mm0\n"
>               "   movntq %%mm0, (%1)\n"
>               "   movq 8(%0), %%mm1\n"
>               "   movntq %%mm1, 8(%1)\n"
>               "   movq 16(%0), %%mm2\n"
>               "   movntq %%mm2, 16(%1)\n"
>               "   movq 24(%0), %%mm3\n"
>               "   movntq %%mm3, 24(%1)\n"
>               "   movq 32(%0), %%mm4\n"
>               "   movntq %%mm4, 32(%1)\n"
>               "   movq 40(%0), %%mm5\n"
>               "   movntq %%mm5, 40(%1)\n"
>               "   movq 48(%0), %%mm6\n"
>               "   movntq %%mm6, 48(%1)\n"
>               "   movq 56(%0), %%mm7\n"
>               "   movntq %%mm7, 56(%1)\n"
>               : : "r" (from), "r" (to) : "memory");
>               from+=3D64;
>               to+=3D64;
>       }
>       __asm__ __volatile__ (
>               " sfence \n "
>               " emms\n"
>               " frstor %0;\n" ::"m"(fpu_save[0]) );
> }
>=20
>=20
> #define rdtsc(low,high) \
>      __asm__ __volatile__("rdtsc" : "=3Da" (low), "=3Dd" (high))
>     =20
> typedef void (clear_func)(void *);
> typedef void (copy_func)(void *,void *);
>=20
> void test_one_clearpage(clear_func *func, char *name, char *Buffer)
> {
>       char *temp;
>       int i;
>       unsigned int blow,bhigh,alow,ahigh;
>       unsigned long long before,after;
>=20
>       rdtsc(blow,bhigh);
>       temp =3D Buffer;
>       for (i=3D0;i<4*1024;i++) {
>               func(temp);
>               temp +=3D 4096;
>       }
>       rdtsc(alow,ahigh);
>       before =3D  blow + (((long long)bhigh)<<32);
>       after =3D alow +(((long long)ahigh)<<32);
>       if (before>after) {
>               printf("test invalid; timer overflow \n");
>               return;
>       }
>       printf("clear_page function '%s'\t took %4lli cycles per
page\n",name,(after-before)/(4*1024) );
>=20
>=20
> }
>     =20
> void test_one_copypage(copy_func *func, char *name, char *Buffer)
> {
>       char *temp;
>       int i;
>       unsigned int blow,bhigh,alow,ahigh;
>       unsigned long long before,after;
>=20
>       sleep(1);
>       rdtsc(blow,bhigh);
>       temp =3D Buffer;
>       for (i=3D0;i<2*1024;i++) {
>               func(temp,temp+8*1024*1024);
>               temp +=3D 4096;
>       }
>       rdtsc(alow,ahigh);
>       before =3D  blow+ (((long long)bhigh)<<32);
>       after =3D alow+(((long long)ahigh)<<32);
>       if (before>after) {
>               printf("test invalid; timer overflow \n");
>               return;
>       }
>       printf("copy_page function '%s'\t took %4lli cycles per
page\n",name,(after-before)/(2*1024) );
>=20
>=20
> }
>     =20
>     =20
> void test_clearpage(char *Buffer)
> {
>       printf("clear_page() tests \n");
>=20
>       test_one_clearpage(fast_clear_page,"warm up run",Buffer);
>       test_one_clearpage(normal_clear_page,"2.4 non MMX",Buffer);
>       test_one_clearpage(slow_zero_page,"2.4 MMX fallback",Buffer);
>       test_one_clearpage(fast_clear_page,"2.4 MMX version",Buffer);
>     =20
test_one_clearpage(faster_clear_page,"faster_clear_page",Buffer);
>     =20
test_one_clearpage(even_faster_clear_page,"even_faster_clear",Buffer);
> }  =20
>=20
> void test_copypage(char *Buffer)
> {
>       printf("copy_page() tests \n");
>      =20
>       test_one_copypage(fast_copy_page,  "warm up run",Buffer);
>       test_one_copypage(normal_copy_page,"2.4 non MMX",Buffer);
>       test_one_copypage(slow_copy_page,  "2.4 MMX fallback",Buffer);
>       test_one_copypage(fast_copy_page,  "2.4 MMX version",Buffer);
>       test_one_copypage(faster_copy_page,"faster_copy",Buffer);
>       test_one_copypage(even_faster_copy_page,"even_faster",Buffer);
>       test_one_copypage(no_prefetch_copy_page,"no_prefetch",Buffer);
> }
>=20
> int main()
> {
>       char *Buffer;
>      =20
>       Buffer =3D malloc(1024*1024*16);
>       memset(Buffer,0xfe,1024*1024*16);
>      =20
>       printf("Athlon test program %s \n",cvsid);
>      =20
>       printf("\n");
>       test_copypage(Buffer);
>=20
>       free(Buffer);
>=20
>       return 0;
> }
--=20
Jorge Bernal (Koke)
The software required Win95 or better, so I installed Linux
ICQ#: 63593654
MSN: koke_jb

--=-haYed/C6giwMgg48QyOK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje esta firmada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9uXFUUH/ZAFsTud0RAmCNAKCcHcVrz4xyCIlD9mvotyvenTs7GgCeN1og
s9iipda9hoLrqKe6QwdlzPI=
=lT37
-----END PGP SIGNATURE-----

--=-haYed/C6giwMgg48QyOK--

