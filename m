Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268775AbUIGXye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268775AbUIGXye (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUIGXye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 19:54:34 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:33811 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S268775AbUIGXy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 19:54:28 -0400
Message-ID: <413E498D.4020807@vmware.com>
Date: Tue, 07 Sep 2004 16:51:41 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk, hpa@zytor.com,
       bgerst@didntduck.org, Riley@Williams.Name
Subject: PROBLEM: x86 alignment check bug
Content-Type: multipart/mixed;
 boundary="------------020300040700030500010005"
X-OriginalArrivalTime: 07 Sep 2004 23:51:41.0845 (UTC) FILETIME=[9FB4D450:01C49535]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.50; host: mailhost1.vmware.com)
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.50; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020300040700030500010005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Exception reporting for alignment check violations on x86 is broken 
(unfortunately, rather badly, and rather hard to fix).  Look at the trap 
function which fills in the si_addr field during an unaligned memory 
access, 2.6.8.1-mm4+, arch/i386/kernel/traps.c, Line 522:

DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, 
BUS_ADRALN, get_cr2())

The hardware does not fill in %cr2 with the faulting address on 
alignment check exceptions (at least on all processors I have tested); 
this assumed behavior is also not documented in either the Intel or AMD 
processor manuals, so at least in my understanding, it does not exist.  
What happens instead is that the last occuring page fault address is 
passed to the user via the siginfo struct.  This address may be 
completely random and have nothing at all to do with the alignment check 
exception.  If any memory debuggers use #AC and are relying on SIGBUS to 
provide a correct address, they may get very confused.

I've attached a sample C program demonstrating the problem.

zach-dev:zach $ ./a.out
Read only write address = 40016000
fault address = 40016000
Unaligned write address = 40018001
fault address = 400a2b70

Clearly, this is not correct.  Considering how difficult the fix is (the 
kernel must disassemble the faulting instruction and use register 
information to determine the faulting address), perhaps it is best to 
simply remove the extra error info from the siginfo struct - the single 
UNIX spec does not actually say that SIGBUS must provide and address 
information.  If the si_addr info is left, it should be clearly 
documented that it does not work properly.

Keywords: signal,i386
Kernel version: apparently, all

Doing a historical search, apparently this was discovered before:
http://seclists.org/lists/linux-kernel/2001/May/0309.html

Zachary Amsden (zach@vmware.com)

--------------020300040700030500010005
Content-Type: text/plain;
 name="foo.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo.c"

#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <setjmp.h>
#include <sys/mman.h>

void *faultAddress = 0;
jmp_buf env;


void getFaultAddress(int signo, struct siginfo *info, void *data)
{
	faultAddress = info->si_addr;
	longjmp(env, 1);
}

int main()
{
	long *l;
	struct sigaction sa;
	sa.sa_sigaction = getFaultAddress;
	sa.sa_flags = SA_SIGINFO | SA_ONESHOT;
	l = (long *)mmap(0,4096, PROT_READ, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
	printf("Read only write address = %08x\n", l);
	sigaction(SIGSEGV, &sa, NULL);
	if (!setjmp(env))
		l[0] = 1;
	else 
		printf("fault address = %08x\n", faultAddress);
	l = (long *)mmap(0,8192, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
	l[0] = 2;
	l[1024] = 3;
	l = (long *)(((char *)l)+1);
	printf("Unaligned write address = %08x\n", l);
	sigaction(SIGBUS, &sa, NULL);
	__asm__ __volatile__("pushfl\n\t"
			     "orl $0x40000,(%esp)\n\t"
			     "popfl");
	if (!setjmp(env)) 
		l[0] = 4;
	else
		printf("fault address = %08x\n", faultAddress);
}

--------------020300040700030500010005--
