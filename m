Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbTINPFX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 11:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbTINPFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 11:05:23 -0400
Received: from [65.248.4.67] ([65.248.4.67]:51125 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S261184AbTINPFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 11:05:06 -0400
Message-ID: <001801c37ace$bdca28a0$f8e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: Final kernel thread for  stack (STK_LIM) overflow
Date: Sun, 14 Sep 2003 11:44:44 -0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0015_01C37AB5.97937B00"
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0015_01C37AB5.97937B00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Some tests are made .

att,
Breno

------=_NextPart_000_0015_01C37AB5.97937B00
Content-Type: application/octet-stream;
	name="check_stack.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="check_stack.c"

/*Check Stack - by Breno_BSD=0A=
    This kernel thread will verify the stack area of almost all tasks=0A=
    and try to safe your system of stack overflow ( just when the size of=0A=
    of stack is almost the same STK_LIM)=0A=
*/=0A=
=0A=
#include <linux/module.h>=0A=
#include <linux/kernel.h>=0A=
#include <linux/init.h>=0A=
#include <linux/unistd.h>=0A=
#include <linux/mm.h>=0A=
#include <linux/sched.h>=0A=
#include <linux/slab.h>=0A=
#include <linux/highmem.h>=0A=
#include <linux/string.h>=0A=
#include <asm/uaccess.h>=0A=
#include <asm/errno.h>=0A=
#include <asm/mman.h>=0A=
#include <asm/page.h>=0A=
#include <asm/pgalloc.h>=0A=
#include <asm/processor.h>=0A=
#include <asm-i386/vm86.h>=0A=
=0A=
#define THREAD 1=0A=
#define STACK_LIMIT 8192=0A=
 =0A=
int check_stack()=0A=
{ =0A=
struct task_struct *p =3D NULL;=0A=
struct vm_area_struct *vma;=0A=
unsigned long stack_size, stack_addr, stack_ptr;=0A=
    =0A=
    daemonize();=0A=
    sprintf(current->comm,"CHECK_STACK");=0A=
 =0A=
    for(;;schedule()) =0A=
    {=0A=
	for_each_task(p)  /*Lets get all process*/=0A=
	{=0A=
	    if((p->mm !=3D NULL) && (p->pid !=3D 1)) =0A=
	    {=0A=
		stack_addr =3D p->mm->start_stack;=0A=
		=0A=
		stack_ptr =3D p->thread.esp;=0A=
	=0A=
		vma =3D find_vma(p->mm,stack_addr);  /*find stack vma*/=0A=
		=0A=
		if(!vma)=0A=
		return 0;=0A=
		=0A=
		stack_size =3D (vma->vm_end - vma->vm_start)/PAGE_SIZE; /*Check the =
size*/=0A=
		=0A=
		if(stack_size >=3D (STACK_LIMIT - 1024))=0A=
		{=0A=
		    if(stack_size >=3D (STACK_LIMIT -  100)) /*Oops , this is not very =
good */=0A=
		    {=0A=
			printk(KERN_CRIT"Process not safe\n");=0A=
			force_sig(SIGKILL,p);=0A=
			return 0;=0A=
		    }=0A=
		=0A=
		=0A=
		    printk(KERN_CRIT"Process %s pid: %d\n",p->comm,p->pid);=0A=
		    printk(KERN_CRIT"Stack size %lu k\n",stack_size);=0A=
		    printk(KERN_CRIT"Start start addr %lu\n",stack_addr);=0A=
		    printk(KERN_CRIT"Stack pointer %lu\n",stack_ptr);=0A=
		    =0A=
		    vma->vm_flags &=3D ~(VM_WRITE | VM_READ); /*The stack is big =
enough*/=0A=
		    =0A=
		    return 0;=0A=
		 }=0A=
	    =0A=
	    }=0A=
	}=0A=
    } 			    	=0A=
 =0A=
 return 0;=0A=
}=0A=
 =0A=
=0A=
int init_module()=0A=
{=0A=
int th_pid[THREAD];=0A=
int i;=0A=
=0A=
    for(i =3D 0;i < THREAD;i++)=0A=
    th_pid[i] =3D kernel_thread(check_stack,NULL,CLONE_SIGHAND);=0A=
=0A=
	if(th_pid[i] < 0)=0A=
	printk(KERN_CRIT"Cannot create thread\n");=0A=
=0A=
return 0;=0A=
}=0A=
=0A=
void cleanup_module()=0A=
{=0A=
}=0A=

------=_NextPart_000_0015_01C37AB5.97937B00--

