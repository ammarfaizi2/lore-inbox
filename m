Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbULIT3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbULIT3A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbULIT3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:29:00 -0500
Received: from mail.aknet.ru ([217.67.122.194]:29456 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261591AbULIT2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:28:20 -0500
Message-ID: <41B8A759.80806@aknet.ru>
Date: Thu, 09 Dec 2004 22:28:25 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru> <20041117131552.GA11053@in.ibm.com> <41B1FD4B.9000208@aknet.ru> <20041207055348.GA1305@in.ibm.com> <41B5FA1B.9090507@aknet.ru> <20041209124738.GB5528@in.ibm.com>
In-Reply-To: <20041209124738.GB5528@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060104090406050204050405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060104090406050204050405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Prasanna S Panchamukhi wrote:
> The patch below takes both the cases into 
> consideration. 
OK, perhaps this one is better, at least
it no longer plays on gcc optimization,
so that I can reproduce the Oopses again,
for good and for test-case.
But I think you really should consider
checking regs->xcs instead of explicitly
checking the corner cases like 0xcd,3.

> I am not able to think of a case, where 
> address is invalid when it enters int3 handler.
> I would appreciate if you can provide such a
> test case.
I already did - it was my very first test-case
which produced the Oops on the if(*addr!=...)
dereference, but you worked around by checking
the VM flag (well, it must be checked, but
not after you already used "addr" a couple of
times, IMHO).
OK, but if you need another test-case,
here it is. Much simpler than the vm86 one.
It can work in 2 modes: started without args,
it will print the diagnostic (passed or
failed) and exit. If started with any arg,
it will Oops the kernel.
This happens both with your latest patch
and without it. This doesn't happen with
your previous patch (no Oops), but then fixing
problems by exploiting the gcc optimization
was not the best idea I think.


--------------060104090406050204050405
Content-Type: text/x-csrc;
 name="brk.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="brk.c"

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <linux/unistd.h>
#include <asm/ldt.h>
#include <asm/segment.h>
#include <asm/page.h>
#include <sys/mman.h>

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

void my_trap(int sig)
{
  printf("Test passed, All OK!\n");
  exit(0);
}

int main(int argc, char *argv[])
{
  unsigned char *ptr;
  if (mmap(0, PAGE_SIZE, PROT_READ | PROT_WRITE,
      MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0) == MAP_FAILED) {
    perror("mmap");
    return 1;
  }
  if ((ptr = mmap(0, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0)) == MAP_FAILED) {
    perror("mmap");
    return 1;
  }
  if (argc == 1)		/* no-Oops mode */
    *(unsigned char *)0 = 1;	/* Set the no-Oops flag :) */
  /* Create the LDT entry */
  #define MY_CS (__USER_CS | 4)
  set_ldt_entry(MY_CS >> 3, (unsigned long)ptr, PAGE_SIZE - 1, 1,
    MODIFY_LDT_CONTENTS_CODE, 1, 0, 0, 0);
  ptr[0] = 0xcc;
  ptr[1] = 0xcb;
  signal(SIGTRAP, my_trap);
  asm volatile ("lcall %0,$0\n"::"i"(MY_CS));
  printf("Stolen interrupt, very bad.\n");
  return 0;
}

--------------060104090406050204050405--
