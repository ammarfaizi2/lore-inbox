Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVIMUss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVIMUss (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVIMUss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:48:48 -0400
Received: from mail.servus.at ([193.170.194.20]:38156 "EHLO mail.servus.at")
	by vger.kernel.org with ESMTP id S932489AbVIMUso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:48:44 -0400
Message-ID: <43273CB3.7090200@oberhumer.com>
Date: Tue, 13 Sep 2005 22:55:15 +0200
From: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] i386: fix stack alignment for signal handlers
X-no-Archive: yes
X-Oberhumer-Conspiracy: There is no conspiracy. Trust us.
Content-Type: multipart/mixed;
 boundary="------------070507060005030402050902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070507060005030402050902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH] i386: fix stack alignment for signal handlers

It seems that the current signal code always sets up a stack frame so that
signal handlers are run with a somewhat mis-aligned stack, i.e. (esp % 8 == 4).

While this is not an i386 ABI requirement we really would like to have at
least a 8-byte alignment (e.g. when using doubles or other floating point
stuff). Furthermore, as recent gcc versions default to
-mpreferred-stack-boundary=4, this patch assures a 16-byte alignment.

Signed-off-by: Markus F.X.J. Oberhumer <markus@oberhumer.com>


Please try the small attached user-space test program and please also
carefully review the patch below - I don't do much kernel hacking...

~Markus

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/



--------------070507060005030402050902
Content-Type: text/plain;
 name="test_sigframe_alignment.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_sigframe_alignment.c"

/* test signal stack alignment (sigframe) */
/* Markus F.X.J. Oberhumer <markus@oberhumer.com> */

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

volatile unsigned long signal_sp = 0;

#if defined(__x86_64__)
/* amd64: signal stack is properly aligned */
asm(
    ".text\n .align 16\n"
"my_sighandler:\n"
    "lea 8(%rsp),%rax\n"
    "movq %rax,(signal_sp)\n"
    "retq\n"
);
#elif defined(__i386__)
/* i386: signal stack is always mis-aligned to 4-bytes */
asm(
    ".text\n .align 16\n"
"my_sighandler:\n"
    "lea 4(%esp),%eax\n"
    "movl %eax,(signal_sp)\n"
    "ret\n"
);
#else
#error "arch not supported - please insert your code here"
#endif


#if defined(__cplusplus)
extern "C"
#endif
void my_sighandler(int);


int main()
{
    int signo = SIGUSR1;

#if 1
    /* randomize stack */
    void * volatile dummy = NULL;
    srand((unsigned)clock() % RAND_MAX);
    dummy = __builtin_alloca(rand() % 2048ul);
#endif

    signal_sp = 0;
    signal(signo, my_sighandler);
    raise(signo);
    printf("sp = 0x%lx  alignment = %lu\n", signal_sp, signal_sp & 15);
    if (signal_sp & 15)
        printf("  error: signal stack not aligned\n");

    return 0;
}


/* vim:set ts=4 et: */



--------------070507060005030402050902
Content-Type: text/x-patch;
 name="i386-align_sigframe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-align_sigframe.patch"

[PATCH] i386: fix stack alignment for signal handlers

It seems that the current signal code always sets up a stack frame
so that signal handlers are run with a somewhat mis-aligned stack,
i.e. (esp % 8 == 4).

While this is not an i386 ABI requirement we really would like to have
at least a 8-byte alignment (e.g. when using doubles or other floating
point stuff). Furthermore, as recent gcc versions default to
-mpreferred-stack-boundary=4, this patch assures a 16-byte alignment.

Signed-off-by: Markus F.X.J. Oberhumer <markus@oberhumer.com>


Index: linux-2.6.git/arch/i386/kernel/signal.c
===================================================================
--- linux-2.6.git.orig/arch/i386/kernel/signal.c
+++ linux-2.6.git/arch/i386/kernel/signal.c
@@ -338,7 +338,7 @@
 		esp = (unsigned long) ka->sa.sa_restorer;
 	}
 
-	return (void __user *)((esp - frame_size) & -8ul);
+	return (void __user *)((esp - frame_size) & -16ul);
 }
 
 /* These symbols are defined with the addresses in the vsyscall page.
@@ -354,7 +354,7 @@
 	int err = 0;
 	int usig;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka, regs, sizeof(*frame)) - 4;
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
@@ -444,7 +444,7 @@
 	int err = 0;
 	int usig;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka, regs, sizeof(*frame)) - 4;
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
Index: linux-2.6.git/arch/x86_64/ia32/ia32_signal.c
===================================================================
--- linux-2.6.git.orig/arch/x86_64/ia32/ia32_signal.c
+++ linux-2.6.git/arch/x86_64/ia32/ia32_signal.c
@@ -425,7 +425,7 @@
 		rsp = (unsigned long) ka->sa.sa_restorer;
 	}
 
-	return (void __user *)((rsp - frame_size) & -8UL);
+	return (void __user *)((rsp - frame_size) & -16UL);
 }
 
 int ia32_setup_frame(int sig, struct k_sigaction *ka,
@@ -434,7 +434,7 @@
 	struct sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka, regs, sizeof(*frame)) - 4;
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;
@@ -527,7 +527,7 @@
 	struct rt_sigframe __user *frame;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka, regs, sizeof(*frame)) - 4;
 
 	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto give_sigsegv;



--------------070507060005030402050902--
