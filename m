Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268218AbTALD6w>; Sat, 11 Jan 2003 22:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268221AbTALD6w>; Sat, 11 Jan 2003 22:58:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29190 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268218AbTALD6g>; Sat, 11 Jan 2003 22:58:36 -0500
Date: Sat, 11 Jan 2003 20:02:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Derek Atkins <warlord@MIT.EDU>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Linus BK tree crashes with PANIC: INIT: segmentation violation
In-Reply-To: <sjm1y3j3znw.fsf@kikki.mit.edu>
Message-ID: <Pine.LNX.4.44.0301111953060.1401-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jan 2003, Derek Atkins wrote:
> 
> The 'String of oopses' was a red herring.  It was fixed sometime in early
> January.  The PANIC: INIT: problem, however, is real, and was introduced
> by the following ChangeSet on January 7:
> 
> D 1.972 03/01/07 10:08:55-08:00 torvalds@home.transmeta.com 15824 15815 2/0/1
> P ChangeSet
> C Move x86 signal handler return stub to the vsyscall page,
> C and stop honoring the SA_RESTORER information.
> C 
> C This will prepare us for alternate signal handler returns.

Interesting.

I was afraid that somebody would actually be _using_ the SA_RESTORER thing 
for some totally private version of signal handler return, but I was 
hoping that wouldn't be the case.

SA_RESTORER was always a bit broken.. The functionality can trivially be
restored (suggested untested patch appended), since it makes it very hard
to improve on signal handling, since old binaries that use SA_RESTORER
will force our hand.

Oh, well. Can you verify whether this fixes it for you? And thanks for 
hunting down the exact changeset.

Btw, what version of "init" are you running? It would be interesting to 
see what it actually does, and obviously none of the machines I have 
around have that init.. 

		Linus

----
===== arch/i386/kernel/signal.c 1.25 vs edited =====
--- 1.25/arch/i386/kernel/signal.c	Tue Jan  7 10:08:52 2003
+++ edited/arch/i386/kernel/signal.c	Sat Jan 11 19:59:57 2003
@@ -350,6 +350,7 @@
 static void setup_frame(int sig, struct k_sigaction *ka,
 			sigset_t *set, struct pt_regs * regs)
 {
+	void *restorer;
 	struct sigframe *frame;
 	int err = 0;
 
@@ -378,8 +379,12 @@
 	if (err)
 		goto give_sigsegv;
 
+	restorer = (void *) (fix_to_virt(FIX_VSYSCALL) + 32);
+	if (ka->sa.sa_flags & SA_RESTORER)
+		restorer = ka->sa.sa_restorer;
+
 	/* Set up to return from userspace.  */
-	err |= __put_user(fix_to_virt(FIX_VSYSCALL) + 32, &frame->pretcode);
+	err |= __put_user(restorer, &frame->pretcode);
 	 
 	/*
 	 * This is popl %eax ; movl $,%eax ; int $0x80
@@ -422,6 +427,7 @@
 static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
 			   sigset_t *set, struct pt_regs * regs)
 {
+	void *restorer;
 	struct rt_sigframe *frame;
 	int err = 0;
 
@@ -456,7 +462,10 @@
 		goto give_sigsegv;
 
 	/* Set up to return from userspace.  */
-	err |= __put_user(fix_to_virt(FIX_VSYSCALL) + 64, &frame->pretcode);
+	restorer = (void *) (fix_to_virt(FIX_VSYSCALL) + 64);
+	if (ka->sa.sa_flags & SA_RESTORER)
+		restorer = ka->sa.sa_restorer;
+	err |= __put_user(restorer, &frame->pretcode);
 	 
 	/*
 	 * This is movl $,%eax ; int $0x80

