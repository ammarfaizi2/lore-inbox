Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVAMOEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVAMOEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVAMOEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:04:51 -0500
Received: from [213.146.154.40] ([213.146.154.40]:147 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261624AbVAMOEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:04:47 -0500
Date: Thu, 13 Jan 2005 14:04:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
Message-ID: <20050113140446.GA22381@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20050113134620.GA14127@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113134620.GA14127@boetes.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.6.3/Makefile	2004-02-17 22:58:39.000000000 -0500
> +++ linux-2.6.3.ssp/Makefile	2004-03-03 10:20:29.000000000 -0500

2.6.3 is from stoneage..

> +ifdef CONFIG_HARDENED_SSP
> +CFLAGS += -fstack-protector
> +endif

What about just CONFIG_PROPOLICY?  The hardnedefoo naming is so childish
(or gentooish, in the end it's the same anyway..)

> diff -urN linux-2.6.3/include/linux/kernel.h linux-2.6.3.ssp/include/linux/kernel.h
> --- linux-2.6.3/include/linux/kernel.h	2004-02-17 22:57:11.000000000 -0500
> +++ linux-2.6.3.ssp/include/linux/kernel.h	2004-03-03 10:08:10.000000000 -0500
> @@ -115,6 +115,10 @@
>  #define TAINT_FORCED_RMMOD		(1<<3)
>  
>  extern void dump_stack(void);
> +#ifdef CONFIG_HARDENED_SSP
> +extern int __guard;
> +extern void __stack_smash_handler(int, char []);
> +#endif

What do you need these prototypes for, they're not used at all.  Also
no need to put ifdefs around them.

> diff -urN linux-2.6.3/lib/propolice.c linux-2.6.3.ssp/lib/propolice.c
> --- linux-2.6.3/lib/propolice.c	1969-12-31 19:00:00.000000000 -0500
> +++ linux-2.6.3.ssp/lib/propolice.c	2004-03-03 17:52:48.000000000 -0500
> @@ -0,0 +1,15 @@
> +#include <linux/module.h>
> +#include <linux/errno.h>

What do you need errno for?

> 
> +
> +EXPORT_SYMBOL_NOVERS(__guard);
> +EXPORT_SYMBOL_NOVERS(__stack_smash_handler);
> + 
> +int __guard = '\0\0\n\777';
> + 
> +void 
> +__stack_smash_handler (int damaged, char func[])
> +{
> +	static char *message = "propolice detects %x at function %s.\n" ;
> +	panic (message, damaged, func);
> +}

ah, it seems you need them because you put the exports before the
delaration.  This file should probably look more like:

/*
 * Insert Copyright here.
 *
 * Insert small description here.
 */
#include <linux/kernel.h>
#include <linux/module.h>

int __guard = '\0\0\n\777';
EXPORT_SYMBOL_NOVERS(__guard);
 
static const char message[] = "propolice detects %x at function %s.\n";

void __stack_smash_handler(int damaged, char func[])
{
	panic(message, damaged, func);
}
EXPORT_SYMBOL_NOVERS(__stack_smash_handler);


