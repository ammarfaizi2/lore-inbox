Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTLDMz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 07:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTLDMz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 07:55:59 -0500
Received: from chico.rediris.es ([130.206.1.3]:1449 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S261799AbTLDMzy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 07:55:54 -0500
From: David =?iso-8859-1?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Errors and later panics in 2.6.0-test11.
Date: Thu, 4 Dec 2003 13:53:49 +0100
User-Agent: KMail/1.5.4
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>, ender@debian.org
References: <200312031417.18462.ender@debian.org> <200312031747.16927.ender@debian.org> <Pine.LNX.4.58.0312030916080.6950@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312030916080.6950@home.osdl.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312041353.50063.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Miércoles, 3 de Diciembre de 2003 18:25, Linus Torvalds escribió:
> It might be more useful to leave it as RAID0, if you're willing to try out
> patches to try to debug this. The slab-debugging thing I sent out earlier
> is one such patch (but may well cause out-of-memory problems under load),
> and possibly the atomic-decrement checker patch (appended). And maybe Jens
> and Neil can come up with something..

	Ok, Linus, I've rebooted the server with your patch applied. It'll be very 
easy to check. People are hitting all the time the archive, downloading the 
Debian CD images, so in several hours I'll tell you the result.

	Thanks in advance,


		Ender.

> ===== arch/i386/lib/dec_and_lock.c 1.1 vs edited =====
> --- 1.1/arch/i386/lib/dec_and_lock.c	Tue Feb  5 09:40:21 2002
> +++ edited/arch/i386/lib/dec_and_lock.c	Sun Nov  2 09:07:53 2003
> @@ -19,7 +19,7 @@
>  	counter = atomic_read(atomic);
>  	newcount = counter-1;
>
> -	if (!newcount)
> +	if (newcount <= 0)
>  		goto slow_path;
>
>  	asm volatile("lock; cmpxchgl %1,%2"
> ===== include/asm-i386/atomic.h 1.5 vs edited =====
> --- 1.5/include/asm-i386/atomic.h	Mon Aug 18 19:46:23 2003
> +++ edited/include/asm-i386/atomic.h	Sun Nov  2 09:40:42 2003
> @@ -2,6 +2,8 @@
>  #define __ARCH_I386_ATOMIC__
>
>  #include <linux/config.h>
> +#include <linux/kernel.h>
> +#include <asm/bug.h>
>
>  /*
>   * Atomic operations that C can't guarantee us.  Useful for
> @@ -136,12 +138,17 @@
>   */
>  static __inline__ int atomic_dec_and_test(atomic_t *v)
>  {
> -	unsigned char c;
> +	static int count = 2;
> +	unsigned char c, neg;
>
>  	__asm__ __volatile__(
> -		LOCK "decl %0; sete %1"
> -		:"=m" (v->counter), "=qm" (c)
> +		LOCK "decl %0; sete %1; sets %2"
> +		:"=m" (v->counter), "=qm" (c), "=qm" (neg)
>
>  		:"m" (v->counter) : "memory");
>
> +	if (count && neg) {
> +		count--;
> +		WARN_ON(neg);
> +	}
>  	return c != 0;
>  }

- -- 
Oh, I saw...Very American. Fire enough bullets and hope
 they hit the target!
		-- Allan Quatermain (The League of Extraordinary Gentlemen)
- --
Servicios de red - Network services
Centro de Comunicaciones CSIC/RedIRIS
Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.49.05
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zy5eWs/EhA1iABsRAslYAKDP9AbmxeYkYMX1VDMbyQvLNhJzEQCgslrF
ZHEPuaAf52qTJ+hfOwZETIQ=
=VmD7
-----END PGP SIGNATURE-----

