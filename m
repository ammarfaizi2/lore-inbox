Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbSLXEB4>; Mon, 23 Dec 2002 23:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267041AbSLXEB4>; Mon, 23 Dec 2002 23:01:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23825 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267039AbSLXEBz>; Mon, 23 Dec 2002 23:01:55 -0500
Date: Mon, 23 Dec 2002 20:10:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, <lk@tantalophile.demon.co.uk>,
       Ingo Molnar <mingo@elte.hu>, <drepper@redhat.com>,
       <bart@etpmod.phys.tue.nl>, <davej@codemonkey.org.uk>,
       <hpa@transmeta.com>, <terje.eggestad@scali.com>,
       <matti.aarnio@zmailer.org>, <hugh@veritas.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021224112233.00e6295d.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0212232005080.2328-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Dec 2002, Stephen Rothwell wrote:
>
> And if you change the 0x00 use for alighment to 0x90 (nop) you can
> use gdb to disassemble that array of bytes to check any changes ...

Yeah, and I really should align the _normal_ return address (and not the
restart address).

Something like the appended, perhaps?

		Linus

===== arch/i386/kernel/entry.S 1.45 vs edited =====
--- 1.45/arch/i386/kernel/entry.S	Wed Dec 18 14:42:17 2002
+++ edited/arch/i386/kernel/entry.S	Mon Dec 23 20:02:10 2002
@@ -233,7 +233,7 @@
 #endif

 /* Points to after the "sysenter" instruction in the vsyscall page */
-#define SYSENTER_RETURN 0xffffe00a
+#define SYSENTER_RETURN 0xffffe010

 	# sysenter call handler stub
 	ALIGN
===== arch/i386/kernel/sysenter.c 1.5 vs edited =====
--- 1.5/arch/i386/kernel/sysenter.c	Sun Dec 22 21:12:23 2002
+++ edited/arch/i386/kernel/sysenter.c	Mon Dec 23 20:04:33 2002
@@ -57,12 +57,17 @@
 		0x51,			/* push %ecx */
 		0x52,			/* push %edx */
 		0x55,			/* push %ebp */
+	/* 3: backjump target */
 		0x89, 0xe5,		/* movl %esp,%ebp */
 		0x0f, 0x34,		/* sysenter */
-		0x00,			/* align return point */
-	/* System call restart point is here! (SYSENTER_RETURN - 2) */
-		0xeb, 0xfa,		/* jmp to "movl %esp,%ebp" */
-	/* System call normal return point is here! (SYSENTER_RETURN in entry.S) */
+
+	/* 7: align return point with nop's to make disassembly easier */
+		0x90, 0x90, 0x90, 0x90,
+		0x90, 0x90, 0x90,
+
+	/* 14: System call restart point is here! (SYSENTER_RETURN - 2) */
+		0xeb, 0xf3,		/* jmp to "movl %esp,%ebp" */
+	/* 16: System call normal return point is here! (SYSENTER_RETURN in entry.S) */
 		0x5d,			/* pop %ebp */
 		0x5a,			/* pop %edx */
 		0x59,			/* pop %ecx */

