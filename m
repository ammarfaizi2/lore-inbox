Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTEZM4D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 08:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTEZM4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 08:56:03 -0400
Received: from [62.112.80.35] ([62.112.80.35]:40577 "EHLO ipc1.karo")
	by vger.kernel.org with ESMTP id S264340AbTEZM4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 08:56:02 -0400
Message-ID: <16082.4540.943674.698305@ipc1.karo>
Date: Mon, 26 May 2003 15:08:12 +0200
From: "Lothar Wassmann" <LW@KARO-electronics.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
In-Reply-To: <20030526095551.C4417@flint.arm.linux.org.uk>
References: <20030523175413.A4584@flint.arm.linux.org.uk>
	<Pine.LNX.4.44.0305231821460.1690-100000@localhost.localdomain>
	<20030523112926.7c864263.akpm@digeo.com>
	<20030523193458.B4584@flint.arm.linux.org.uk>
	<1053919171.14018.2.camel@rth.ninka.net>
	<20030526095551.C4417@flint.arm.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> Lothar - can you confirm that your problem vanishes when you turn off
> write allocation on the caches please?  (cachepolicy=writeback)
> 
No, its still there. But I seem to be unable to turn writealloc ON
anyway. I get:
|CPU: XScale-PXA250 [69052904] revision 4 (ARMv5TE)
|CPU: D undefined 5 cache
|CPU: I cache: 32768 bytes, associativity 32, 32 byte lines, 32 sets
|CPU: D cache: 32768 bytes, associativity 32, 32 byte lines, 32 sets
|Machine: KARO electronics PXA25x module
|Memory policy: ECC disabled, Data cache write back
no matter whether I specify 'cachepolicy=writeback', '...writealloc'
or no cachepolicy at all.
(This is because ARMv5TE is not recognized as an ARMv5 architecture and
 PMD_SECT_WBWA is turned into PMD_SECT_WB in build_mem_type_table()
 ('arch/arm/mm/mm-armv.c' line 304).
 Another bug?)
Shouldn't it be:
@@ -295,12 +295,13 @@
 	/*
 	 * ARMv5 can use ECC memory.
 	 */
-	if (cpu_arch == CPU_ARCH_ARMv5) {
+	if (cpu_arch == CPU_ARCH_ARMv5 || cpu_arch == CPU_ARCH_ARMv5T ||
+		cpu_arch == CPU_ARCH_ARMv5TE) {
 		mem_types[MT_VECTORS].prot_l1 |= ecc_mask;
 		mem_types[MT_MEMORY].prot_sect |= ecc_mask;
 	} else {
 		mem_types[MT_MINICLEAN].prot_sect &= ~PMD_SECT_TEX(1);
 		if (cachepolicy == PMD_SECT_WBWA)
 			cachepolicy = PMD_SECT_WB;
 		ecc_mask = 0;
 	}

Only 'cachepolicy=writethrough' makes the problem disappear.


Lothar
