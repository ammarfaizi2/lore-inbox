Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUDMCYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 22:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUDMCYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 22:24:13 -0400
Received: from ip-40-162-97-218.anlai.com ([218.97.162.40]:9999 "EHLO
	exchhz01.viatech.com.cn") by vger.kernel.org with ESMTP
	id S263188AbUDMCYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 22:24:09 -0400
Message-ID: <81409C6755E1D5118B8700D0B7889D3A029559BE@exchhz01.viatech.com.cn>
From: "Lora Yin (HangZhou)" <LoraYin@viatech.com.cn>
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel NULL pointer when using cpuid instruction
	 in kernel module for linux kernel 2.6.5
Date: Tue, 13 Apr 2004 10:24:21 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I write a kernel module to test  cpuid instruction in a  kernel module.  
In the module if I push the registers before calling the cpuid instruction
and pop them after calling, install the module will cause a system error 
In the module if I do not pushl/popl the registers,  install the module will
be successful.
I have test the module in the Redhat 9.0 with linux kernel 2.4.20-8, but in
this version the error is not exist.
Does anyone know if there is any special difference between the two version
of linux kernel which will affect the execution of asm instruction such as
cpuid?

Thanks.
Best regards,
Lora

The error message is as following:

	test: module license 'unspecified' taints kernel.
	check_ace = 0
	Unable to handle kernel NULL pointer dereference at virtual address
00000001
	 printing eip:
	c012fd02
	*pde = 00000000
	Oops: 0002 [#1]
	CPU:    0
	EIP:    0060:[<c012fd02>]    Tainted: P  
	EFLAGS: 00010246   (2.6.5) 
	EIP is at sys_init_module+0x122/0x1e0
	eax: 00000000   ebx: 00000000   ecx: c030d2f8   edx: c030aa38
	esi: c030d2f8   edi: 00000001   ebp: c9f96000   esp: c9f97fa8
	ds: 007b   es: 007b   ss: 0068
	Process insmod (pid: 2313, threadinfo=c9f96000 task=c9f8b260)
	Stack: c03bfbc4 00000001 ce821380 0804b060 0804b975 bffffc32
c0108b59 0804b060 
	       00000915 0804b050 0804b975 bffffc32 bffffad8 00000080
0000007b 0000007b 
	       00000080 ffffe410 00000073 00000246 bffffa90 0000007b 
	Call Trace:
	 [<c0108b59>] sysenter_past_esp+0x52/0x79
	Code: c7 07 00 00 00 00 ff 8f a0 00 00 00 8b 47 6c 89 3c 24 89 44 

 


The source code of the module is as following:

//#define MODULE
#include <linux/module.h>
#include <linux/config.h>
#include <linux/init.h>

#define true 1
#define NEH_PUSHREG	asm volatile  ("pushl %eax\n pushl %ebx\n pushl
%ecx\n pushl %edx\n pushl %esi\n pushl %edi\n")
#define NEH_POPREG asm volatile  ("popl %edi\n popl %esi\n popl %edx\n popl
%ecx\n popl %ebx\n popl %eax\n")

static int check_ace(void)
{
	int result = 0;
	// ?? if use pushl/popl,  will be error, why?
	NEH_PUSHREG;	
	asm volatile ("movl $0xC0000000, %%eax\n \
	     cpuid\n \
	     cmpl $0xC0000001, %%eax\n  \
	     jnz  local_label\n \
	     cpuid\n \
	     andl $0xC0, %%edx\n \
	     jz  local_label\n \
	     movl %1, %0 \n \
local_label:\n"
		:"=m"(result)
		:"i"(true));
	NEH_POPREG;	
	return result;
}
static int __init init(void){
	int result = 0;
	result = check_ace();
	printk("check_ace = %d\n",result);
	if (result != 0){
		printk("has ace!\n");
	}
	return 0;
}
static void __exit fini(void) { 
	printk("exit\n");
}
module_init(init);
module_exit(fini);


