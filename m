Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVCIA3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVCIA3G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVCIAZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:25:53 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:56075 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262222AbVCIAX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 19:23:57 -0500
Message-ID: <422E4217.10607@vmware.com>
Date: Tue, 08 Mar 2005 16:23:51 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: i386 / sysenter safety test case
Content-Type: multipart/mixed;
 boundary="------------020409010601070609020008"
X-OriginalArrivalTime: 09 Mar 2005 00:23:59.0407 (UTC) FILETIME=[49C3D3F0:01C5243E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020409010601070609020008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Code inspection of entry.S on i386 showed a potential problem - load 
through segment without verifying "flatness" on the sysenter path.  
Turns out this code is safe, but only by a thread ..

ENTRY(sysenter_entry)
        movl TSS_sysenter_esp0(%esp),%esp
sysenter_past_esp:
        sti
        pushl $(__USER_DS)
        pushl %ebp
        pushfl
        pushl $(__USER_CS)
        pushl $SYSENTER_RETURN

/*
 * Load the potential sixth argument from user stack.
 * Careful about security.
 */
        cmpl $__PAGE_OFFSET-3,%ebp
        jae syscall_fault
1:      movl (%ebp),%ebp

If it weren't for the fact that %ebp relative addresses default to using 
the SS segment, we could have loaded through a user segment here to read 
arbitrary memory (sysenter does nothing to DS segment).  Perhaps this 
was considered before, but because of the implications, I thought this 
might be worth annotating in the source.   Also provided a test case.  
Obviously only works on sysenter capable processors.  Tested on 2.6.8.

Zach Amsden
zach@vmware.com

--------------020409010601070609020008
Content-Type: text/plain;
 name="sysenter.S"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysenter.S"

#include <sys/syscall.h>

.text
.global sysenter_call
.global sysenter_call_2

/* void sysenter_call(pid_t pid, int signo, short ds, void *addr) */

sysenter_call:
	push %ebx
	push %edi
	push %ebp
        push %ds
	movl %esp, %edi
	movl 20(%esp), %ebx   /* pid */
	movl 24(%esp), %ecx   /* signo */
	movl 28(%esp), %ds    /* exploit DS */
	movl 32(%esp), %ebp
	movl %ebp, %esp
        push $sysenter_return
	push %ecx
	push %edx
	subl $16, %ebp
	push $0xbaadf00d
	movl $SYS_kill, %eax
	sysenter

/* vsyscall page will ret to us here */
sysenter_return:
        mov %edi, %esp
	pop %ds
	pop %ebp
	pop %edi
	pop %ebx	
	ret

sysenter_call_2:
	push %ebx
	push %ebp
	movl 20(%esp), %ebx   /* pid */
	movl 24(%esp), %ecx   /* signo */
	movl 28(%esp), %ebp
	movl $SYS_kill, %eax
	sysenter

.data
test: .long 0 

--------------020409010601070609020008
Content-Type: text/plain;
 name="sysenter.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysenter.c"

/*
 * Copyright (c) 2005, Zachary Amsden (zach@vmware.com)
 * This is licensed under the GPL.
 */

#include <stdio.h>
#include <signal.h>
#include <asm/ldt.h>
#include <asm/segment.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/mman.h>
#define __KERNEL__
#include <asm/page.h>

extern void sysenter_call(pid_t pid, int signo, short ds, void *addr);
extern void sysenter_call_2(pid_t pid, int signo, void *addr);
void catch_sig(int signo, struct sigcontext ctx)
{
	__asm__ __volatile__("mov %0, %%ds" : : "r" (__USER_DS));
	printf("interrupted %%ebp = 0x%x\n", ctx.ebp);
	if (ctx.ebp == 0xbaadf00d)
		printf("phew\n");
}

void main(void)
{
	struct user_desc desc;
	short ds;
	unsigned long addr;
	unsigned *stack;
	unsigned long offset;

	stack = (unsigned *)mmap(0, 4096, PROT_EXEC|PROT_READ|PROT_WRITE,
				 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	stack = &stack[1024];
	addr = 0xf0000; /* Try to read BIOS */
	offset = __PAGE_OFFSET-(unsigned)stack+addr+16;
	signal(SIGUSR1, catch_sig);
	desc.entry_number = 0;
	desc.base_addr = offset;
	desc.limit = 0xffffff;
	desc.seg_32bit = 1;
	desc.contents = MODIFY_LDT_CONTENTS_DATA;
	desc.read_exec_only = 0;
	desc.limit_in_pages = 1;
	desc.seg_not_present = 0;
	desc.useable = 1;
	if (modify_ldt(1, &desc, sizeof(desc)) != 0) {
		perror("modify_ldt");
	}
	ds = 0x7; /* TI | RPL 3 */
	sysenter_call(getpid(), SIGUSR1, ds, stack);
	sysenter_call_2(getpid(), SIGSTOP, __PAGE_OFFSET+4096);
	printf("not reached - core should show %%eax == -EFAULT\n");
}

--------------020409010601070609020008--
