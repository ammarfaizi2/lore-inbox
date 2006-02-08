Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWBHHZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWBHHZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWBHHZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:25:31 -0500
Received: from mail8.hitachi.co.jp ([133.145.228.43]:51156 "EHLO
	mail8.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1161039AbWBHHZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:25:30 -0500
Message-ID: <43E99CD9.3000400@sdl.hitachi.co.jp>
Date: Wed, 08 Feb 2006 16:25:13 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>
CC: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       SystemTAP <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
Subject: Re: [PATCH] kretprobe: kretprobe-booster against 2.6.16-rc1  for
 i386
References: <200602071852_MC3-1-B7D8-BD57@compuserve.com>
In-Reply-To: <200602071852_MC3-1-B7D8-BD57@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chuck

Chuck Ebbert wrote:
> In-Reply-To: <43DE0A53.3060801@sdl.hitachi.co.jp>
> 
> On Mon, 30 Jan 2006 at 21:45:07 +0900, Masami Hiramatsu wrote:
> 
>> Here is a patch of the kretprobe-booster for i386 arch against
>> linux-2.6.16-rc1 and also appliable against 2.6.16-rc1-mm4.
> 
>> --- a/arch/i386/kernel/kprobes.c      2006-01-24 19:07:26.000000000 +0900
>> +++ b/arch/i386/kernel/kprobes.c      2006-01-30 18:40:12.000000000 +0900
>> @@ -255,17 +255,45 @@ no_kprobe:
>>   * here. When a retprobed function returns, this probe is hit and
>>   * trampoline_probe_handler() runs, calling the kretprobe's handler.
>>   */
>> - void kretprobe_trampoline_holder(void)
>> + void __kprobes kretprobe_trampoline_holder(void)
>>   {
>> -     asm volatile (  ".global kretprobe_trampoline\n"
>> +      asm volatile ( ".global kretprobe_trampoline\n"
>>                       "kretprobe_trampoline: \n"
>> -                     "nop\n");
>> - }
>> +                     "       subl $8, %esp\n"
> 
>         There is no need to reserve these 8 bytes; they wouldn't be
> there if INT3 were done from kernel space anyway.

OK, I agree.

>> +                     "       pushf\n"
>> +                     "       subl $20, %esp\n"
>> +                     "       pushl %eax\n"
>> +                     "       pushl %ebp\n"
>> +                     "       pushl %edi\n"
>> +                     "       pushl %esi\n"
>> +                     "       pushl %edx\n"
>> +                     "       pushl %ecx\n"
>> +                     "       pushl %ebx\n"
>> +                     "       movl %esp, %eax\n"
>> +                     "       pushl %eax\n"
> 
>         If you make trampoline_probe_handler "fastcall" you can just
> pass eax to the handler directly.

It is a nice idea.

>> +                     "       addl $60, %eax\n"
>> +                     "       movl %eax, 56(%esp)\n"
> 
>         No need for this either, since oldesp isn't there on INT3 call anyway. 

OK, I agree too.

>> +                     "       movl $trampoline_handler, %eax\n"
>> +                     "       call *%eax\n"
> 
>         Why not just "call trampoline_handler"?

I forgot to do so... thanks!

>> +                     "       addl $4, %esp\n"
>> +                     "       movl %eax, 56(%esp)\n"
>> +                     "       popl %ebx\n"
>> +                     "       popl %ecx\n"
>> +                     "       popl %edx\n"
>> +                     "       popl %esi\n"
>> +                     "       popl %edi\n"
>> +                     "       popl %ebp\n"
>> +                     "       popl %eax\n"
>> +                     "       addl $20, %esp\n"
>> +                     "       popf\n"
>> +                     "       addl $4, %esp\n"
> 
>         This "add" corrupts the flags you just popped from the stack.

Sure, this "add" may modify the status flags. It should be fixed.

> This can be fixed by moving the return address up 4 bytes on the stack
> and doing "ret 4" or by putting the address in regs->eip and just doing
> an "iret" to return to the caller.

Why would you like to use "iret"?
I worry about its negative side effects, because the "iret" is only for
interrupt handlers and may have some side effects.
In my honest opinion, this can be fixed by moving eflags to cs field,
putting the return address in eflags and using "ret".
I developed a patch and attach it to this mail.

This patch fixes and cleanups kretprobe-kretprobe-booster by:

          - Not reserving 8 bytes at stack bottom
          - Making trampoline_handler fastcall and calling it directly
          - Not changing the status flags

I'm very happy to be fixed it! Thank you very much for pointing it out!

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

Signed-off-by: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>

 kprobes.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)
diff -Narup a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
--- a/arch/i386/kernel/kprobes.c	2006-02-07 11:51:16.000000000 +0900
+++ b/arch/i386/kernel/kprobes.c	2006-02-08 16:05:35.000000000 +0900
@@ -325,8 +325,8 @@ no_kprobe:
  {
 	 asm volatile ( ".global kretprobe_trampoline\n"
  			"kretprobe_trampoline: \n"
-			"	subl $8, %esp\n"
 			"	pushf\n"
+			/* skip cs, eip, orig_eax, es, ds */
 			"	subl $20, %esp\n"
 			"	pushl %eax\n"
 			"	pushl %ebp\n"
@@ -336,13 +336,12 @@ no_kprobe:
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
+			/* move eflags to cs */
+			"	movl 48(%esp), %edx\n"
+			"	movl %edx, 44(%esp)\n"
+			/* save true return address on eflags */
+			"	movl %eax, 48(%esp)\n"
 			"	popl %ebx\n"
 			"	popl %ecx\n"
 			"	popl %edx\n"
@@ -350,16 +349,16 @@ no_kprobe:
 			"	popl %edi\n"
 			"	popl %ebp\n"
 			"	popl %eax\n"
-			"	addl $20, %esp\n"
+			/* skip eip, orig_eax, es, ds */
+			"	addl $16, %esp\n"
 			"	popf\n"
-			"	addl $4, %esp\n"
 			"	ret\n");
 }

 /*
  * Called from kretprobe_trampoline
  */
-asmlinkage void *__kprobes trampoline_handler(struct pt_regs *regs)
+fastcall void *__kprobes trampoline_handler(struct pt_regs *regs)
 {
         struct kretprobe_instance *ri = NULL;
         struct hlist_head *head;

