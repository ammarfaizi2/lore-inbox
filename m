Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261926AbSIYHCp>; Wed, 25 Sep 2002 03:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261927AbSIYHCp>; Wed, 25 Sep 2002 03:02:45 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:57031 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261926AbSIYHCl>;
	Wed, 25 Sep 2002 03:02:41 -0400
Date: Wed, 25 Sep 2002 17:07:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org, anton@samba.org, jdike@karaya.com
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] sigcontext_struct -> sigcontext
Message-Id: <20020925170742.410f3887.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, Anton, Jeff,

PPC and PPC64 are the only two architectures that define a struct
sigcontext_struct - all the others use struct sigcontext (UML seems to
have been infected :-)). This patch just renames sigcontext_struct to
sigcontext.  It also renames sigcontext32_struct to sigcontext.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.38/arch/ppc/kernel/signal.c 2.5.38-sigcontext/arch/ppc/kernel/signal.c
--- 2.5.38/arch/ppc/kernel/signal.c	2002-09-21 16:53:51.000000000 +1000
+++ 2.5.38-sigcontext/arch/ppc/kernel/signal.c	2002-09-25 16:53:25.000000000 +1000
@@ -196,7 +196,7 @@
 		     struct pt_regs *regs)
 {
 	struct rt_sigframe *rt_sf;
-	struct sigcontext_struct sigctx;
+	struct sigcontext sigctx;
 	struct sigregs *sr;
 	elf_gregset_t saved_regs;  /* an array of ELF_NGREG unsigned longs */
 	sigset_t set;
@@ -297,12 +297,12 @@
 int sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 		  struct pt_regs *regs)
 {
-	struct sigcontext_struct *sc, sigctx;
+	struct sigcontext *sc, sigctx;
 	struct sigregs *sr;
 	elf_gregset_t saved_regs;  /* an array of ELF_NGREG unsigned longs */
 	sigset_t set;
 
-	sc = (struct sigcontext_struct *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
+	sc = (struct sigcontext *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
 	if (copy_from_user(&sigctx, sc, sizeof(sigctx)))
 		goto badframe;
 
@@ -344,7 +344,7 @@
 setup_frame(struct pt_regs *regs, struct sigregs *frame,
 	    unsigned long newsp)
 {
-	struct sigcontext_struct *sc = (struct sigcontext_struct *) newsp;
+	struct sigcontext *sc = (struct sigcontext *) newsp;
 
 	if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto badframe;
@@ -387,7 +387,7 @@
 handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
 	struct pt_regs * regs, unsigned long *newspp, unsigned long frame)
 {
-	struct sigcontext_struct *sc;
+	struct sigcontext *sc;
 	struct rt_sigframe *rt_sf;
 	struct k_sigaction *ka = &current->sig->action[sig-1];
 
@@ -428,7 +428,7 @@
 	} else {
 		/* Put a sigcontext on the stack */
 		*newspp -= sizeof(*sc);
-		sc = (struct sigcontext_struct *) *newspp;
+		sc = (struct sigcontext *) *newspp;
 		if (verify_area(VERIFY_WRITE, sc, sizeof(*sc)))
 			goto badframe;
 		
diff -ruN 2.5.38/arch/ppc64/kernel/signal.c 2.5.38-sigcontext/arch/ppc64/kernel/signal.c
--- 2.5.38/arch/ppc64/kernel/signal.c	2002-09-21 16:53:53.000000000 +1000
+++ 2.5.38-sigcontext/arch/ppc64/kernel/signal.c	2002-09-25 16:53:51.000000000 +1000
@@ -213,7 +213,7 @@
 		     struct pt_regs *regs)
 {
 	struct rt_sigframe *rt_sf;
-	struct sigcontext_struct sigctx;
+	struct sigcontext sigctx;
 	struct sigregs *sr;
 	elf_gregset_t saved_regs;  /* an array of ELF_NGREG unsigned longs */
 	sigset_t set;
@@ -331,12 +331,12 @@
 		   unsigned long r6, unsigned long r7, unsigned long r8,
 		   struct pt_regs *regs)
 {
-	struct sigcontext_struct *sc, sigctx;
+	struct sigcontext *sc, sigctx;
 	struct sigregs *sr;
 	elf_gregset_t saved_regs;  /* an array of ELF_NGREG unsigned longs */
 	sigset_t set;
 
-	sc = (struct sigcontext_struct *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
+	sc = (struct sigcontext *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
 	if (copy_from_user(&sigctx, sc, sizeof(sigctx)))
 		goto badframe;
 
@@ -391,7 +391,7 @@
 	struct funct_descr_entry * funct_desc_ptr;
 	unsigned long temp_ptr;
 
-	struct sigcontext_struct *sc = (struct sigcontext_struct *)newsp;
+	struct sigcontext *sc = (struct sigcontext *)newsp;
   
 	if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto badframe;
@@ -440,7 +440,7 @@
 static void handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
 	struct pt_regs * regs, unsigned long *newspp, unsigned long frame)
 {
-	struct sigcontext_struct *sc;
+	struct sigcontext *sc;
 	struct rt_sigframe *rt_sf;
 	struct k_sigaction *ka = &current->sig->action[sig-1];
 
@@ -481,7 +481,7 @@
 	} else {
 		/* Put a sigcontext on the stack */
 		*newspp -= sizeof(*sc);
-		sc = (struct sigcontext_struct *)*newspp;
+		sc = (struct sigcontext *)*newspp;
 		if (verify_area(VERIFY_WRITE, sc, sizeof(*sc)))
 			goto badframe;
 		
diff -ruN 2.5.38/arch/ppc64/kernel/signal32.c 2.5.38-sigcontext/arch/ppc64/kernel/signal32.c
--- 2.5.38/arch/ppc64/kernel/signal32.c	2002-09-21 16:53:54.000000000 +1000
+++ 2.5.38-sigcontext/arch/ppc64/kernel/signal32.c	2002-09-25 17:04:42.000000000 +1000
@@ -218,14 +218,14 @@
 		     unsigned long r6, unsigned long r7, unsigned long r8,
 		     struct pt_regs *regs)
 {
-	struct sigcontext32_struct *sc, sigctx;
+	struct sigcontext32 *sc, sigctx;
 	struct sigregs32 *sr;
 	int ret;
 	elf_gregset_t32 saved_regs;  /* an array of ELF_NGREG unsigned ints (32 bits) */
 	sigset_t set;
 	int i;
 
-	sc = (struct sigcontext32_struct *)(regs->gpr[1] + __SIGNAL_FRAMESIZE32);
+	sc = (struct sigcontext32 *)(regs->gpr[1] + __SIGNAL_FRAMESIZE32);
 	if (copy_from_user(&sigctx, sc, sizeof(sigctx)))
 		goto badframe;
 
@@ -315,8 +315,7 @@
 static void setup_frame32(struct pt_regs *regs, struct sigregs32 *frame,
             unsigned int newsp)
 {
-	struct sigcontext32_struct *sc =
-		(struct sigcontext32_struct *)(u64)newsp;
+	struct sigcontext32 *sc = (struct sigcontext32 *)(u64)newsp;
 	int i;
 
 	if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
@@ -430,7 +429,7 @@
 			struct pt_regs * regs)
 {
 	struct rt_sigframe_32 *rt_sf;
-	struct sigcontext32_struct sigctx;
+	struct sigcontext32 sigctx;
 	struct sigregs32 *sr;
 	int ret;
 	elf_gregset_t32 saved_regs;   /* an array of 32 bit register values */
@@ -958,7 +957,7 @@
 		sigset_t *oldset, struct pt_regs * regs, unsigned int *newspp,
 		unsigned int frame)
 {
-	struct sigcontext32_struct *sc;
+	struct sigcontext32 *sc;
 	struct rt_sigframe_32 *rt_sf;
 	struct k_sigaction *ka = &current->sig->action[sig-1];
 
@@ -1000,7 +999,7 @@
 	} else {
 		/* Put a sigcontext on the stack */
 		*newspp -= sizeof(*sc);
-		sc = (struct sigcontext32_struct *)(u64)*newspp;
+		sc = (struct sigcontext32 *)(u64)*newspp;
 		if (verify_area(VERIFY_WRITE, sc, sizeof(*sc)))
 			goto badframe;
 		/*
diff -ruN 2.5.38/arch/um/include/sysdep-ppc/sigcontext.h 2.5.38-sigcontext/arch/um/include/sysdep-ppc/sigcontext.h
--- 2.5.38/arch/um/include/sysdep-ppc/sigcontext.h	2002-09-16 13:40:49.000000000 +1000
+++ 2.5.38-sigcontext/arch/um/include/sysdep-ppc/sigcontext.h	2002-09-25 16:54:09.000000000 +1000
@@ -9,7 +9,7 @@
 #define DSISR_WRITE 0x02000000
 
 #define SC_FAULT_ADDR(sc) ({ \
-		struct sigcontext_struct *_sc = (sc); \
+		struct sigcontext *_sc = (sc); \
 		long retval = -1; \
 		switch (_sc->regs->trap) { \
 		case 0x300: \
@@ -27,7 +27,7 @@
 	})
 
 #define SC_FAULT_WRITE(sc) ({ \
-		struct sigcontext_struct *_sc = (sc); \
+		struct sigcontext *_sc = (sc); \
 		long retval = -1; \
 		switch (_sc->regs->trap) { \
 		case 0x300: \
diff -ruN 2.5.38/arch/um/kernel/trap_user.c 2.5.38-sigcontext/arch/um/kernel/trap_user.c
--- 2.5.38/arch/um/kernel/trap_user.c	2002-09-16 13:40:50.000000000 +1000
+++ 2.5.38-sigcontext/arch/um/kernel/trap_user.c	2002-09-25 16:54:43.000000000 +1000
@@ -416,7 +416,7 @@
 
 void segv_handler(int sig, struct uml_pt_regs *regs)
 {
-	struct sigcontext_struct *context = regs->sc;
+	struct sigcontext *context = regs->sc;
 	int index;
 
 	if(regs->is_user && !SEGV_IS_FIXABLE(context)){
diff -ruN 2.5.38/include/asm-ppc/sigcontext.h 2.5.38-sigcontext/include/asm-ppc/sigcontext.h
--- 2.5.38/include/asm-ppc/sigcontext.h	2002-09-21 16:54:02.000000000 +1000
+++ 2.5.38-sigcontext/include/asm-ppc/sigcontext.h	2002-09-25 16:54:58.000000000 +1000
@@ -4,7 +4,7 @@
 #include <asm/ptrace.h>
 
 
-struct sigcontext_struct {
+struct sigcontext {
 	unsigned long	_unused[4];
 	int		signal;
 	unsigned long	handler;
diff -ruN 2.5.38/include/asm-ppc/ucontext.h 2.5.38-sigcontext/include/asm-ppc/ucontext.h
--- 2.5.38/include/asm-ppc/ucontext.h	2002-09-21 16:54:02.000000000 +1000
+++ 2.5.38-sigcontext/include/asm-ppc/ucontext.h	2002-09-25 16:55:12.000000000 +1000
@@ -7,7 +7,7 @@
 	unsigned long	  uc_flags;
 	struct ucontext  *uc_link;
 	stack_t		  uc_stack;
-	struct sigcontext_struct uc_mcontext;
+	struct sigcontext uc_mcontext;
 	sigset_t	  uc_sigmask;	/* mask last for extensibility */
 };
 
diff -ruN 2.5.38/include/asm-ppc64/ppc32.h 2.5.38-sigcontext/include/asm-ppc64/ppc32.h
--- 2.5.38/include/asm-ppc64/ppc32.h	2002-02-20 14:13:20.000000000 +1100
+++ 2.5.38-sigcontext/include/asm-ppc64/ppc32.h	2002-09-25 17:05:04.000000000 +1000
@@ -212,7 +212,7 @@
 	unsigned int   st_ctime;
 };
 
-struct sigcontext32_struct {
+struct sigcontext32 {
 	unsigned int	_unused[4];
 	int		signal;
 	unsigned int	handler;
@@ -224,7 +224,7 @@
 	unsigned int	  uc_flags;
 	unsigned int 	  uc_link;
 	stack_32_t	  uc_stack;
-	struct sigcontext32_struct uc_mcontext;
+	struct sigcontext32 uc_mcontext;
 	sigset_t	  uc_sigmask;	/* mask last for extensibility */
 };
 
diff -ruN 2.5.38/include/asm-ppc64/sigcontext.h 2.5.38-sigcontext/include/asm-ppc64/sigcontext.h
--- 2.5.38/include/asm-ppc64/sigcontext.h	2002-02-20 14:13:20.000000000 +1100
+++ 2.5.38-sigcontext/include/asm-ppc64/sigcontext.h	2002-09-25 16:55:28.000000000 +1000
@@ -10,7 +10,7 @@
 
 #include <asm/ptrace.h>
 
-struct sigcontext_struct {
+struct sigcontext {
 	unsigned long	_unused[4];
 	int		signal;
 	unsigned long	handler;
diff -ruN 2.5.38/include/asm-ppc64/ucontext.h 2.5.38-sigcontext/include/asm-ppc64/ucontext.h
--- 2.5.38/include/asm-ppc64/ucontext.h	2002-02-20 14:13:20.000000000 +1100
+++ 2.5.38-sigcontext/include/asm-ppc64/ucontext.h	2002-09-25 16:55:36.000000000 +1000
@@ -13,7 +13,7 @@
 	unsigned long	  uc_flags;
 	struct ucontext  *uc_link;
 	stack_t		  uc_stack;
-	struct sigcontext_struct uc_mcontext;
+	struct sigcontext uc_mcontext;
 	sigset_t	  uc_sigmask;	/* mask last for extensibility */
 };
 
