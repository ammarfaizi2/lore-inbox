Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVJYWF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVJYWF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVJYWFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:05:42 -0400
Received: from [151.97.230.9] ([151.97.230.9]:54501 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932423AbVJYWFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:05:32 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 05/11] uml: fix assembly stub for segv
Date: Wed, 26 Oct 2005 00:01:34 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051025220133.20010.19935.stgit@zion.home.lan>
In-Reply-To: <20051025220053.20010.56979.stgit@zion.home.lan>
References: <20051025220053.20010.56979.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Even here, we reuse values from one asm statement to the next without telling
this to GCC - so fix this.

While at it, a bit of improvements to the generated asm code, with better use of
constraints. Still TODO: convert all this to the syscall_stub macros we already
have.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/sys-i386/stub_segv.c   |   10 ++++++----
 arch/um/sys-x86_64/stub_segv.c |   18 ++++++++++--------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/um/sys-i386/stub_segv.c b/arch/um/sys-i386/stub_segv.c
--- a/arch/um/sys-i386/stub_segv.c
+++ b/arch/um/sys-i386/stub_segv.c
@@ -13,17 +13,19 @@ void __attribute__ ((__section__ (".__sy
 stub_segv_handler(int sig)
 {
 	struct sigcontext *sc = (struct sigcontext *) (&sig + 1);
+	long pid;
 
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
 			      sc);
 
-	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
-	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
-		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1));
+	__asm__("movl %1, %%eax ; int $0x80": "=&a" (pid): "i" (__NR_getpid));
+	__asm__("movl %0, %%eax ; movl %1, %%ecx ;"
+		"int $0x80": : "i" (__NR_kill), "i" (SIGUSR1), "b" (pid)
+		: "eax", "ecx");
 	/* Load pointer to sigcontext into esp, since we need to leave
 	 * the stack in its original form when we do the sigreturn here, by
 	 * hand.
 	 */
 	__asm__("mov %0,%%esp ; movl %1, %%eax ; "
-		"int $0x80" : : "a" (sc), "g" (__NR_sigreturn));
+		"int $0x80" : : "r" (sc), "i" (__NR_sigreturn));
 }
diff --git a/arch/um/sys-x86_64/stub_segv.c b/arch/um/sys-x86_64/stub_segv.c
--- a/arch/um/sys-x86_64/stub_segv.c
+++ b/arch/um/sys-x86_64/stub_segv.c
@@ -31,21 +31,23 @@ void __attribute__ ((__section__ (".__sy
 stub_segv_handler(int sig)
 {
 	struct ucontext *uc;
+	long pid;
 
-	__asm__("movq %%rdx, %0" : "=g" (uc) :);
+	__asm__("movq %%rdx, %0" : "=g" (uc) : );
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
 			      &uc->uc_mcontext);
 
-	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid));	
-	__asm__("movq %%rax, %%rdi ; movq %0, %%rax ; movq %1, %%rsi ;"
-		"syscall": : "g" (__NR_kill), "g" (SIGUSR1) : 
-		"%rdi", "%rax", "%rsi");
+	__asm__("movq %0, %%rax ; syscall": "=&a" (pid) : "g" (__NR_getpid)
+			: "rax", __syscall_clobber);
+	__asm__("movq %0, %%rax ; movq %1, %%rsi ;"
+		"syscall": : "i" (__NR_kill), "i" (SIGUSR1), "D" (pid) :
+		"rdi", "rax", "rsi", __syscall_clobber);
 	/* sys_sigreturn expects that the stack pointer will be 8 bytes into
 	 * the signal frame.  So, we use the ucontext pointer, which we know
 	 * already, to get the signal frame pointer, and add 8 to that.
 	 */
-	__asm__("movq %0, %%rsp": : 
-		"g" ((unsigned long) container_of(uc, struct rt_sigframe, 
+	__asm__("movq %0, %%rsp": :
+		"g" ((unsigned long) container_of(uc, struct rt_sigframe,
 						  uc) + 8));
-	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn));
+	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn) : "rax");
 }

