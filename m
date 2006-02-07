Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030295AbWBGXwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030295AbWBGXwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWBGXwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:52:50 -0500
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:50913 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030295AbWBGXwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:52:49 -0500
Date: Tue, 7 Feb 2006 18:49:13 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] kretprobe: kretprobe-booster against 2.6.16-rc1
  for i386
To: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
Cc: Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       SystemTAP <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
Message-ID: <200602071852_MC3-1-B7D8-BD57@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <43DE0A53.3060801@sdl.hitachi.co.jp>

On Mon, 30 Jan 2006 at 21:45:07 +0900, Masami Hiramatsu wrote:

> Here is a patch of the kretprobe-booster for i386 arch against
> linux-2.6.16-rc1 and also appliable against 2.6.16-rc1-mm4.

> --- a/arch/i386/kernel/kprobes.c      2006-01-24 19:07:26.000000000 +0900
> +++ b/arch/i386/kernel/kprobes.c      2006-01-30 18:40:12.000000000 +0900
> @@ -255,17 +255,45 @@ no_kprobe:
>   * here. When a retprobed function returns, this probe is hit and
>   * trampoline_probe_handler() runs, calling the kretprobe's handler.
>   */
> - void kretprobe_trampoline_holder(void)
> + void __kprobes kretprobe_trampoline_holder(void)
>   {
> -     asm volatile (  ".global kretprobe_trampoline\n"
> +      asm volatile ( ".global kretprobe_trampoline\n"
>                       "kretprobe_trampoline: \n"
> -                     "nop\n");
> - }
> +                     "       subl $8, %esp\n"

        There is no need to reserve these 8 bytes; they wouldn't be
there if INT3 were done from kernel space anyway.

> +                     "       pushf\n"
> +                     "       subl $20, %esp\n"
> +                     "       pushl %eax\n"
> +                     "       pushl %ebp\n"
> +                     "       pushl %edi\n"
> +                     "       pushl %esi\n"
> +                     "       pushl %edx\n"
> +                     "       pushl %ecx\n"
> +                     "       pushl %ebx\n"
> +                     "       movl %esp, %eax\n"
> +                     "       pushl %eax\n"

        If you make trampoline_probe_handler "fastcall" you can just
pass eax to the handler directly.

> +                     "       addl $60, %eax\n"
> +                     "       movl %eax, 56(%esp)\n"

        No need for this either, since oldesp isn't there on INT3 call anyway. 

> +                     "       movl $trampoline_handler, %eax\n"
> +                     "       call *%eax\n"

        Why not just "call trampoline_handler"?

> +                     "       addl $4, %esp\n"
> +                     "       movl %eax, 56(%esp)\n"
> +                     "       popl %ebx\n"
> +                     "       popl %ecx\n"
> +                     "       popl %edx\n"
> +                     "       popl %esi\n"
> +                     "       popl %edi\n"
> +                     "       popl %ebp\n"
> +                     "       popl %eax\n"
> +                     "       addl $20, %esp\n"
> +                     "       popf\n"
> +                     "       addl $4, %esp\n"

        This "add" corrupts the flags you just popped from the stack.
This can be fixed by moving the return address up 4 bytes on the stack
and doing "ret 4" or by putting the address in regs->eip and just doing
an "iret" to return to the caller.

> +                     "       ret\n");
> +}


Patch for 2.6.16-rc1-mm5 follows.


Fix and clean up kretprobe-kretprobe-booster by:

        - Not reserving 8 bytes at stack bottom
        - Making trampoline_handler fastcall and calling it directly
        - Using "iret" to return to original caller

Using "iret" is slightly slower than direct return; time went from 1030 CPU cycles
overhead per kretprobe to 1050 cycles (2%), but the code is cleaner.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/i386/kernel/kprobes.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

--- 2.6.16-rc1-mm5-386.orig/arch/i386/kernel/kprobes.c
+++ 2.6.16-rc1-mm5-386/arch/i386/kernel/kprobes.c
@@ -325,9 +325,10 @@ no_kprobe:
  {
 	 asm volatile ( ".global kretprobe_trampoline\n"
  			"kretprobe_trampoline: \n"
-			"	subl $8, %esp\n"
 			"	pushf\n"
-			"	subl $20, %esp\n"
+			"	pushl %cs\n"
+			/* skip eip, orig_eax, es, ds */
+			"	subl $16, %esp\n"
 			"	pushl %eax\n"
 			"	pushl %ebp\n"
 			"	pushl %edi\n"
@@ -336,13 +337,9 @@ no_kprobe:
 			"	pushl %ecx\n"
 			"	pushl %ebx\n"
 			"	movl %esp, %eax\n"
-			"	pushl %eax\n"
-			"	addl $60, %eax\n"
-			"	movl %eax, 56(%esp)\n"
-			"	movl $trampoline_handler, %eax\n"
-			"	call *%eax\n"
-			"	addl $4, %esp\n"
-			"	movl %eax, 56(%esp)\n"
+			"	call trampoline_handler\n"
+			/* save new eip */
+			"	movl %eax, 40(%esp)\n"
 			"	popl %ebx\n"
 			"	popl %ecx\n"
 			"	popl %edx\n"
@@ -350,16 +347,15 @@ no_kprobe:
 			"	popl %edi\n"
 			"	popl %ebp\n"
 			"	popl %eax\n"
-			"	addl $20, %esp\n"
-			"	popf\n"
-			"	addl $4, %esp\n"
-			"	ret\n");
+			/* skip ds, es, orig_eax */
+			"	addl $12, %esp\n"
+			"	iret\n");
 }
 
 /*
  * Called from kretprobe_trampoline
  */
-asmlinkage void *__kprobes trampoline_handler(struct pt_regs *regs)
+fastcall void *__kprobes trampoline_handler(struct pt_regs *regs)
 {
         struct kretprobe_instance *ri = NULL;
         struct hlist_head *head;
-- 
Chuck
