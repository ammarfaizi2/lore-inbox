Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268298AbUIPRyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268298AbUIPRyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268368AbUIPRxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:53:44 -0400
Received: from mail.aknet.ru ([217.67.122.194]:33551 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S268186AbUIPRtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:49:36 -0400
Message-ID: <4149D243.5050501@aknet.ru>
Date: Thu, 16 Sep 2004 21:49:55 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ESP corruption bug - what CPUs are affected?
Content-Type: multipart/mixed;
 boundary="------------090705060906090500000209"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090705060906090500000209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

My question is not directly linux-related,
but I think people here can give me some clue
on an issue.

There is a "semi-official" bug in Intel CPUs,
which is described here:
http://www.intel.com/design/intarch/specupdt/27287402.PDF
chapter "Specification Clarifications"
section 4: "Use Of ESP In 16-Bit Code With 32-Bit Interrupt Handlers".

A short quote:
"ISSUE: When a 32-bit IRET is used to return to another privilege level,
and the old level uses a 4G stack (D/B bit in the segment register = 1),
while the new level uses a 64k stack (D/B bit = 0), then only the 
lower word of ESP is updated."

Which means that the higher word of ESP gets
trashed. This bug beats dosemu rather badly,
but there seem to be not much info about that
bug available on the net.
What I want to find out, is what CPUs are
affected. I wrote a small test-case. It is
attached. I tried it on Intel Pentium and
on AMD Athlon - bug is present on both. But
I'd like to know if it is also present on a
Transmeta Crusoe, Cyrix and other CPUs.
Can someone please run the test-case on some
of that CPUs and see how it goes?
Note: specifying "32" as an arg to the
test-case, will make it to use the 32bit
segment for the stack, and it will not detect
the bug. It is there to prove that it detects
the Right Thing. Run it without that argument.

I'd also like to know any thoughts on whether
it is possible to work around the bug, probably
in a kernel? Well, I am not hoping on such a
possibility, but who knows...
Anyway, I'd be glad to get any info on that bug.
Why it was not fixed for so many years, looks
also like an interesting question, as for me.


--------------090705060906090500000209
Content-Type: text/x-csrc;
 name="stk.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stk.c"

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
  printf("Now sp=%#lx, ss=%#hx\n", new_esp, new_ss);

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

--------------090705060906090500000209--
