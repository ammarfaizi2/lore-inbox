Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTFTIgd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 04:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTFTIgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 04:36:31 -0400
Received: from dns1.seagha.com ([217.66.0.18]:50973 "EHLO relay-1.seagha.com")
	by vger.kernel.org with ESMTP id S262444AbTFTIWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 04:22:54 -0400
Message-ID: <6DED3619289CD311BCEB00508B8E1336011774BD@nt-server2.antwerp.seagha.com>
From: Karl Vogel <karl.vogel@seagha.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: fast_copy_page sections?!
Date: Fri, 20 Jun 2003 10:38:58 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In arch/i386/lib/mmx.c there is a function fast_copy_page() using some
crafty asm statements. However I don't quite understand the part with the
fixup sections?! Can anybody shed some light into was is going on here?!

----- arch/i386/lib/mmx.c
static void fast_copy_page(void *to, void *from)
{
        int i;

        kernel_fpu_begin();

        /* maybe the prefetch stuff can go before the expensive fnsave...
         * but that is for later. -AV
         */
        __asm__ __volatile__ (
                "1: prefetch (%0)\n"
                "   prefetch 64(%0)\n"
                "   prefetch 128(%0)\n"
                "   prefetch 192(%0)\n"
                "   prefetch 256(%0)\n"
                "2:  \n"
                ".section .fixup, \"ax\"\n"
                "3: movw $0x1AEB, 1b\n" /* jmp on 26 bytes */
                "   jmp 2b\n"
                ".previous\n"
                ".section __ex_table,\"a\"\n"
                "       .align 4\n"
                "       .long 1b, 3b\n"
                ".previous"
                : : "r" (from) );

        for(i=0; i<(4096-320)/64; i++)
        {
                __asm__ __volatile__ (
                "1: prefetch 320(%0)\n"
                "2: movq (%0), %%mm0\n"
                "   movntq %%mm0, (%1)\n"
                "   movq 8(%0), %%mm1\n"
                "   movntq %%mm1, 8(%1)\n"
                "   movq 16(%0), %%mm2\n"
                "   movntq %%mm2, 16(%1)\n"
                "   movq 24(%0), %%mm3\n"
                "   movntq %%mm3, 24(%1)\n"
                "   movq 32(%0), %%mm4\n"
                "   movntq %%mm4, 32(%1)\n"
                "   movq 40(%0), %%mm5\n"
                "   movntq %%mm5, 40(%1)\n"
                "   movq 48(%0), %%mm6\n"
                "   movntq %%mm6, 48(%1)\n"
                "   movq 56(%0), %%mm7\n"
                "   movntq %%mm7, 56(%1)\n"
                ".section .fixup, \"ax\"\n"
                "3: movw $0x05EB, 1b\n" /* jmp on 5 bytes */
                "   jmp 2b\n"
                ".previous\n"
                ".section __ex_table,\"a\"\n"
                "       .align 4\n"
                "       .long 1b, 3b\n"
                ".previous"
                : : "r" (from), "r" (to) : "memory");
                from+=64;
                to+=64;
        }
--- cut the remainder ---


Also.. a while ago, there were some posts about a faster version. Does
anybody know why that version was never used?! (did nobody send a patch, or
was there something wrong with it?)

Message archive at:
  http://www.ussg.iu.edu/hypermail/linux/kernel/0210.3/0156.html

