Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVGKOVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVGKOVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVGKOTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:19:08 -0400
Received: from relay01.pair.com ([209.68.5.15]:5137 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261842AbVGKOSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:18:55 -0400
X-pair-Authenticated: 24.126.76.52
Message-ID: <42D27DAA.3040202@kegel.com>
Date: Mon, 11 Jul 2005 07:09:46 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible;MSIE 5.5; Windows 98)
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: CONFIG_ALPHA_GENERIC problem with gcc-4.1 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing builds of linux-2.6.11 as a sanity check
for new versions of gcc, and a problem just popped up
in arch/alpha/Makefile (see http://gcc.gnu.org/ml/gcc/2005-07/msg00397.html)
I think I can work around this myself by using CONFIG_ALPHA_EV6
instead of CONFIG_ALPHA_GENERIC, but here's my analysis
of the problem; maybe the alpha kernel maintainer can take it from here?

Take the following with a grain of salt; I don't know much
about alpha or gcc, I'm just doing a little QA.

arch/alpha/Makefile says:
36   # If GENERIC, make sure to turn off any instruction set extensions that
37   # the host compiler might have on by default.  Given that EV4 and EV5
38   # have the same instruction set, prefer EV5 because an EV5 schedule is
39   # more likely to keep an EV4 processor busy than vice-versa.
40   ifeq ($(CONFIG_ALPHA_GENERIC),y)
41     mcpu := ev5
42     mcpu_done := y
43   endif
...
84 # For TSUNAMI, we must have the assembler not emulate our instructions.
85 # The same is true for IRONGATE, POLARIS, PYXIS.
86 # BWX is most important, but we don't really want any emulation ever.
87 CFLAGS += $(cflags-y) -Wa,-mev6

Thus when you pick CONFIG_ALPHA_GENERIC, gcc is invoked with
the contradictory options -mcpu=ev5 -Wa,-mev6

This probably means that even on ev5, some ev6 instructions are used.
In particular, see include/asm-alpha/compiler.h:

#if defined(__alpha_bwx__)
#define __kernel_ldbu(mem)      (mem)
#define __kernel_ldwu(mem)      (mem)
#define __kernel_stb(val,mem)   ((mem) = (val))
#define __kernel_stw(val,mem)   ((mem) = (val))
#else
#define __kernel_ldbu(mem)                              \
   ({ unsigned char __kir;                               \
      __asm__("ldbu %0,%1" : "=r"(__kir) : "m"(mem));    \
      __kir; })

That inline assembly is fine on ev5, but only if the assembler
is emulating the ldbu instruction with a macro -- exactly
the kind of thing arch/alpha/Makefile is trying to
inhibit when it says -Wa,-mev6.

This is an issue now because building the kernel with CONFIG_ALPHA_GENERIC
fails on the current gcc-4.1 snapshot with

 > {standard input}:496: Error: macro requires $at register while noat in effect
 > make[1]: *** [arch/alpha/kernel/core_cia.o] Error 1

and it looks like a kernel problem, not a gcc problem:
don't try to use ev6 instructions on ev5 or earlier processors.

That probably means conditionalizing that -Wa,ev6 properly,
but if that's hard, maybe it means dropping support for ev4 and ev5 processors,
and mapping CONFIG_ALPHA_GENERIC to ev6.  I wouldn't know...
- Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
