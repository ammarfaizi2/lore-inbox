Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268178AbTBNVNs>; Fri, 14 Feb 2003 16:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268150AbTBNVN2>; Fri, 14 Feb 2003 16:13:28 -0500
Received: from mail.mplayerhq.hu ([192.190.173.45]:13511 "EHLO
	mail.mplayerhq.hu") by vger.kernel.org with ESMTP
	id <S268168AbTBNVNN>; Fri, 14 Feb 2003 16:13:13 -0500
Date: Fri, 14 Feb 2003 22:32:58 +0100 (CET)
From: Szabolcs Berecz <szabi@mplayerhq.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [2.5.59] Oops in __send_sig_info
Message-ID: <Pine.LNX.4.33.0302142229140.16839-100000@mail.mplayerhq.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I was running the following program:

#include <stdlib.h>

int main(void)
{
	void *p;
	int i;

	p = malloc(1024*1024);
	if (p == NULL)
		return 0;

	for (i = 0; i < 1024*1024; i += 1024)
		((char *) p)[i] = 1;
	sleep(50);
	free(p);
	return 0;
}

with the command:
while true; do ( ./malloc ) & done

When the system goes out of memory, the oom_kill kills some of the
malloc and bash processes. It usually works ok, but sometimes I get
an oops:

Out of Memory: Killed process 190 (bash).
Unable to handle kernel paging request at virtual address 6b6b6b77
 printing eip:
c011d77b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c011d77b>]    Not tainted
EFLAGS: 00010046
EIP is at __send_sig_info+0x17/0x248
eax: 6b6b6b6b   ebx: c97d8000   ecx: 00000013   edx: 00000001
esi: c64d60c0   edi: 00000013   ebp: 00000000   esp: c97d9f30
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 190, threadinfo=c97d8000 task=c97318a0)
Stack: c97d8000 00000202 00000000 c97d9fbc c97d8000 c9fee8fc c011d9d0 00000013
       00000001 c64d60c0 c64d60c0 00000000 00000000 c011dc67 00000013 00000001
       c64d60c0 c0115855 00000013 c64d60c0 00000001 bffff9ec bffffa6c 00000001
Call Trace:
 [<c011d9d0>] send_sig_info+0x24/0x40
 [<c011dc67>] send_sig+0x1b/0x20
 [<c0115855>] do_fork+0xc9/0x130
 [<c01074d7>] sys_fork+0x17/0x28
 [<c0108a47>] syscall_call+0x7/0xb

Code: 8b 50 0c 83 c0 0c 39 02 0f 84 06 02 00 00 85 ff 0f 84 fe 01
 <6>note: bash[190] exited with preempt_count 1

The oops occured only when killing a bash process but not every time.

Here is the disassembly of the start of __send_sig_info:

Dump of assembler code for function __send_sig_info:
0xc011d764 <__send_sig_info>:	sub    $0x8,%esp
0xc011d767 <__send_sig_info+3>:	push   %ebp
0xc011d768 <__send_sig_info+4>:	push   %edi
0xc011d769 <__send_sig_info+5>:	push   %esi
0xc011d76a <__send_sig_info+6>:	push   %ebx
0xc011d76b <__send_sig_info+7>:	mov    0x24(%esp,1),%esi
0xc011d76f <__send_sig_info+11>:	mov    0x1c(%esp,1),%edi
0xc011d773 <__send_sig_info+15>:	mov    0xe0(%esi),%eax
0xc011d779 <__send_sig_info+21>:	xor    %ebp,%ebp
0xc011d77b <__send_sig_info+23>:	mov    0xc(%eax),%edx
0xc011d77e <__send_sig_info+26>:	add    $0xc,%eax
0xc011d781 <__send_sig_info+29>:	cmp    %eax,(%edx)
0xc011d783 <__send_sig_info+31>:	je     0xc011d98f <__send_sig_info+555>
0xc011d789 <__send_sig_info+37>:	test   %edi,%edi
0xc011d78b <__send_sig_info+39>:	je     0xc011d98f <__send_sig_info+555>

So the oops is in thread_group_empty()

Once I got the following addition to the above oops:

bad: scheduling while atomic!
Call Trace:
 [<c0112e15>] schedule+0x3d/0x2d0
 [<c01309fe>] unmap_vmas+0x10a/0x210
 [<c0113cfb>] __cond_resched+0x17/0x1c
 [<c0130a64>] unmap_vmas+0x170/0x210
 [<c0133c3c>] exit_mmap+0x70/0x16c
 [<c01145b2>] mmput+0x4e/0x64
 [<c0117b26>] do_exit+0x14e/0x3a4
 [<c010919f>] die+0x6f/0x70
 [<c0111d36>] do_page_fault+0x2d6/0x404
 [<c0111a60>] do_page_fault+0x0/0x404
 [<c013087d>] zap_pmd_range+0x35/0x50
 [<c01308d2>] unmap_page_range+0x3a/0x5c
 [<c0108cad>] error_code+0x2d/0x40
 [<c011d77b>] __send_sig_info+0x17/0x248
 [<c011d9d0>] send_sig_info+0x24/0x40
 [<c011dc67>] send_sig+0x1b/0x20
 [<c0115855>] do_fork+0xc9/0x130
 [<c01074d7>] sys_fork+0x17/0x28
 [<c0108a47>] syscall_call+0x7/0xb

It's a UP system with 160MB memory. It oopses with and without swap.

What additional information do you want?

Bye,
Szabi

ps: I can access the internet only on weekends, so don't expect me to
reply on weekdays.


