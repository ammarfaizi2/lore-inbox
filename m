Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWFSM0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWFSM0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWFSMZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60349 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932403AbWFSMZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:09 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 03/15] frv: signal annotations
Date: Mon, 19 Jun 2006 13:24:50 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122450.10060.98183.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Add annotations to the FRV signal handling for sparse.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/signal.c |   20 ++++++++++----------
 include/asm-frv/signal.h |    6 +++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/frv/kernel/signal.c b/arch/frv/kernel/signal.c
index 679c1d5..dd5e6fd 100644
--- a/arch/frv/kernel/signal.c
+++ b/arch/frv/kernel/signal.c
@@ -98,7 +98,7 @@ int sys_sigaltstack(const stack_t __user
 
 struct sigframe
 {
-	void (*pretcode)(void);
+	__sigrestore_t pretcode;
 	int sig;
 	struct sigcontext sc;
 	unsigned long extramask[_NSIG_WORDS-1];
@@ -107,10 +107,10 @@ struct sigframe
 
 struct rt_sigframe
 {
-	void (*pretcode)(void);
+	__sigrestore_t pretcode;
 	int sig;
-	struct siginfo *pinfo;
-	void *puc;
+	struct siginfo __user *pinfo;
+	void __user *puc;
 	struct siginfo info;
 	struct ucontext uc;
 	uint32_t retcode[2];
@@ -284,7 +284,7 @@ static int setup_frame(int sig, struct k
 		 *	setlos	#__NR_sigreturn,gr7
 		 *	tira	gr0,0
 		 */
-		if (__put_user((void (*)(void))frame->retcode, &frame->pretcode) ||
+		if (__put_user((__sigrestore_t)frame->retcode, &frame->pretcode) ||
 		    __put_user(0x8efc0000|__NR_sigreturn, &frame->retcode[0]) ||
 		    __put_user(0xc0700000, &frame->retcode[1]))
 			goto give_sigsegv;
@@ -300,7 +300,7 @@ static int setup_frame(int sig, struct k
 
 	if (get_personality & FDPIC_FUNCPTRS) {
 		struct fdpic_func_descriptor __user *funcptr =
-			(struct fdpic_func_descriptor *) ka->sa.sa_handler;
+			(struct fdpic_func_descriptor __user *) ka->sa.sa_handler;
 		__get_user(__frame->pc, &funcptr->text);
 		__get_user(__frame->gr15, &funcptr->GOT);
 	} else {
@@ -359,8 +359,8 @@ static int setup_rt_frame(int sig, struc
 
 	/* Create the ucontext.  */
 	if (__put_user(0, &frame->uc.uc_flags) ||
-	    __put_user(0, &frame->uc.uc_link) ||
-	    __put_user((void*)current->sas_ss_sp, &frame->uc.uc_stack.ss_sp) ||
+	    __put_user(NULL, &frame->uc.uc_link) ||
+	    __put_user((void __user *)current->sas_ss_sp, &frame->uc.uc_stack.ss_sp) ||
 	    __put_user(sas_ss_flags(__frame->sp), &frame->uc.uc_stack.ss_flags) ||
 	    __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size))
 		goto give_sigsegv;
@@ -382,7 +382,7 @@ static int setup_rt_frame(int sig, struc
 		 *	setlos	#__NR_sigreturn,gr7
 		 *	tira	gr0,0
 		 */
-		if (__put_user((void (*)(void))frame->retcode, &frame->pretcode) ||
+		if (__put_user((__sigrestore_t)frame->retcode, &frame->pretcode) ||
 		    __put_user(0x8efc0000|__NR_rt_sigreturn, &frame->retcode[0]) ||
 		    __put_user(0xc0700000, &frame->retcode[1]))
 			goto give_sigsegv;
@@ -398,7 +398,7 @@ static int setup_rt_frame(int sig, struc
 	__frame->gr9 = (unsigned long) &frame->info;
 
 	if (get_personality & FDPIC_FUNCPTRS) {
-		struct fdpic_func_descriptor *funcptr =
+		struct fdpic_func_descriptor __user *funcptr =
 			(struct fdpic_func_descriptor __user *) ka->sa.sa_handler;
 		__get_user(__frame->pc, &funcptr->text);
 		__get_user(__frame->gr15, &funcptr->GOT);
diff --git a/include/asm-frv/signal.h b/include/asm-frv/signal.h
index 6736689..dcc1b35 100644
--- a/include/asm-frv/signal.h
+++ b/include/asm-frv/signal.h
@@ -114,13 +114,13 @@ struct old_sigaction {
 	__sighandler_t sa_handler;
 	old_sigset_t sa_mask;
 	unsigned long sa_flags;
-	void (*sa_restorer)(void);
+	__sigrestore_t sa_restorer;
 };
 
 struct sigaction {
 	__sighandler_t sa_handler;
 	unsigned long sa_flags;
-	void (*sa_restorer)(void);
+	__sigrestore_t sa_restorer;
 	sigset_t sa_mask;		/* mask last for extensibility */
 };
 
@@ -146,7 +146,7 @@ #define sa_sigaction	_u._sa_sigaction
 #endif /* __KERNEL__ */
 
 typedef struct sigaltstack {
-	void *ss_sp;
+	void __user *ss_sp;
 	int ss_flags;
 	size_t ss_size;
 } stack_t;

