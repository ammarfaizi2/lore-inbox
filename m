Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284541AbRLXKFg>; Mon, 24 Dec 2001 05:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284542AbRLXKF0>; Mon, 24 Dec 2001 05:05:26 -0500
Received: from d-dialin-2782.addcom.de ([213.61.81.150]:27888 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S284541AbRLXKFQ>; Mon, 24 Dec 2001 05:05:16 -0500
Date: Mon, 24 Dec 2001 11:05:00 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Keith Owens <kaos@ocs.com.au>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        "H . J . Lu" <hjl@lucon.org>
Subject: Re: How to fix false positives on references to discarded text/data?
In-Reply-To: <28371.1009174924@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0112241055380.1676-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2001, Keith Owens wrote:

> >> .text.lock.es1371:
> >> 6387:   80 bd f8 00 00 00 00    cmpb   $0x0,0xf8(%ebp)
> >> 638e:   f3 90                   repz nop
> >> 6390:   0f 8e f1 ff ff ff       jle    6387 <.text.lock.es1371> <=== 6 bytes
> >> 6396:   e9 33 9e ff ff          jmp    1ce <set_adc_rate+0x8e>
> >> 
> >> The inline code is unchanged, it is only the out of line code that is
> >> bigger.  IMHO the subsection difference is a gcc/as bug which should
> >> not stop us using this fix.
> >
> >I don't see this.   With egcs-1.1.2 and assembler 2.11.90.0.25,
> >your patch actually (and mysteriously) shrunk the kernel by 500
> >bytes - the new .text is a little smaller than the sum of the
> >old .text and .text.lock.

Another datapoint (RH7.2):

00006397 <.text.lock.es1371>:
    6397:       80 bd f8 00 00 00 00    cmpb   $0x0,0xf8(%ebp)
    639e:       f3 90                   repz nop
    63a0:       7e f5                   jle    6397 <.text.lock.es1371>
    63a2:       e9 27 9e ff ff          jmp    1ce <set_adc_rate+0x8e>

[kai@vaio kai]$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
[kai@vaio kai]$ as -v
GNU assembler version 2.11.90.0.8 (i386-redhat-linux) using BFD version 
2.11.90.0.8
[kai@vaio kai]$ rpm -qf `which as`
binutils-2.11.90.0.8-9

> NOTE: The patch had one .previous left in include/asm-i386/spinlock.h,
>       which needs to be changed to .subsection 0\n.  But that change
>       makes no difference.

According to my reading of the docs and also to my testing, .subsection 0 
and .previous should be equivalent here. But .subsection 0 may be cleaner.

--Kai

