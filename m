Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286331AbSAAXDj>; Tue, 1 Jan 2002 18:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286342AbSAAXDa>; Tue, 1 Jan 2002 18:03:30 -0500
Received: from [217.9.226.246] ([217.9.226.246]:19073 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S286325AbSAAXDR>; Tue, 1 Jan 2002 18:03:17 -0500
To: linux-kernel@vger.kernel.org
Cc: gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] C undefined behavior fix
From: Momchil Velikov <velco@fadata.bg>
Date: 02 Jan 2002 01:03:25 +0200
Message-ID: <87g05py8qq.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: to gcc list, in case someone wants to argue about standards]

The appended patch fix incorrect code, which interferes badly with
optimizations in GCC 3.0.4 and GCC 3.1.

The GCC tries to replace the strcpy from a constant string source with
a memcpy, since the length is know at compile time.

Thus 
   strcpy (dst, "abcdef" + 2)
gives
   memcpy (dst, "abcdef" + 2, 5)

However, GCC does not handle the case, when the above offset (2) is
not within the bounds of the string, which result in undefined
behavior according to ANSI/ISO C99.

The error is that
   strcpy (namep, "linux,phandle" + 0xc0000000);
gets emitted as
   memcpy (namep, "linux,phandle" + 0xc0000000, 14 - 0xc0000000);

Regards,
-velco

--- 1.3/arch/ppc/kernel/prom.c	Wed Dec 26 18:27:54 2001
+++ edited/arch/ppc/kernel/prom.c	Tue Jan  1 22:53:23 2002
@@ -997,7 +997,7 @@
 		prev_propp = &pp->next;
 		namep = (char *) (pp + 1);
 		pp->name = PTRUNRELOC(namep);
-		strcpy(namep, RELOC("linux,phandle"));
+		memcpy (namep, RELOC("linux,phandle"), sizeof("linux,phandle"));
 		mem_start = ALIGN((unsigned long)namep + strlen(namep) + 1);
 		pp->value = (unsigned char *) PTRUNRELOC(&np->node);
 		pp->length = sizeof(np->node);
