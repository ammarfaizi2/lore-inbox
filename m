Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVJITmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVJITmp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVJITmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:42:42 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:22122 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750914AbVJITmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:42:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Message-Id;
  b=tU/Mr6hP6SqgKSt6TveFNbA1vWr5L105BeFCj8kxqNQdFjnkSvV3R9nvye3FijwrjzzuuKJK6I1Qrw8TAhQC7iwkaZHbd3tOxQjmfdI3vrL2XULLwMwNokYa4A+/yzaEGd0mVQ1/s9HthZQIIjFvAqsF3IdPhIZieln9AAhpx68=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Uml left showstopper bugs for 2.6.14
Date: Sun, 9 Oct 2005 21:42:32 +0200
User-Agent: KMail/1.8.2
Cc: Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>,
       "Kai Tan" <mineown@hotmail.com>
References: <200510092118.21032.blaisorblade@yahoo.it>
In-Reply-To: <200510092118.21032.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pKXSDot0Ym1KX8M"
Message-Id: <200510092142.33332.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_pKXSDot0Ym1KX8M
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Kai - go to the end, there are patches for your SKAS0 problem.

On Sunday 09 October 2005 21:18, Blaisorblade wrote:
> Here's a short and updated list of showstoppers for 2.6.14 release, from
> the UML point of view.

> 2) Someone broke endianness of COW driver macros in a header cleanup. I
> have fixes.
Just sent them.
> 3) SKAS0 is broken on amd64 hosts, when frame pointers are disabled. Jeff
> has the fix, waiting end of testing.

> 4) SKAS0 is broken with GCC 3.2.3, and potentially other GCC releases -
> look at arch/um/include/sysdep-i386/stub.h: stub_syscall*() to see how. I
> have two fixes, choosing the safer one (it's all just simply reusing code
> from <asm/unistd.h>).
Jeff, I've attached patches for this. Also found another problematic piece of 
code, in stub-segv (same bad idea).

The patch for that changes a bit more things that strictly needed - complain 
if that's a problem for merging in 2.6.14.

Kai Tan, the order of the patches is:

uml-fix-misassembling-skas0-stub
uml-fix-misassembling-skas0-stub-segv

Note that the second is a bit less tested, so if both together cause problems, 
try with only the first one.

And remember to add "skas0" to the cmd line, to force UML to run in SKAS0 
mode.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_pKXSDot0Ym1KX8M
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-fix-misassembling-skas0-stub"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-misassembling-skas0-stub"

uml: fix SKAS0 assembly stubs - use proper constraints

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Jeff Dike noted that the assembly code for syscall stubs is misassembled with
GCC 3.2.3: the values copied in registers weren't preserved between one asm()
and the following one.

So I fixed the thing by rewriting the __asm__ constraints more
like unistd.h ones.

Note: in syscall6 case I had to add one more instruction (i.e. moving arg6 in
eax and shuffling things around) - it's needed for the function to be valid in
general (we can't load the value from the stack, relative to ebp, because we
change it), but could be avoided since we actually use a constant as param 6.

The only fix would be to turn stub_syscall6 to a macro and use a "i" constraint
for arg6 (i.e., specify it's a constant value).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.13/arch/um/include/sysdep-i386/stub.h
===================================================================
--- linux-2.6.13.orig/arch/um/include/sysdep-i386/stub.h
+++ linux-2.6.13/arch/um/include/sysdep-i386/stub.h
@@ -16,45 +16,69 @@ extern void stub_clone_handler(void);
 #define STUB_MMAP_NR __NR_mmap2
 #define MMAP_OFFSET(o) ((o) >> PAGE_SHIFT)
 
+static inline long stub_syscall1(long syscall, long arg1)
+{
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1));
+
+	return ret;
+}
+
 static inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
 
-	__asm__("movl %0, %%ecx; " : : "g" (arg2) : "%ecx");
-	__asm__("movl %0, %%ebx; " : : "g" (arg1) : "%ebx");
-	__asm__("movl %0, %%eax; " : : "g" (syscall) : "%eax");
-	__asm__("int $0x80;" : : : "%eax");
-	__asm__ __volatile__("movl %%eax, %0; " : "=g" (ret) :);
-	return(ret);
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2));
+
+	return ret;
 }
 
 static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
 {
-	__asm__("movl %0, %%edx; " : : "g" (arg3) : "%edx");
-	return(stub_syscall2(syscall, arg1, arg2));
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2), "d" (arg3));
+
+	return ret;
 }
 
 static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
 				 long arg4)
 {
-	__asm__("movl %0, %%esi; " : : "g" (arg4) : "%esi");
-	return(stub_syscall3(syscall, arg1, arg2, arg3));
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2), "d" (arg3), "S" (arg4));
+
+	return ret;
+}
+
+static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
+				 long arg4, long arg5)
+{
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall), "b" (arg1),
+			"c" (arg2), "d" (arg3), "S" (arg4), "D" (arg5));
+
+	return ret;
 }
 
 static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
 				 long arg4, long arg5, long arg6)
 {
 	long ret;
-	__asm__("movl %0, %%eax; " : : "g" (syscall) : "%eax");
-	__asm__("movl %0, %%ebx; " : : "g" (arg1) : "%ebx");
-	__asm__("movl %0, %%ecx; " : : "g" (arg2) : "%ecx");
-	__asm__("movl %0, %%edx; " : : "g" (arg3) : "%edx");
-	__asm__("movl %0, %%esi; " : : "g" (arg4) : "%esi");
-	__asm__("movl %0, %%edi; " : : "g" (arg5) : "%edi");
-	__asm__ __volatile__("pushl %%ebp ; movl %1, %%ebp; "
-		"int $0x80; popl %%ebp ; "
-		"movl %%eax, %0; " : "=g" (ret) : "g" (arg6) : "%eax");
-	return(ret);
+
+	__asm__ volatile ("push %%ebp ; movl %%eax,%%ebp ; movl %1,%%eax ; "
+			"int $0x80 ; pop %%ebp"
+			: "=a" (ret)
+			: "g" (syscall), "b" (arg1), "c" (arg2), "d" (arg3),
+			  "S" (arg4), "D" (arg5), "0" (arg6));
+
+	return ret;
 }
 
 static inline void trap_myself(void)
Index: linux-2.6.13/arch/um/include/sysdep-x86_64/stub.h
===================================================================
--- linux-2.6.13.orig/arch/um/include/sysdep-x86_64/stub.h
+++ linux-2.6.13/arch/um/include/sysdep-x86_64/stub.h
@@ -17,37 +17,72 @@ extern void stub_clone_handler(void);
 #define STUB_MMAP_NR __NR_mmap
 #define MMAP_OFFSET(o) (o)
 
+#define __syscall_clobber "r11","rcx","memory"
+#define __syscall "syscall"
+
 static inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
 
-	__asm__("movq %0, %%rsi; " : : "g" (arg2) : "%rsi");
-	__asm__("movq %0, %%rdi; " : : "g" (arg1) : "%rdi");
-	__asm__("movq %0, %%rax; " : : "g" (syscall) : "%rax");
-	__asm__("syscall;" : : : "%rax", "%r11", "%rcx");
-	__asm__ __volatile__("movq %%rax, %0; " : "=g" (ret) :);
-	return(ret);
+	__asm__ volatile (__syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2) : __syscall_clobber );
+
+	return ret;
 }
 
 static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
 {
-	__asm__("movq %0, %%rdx; " : : "g" (arg3) : "%rdx");
-	return(stub_syscall2(syscall, arg1, arg2));
+	long ret;
+
+	__asm__ volatile (__syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3)
+		: __syscall_clobber );
+
+	return ret;
 }
 
 static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
 				 long arg4)
 {
-	__asm__("movq %0, %%r10; " : : "g" (arg4) : "%r10");
-	return(stub_syscall3(syscall, arg1, arg2, arg3));
+	long ret;
+
+	__asm__ volatile ("movq %5,%%r10 ; " __syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
+		  "g" (arg4)
+		: __syscall_clobber, "r10" );
+
+	return ret;
+}
+
+static inline long stub_syscall5(long syscall, long arg1, long arg2, long arg3,
+				 long arg4, long arg5)
+{
+	long ret;
+
+	__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; " __syscall
+		: "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
+		  "g" (arg4), "g" (arg5)
+		: __syscall_clobber, "r10", "r8" );
+
+	return ret;
 }
 
 static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
 				 long arg4, long arg5, long arg6)
 {
-	__asm__("movq %0, %%r9; " : : "g" (arg6) : "%r9");
-	__asm__("movq %0, %%r8; " : : "g" (arg5) : "%r8");
-	return(stub_syscall4(syscall, arg1, arg2, arg3, arg4));
+	long ret;
+
+	__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; "
+		"movq %7, %%r9; " __syscall : "=a" (ret)
+		: "0" (syscall), "D" (arg1), "S" (arg2), "d" (arg3),
+		  "g" (arg4), "g" (arg5), "g" (arg6)
+		: __syscall_clobber, "r10", "r8", "r9" );
+
+	return ret;
 }
 
 static inline void trap_myself(void)

--Boundary-00=_pKXSDot0Ym1KX8M
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="uml-fix-misassembling-skas0-stub-segv"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="uml-fix-misassembling-skas0-stub-segv"

uml: fix assembly stub for segv

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Even here, we reuse values from one asm statement to the next without telling
this to GCC - so fix this.

While at it, a bit of improvements to the generated asm code, with better use of
constraints. Still TODO: convert all this to the syscall_stub macros we already
have.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.13/arch/um/sys-i386/stub_segv.c
===================================================================
--- linux-2.6.13.orig/arch/um/sys-i386/stub_segv.c
+++ linux-2.6.13/arch/um/sys-i386/stub_segv.c
@@ -14,17 +14,19 @@ void __attribute__ ((__section__ (".__sy
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
Index: linux-2.6.13/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- linux-2.6.13.orig/arch/um/sys-x86_64/stub_segv.c
+++ linux-2.6.13/arch/um/sys-x86_64/stub_segv.c
@@ -30,15 +30,17 @@ void __attribute__ ((__section__ (".__sy
 stub_segv_handler(int sig)
 {
 	struct ucontext *uc;
+	long pid;
 
 	__asm__("movq %%rdx, %0" : "=g" (uc) : );
         GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
                               &uc->uc_mcontext);
 
-	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid) : "%rax");
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
@@ -46,5 +48,5 @@ stub_segv_handler(int sig)
 	__asm__("movq %0, %%rsp": :
 		"g" ((unsigned long) container_of(uc, struct rt_sigframe,
 						  uc) + 8));
-	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn) : "%rax");
+	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn) : "rax");
 }

--Boundary-00=_pKXSDot0Ym1KX8M--

		
___________________________________
Yahoo! Agenda ti aiuta a ricordare impegni, appuntamenti e compleanni
http://agenda.yahoo.it
