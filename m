Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269218AbUIRK6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269218AbUIRK6E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 06:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269228AbUIRK6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 06:58:04 -0400
Received: from mail.aknet.ru ([217.67.122.194]:7443 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S269218AbUIRK5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 06:57:53 -0400
Message-ID: <414C14CD.7030200@aknet.ru>
Date: Sat, 18 Sep 2004 14:58:21 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <4149D243.5050501@aknet.ru> <200409162203.17988.vda@port.imtp.ilyichevsk.odessa.ua> <414B2949.700@aknet.ru> <200409180104.09796.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409180104.09796.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: multipart/mixed;
 boundary="------------010600080604030906030700"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010600080604030906030700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Denis Vlasenko wrote:
>> This is what happens: CPU is doing IRET in 32bit mode.
>> Stack layout:
> +20 (empty) <--- SS:ESP
> +16 old_CS
> +12 old_EIP
>  +8 old_EFLAGS
>  +4 old_SS
>  +0 old_ESP
JFYI, looks like you swapped CS<-->EIP and SS<-->ESP
on your stack frame layout.
 
> If old_SS references 'small' data segment (16-bit one),
> processor does not restore ESP from old_ESP.
> It restores lower 16 bits only. Upper 16 bits are filled
> with garbage (or just not modified at all?).
Not modified at all, yes. That's why it is always
greater than TASK_SIZE (0xc0000000) - it is still
in a kernel space.

> This works fine because processor uses SP, not ESP,
> for subsequent push/pop/call/ret operations.
> But if code uses full ESP, thinking that upper 16 bits are zero,
> it will crash badly. Correct me if I'm wrong.
That's correct. But you should note that the
program not just "thinks" that the upper 16 bits
are zero. It writes zero there itself, and a few
instructions later - oops, it is no longer zero...
My test-case does "hlt" to force the context switch,
but in fact it is not necessary. I tried an
empty loop instead of HLT. If the loop is long
enough and some IRQ being handled by the kernel
in a mean time, the ESP is corrupted. So the
user-space never knows when exactly it gets corrupted.
And, as I mentioned already, since the code is 32bit,
it just does the things like "mov ebp,esp" and
uses ebp to access the function params and locals,
which crashes, or uses ESP directly to access
something, etc.

> Hmm. I think you need to *emulate* this IRET.
> Is this IRET happens in kernel or in dosemu code?
The problem happens only when iret is used to
switch to another priv level. So it is the kernel's
iret of course, something to the effect of entry.S:128
I think. The control is transferred from kernel code
to the DOS code directly. dosemu code is completely
bypassed. dosemu have no chances to intercept that.
The DOS program is running on its own (as long as
it doesn't trigger an exception, or SIGALRM comes),
and the CPU is corrupting its ESP in *any* place,
since it happens when an external IRQ arrives.

>> That's strange indeed! Apparently your ESP value,
>> 0xccf1fb10, is greater than 0xc0000000, in which
>> case my program should just write "BUG!", but for
>> you it doesn't. Haven't you altered the code
>> somehow?
> No, I didn't alter anything. Strange indeed.
So that proves that writing the bug-free code, esp.
when the asm is involved, is not always as easy as
I assume...

> I am thoroughly confused now. Two back-to-back
> 'printf("Now sp=%08lx\n", new_esp);'
> gave different result.  How this can happen??
My code did the assumption that the ESP should
not change within the execution of main(). This
is true only if you don't enable the optimization
(as I did), or use -fno-defer-pop option of gcc.
Fixed code is attached (just for the overall
completeness:) Should survive the optimization now.


--------------010600080604030906030700
Content-Type: text/x-csrc;
 name="stk1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stk1.c"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <signal.h>
#include <linux/unistd.h>
#include <asm/ldt.h>
#include <asm/ucontext.h>

unsigned char stack[65536];

void my_segv(int signum, siginfo_t *info, void *c)
{
  struct sigcontext *ctx = &((struct ucontext *)c)->uc_mcontext;
  printf("In sighandler: esp=%lx\n", ctx->esp);
  /* Skip HLT */
  ctx->eip++;
}

_syscall3(int, modify_ldt, int, func, void *, ptr, unsigned long, bytecount)

static int set_ldt_entry(int entry, unsigned long base, unsigned int limit,
	      int seg_32bit_flag, int contents, int read_only_flag,
	      int limit_in_pages_flag, int seg_not_present, int useable)
{
  struct modify_ldt_ldt_s ldt_info;
  ldt_info.entry_number = entry;
  ldt_info.base_addr = base;
  ldt_info.limit = limit;
  ldt_info.seg_32bit = seg_32bit_flag;
  ldt_info.contents = contents;
  ldt_info.read_exec_only = read_only_flag;
  ldt_info.limit_in_pages = limit_in_pages_flag;
  ldt_info.seg_not_present = seg_not_present;
  ldt_info.useable = useable;

  return modify_ldt(1, &ldt_info, sizeof(ldt_info));
}

int main(int argc, char *argv[])
{
  unsigned short _ss, new_ss;
  unsigned long _esp, new_esp;
  int is32 = 0;
  stack_t sig_stack;
  struct sigaction sa;

  if (argc > 1 && !strncmp(argv[1], "32", 3))
    is32 = 1;

  sig_stack.ss_sp = stack;
  sig_stack.ss_flags = 0;
  sig_stack.ss_size = sizeof(stack);
  if (sigaltstack(&sig_stack, NULL)) {
    perror("sigaltstack()");
    return 1;
  }

  sa.sa_sigaction = my_segv;
  sigemptyset(&sa.sa_mask);
  sa.sa_flags = SA_ONSTACK | SA_SIGINFO;
  sigaction(SIGSEGV, &sa, NULL);

  /* Get SS */
  asm volatile(
    "movw %%ss, %0\n"
    :"=m"(_ss)
  );

  /* Force to LDT */
  new_ss = _ss | 4;
  /* Create the LDT entry */
  set_ldt_entry(new_ss >> 3, 0, 0xbffff, is32, MODIFY_LDT_CONTENTS_DATA, 0, 1, 0, 0);
  printf("old_ss=%#hx new_ss=%#hx\n", _ss, new_ss);

  /* Do the trick... Switch stack and then switch context. */
  asm volatile(
    "movl %%esp, %1\n"		/* Save ESP */
    "movw %2, %%ss\n"		/* Load our LDT selector to SS */
    "hlt\n"			/* Force the context switch */
    "movw %3, %%ss\n"		/* Restore SS ASAP */
    "movl %%esp, %0\n"		/* Get new ESP */
    "movl %1, %%esp\n"		/* Restore ESP */
    :"=m"(new_esp), "=a"(_esp)
    :"m"(new_ss), "m"(_ss)
  );
  printf("old_esp=%#lx new_esp=%#lx\n", _esp, new_esp);

  /* See what we've got... */
  if (new_esp > 0xc0000000) {
    printf("BUG!\n");
  } else if (new_esp != _esp) {
    printf("Esp changed, strange...\n");
  } else {
    printf("No bug here! What CPU is this?\n");
    if (!is32)
      system("cat /proc/cpuinfo");
  }
  return 0;
}

--------------010600080604030906030700--
