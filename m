Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267419AbTGKUdw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbTGKUdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:33:52 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:54174 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S267419AbTGKUdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:33:50 -0400
Date: Fri, 11 Jul 2003 22:48:30 +0200 (MEST)
Message-Id: <200307112048.h6BKmUQj003987@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: axboe@suse.de, bernie@develer.com
Subject: 2.5.75 as-iosched.c & asm-generic/div64.h breakage
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.5.75 for PPC32 results in:

  gcc -Wp,-MD,drivers/block/.as-iosched.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD_BASENAME=as_iosched -DKBUILD_MODNAME=as_iosched -c -o drivers/block/as-iosched.o drivers/block/as-iosched.c
drivers/block/as-iosched.c: In function `as_update_iohist':
drivers/block/as-iosched.c:840: warning: right shift count >= width of type
drivers/block/as-iosched.c:840: warning: passing arg 1 of `__div64_32' from incompatible pointer type

The statement is "do_div(aic->seek_mean, aic->seek_samples);".

There are two problems here:
- aic->seek_mean is a sector_t, but this type is usually only u32 on 32-bitters,
  unless CONFIG_LBD is set. Thus, as-iosched.c often passes a u32 lvalue to
  do_div() where a u64 lvalue is expected.
- include/asm-generic/div64.h, which is what several 32-bit archs use now, is
  unsafe when its first parameter "n" is a u32 lvalue:
  * The "((n) >> 32) == 0" in the initial test invokes undefined behaviour.
    We want it to be false, but this isn't guaranteed.
  * The call "__div64_32(&(n), __base)" passes a u32* to a function
    expecting a u64*. Major breakage.

x86 survives this because it's custom do_div() implicitly casts "n" to u64
before pulling it apart, and updates "n" with an assignment from a u64, so
the compiler can compensate when "n" is a u32. asm-generic/div64.h should
do something similar, IMO.
  
/Mikael
