Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTEAADf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbTEAADe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:03:34 -0400
Received: from zero.aec.at ([193.170.194.10]:26897 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262610AbTEAADd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:03:33 -0400
Date: Thu, 1 May 2003 02:15:12 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix prefetch patching in 2.5-bk
Message-ID: <20030501001511.GA2890@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Brown paperbag time. I forgot to take the modrm byte in account
with the prefetch patch replacement.  With 3.2 it worked because
it used the right registers in my configuration.

But gcc 2.96 uses a different register in __dpath and the prefetch becomes
4 bytes with modrm and the original nop needs to be as long as that too.

If your machine BUG()s in apply_alternatives at booting 
or module loading you need this patch.

Linus please apply.

-Andi

Index: linux/include/asm-i386/processor.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/asm-i386/processor.h,v
retrieving revision 1.48
diff -u -u -r1.48 processor.h
--- linux/include/asm-i386/processor.h	30 Apr 2003 14:32:05 -0000	1.48
+++ linux/include/asm-i386/processor.h	30 Apr 2003 22:48:26 -0000
@@ -564,7 +564,7 @@
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
 {
-	alternative_input(ASM_NOP3,
+	alternative_input(ASM_NOP4,
 			  "prefetchnta (%1)",
 			  X86_FEATURE_XMM,
 			  "r" (x));
@@ -578,7 +578,7 @@
    spinlocks to avoid one state transition in the cache coherency protocol. */
 extern inline void prefetchw(const void *x)
 {
-	alternative_input(ASM_NOP3,
+	alternative_input(ASM_NOP4,
 			  "prefetchw (%1)",
 			  X86_FEATURE_3DNOW,
 			  "r" (x));
