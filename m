Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271719AbRIRO5B>; Tue, 18 Sep 2001 10:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271877AbRIRO4v>; Tue, 18 Sep 2001 10:56:51 -0400
Received: from [195.66.192.167] ([195.66.192.167]:33028 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271719AbRIRO4q>; Tue, 18 Sep 2001 10:56:46 -0400
Date: Tue, 18 Sep 2001 17:55:39 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <16133872776.20010918175539@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
CC: Roberto Jung Drebes <drebes@inf.ufrgs.br>
Subject: [PATCH] Extra memory prefetch in mmx.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looking at arch/i386/lib/mmx.c I see that MMX fast_copy_page()
makes extra prefetches past the end of source page.
This is harmless but wastes CPU cycles and pollutes cache.
Pls find a patch below.
Diffed against 2.4.9.

If you want to test it, be sure to disable K7 optimization
or else this code will be ifdef'ed out :-)
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/

--- mmx.c.orig  Tue May 22 15:23:16 2001
+++ mmx.c       Tue Sep 18 16:51:50 2001
@@ -293,7 +293,7 @@
                ".previous"
                : : "r" (from) );
 
-       for(i=0; i<4096/64; i++)
+       for(i=0; i<(4096-320)/64; i++)
        {
                __asm__ __volatile__ (
                "1: prefetch 320(%0)\n"
@@ -321,6 +321,29 @@
                "       .align 4\n"
                "       .long 1b, 3b\n"
                ".previous"
+               : : "r" (from), "r" (to) : "memory");
+               from+=64;
+               to+=64;
+       }
+       for(i=(4096-320)/64; i<4096/64; i++)
+       {
+               __asm__ __volatile__ (
+               "2: movq (%0), %%mm0\n"
+               "   movq 8(%0), %%mm1\n"
+               "   movq 16(%0), %%mm2\n"
+               "   movq 24(%0), %%mm3\n"
+               "   movq %%mm0, (%1)\n"
+               "   movq %%mm1, 8(%1)\n"
+               "   movq %%mm2, 16(%1)\n"
+               "   movq %%mm3, 24(%1)\n"
+               "   movq 32(%0), %%mm0\n"
+               "   movq 40(%0), %%mm1\n"
+               "   movq 48(%0), %%mm2\n"
+               "   movq 56(%0), %%mm3\n"
+               "   movq %%mm0, 32(%1)\n"
+               "   movq %%mm1, 40(%1)\n"
+               "   movq %%mm2, 48(%1)\n"
+               "   movq %%mm3, 56(%1)\n"
                : : "r" (from), "r" (to) : "memory");
                from+=64;
                to+=64;


