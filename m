Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTFTJLw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 05:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTFTJLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 05:11:51 -0400
Received: from dns1.seagha.com ([217.66.0.18]:43632 "EHLO relay-1.seagha.com")
	by vger.kernel.org with ESMTP id S262497AbTFTJLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 05:11:49 -0400
Message-ID: <6DED3619289CD311BCEB00508B8E1336011774C0@nt-server2.antwerp.seagha.com>
From: Karl Vogel <karl.vogel@seagha.com>
To: "'arjanv@redhat.com'" <arjanv@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: fast_copy_page sections?!
Date: Fri, 20 Jun 2003 11:27:48 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2003-06-20 at 10:38, Karl Vogel wrote:
> > In arch/i386/lib/mmx.c there is a function fast_copy_page() 
> using some
> > crafty asm statements. However I don't quite understand the 
> part with the
> > fixup sections?! 
> 
> basically, if your cpu doesn't do prefetch, it will fault. The section
> stuff adds an exception handler for this fault that zeroes out the
> prefetch code so that next time there no longer is a prefetch() there.

Oh I see, but the code is wrapped in an #ifdef CONFIG_MK7. Don't all
Athlon's have the prefetch instruction?!

Why wasn't your no_prefetch code from your fast.c test program used? 
Since it doesn't need the fault handler and it is faster anyway.

I did some testing and was able to save some more cycles (mind you,
not a whole lot :)

$ sudo nice -n -20 ./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 18241 cycles per page
copy_page function '2.4 non MMX'         took 20254 cycles per page
copy_page function '2.4 MMX fallback'    took 20194 cycles per page
copy_page function '2.4 MMX version'     took 18236 cycles per page
copy_page function 'faster_copy'         took 10954 cycles per page
copy_page function 'even_faster'         took 10777 cycles per page
copy_page function 'no_prefetch'         took 6631 cycles per page
copy_page function 'no_prefetch2'        took 6586 cycles per page


no_prefetch2 is using:

        for (i=0;i<=4096-256;i+=256)
                __asm__ __volatile(
                        "movl 192(%1,%2),%0\n"
                        "movl 128(%1,%2),%0\n"
                        "movl 64(%1,%2),%0\n"
                        "movl 0(%1,%2),%0\n"
                        : "=&r" (d1)
                        : "r" (from), "r" (i));
        for(i=0; i<4096/64; i++) {
                __asm__ __volatile__ (
                "   movq (%0), %%mm0\n"
                "   movq 8(%0), %%mm1\n"
                "   movq 16(%0), %%mm2\n"
                "   movq 24(%0), %%mm3\n"
                "   movq 32(%0), %%mm4\n"
                "   movq 40(%0), %%mm5\n"
                "   movq 48(%0), %%mm6\n"
                "   movq 56(%0), %%mm7\n"
                "   movntq %%mm0, (%1)\n"
                "   movntq %%mm1, 8(%1)\n"
                "   movntq %%mm2, 16(%1)\n"
                "   movntq %%mm3, 24(%1)\n"
                "   movntq %%mm4, 32(%1)\n"
                "   movntq %%mm5, 40(%1)\n"
                "   movntq %%mm6, 48(%1)\n"
                "   movntq %%mm7, 56(%1)\n"
                : : "r" (from), "r" (to) : "memory");
                from+=64;
                to+=64;
        }


$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1700+
stepping        : 2
cpu MHz         : 1465.996
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2922.90
