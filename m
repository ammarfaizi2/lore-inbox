Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316140AbSEJVzV>; Fri, 10 May 2002 17:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316141AbSEJVzU>; Fri, 10 May 2002 17:55:20 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:49524 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316140AbSEJVzT>; Fri, 10 May 2002 17:55:19 -0400
Date: Fri, 10 May 2002 22:22:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] BUG() disassembly tweak
Message-ID: <Pine.LNX.4.21.0205102216160.3747-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could we change the i386 BUG() macro slightly again?  Sorry to return
to this stale subject, but I'm now trying to do something constructive
about the insane disassembly issue, before 2.4.19 finalizes, and have
found that if FILE pointer and LINE short are interchanged, then ud2
instruction can be well displayed as an "Ap" instruction, like ljmp.
Whereas I've not found an instruction format that fits its current
ordering: maybe that's just my ignorance, please enlighten me if so.
Patch below against 2.5.15, applies with offset warning to 2.4.19-pre8.

Hugh

diff -urN 2.5.15/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- 2.5.15/arch/i386/kernel/traps.c	Tue Apr 23 12:18:51 2002
+++ linux/arch/i386/kernel/traps.c	Fri May 10 21:56:49 2002
@@ -260,9 +260,9 @@
 		goto no_bug;
 	if (ud2 != 0x0b0f)
 		goto no_bug;
-	if (__get_user(line, (unsigned short *)(eip + 2)))
+	if (__get_user(line, (unsigned short *)(eip + 6)))
 		goto bug;
-	if (__get_user(file, (char **)(eip + 4)) ||
+	if (__get_user(file, (char **)(eip + 2)) ||
 		(unsigned long)file < PAGE_OFFSET || __get_user(c, file))
 		file = "<bad filename>";
 
diff -urN 2.5.15/include/asm-i386/page.h linux/include/asm-i386/page.h
--- 2.5.15/include/asm-i386/page.h	Wed May  8 20:42:40 2002
+++ linux/include/asm-i386/page.h	Fri May 10 21:55:44 2002
@@ -98,9 +98,9 @@
 #if 1	/* Set to zero for a slightly smaller kernel */
 #define BUG()				\
  __asm__ __volatile__(	"ud2\n"		\
-			"\t.word %c0\n"	\
-			"\t.long %c1\n"	\
-			 : : "i" (__LINE__), "i" (__FILE__))
+			"\t.long %c0\n"	\
+			"\t.word %c1\n"	\
+			 : : "i" (__FILE__), "i" (__LINE__))
 #else
 #define BUG() __asm__ __volatile__("ud2\n")
 #endif

