Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVAUMnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVAUMnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbVAUMnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:43:52 -0500
Received: from asplinux.ru ([195.133.213.194]:22802 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S262352AbVAUMmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:42:33 -0500
Message-ID: <41F0F9A6.5040601@sw.ru>
Date: Fri, 21 Jan 2005 15:46:30 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Seth, Rohit" <rohit.seth@intel.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Andrey Savochkin" <saw@sawoct.com>, linux-kernel@vger.kernel.org
Subject: Re: possible CPU bug and request for Intel contacts
References: <01EF044AAEE12F4BAAD955CB7506494302DFE109@scsmsx401.amr.corp.intel.com>
In-Reply-To: <01EF044AAEE12F4BAAD955CB7506494302DFE109@scsmsx401.amr.corp.intel.com>
Content-Type: multipart/mixed;
 boundary="------------010309050405050902060100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010309050405050902060100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Here are the details about CPU bug I mentioned in my previous post. 
Though it turned out later that it happens on P-III systems only I still 
hope it can be of interest.

Brief description
~~~~~~~~~~~~~~~~~

This issue was found by Vasily Averin (vvs@sw.ru) when playing
with uselib security exploit on kernels with my 4gb split patch.

This bug results in strange effects such as calltraces below,
reboots, impossible call traces and so on.

I started to resolve the bug, narrowed down uselib exploit and
got a simple testcase for the bug, which can be found in attach.
This testcase does a simple thing - it maps pages at low addresses
from 0x04000000 downto 0x00000000, page by page and touches them
for write. Sometimes when running this exploit I got oopses,
sometimes reboots and I found that this is sensitive to the page
addresses which exploit maps.

Why it crashes? I think this is due to virtual addresses of
kernel code and mapped user space pages overlap. I was able even to
reboot machine if mapped user space pages were filled with some
appropriate asm code.

I found that Ingo Molnar 4gb split is not vulnerable, and after
investigations I found that Ingo patch doesn't map kernel entry code
(trampline) as _PAGE_GLOBAL. This was the answer.

I tested it on 4 different P-III machines - all of them were vulnerable.
But lately I tested it on Celeron 2.4Ghz and P4 systems - it doesn't 
happen, so this bug can be of low interest to Intel people :(

Below you can find the way how to reproduce the bug, call traces
and why I think it's a hardware bug.

How to reproduce a bug
~~~~~~~~~~~~~~~~~~~~~~

- take any FedoraCore kernel with Ingo Molnar 4gb split patch
   or mainstream kernel and apply 4GB split patch
- apply attached diff-arch-4gb-global patch to make
   trampline code to be GLOBAL
- compile kernel with turned on 4gb split, i.e. CONFIG_X86_4GB=y
- boot the kernel and run the attached testcase:

# while true; do ./4gbtest; done;

or

# ./elflbl -l ./lib -a 0x4000000  (where elflbl is uselib exploit)

During each 4-5 test runs I get the following oops:

Jan 21 12:15:17 ts Unable to handle kernel NULL pointer dereference at 
virtual address 000000c0
Jan 21 12:15:17 ts  printing eip:
Jan 21 12:15:17 ts 02114450
Jan 21 12:15:17 ts *pde = 00000000
Jan 21 12:15:17 ts Oops: 0002
Jan 21 12:15:17 ts SMP
Jan 21 12:15:17 ts Modules linked in:
Jan 21 12:15:17 ts CPU:    0
Jan 21 12:15:17 ts EIP:    0060:[<02114450>]    Not tainted
Jan 21 12:15:17 ts EFLAGS: 00010246   (2.6.8-dev)
Jan 21 12:15:17 ts EIP is at sys_mmap2+0x0/0xb0
Jan 21 12:15:17 ts eax: 000000c0   ebx: 31524fc4   ecx: 00001000   edx: 
004ec000
Jan 21 12:15:17 ts esi: 00000032   edi: 00000000   ebp: 31524000   esp: 
31524fc0
Jan 21 12:15:17 ts ds: 007b   es: 007b   ss: 0068
Jan 21 12:15:17 ts Process test (pid: 25, threadinfo=31524000 task=31f680c0)
Jan 21 12:15:17 ts Stack: fffec200 01a2a000 00001000 00000003 00000032 
00000000 00000000 000000c0
Jan 21 12:15:17 ts        0000007b 0000007b 000000c0 08048541 00000073 
00000282 bffffdcc 0000007b
Jan 21 12:15:17 ts Call Trace:
Jan 21 12:15:17 ts Code: 55 bd f7 ff ff ff 57 31 ff 56 53 83 ec 18 8b 44 
24 38 89 c6

  Unable to handle kernel NULL pointer dereference at virtual address 
000000c0
  02114450
  *pde = 00000000
  Oops: 0002
  CPU:    0
  EIP:    0060:[<02114450>]    Not tainted
  EFLAGS: 00010246   (2.6.8-dev)
  eax: 000000c0   ebx: 31524fc4   ecx: 00001000   edx: 004ec000
  esi: 00000032   edi: 00000000   ebp: 31524000   esp: 31524fc0
  ds: 007b   es: 007b   ss: 0068
  Stack: fffec200 01a2a000 00001000 00000003 00000032 00000000 00000000 
000000c0
         0000007b 0000007b 000000c0 08048541 00000073 00000282 bffffdcc 
0000007b
  Call Trace:
  Code: 55 bd f7 ff ff ff 57 31 ff 56 53 83 ec 18 8b 44 24 38 89 c6


 >>EIP; 02114450 <sys_mmap2+0/b0>   <=====

 >>ebx; 31524fc4 <pg0+2eff8fc4/fdac0000>
 >>ebp; 31524000 <pg0+2eff8000/fdac0000>
 >>esp; 31524fc0 <pg0+2eff8fc0/fdac0000>

Code;  02114450 <sys_mmap2+0/b0>
00000000 <_EIP>:
Code;  02114450 <sys_mmap2+0/b0>   <=====
    0:   55                        push   %ebp   <=====
Code;  02114451 <sys_mmap2+1/b0>
    1:   bd f7 ff ff ff            mov    $0xfffffff7,%ebp
Code;  02114456 <sys_mmap2+6/b0>
    6:   57                        push   %edi
Code;  02114457 <sys_mmap2+7/b0>
    7:   31 ff                     xor    %edi,%edi
Code;  02114459 <sys_mmap2+9/b0>
    9:   56                        push   %esi
Code;  0211445a <sys_mmap2+a/b0>
    a:   53                        push   %ebx
Code;  0211445b <sys_mmap2+b/b0>
    b:   83 ec 18                  sub    $0x18,%esp
Code;  0211445e <sys_mmap2+e/b0>
    e:   8b 44 24 38               mov    0x38(%esp,1),%eax
Code;  02114462 <sys_mmap2+12/b0>
   12:   89 c6                     mov    %eax,%esi

Why CPU is unable to handle paging request at 0x000000c0? There is no 
access to
this addr in executing code! What has "push %ebp" to do with 0xc0?
The answer is that %eax contains 0xc0 and the touched in user space pages
contain 4092 zero bytes. And 0x0000 is an opcode for "addl %al, (%eax)".
So we see the situation when CPU is executing code from user space
pages though we are in kernel space already and data peeks from these 
addresses
shows us the correct code (code in call trace is correct!).
I checked it and if these pages are filled with some other values,
not zeroes, than it's possible to make CPU execute this code.

And why this happens on sys_mmap2+0? Because entry code (system_call)
is mapped at high addresses (> 0xffc00000) and is the same both in kernel
and user spaces, so entry.S code works ok.

So we found 2 ways of curing this bug:
- make trampline code to be non-GLOBAL
- another observation was that PAE turned ON helps as well.

Hypothesis
~~~~~~~~~~
I think that the problem is in code prefetch queue or somewhere in CPU.
It looks like CPU doesn't flush code prefetch queue after %cr3 reload
(to kernel space) in entry.S and continues to execute prefetched code
from user space pages.

Why making entry code non-global helps the problem?
I think that if the code at %eip is flushed on %cr3 reload than the _whole_
prefetch queue is flushed and when entry code is global than it is
not flushed on %cr3 reload and prefetch queue (including call to flushed
sys_mmap2 code) is not flushed.

Kirill


> Hi Kirill,
> 
> I appreciate you bringing this issue up.  Could you please send us the
> information on how you are able to reproduce this issue (System config,
> Linux kernel version and any test case).  We would like to root cause
> the failure here at Intel.
> 
> Appreciate your help,
> Thanks, 
> -rohit
> 
> Kirill Korotaev <> wrote on Wednesday, January 19, 2005 8:08 AM:
> 
> 
>>Hello Linus,
>>
>>Linus, Ingo, I've got one strange CPU bug leading to oopses, reboots
>>and so on. This bug can be reproduced with a little bit modified 4gb
>>split and is probably related to CPU speculative execution. I'll post
>>more information about this bug later, but I would like to ask you
>>for Intel guys contacts who maybe interested in this information, so
>>I could CC them as well.
>>
>>Thank you,
>>Kirill
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe
>>linux-kernel" in the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


--------------010309050405050902060100
Content-Type: text/plain;
 name="4gbtest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="4gbtest.c"

/*
 *	binfmt_elf uselib VMA insert race vulnerability
 *	v1.09
 *	tested only on 2.4.x and gcc 2.96
 *
 *	gcc -O2 -fomit-frame-pointer elflbl.c -o elflbl
 *
 *	Copyright (c) 2004  iSEC Security Research. All Rights Reserved.
 *
 *	THIS PROGRAM IS FOR EDUCATIONAL PURPOSES *ONLY* IT IS PROVIDED "AS IS"
 *	AND WITHOUT ANY WARRANTY. COPYING, PRINTING, DISTRIBUTION, MODIFICATION
 *	WITHOUT PERMISSION OF THE AUTHOR IS STRICTLY PROHIBITED.
 *
 */


#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <syscall.h>
#include <signal.h>

#include <sys/types.h>
#include <sys/mman.h>
#include <asm/page.h>

static int
	map_base=0x4000000,
	map_addr;

#define __NR_sys_mmap2		__NR_mmap2
inline _syscall6(int, sys_mmap2, int, a, int, b, int, c, int, d, int, e, int, f);

void fatal(const char *message)
{
	int sig = SIGKILL;

	if(!errno) {
		fprintf(stdout, "\n[-] FAILED: %s ", message);
	} else {
		fprintf(stdout, "\n[-] FAILED: %s (%s) ", message,
			(char*) (strerror(errno)) );
	}
	printf("\n");
	fflush(stdout);

	for(;;) kill(0, sig);
}

void mmap_one_page()
{
	int *r, i;

	map_addr -= PAGE_SIZE;

	r = (void*)sys_mmap2((unsigned)map_addr, PAGE_SIZE, PROT_READ|PROT_WRITE,
			     MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED, 0, 0);
	if(MAP_FAILED == r) {
		fatal("mmap2 failed");
	}

	/* TOUCH THE PAGE! THIS IS IMPORTANT! */
	*r = map_addr;
//	for (i = 0; i < 1024; i++)
//		*(r+i) = 0x128b128b;
//	memset(r, 0x11, PAGE_SIZE);
}



//	use elf library and try to sleep on kmalloc
void exploitme()
{
	int pages;

	map_addr = map_base;
	pages = map_addr/PAGE_SIZE;

//	map_addr = 0x2150000;
//	pages = 0x35;
	printf("mmaping 0x%08x downto 0x%08x...\n",
			map_addr, map_addr - pages * PAGE_SIZE);
	while(pages) {
		mmap_one_page();
		pages--;
	}
}

void usage(char *n)
{
	printf("\nUsage: %s\t\n", n);
	printf("\t\t-a alternate addr hex\n");
	printf("\n");
	_exit(1);
}


//	give -s for forced stop, -b to clean SLAB
int main(int ac, char **av)
{
	int r;

	while(ac) {
		r = getopt(ac, av, "a:h");
		if(r<0) break;

		switch(r) {

		case 'a' :
			if(1!=sscanf(optarg, "%x", &map_base))
				fatal("bad addr value");
			break;

		case 'h' :
		default:
			usage(av[0]);
			break;
		}
	}

	exploitme();

	return 0;
}

--------------010309050405050902060100
Content-Type: text/plain;
 name="diff-arch-4gb-global"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-arch-4gb-global"

--- ./arch/i386/kernel/entry_trampoline.c.4gbglb	2005-01-19 11:01:17.000000000 +0300
+++ ./arch/i386/kernel/entry_trampoline.c	2005-01-19 11:01:28.275121416 +0300
@@ -24,14 +24,16 @@ void __init init_entry_mappings(void)
 
 	void *tramp;
 	int p;
+	pgprot_t prot;
 
 	/*
 	 * We need a high IDT and GDT for the 4G/4G split:
 	 */
 	trap_init_virtual_IDT();
 
-	__set_fixmap(FIX_ENTRY_TRAMPOLINE_0, __pa((unsigned long)&__entry_tramp_start), PAGE_KERNEL_EXEC);
-	__set_fixmap(FIX_ENTRY_TRAMPOLINE_1, __pa((unsigned long)&__entry_tramp_start) + PAGE_SIZE, PAGE_KERNEL_EXEC);
+	prot = __pgprot(pgprot_val(PAGE_KERNEL_EXEC) | _PAGE_GLOBAL);
+	__set_fixmap(FIX_ENTRY_TRAMPOLINE_0, __pa((unsigned long)&__entry_tramp_start), prot);
+	__set_fixmap(FIX_ENTRY_TRAMPOLINE_1, __pa((unsigned long)&__entry_tramp_start) + PAGE_SIZE, prot);
 	tramp = (void *)fix_to_virt(FIX_ENTRY_TRAMPOLINE_0);
 
 	printk("mapped 4G/4G trampoline to %p.\n", tramp);

--------------010309050405050902060100--

