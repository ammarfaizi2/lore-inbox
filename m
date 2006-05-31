Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751519AbWEaBhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbWEaBhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbWEaBhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:37:06 -0400
Received: from terminus.zytor.com ([192.83.249.54]:4587 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751519AbWEaBhE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:37:04 -0400
Message-ID: <447CF32F.1050309@zytor.com>
Date: Tue, 30 May 2006 18:36:47 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Lesiak <chris.lesiak@licor.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2.6.17-rc5 1/2] i386 memcpy: use as few moves as  possible
 for I/O
References: <200605302103_MC3-1-BF0E-59B@compuserve.com>
In-Reply-To: <200605302103_MC3-1-BF0E-59B@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One concern: this is not the standard return value for memcpy().  It either needs a 
comment to that effect (stating it returns a pointer to the end of the area), or just make 
it return void.

Also, the formatting looks nonstandard.

>  
>  /*
> + * Do memcpy with as few moves as possible (for transfers to/from IO space.)
> + */
> +static inline void * __minimal_memcpy(void * to, const void * from, size_t n)
> +{
> +int d0, d1, d2;
> +__asm__ __volatile__(
> +	"rep ; movsl\n\t"
> +	"testb $2,%b4\n\t"
> +	"jz 1f\n\t"
> +	"movsw\n"
> +	"1:\n\t"
> +	"testb $1,%b4\n\t"
> +	"jz 2f\n\t"
> +	"movsb\n"
> +	"2:"
> +	: "=&c" (d0), "=&D" (d1), "=&S" (d2)
> +	:"0" (n/4), "q" (n), "1" ((long) to), "2" ((long) from)
> +	: "memory");
> +return to;
> +}


	-hpa
