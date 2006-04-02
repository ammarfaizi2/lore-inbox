Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWDBKWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWDBKWb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 06:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWDBKWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 06:22:30 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:48842 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932306AbWDBKWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 06:22:30 -0400
Date: Sun, 2 Apr 2006 13:23:50 +0300
From: Dan Aloni <da-x@monatomic.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: Keith Owens <kaos@sgi.com>, Nathan Scott <nathans@sgi.com>,
       kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Announce: kdb v4.4 is available for kernel 2.6.16
Message-ID: <20060402102350.GA4671@localdomain>
References: <28258.1142920764@kao2.melbourne.sgi.com> <20060401170430.GA14715@localdomain> <20060401234313.GA22482@tsunami.ccur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060401234313.GA22482@tsunami.ccur.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 06:43:13PM -0500, Joe Korty wrote:
> On Sat, Apr 01, 2006 at 08:04:30PM +0300, Dan Aloni wrote:
> > > Current versions are :-
> > > 
> > >   kdb-v4.4-2.6.16-common-1.bz2
> > >   kdb-v4.4-2.6.16-i386-1.bz2
> > >   kdb-v4.4-2.6.16-ia64-1.bz2
> > 
> > Thanks for this new version, however I'm looking forward to see
> > kdb maintained also for the x86_64 architecture. Currently I have 
> > got as far as forward-porting it to a level where it "works" except 
> > for one annoying issue where setjmp/longjmp looks to be broken:
> 
> Problem is due to the mixed C/asm implementation of setjmp/longjmp.
> Replace that with one written entirely in assemply and it will work.
> Here's mine:

Thanks, it's obviously a better way to do it, I've tested it and 
made it into a patch:

diff --git a/arch/x86_64/kdb/kdbasupport.c b/arch/x86_64/kdb/kdbasupport.c
index 57c2a72..1be4909 100644
--- a/arch/x86_64/kdb/kdbasupport.c
+++ b/arch/x86_64/kdb/kdbasupport.c
@@ -1029,71 +1029,41 @@ kdba_clearsinglestep(struct pt_regs *reg
 		regs->eflags &= ~EF_IE;
 }
 
-#ifdef KDB_HAVE_LONGJMP
-int asmlinkage
-kdba_setjmp(kdb_jmp_buf *jb)
-{
-#if defined(CONFIG_FRAME_POINTER)
-	__asm__("movq %rbx, (0*8)(%rdi);"
-		"movq %rbp, (1*8)(%rdi);"
-		"movq %r12, (2*8)(%rdi);"
-		"movq %r13, (3*8)(%rdi);"
-		"movq %r14, (4*8)(%rdi);"
-		"movq %r15, (5*8)(%rdi);"
-		"leaq 16(%rsp), %rdx;"
-		"movq %rdx, (6*8)(%rdi);"
-		"movq (%rsp), %rax;"
-		"movq %rax, (7*8)(%rdi)");
-#else	 /* CONFIG_FRAME_POINTER */
-	__asm__("movq %rbx, (0*8)(%rdi);"
-		"movq %rbp, (1*8)(%rdi);"
-		"movq %r12, (2*8)(%rdi);"
-		"movq %r13, (3*8)(%rdi);"
-		"movq %r14, (4*8)(%rdi);"
-		"movq %r15, (5*8)(%rdi);"
-		"leaq 8(%rsp), %rdx;"
-		"movq %rdx, (6*8)(%rdi);"
-		"movq (%rsp), %rax;"
-		"movq %rax, (7*8)(%rdi)");
-#endif   /* CONFIG_FRAME_POINTER */
-	KDB_STATE_SET(LONGJMP);
-	return 0;
-}
-
-void asmlinkage
-kdba_longjmp(kdb_jmp_buf *jb, int reason)
-{
-#if defined(CONFIG_FRAME_POINTER)
-	__asm__("movq (0*8)(%rdi),%rbx;"
-		"movq (1*8)(%rdi),%rbp;"
-		"movq (2*8)(%rdi),%r12;"
-		"movq (3*8)(%rdi),%r13;"
-		"movq (4*8)(%rdi),%r14;"
-		"movq (5*8)(%rdi),%r15;"
-		"test %esi,%esi;"
-		"mov $01,%eax;"
-		"cmove %eax,%esi;"
-		"mov %esi, %eax;"
-		"movq (7*8)(%rdi),%rdx;"
-		"movq (6*8)(%rdi),%rsp;"
-		"jmpq *%rdx");
-#else    /* CONFIG_FRAME_POINTER */
-	__asm__("movq (0*8)(%rdi),%rbx;"
-		"movq (1*8)(%rdi),%rbp;"
-		"movq (2*8)(%rdi),%r12;"
-		"movq (3*8)(%rdi),%r13;"
-		"movq (4*8)(%rdi),%r14;"
-		"movq (5*8)(%rdi),%r15;"
-		"test %esi,%esi;"
-		"mov $01,%eax;"
-		"cmove %eax,%esi;"
-		"mov %esi, %eax;"
-		"movq (7*8)(%rdi),%rdx;"
-		"movq (6*8)(%rdi),%rsp;"
-		"jmpq *%rdx");
-#endif	 /* CONFIG_FRAME_POINTER */
-}
-#endif	/* KDB_HAVE_LONGJMP */
+asm(
+"        .section .text\n"
+"        .globl  kdba_setjmp\n"
+"        .p2align 4\n"
+"kdba_setjmp:\n"
+"        movq    %rbx,0x0(%rdi)\n"
+"        movq    %rbp,0x8(%rdi)\n"
+"        movq    %r12,0x10(%rdi)\n"
+"        movq    %r13,0x18(%rdi)\n"
+"        movq    %r14,0x20(%rdi)\n"
+"        movq    %r15,0x28(%rdi)\n"
+"        leaq    0x8(%rsp),%rdx\n"
+"        movq    %rdx,0x30(%rdi)\n"
+"        movq    (%rsp),%rax\n"
+"        movq    %rax,0x38(%rdi)\n"
+"        xorq    %rax,%rax\n"
+"        ret\n"
+"           \n"
+"        .globl  kdba_longjmp\n"
+"kdba_longjmp:\n"
+"        movq    0x0(%rdi),%rbx\n"
+"        movq    0x8(%rdi),%rbp\n"
+"        movq    0x10(%rdi),%r12\n"
+"        movq    0x18(%rdi),%r13\n"
+"        movq    0x20(%rdi),%r14\n"
+"        movq    0x28(%rdi),%r15\n"
+"        test    %esi,%esi\n"
+"        mov     $1,%eax\n"
+"        cmove   %eax,%esi\n"
+"        mov     %esi,%eax\n"
+"        movq    0x38(%rdi),%rdx\n"
+"        movq    0x30(%rdi),%rsp\n"
+"        jmpq    *%rdx\n"
+"        .previous\n"
+);
 
 /*
  * kdba_enable_lbr


-- 
Dan Aloni, Linux specialist
XIV LTD, http://www.xivstorage.com
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
