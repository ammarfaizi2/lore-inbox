Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWFNI5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWFNI5O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 04:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWFNI5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 04:57:14 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:18438 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751270AbWFNI5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 04:57:13 -0400
Subject: Re: [patch] s390: missing ifdef in bitops.h
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: David Woodhouse <dwmw2@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <1150211828.2844.20.camel@hades.cambridge.redhat.com>
References: <20060613120916.GA9405@osiris.boeblingen.de.ibm.com>
	 <1150211828.2844.20.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 14 Jun 2006 10:57:11 +0200
Message-Id: <1150275431.6461.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 16:17 +0100, David Woodhouse wrote:
> On Tue, 2006-06-13 at 14:09 +0200, Heiko Carstens wrote:
> > Add missing #ifdef __KERNEL__ to asm-s390/bitops.h
> 
> But asm/bitops.h isn't suitable for userspace _anyway_, is it?
> We should be able to drop all instances of __KERNEL__ from it.

Nothing from asm/bitops.h should ever be used in userspace.

> Which means that asm-s390/posix_types.h probably ought never to be
> trying to include asm/bitops.h in the !__KERNEL__ case... we never had
> libc5 on S390 anyway, did we?

Correct. And the depedency to bitops.h in case of __KERNEL__ = 1 should
not be there either, in particular since __FD_SET/__FD_CLR do not have
to be atomic. A simple piece of C code should be used instead of
set_bit/clear_bit. 

> Martin, is it OK for me to add this to the hdrcleanup-2.6.git tree?
> 
> diff --git a/include/asm-s390/posix_types.h b/include/asm-s390/posix_types.h
> index 61788de..18344dc 100644
> --- a/include/asm-s390/posix_types.h
> +++ b/include/asm-s390/posix_types.h
> @@ -76,7 +76,7 @@ #endif                       /* !defined
>  } __kernel_fsid_t;
>  
> 
> -#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
> +#ifdef __KERNEL__
>  
>  #ifndef _S390_BITOPS_H
>  #include <asm/bitops.h>
> @@ -94,6 +94,6 @@ #define __FD_ISSET(fd,fdsetp)  test_bit(
>  #undef  __FD_ZERO
>  #define __FD_ZERO(fdsetp) (memset ((fdsetp), 0, sizeof(*(fd_set *)(fdsetp))))
>  
> -#endif     /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)*/
> +#endif     /* __KERNEL__ */
>  
>  #endif

It should not hurt. s390 always used a glibc with a major >= 2.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


