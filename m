Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269291AbUIQWKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbUIQWKL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269334AbUIQWJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:09:41 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:23304 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269065AbUIQWEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:04:25 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Stas Sergeev <stsp@aknet.ru>
Subject: Re: ESP corruption bug - what CPUs are affected?
Date: Sat, 18 Sep 2004 01:04:09 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <4149D243.5050501@aknet.ru> <200409162203.17988.vda@port.imtp.ilyichevsk.odessa.ua> <414B2949.700@aknet.ru>
In-Reply-To: <414B2949.700@aknet.ru>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Z91SBiPHf3npEWr"
Message-Id: <200409180104.09796.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Z91SBiPHf3npEWr
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 17 September 2004 21:13, Stas Sergeev wrote:
> Hello.
>
> Denis Vlasenko wrote:
> >> Which means that the higher word of ESP gets
> >> trashed. This bug beats dosemu rather badly,
> >> but there seem to be not much info about that
> >> bug available on the net.
> >
> > Well. Strictly speaking it's not a bug.
> > Code executes as it should. IRET returns to the correct
> > location. Upper 16 bits of ESP do not affect execution
> > in this case.
>
> Unfortunately this is not true. Mainly because
> the code is still 32bit, so when is operates with
> the stack pointer directly, it gets ESP, not SP.
> Here are a few examples from the real DOS progs:
> ---
> frstor  [esp]  <--crash
> ---
> push    ebp
> mov     ebp,esp
> mov     edx,[ebp+0x8]  <--crash
> ---

Hmmm. Let me dust off my i386 knwoledge.

This is what happens: CPU is doing IRET in 32bit mode.
Stack layout:

+20 (empty) <--- SS:ESP
+16 old_CS
+12 old_EIP
 +8 old_EFLAGS
 +4 old_SS
 +0 old_ESP
 
If old_SS references 'small' data segment (16-bit one),
processor does not restore ESP from old_ESP.
It restores lower 16 bits only. Upper 16 bits are filled
with garbage (or just not modified at all?).
This works fine because processor uses SP, not ESP,
for subsequent push/pop/call/ret operations.
But if code uses full ESP, thinking that upper 16 bits are zero,
it will crash badly. Correct me if I'm wrong.

> and there are much more. "mov ebp,esp" is just a
> standard thing, and then the ebp is being used to
> access the locals and function arguments. Why do
> they use the 16bit stack in that case, is another
> question. Unfortunately some of them do.

Hmm. I think you need to *emulate* this IRET.
Is this IRET happens in kernel or in dosemu code?

> > # gcc -O2 stk.c
> > # ./a.out
> > sp=0xbffffb30, ss=0x7b
> > In sighandler: esp=bffffb10
> > Now sp=0xccf1fb10, ss=0x7f
> > Esp changed, strange...
>
> That's strange indeed! Apparently your ESP value,
> 0xccf1fb10, is greater than 0xc0000000, in which
> case my program should just write "BUG!", but for
> you it doesn't. Haven't you altered the code
> somehow?

No, I didn't alter anything. Strange indeed.

> Why I compare it with 0xc0000000, is
> because ESP has the higher word of a kernel's stack
> address, so it should be above the TASK_SIZE when
> corrupted.

Even more strange! Now I did modify the code (attached),
and this is what I've got:

# gcc -o stk2 -O2 stk2.c
# ./stk2
sp=0xbffffb30, ss=0x7b
In sighandler: esp=bffffb10
Now sp=cd79fb10   <=========
Now sp=bffffb50   <========= !?
Now sp=bffffb50, ss=007f
Now sp=bffffb50
Now sp=bffffb50
Now sp=bffffb50
Esp changed, strange...

I am thoroughly confused now. Two back-to-back
'printf("Now sp=%08lx\n", new_esp);'
gave different result.  How this can happen??

Corresponding gcc -S code. new_esp is at -180(%ebp):

#APP
        movw -182(%ebp), %ss
hlt
movw -170(%ebp), %ss
movl %esp, -180(%ebp)
movl -176(%ebp), %esp

#NO_APP
        addl    $40, %esp
        pushl   -180(%ebp)
        pushl   $.LC4
        call    printf
        popl    %eax
        popl    %edx
        pushl   -180(%ebp)
        pushl   $.LC4
        call    printf
        addl    $12, %esp
        movzwl  -182(%ebp), %eax
        pushl   %eax
        pushl   -180(%ebp)
        pushl   $.LC5
        call    printf
        popl    %ecx
        popl    %ebx
        pushl   -180(%ebp)
        pushl   $.LC4
        call    printf
        popl    %eax
        popl    %edx

--
vda

--Boundary-00=_Z91SBiPHf3npEWr
Content-Type: text/x-csrc;
  charset="koi8-r";
  name="stk2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="stk2.c"

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

_syscall3(int, modify_ldt, int, func, void *, ptr, unsigned long, bytecount);

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

  /* Get SS, ESP */
  asm volatile(
    "movw %%ss, %0\n"
    "movl %%esp, %1\n"
    :"=m"(_ss), "=m"(_esp)
  );
  printf("sp=%#lx, ss=%#hx\n", _esp, _ss);

  /* Force to LDT */
  new_ss = _ss | 4;
  /* Create the LDT entry */
  set_ldt_entry(new_ss >> 3, 0, 0xbffff, is32, MODIFY_LDT_CONTENTS_DATA, 0, 1, 0, 0);

  /* Do the trick... Switch stack and then switch context. */
  asm volatile(
    "movw %3, %%ss\n"		/* Load our LDT selector to SS */
    "hlt\n"			/* Force the context switch */
    "movw %1, %%ss\n"		/* Restore SS ASAP */
    "movl %%esp, %0\n"		/* Get new ESP */
    "movl %2, %%esp\n"		/* Restore ESP */
    :"=m"(new_esp)
    : "m"(_ss), "m"(_esp), "m"(new_ss)
  );
  printf("Now sp=%08lx\n", new_esp);
  printf("Now sp=%08lx\n", new_esp);
  printf("Now sp=%08lx, ss=%04hx\n", new_esp, new_ss);
  printf("Now sp=%08lx\n", new_esp);
  printf("Now sp=%08lx\n", new_esp);

  /* See what we've got... */
  if (new_esp > 0xc0000000) {
    printf("Now sp=%08lx\n", new_esp);
    printf("BUG!\n");
  } else if (new_esp != _esp) {
    printf("Now sp=%08lx\n", new_esp);
    printf("Esp changed, strange...\n");
  } else {
    printf("Now sp=%08lx\n", new_esp);
    printf("No bug here! What CPU is this?\n");
    if (!is32)
      system("cat /proc/cpuinfo");
  }
  return 0;
}

--Boundary-00=_Z91SBiPHf3npEWr--

