Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318986AbSH1U0D>; Wed, 28 Aug 2002 16:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318980AbSH1U0D>; Wed, 28 Aug 2002 16:26:03 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:40640 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S318986AbSH1UZy>; Wed, 28 Aug 2002 16:25:54 -0400
Date: Wed, 28 Aug 2002 21:30:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dave Jones <davej@suse.de>,
       Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M386 flush_one_tlb invlpg
In-Reply-To: <Pine.LNX.4.44.0208271216440.1419-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208282059390.2079-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002, Linus Torvalds wrote:
> 
> This test is senseless, in my opinion:
> 
> > +		if (cpu_has_pge)					\
> > +			__flush_tlb_single(addr);			\
> 
> The test _should_ be for something like
> 
> 	if (cpu_has_invlpg)
> 		__flush_tlb_single(addr);
> 
> since we want to use the invlpg instruction regardless of any PGE issues 

New patch below defines cpu_has_invlpg as (boot_cpu_data.x86 > 3).
But I do feel safer with that original cpu_has_pge test, which was
using a decent capability flag, and only changed behaviour of the
CONFIG_M386 __flush_tlb_one when it's necessary.

Isn't CONFIG_M386 about maximum safe applicability, rather than speed?
Am I imagining it, or were there a few i386 + i486 SMP machines built?
Or might there be some i486 clone which didn't really implement invlpg,
which could be used with a CONFIG_M386 kernel before this change,
but not after?  But perhaps I'm just dreaming up excuses for my
senselessness - your call.

Hugh

CONFIG_M386 kernel running on PPro+ processor with X86_FEATURE_PGE may
set _PAGE_GLOBAL bit: then __flush_tlb_one must use invlpg instruction.

--- 2.5.32/include/asm-i386/tlbflush.h	Tue May 28 21:41:36 2002
+++ linux/include/asm-i386/tlbflush.h	Wed Aug 28 20:48:44 2002
@@ -45,11 +45,21 @@
 			__flush_tlb();					\
 	} while (0)
 
-#ifndef CONFIG_X86_INVLPG
-#define __flush_tlb_one(addr) __flush_tlb()
+#define cpu_has_invlpg	(boot_cpu_data.x86 > 3)
+
+#define __flush_tlb_single(addr) \
+	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+
+#ifdef CONFIG_X86_INVLPG
+# define __flush_tlb_one(addr) __flush_tlb_single(addr)
 #else
-#define __flush_tlb_one(addr) \
-__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+# define __flush_tlb_one(addr)						\
+	do {								\
+		if (cpu_has_invlpg)					\
+			__flush_tlb_single(addr);			\
+		else							\
+			__flush_tlb();					\
+	} while (0)
 #endif
 
 /*

