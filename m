Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSKHP3Y>; Fri, 8 Nov 2002 10:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbSKHP3X>; Fri, 8 Nov 2002 10:29:23 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:52910 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261640AbSKHP3X>;
	Fri, 8 Nov 2002 10:29:23 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Rusty Trivial Russell <rusty@rustcorp.com.au>
Date: Fri, 8 Nov 2002 16:35:26 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [TRIVIAL] Re: UP went into unexpected trashing
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-mailer: Pegasus Mail v3.50
Message-ID: <6EF6764388E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Nov 02 at 19:33, Rusty Trivial Russell wrote:
> --- trivial-2.5-bk/include/asm-i386/bitops.h.orig   2002-11-08 18:47:20.000000000 +1100
> +++ trivial-2.5-bk/include/asm-i386/bitops.h    2002-11-08 18:47:20.000000000 +1100
> @@ -311,12 +311,13 @@
>         "repe; scasl\n\t"
>         "jz 1f\n\t"
>         "leal -4(%%edi),%%edi\n\t"
> -       "bsfl (%%edi),%%eax\n"
> -       "1:\tsubl %%ebx,%%edi\n\t"
> +       "bsfl (%%edi),%%edx\n"
> +       "subl %%ebx,%%edi\n\t"
>         "shll $3,%%edi\n\t"
> -       "addl %%edi,%%eax"
> +       "addl %%edi,%%edx\n\t"
> +       "1:\tmovl %%edx,%%eax\n\t"
>         :"=a" (res), "=&c" (d0), "=&D" (d1)
> -       :"1" ((size + 31) >> 5), "2" (addr), "b" (addr));
> +       :"1" ((size + 31) >> 5), "2" (addr), "b" (addr), "d" (size));
>     return res;

EDX is modified, should not you list "=d" as output, with new variable (d2)?

Or better, drop last line of assembly code, and say that (res) is in
"d", and list "a" as clobbered or dummy output register.

And BTW, if you'll do 

unsigned long b = 0x8000;
find_first_bit(&b, 1);

return value will be 15 even with patched function. So either more
fixing is needed, or code which calls find_first_bit() with value which
is not multiple of 32 should take special care that last dword does
not contain set bits after last interesting bit.

So maybe callers should just treat any return value >= size as "not found",
leaving older smaller code in place.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
