Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267657AbUHRUi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUHRUi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 16:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUHRUi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 16:38:56 -0400
Received: from math.ut.ee ([193.40.5.125]:17591 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S267650AbUHRUgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 16:36:43 -0400
Date: Wed, 18 Aug 2004 23:29:02 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Tom Rini <trini@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: How to debug 2.6 PReP boot hang?
In-Reply-To: <20040816145347.GD2377@smtp.west.cox.net>
Message-ID: <Pine.GSO.4.44.0408181853430.23535-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's the one that reorganizes boot code:
> > PPC32: Kill off arch/ppc/boot/prep and rearrange some files.
>
> Sadly, that is what I expected.  Try narrowing down the differences
> between prep/head.S and simple/head.S (or rather head.s via make
> arch/ppc/boot/prep/head.s and simple/head.s to strip out comments, etc).

I replaced the whole head.S with old prep one. Works, so head.S is
probably the culprit.

1. L1 cache disabling was moved. I moved it back to before cheking OF
address (but after recording link register into r3 since I left the
disabling a subroutine), it still hangs.

2. The address that the code is relocated to is computed differently.
Old code relocates itself to hardcoded 8M (start), new code to
max(load+size, end).

3. Relocation loop is different (see ms to be memmove, not memcpy, at
the first glance).

I replaced the calculation and relocate with old unconditional relocate,
it still hangs.

Replaced head.S with first half of old head.S (relocate from old,
start_ldr from new), still hangs.

Put a couple of debugging traps around. Trap before load_kernel is
executed, trap after load_kernel is never reached. So head.S changes
cause load_kernel to hang.

Some more changes and the only difference is load_kernel vs
decompress_kernel. Changing load_kernel call in relocate.S to
decompress_kernel makes the kernel boot. Oh, finally.

BTW, the address of OF residual data bounces around in
r3->r29->r4->r11->r6. The old code only did r3->r11->r6 but the new code
uses r11 for cache disabling.

This is the patch I'm using currently. I understand that this is
probably not the right patch for inclusion :)

===== arch/ppc/boot/simple/relocate.S 1.11 vs edited =====
--- 1.11/arch/ppc/boot/simple/relocate.S	2004-04-03 06:13:47 +03:00
+++ edited/arch/ppc/boot/simple/relocate.S	2004-08-18 23:27:39 +03:00
@@ -183,7 +183,7 @@
 	mr	r5,r6		/* Checksum */
 	mr	r6,r11		/* Residual data */
 	mr	r7,r25		/* Validated OFW interface */
-	bl	load_kernel
+	bl	decompress_kernel

 	/*
 	 * Make sure the kernel knows we don't have things set in

-- 
Meelis Roos (mroos@linux.ee)









