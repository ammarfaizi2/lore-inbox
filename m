Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313862AbSEMP3b>; Mon, 13 May 2002 11:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314061AbSEMP33>; Mon, 13 May 2002 11:29:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:26711 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S313862AbSEMP32>; Mon, 13 May 2002 11:29:28 -0400
Date: Mon, 13 May 2002 16:31:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Keith Owens <kaos@ocs.com.au>, Dave Jones <davej@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak
In-Reply-To: <Pine.LNX.4.21.0205102216160.3747-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0205131611010.4616-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, Hugh Dickins wrote:
> Could we change the i386 BUG() macro slightly again?  Sorry to return
> to this stale subject, but I'm now trying to do something constructive
> about the insane disassembly issue, before 2.4.19 finalizes, and have
> found that if FILE pointer and LINE short are interchanged, then ud2
> instruction can be well displayed as an "Ap" instruction, like ljmp.

My enthusiasm for making even the slightest change (ud2 Ap) to the
various disassemblers has waned over the weekend.  Particularly a
change that would require objdump to know whether and what version
of kernel it was dealing with.  And it seems to be an issue which
worries only me.

So I retract my earlier patch, and won't attempt to persuade Marcelo
to include it (or the one below) in 2.4.19: it was good for minimizing
change to the disassemblers, but no good for avoiding change to them.
Personally, I'll use some patch like the one below: waste another
byte to encapsulate the file pointer and line number in an ljmp.

Hugh

--- 2.4.19-pre8/arch/i386/kernel/traps.c	Fri May  3 12:17:41 2002
+++ linux/arch/i386/kernel/traps.c	Mon May 13 15:27:09 2002
@@ -256,9 +256,9 @@
 		goto no_bug;
 	if (ud2 != 0x0b0f)
 		goto no_bug;
-	if (__get_user(line, (unsigned short *)(eip + 2)))
+	if (__get_user(line, (unsigned short *)(eip + 7)))
 		goto bug;
-	if (__get_user(file, (char **)(eip + 4)) ||
+	if (__get_user(file, (char **)(eip + 3)) ||
 		(unsigned long)file < PAGE_OFFSET || __get_user(c, file))
 		file = "<bad filename>";
 
--- 2.4.19-pre8/include/asm-i386/page.h	Wed May  8 20:22:42 2002
+++ linux/include/asm-i386/page.h	Mon May 13 15:24:50 2002
@@ -89,18 +89,19 @@
 #ifndef __ASSEMBLY__
 
 /*
- * Tell the user there is some problem. Beep too, so we can
- * see^H^H^Hhear bugs in early bootup as well!
+ * Tell the user there is some problem.
  * The offending file and line are encoded after the "officially
- * undefined" opcode for parsing in the trap handler.
+ * undefined" opcode for parsing in the trap handler, with an
+ * "ljmp" code inserted so as not to confuse disassemblers.
  */
 
 #if 1	/* Set to zero for a slightly smaller kernel */
 #define BUG()				\
  __asm__ __volatile__(	"ud2\n"		\
-			"\t.word %c0\n"	\
-			"\t.long %c1\n"	\
-			 : : "i" (__LINE__), "i" (__FILE__))
+			"\t.byte 0xea\n" \
+			"\t.long %c0\n"	\
+			"\t.word %c1\n"	\
+			 : : "i" (__FILE__), "i" (__LINE__))
 #else
 #define BUG() __asm__ __volatile__("ud2\n")
 #endif

