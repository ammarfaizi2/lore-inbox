Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280978AbRKLUb7>; Mon, 12 Nov 2001 15:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280980AbRKLUbt>; Mon, 12 Nov 2001 15:31:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54284 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280978AbRKLUbn>; Mon, 12 Nov 2001 15:31:43 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.4.15-pre4 compile problem
Date: Mon, 12 Nov 2001 20:27:39 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9spbbr$1qi$1@penguin.transmeta.com>
In-Reply-To: <200111121939.fACJdX309798@danapple.com>
X-Trace: palladium.transmeta.com 1005597088 28429 127.0.0.1 (12 Nov 2001 20:31:28 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 Nov 2001 20:31:28 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200111121939.fACJdX309798@danapple.com>,
Daniel I. Applebaum <kernel@danapple.com> wrote:
>
>While compiling 2.4.15-pre4:
>+++++++++++++++
>gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o setup.o setup.c
>setup.c: In function `c_start':
>setup.c:2791: subscripted value is neither array nor pointer

Ugh. That's because a buggy #define on UP in x86.

It should be trivially fixed by changing include/asm-i386/processor.h:

	#define cpu_data &boot_cpu_data

to

	#define cpu_data (&boot_cpu_data)

in order to get the right parsing order for all users of cpu_data. Ie
just add the parenthesis around the thing.

Oh, well.  "Always put parentesis around define-expands" is a really
really good rule.  Along with "Always put parenthesis around the
argument expansion too". 

Oh, and cleaning up the particular offending user will hide the problem
too, if you just use

	cpu_data+*pos

instead of using

	&cpu_data[*pos]

in arch/i386/kernel/setup.c: c_start().  Which is cleaner and simpler
anyway, and which is defined by C to be exactly the same thing (as long
as "cpu_data" behaves like a real array, not a broken #define that
depends on operator precedence around it). 

I'll do both in my tree. Thanks,

		Linus
