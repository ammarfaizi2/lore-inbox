Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUBZVUe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 16:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUBZVUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 16:20:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42436 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261348AbUBZVUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:20:30 -0500
From: Alexandre Oliva <aoliva@redhat.com>
Subject: raid 5 with >= 5 members broken on x86
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, arjanv@redhat.com, davej@redhat.com
Date: 26 Feb 2004 15:36:10 -0300
Organization: Red Hat Global Engineering Services Compiler Team
Message-ID: <orznb5leqs.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Apologies if this is a dup (or a trip :-); I seem to be having
 trouble getting through the list spam filtering.  Too bad the failure
 is silent.]

There was a bug in the inline asm used to implement xor_p5_mmx_5.  It
had pushes and pops although it took a +g operand.  It turned out
that gcc chose to pass `lines' as an %esp+offset address.  With
changes in esp, it wouldn't work.

I suppose I could just change lines from +g to +r, like xor_pII_mmx_5,
but avoiding the pushes and pops is more efficient, and making sure
GCC doesn't get clever about sharing or reusing p4 and p5, it's just
as safe.  This approach should probably be extended to the other uses
of push and pop due to limitations in the number of operands.

Yet another possibility is to just use +r for p4 and p5; this works in
GCC 3.1 and above.  I wasn't sure the kernel was willing to require
that, so I took the most conservative approach.

Here's the patch.  More details at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=116679

Here's the patch.

--- include/asm-i386/xor.h.orig	2004-02-26 15:13:03.000000000 -0300
+++ include/asm-i386/xor.h	2004-02-26 15:18:20.000000000 -0300
@@ -425,10 +425,28 @@
 
 	kernel_fpu_begin();
 
-	/* need to save p4/p5 manually to not exceed gcc's 10 argument limit */
+	/* GCC up to 3.0.x had this limitation of at most 10 asm
+	   operands, and + operands counted as two (one input and one
+	   output).  We unfortunately have to inform GCC that we're
+	   modifying all of these registers.  The trick we use here is
+	   to make sure the values of p4 and p5 are dissociated from
+	   whatever other registers or stack locations they might have
+	   been shared with, and make sure GCC knows they've been
+	   modified after the asm statement.  This incurs no
+	   additional costs and AFAICT is safe.
+
+	   Should it be found to not work, we'd have to resort to
+	   passing to the asm statement a pointer to a stack save
+	   area, and use that to preserve registers that had to be
+	   marked as read only but that may have been clobbered, which
+	   would impact performance without any actual advantage.
+	   Note that we can't just push and pop the registers, because
+	   this changes esp, and lines may be passed as an
+	   esp-relative address.  Well, I suppose we could require
+	   lines to be passed in a register...  -aoliva@redhat.com */
+
+	__asm__ ("" : "+r" (p4), "+r" (p5));
 	__asm__ __volatile__ (
-	"	pushl %4\n"
-	"	pushl %5\n"        	
 	" .align 32,0x90             ;\n"
 	" 1:                         ;\n"
 	"       movq   (%1), %%mm0   ;\n"
@@ -487,12 +505,11 @@
 	"       addl $64, %5         ;\n"
 	"       decl %0              ;\n"
 	"       jnz 1b               ;\n"
-	"	popl %5\n"
-	"	popl %4\n"
 	: "+g" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3)
 	: "r" (p4), "r" (p5)
 	: "memory");
+	__asm__ __volatile__ ("" : "+r" (p4), "+r" (p5));
 
 	kernel_fpu_end();
 }

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Happy GNU Year!                     oliva@{lsd.ic.unicamp.br, gnu.org}
Red Hat GCC Developer                 aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist                Professional serial bug killer
