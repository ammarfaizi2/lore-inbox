Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWEaLjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWEaLjn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 07:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWEaLjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 07:39:43 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:51984 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932323AbWEaLjm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 07:39:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 31 May 2006 11:39:12.0009 (UTC) FILETIME=[D6384F90:01C684A6]
Content-class: urn:content-classes:message
Subject: Re: [patch 2.6.17-rc5 1/2] i386 memcpy: use as few moves as  possible for I/O
Date: Wed, 31 May 2006 07:39:02 -0400
Message-ID: <Pine.LNX.4.61.0605310732110.28667@chaos.analogic.com>
In-Reply-To: <200605302103_MC3-1-BF0E-59B@compuserve.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.17-rc5 1/2] i386 memcpy: use as few moves as  possible for I/O
Thread-Index: AcaEptZBZ8+wCUiIRpugrCHiZoXkFA==
References: <200605302103_MC3-1-BF0E-59B@compuserve.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Chris Lesiak" <chris.lesiak@licor.com>,
       "H. Peter Anvin" <hpa@zytor.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 May 2006, Chuck Ebbert wrote:

> Chris Lesiak reported that changes to i386's __memcpy() broke his device
> because it can't handle byte moves and the new code uses them for
> all trailing bytes when the length is not divisible by four.  The old
> code tried to use a 16-bit move and/or a byte move as needed.
>
> H. Peter Anvin:
> "There are only a few semantics that make sense: fixed 8, 16, 32, or 64
> bits, plus "optimal"; the latter to be used for anything that doesn't
> require a specific transfer size.  Logically, an unqualified
> "memcpy_to/fromio" should be the optimal size (as few transfers as
> possible)"
>
> So add back the old code as __minimal_memcpy and have IO transfers
> use that.
>
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
>
> ---
>
> include/asm-i386/io.h     |    4 ++--
> include/asm-i386/string.h |   21 +++++++++++++++++++++
> 2 files changed, 23 insertions(+), 2 deletions(-)
>
> --- 2.6.17-rc5-32.orig/include/asm-i386/io.h
> +++ 2.6.17-rc5-32/include/asm-i386/io.h
> @@ -202,11 +202,11 @@ static inline void memset_io(volatile vo
> }
> static inline void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
> {
> -	__memcpy(dst, (void __force *) src, count);
> +	__minimal_memcpy(dst, (void __force *) src, count);
> }
> static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
> {
> -	__memcpy((void __force *) dst, src, count);
> +	__minimal_memcpy((void __force *) dst, src, count);
> }
>
> /*
> --- 2.6.17-rc5-32.orig/include/asm-i386/string.h
> +++ 2.6.17-rc5-32/include/asm-i386/string.h
> @@ -220,6 +220,28 @@ return (to);
> }
>
> /*
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
> +
> +/*
>  * This looks ugly, but the compiler can optimize it totally,
>  * as the count is constant.
>  */

> +	"rep ; movsl\n\t"
^^^^^^^^^^^^^^^^^^^^^^^^
Huh, you copyied stuff into three variables, then you needed to make
memory accesses to those variables, and you claim "the compiler can
optimize it totally". Sure. I got a bridge I'd like to sell you.

Please, instead of guessing, why don't measure the exact number of
CPU cycles with rdtsc?

> --
> Chuck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.73 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
