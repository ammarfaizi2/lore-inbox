Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWFMUdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWFMUdN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWFMUdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:33:13 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:54516 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932164AbWFMUdL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:33:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [patch] s390: missing ifdef in bitops.h
Date: Tue, 13 Jun 2006 22:33:07 +0200
User-Agent: KMail/1.9.1
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
References: <20060613120916.GA9405@osiris.boeblingen.de.ibm.com> <1150211828.2844.20.camel@hades.cambridge.redhat.com>
In-Reply-To: <1150211828.2844.20.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606132233.07830.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tuesday 13 June 2006 17:17 schrieb David Woodhouse:
> -#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
> +#ifdef __KERNEL__
>  
>  #ifndef _S390_BITOPS_H
>  #include <asm/bitops.h>
> @@ -94,6 +94,6 @@ #define __FD_ISSET(fd,fdsetp)  test_bit(
>  #undef  __FD_ZERO
>  #define __FD_ZERO(fdsetp) (memset ((fdsetp), 0, sizeof(*(fd_set
> *)(fdsetp)))) 
> -#endif     /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ <
> 2)*/ +#endif     /* __KERNEL__ */
>  

Erm, I don't think the kernel even uses those definitions, the only reason
to keep them is old user space.

Now that is true for all architectures, although they all handle things
slightly differently: 

cris, v850, s390: use bitops, which can be considered broken
arm, arm26, frv, h8300, m68k: use a trivial C macro
i386: has an inline assembly
sparc64, x86_64, alpha, xtensa, sparc, ia64, powerpc, sh, parisc, mips:
   use variations of the same unrolled C inline functions

I'd suggest using only one version. In doubt, I would move the parisc
version to asm-generic/fd_set.h or similar and include that from
everywhere.

	Arnd <><
