Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVJIQxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVJIQxW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 12:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVJIQxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 12:53:21 -0400
Received: from mail.servus.at ([193.170.194.20]:34308 "EHLO mail.servus.at")
	by vger.kernel.org with ESMTP id S932133AbVJIQxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 12:53:21 -0400
Message-ID: <43494B3F.5070303@oberhumer.com>
Date: Sun, 09 Oct 2005 18:54:23 +0200
From: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1.centos4 (X11/20051007)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
References: <43273CB3.7090200@oberhumer.com> <Pine.LNX.4.58.0509131542510.26803@g5.osdl.org> <4327611D.7@oberhumer.com> <Pine.LNX.4.58.0509131649060.26803@g5.osdl.org> <20050914142204.GA19731@nevyn.them.org> <Pine.LNX.4.58.0509140753260.26803@g5.osdl.org> <20050914154425.GM11338@wotan.suse.de>
In-Reply-To: <20050914154425.GM11338@wotan.suse.de>
X-no-Archive: yes
X-Oberhumer-Conspiracy: There is no conspiracy. Trust us.
Content-Type: multipart/mixed;
 boundary="------------090708010202040909070303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090708010202040909070303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
> On Wed, Sep 14, 2005 at 07:55:53AM -0700, Linus Torvalds wrote:
>>
>>On Wed, 14 Sep 2005, Daniel Jacobowitz wrote:
>>
>>>The comment for the relevant bits of the GCC configuration says it won't
>>>assume this for x86, but I believe that comment is out of date. I think
>>>it'll assume 16-byte alignment on entrance to non-main() functions.
>>
>>Well, that's kind of the point. We _do_ have the stack aligned on
>>entrance, but it looks like gcc wants it _non-aligned_. It seems to want
>>it offset by the "return address push" - ie it seems to expect that it was
>>aligned before the "call", but entry into the next function will thus
>>_never_ be aligned.
>>
>>So the kernel actually seems to have it _too_ aligned right now. 
> 
> 
> Yes it's wrong. I would recommend to apply Markus' patch for i386
> and x86-64.
> 
> -Andi

Here is a somewhat simplified version of my previous patch with
updated comments.

Attached is also a new small user-space test program which does not
depend on any special gcc features and should trigger the problem on all 
machines.

~Markus

P.S. I have not been involved in lkml back since 1999, so I currently don't 
know whom to bug to get this patch applied, esp. as there seems to be no 
official i386 maintainer.

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/

--------------090708010202040909070303
Content-Type: text/x-patch;
 name="i386-align_sigframe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-align_sigframe.patch"

[PATCH] i386: fix stack alignment for signal handlers

This patches fixes the setup of the alignment of the signal frame, so
that all signal handlers are run with a properly aligned stack frame.

The current code "over-aligns" the stack pointer so that the stack
frame is effectively always mis-aligned by 4 bytes. But what we really
want is that on function entry ((sp + 4) & 15) == 0.


Signed-off-by: Markus F.X.J. Oberhumer <markus@oberhumer.com>


 arch/i386/kernel/signal.c      |    6 +++++-
 arch/x86_64/ia32/ia32_signal.c |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

Index: linux-2.6.git/arch/i386/kernel/signal.c
===================================================================
--- linux-2.6.git.orig/arch/i386/kernel/signal.c
+++ linux-2.6.git/arch/i386/kernel/signal.c
@@ -338,7 +338,11 @@
 		esp = (unsigned long) ka->sa.sa_restorer;
 	}
 
-	return (void __user *)((esp - frame_size) & -8ul);
+	esp -= frame_size;
+	/* Align the stack pointer according to the i386 ABI,
+	 * i.e. so that on function entry ((sp + 4) & 15) == 0. */
+	esp = ((esp + 4) & -16ul) - 4;
+	return (void __user *) esp;
 }
 
 /* These symbols are defined with the addresses in the vsyscall page.
Index: linux-2.6.git/arch/x86_64/ia32/ia32_signal.c
===================================================================
--- linux-2.6.git.orig/arch/x86_64/ia32/ia32_signal.c
+++ linux-2.6.git/arch/x86_64/ia32/ia32_signal.c
@@ -425,7 +425,11 @@
 		rsp = (unsigned long) ka->sa.sa_restorer;
 	}
 
-	return (void __user *)((rsp - frame_size) & -8UL);
+	rsp -= frame_size;
+	/* Align the stack pointer according to the i386 ABI,
+	 * i.e. so that on function entry ((sp + 4) & 15) == 0. */
+	rsp = ((rsp + 4) & -16ul) - 4;
+	return (void __user *) rsp;
 }
 
 int ia32_setup_frame(int sig, struct k_sigaction *ka,

--------------090708010202040909070303
Content-Type: text/plain;
 name="test_sigframe_alignment.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_sigframe_alignment.c"

/* test signal stack alignment (sigframe)
 *
 * a small user-space demo program to show that the signal stack
 * is currently mis-aligned on i386-linux
 *
 * Markus F.X.J. Oberhumer <markus@oberhumer.com>
 */

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

void sighandler(int);
void test(void);

volatile unsigned long sp = 0;

/* assembler prologue code that stores the stack pointer into 'sp'
 * and then jumps to the real function */
#if defined(__i386__)
asm(
    ".text\n"
"sighandler:\n"
    "lea    4(%esp), %eax\n"
    "mov    %eax, (sp)\n"
    "jmp    do_sighandler\n"
"test:\n"
    "lea    4(%esp), %eax\n"
    "mov    %eax, (sp)\n"
    "jmp    do_test\n"
".globl main\n"
"main:\n"
    "lea    4(%esp), %eax\n"
    "mov    %eax, (sp)\n"
    "jmp    do_main\n"
);
#elif defined(__x86_64__)
asm(
    ".text\n"
"sighandler:\n"
    "lea    8(%rsp), %rax\n"
    "mov    %rax, sp(%rip)\n"
    "jmp    do_sighandler\n"
"test:\n"
    "lea    8(%rsp), %rax\n"
    "mov    %rax, sp(%rip)\n"
    "jmp    do_test\n"
".globl main\n"
"main:\n"
    "lea    8(%rsp), %rax\n"
    "mov    %rax, sp(%rip)\n"
    "jmp    do_main\n"
);
#else
#error "arch not supported - please insert your code here"
#endif


void do_sighandler(void)
{
    printf("in sighandler: sp = 0x%lx\n", sp);
}

void do_test(void)
{
    printf("in test      : sp = 0x%lx\n", sp);
    signal(SIGUSR1, sighandler);
    raise(SIGUSR1);
}

int do_main(void)
{
    printf("in main      : sp = 0x%lx\n", sp);
    test();
    printf("All done.\n");
    return 0;
}


/* vim:set ts=4 et: */

--------------090708010202040909070303--
