Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTIMDT3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 23:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbTIMDT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 23:19:29 -0400
Received: from [65.248.4.67] ([65.248.4.67]:24542 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S262000AbTIMDT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 23:19:26 -0400
Message-ID: <001701c37984$200442e0$f8e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "William Lee Irwin III" <wli@holomorphy.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <002b01c37956$d88d67c0$f8e4a7c8@bsb.virtua.com.br> <20030912165047.Z18851@schatzie.adilger.int> <20030912230601.GU4306@holomorphy.com> <1063408711.6740.4.camel@dhcp23.swansea.linux.org.uk> <20030912232507.GV4306@holomorphy.com>
Subject: stack overflow - kernel thread
Date: Sat, 13 Sep 2003 00:18:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi .... this worked

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/unistd.h>
#include <linux/mm.h>
#include <linux/sched.h>
#include <linux/slab.h>
#include <linux/highmem.h>
#include <linux/string.h>
#include <asm/uaccess.h>
#include <asm/errno.h>
#include <asm/mman.h>
#include <asm/page.h>
#include <asm/pgalloc.h>
#include <asm/processor.h>
#include <asm-i386/vm86.h>

#define THREAD 1
#define STACK_LIMIT 8192

int check_stack()
{ 
struct task_struct *p = NULL;
struct vm_area_struct *vma;
unsigned long stack_size, stack_addr, stack_ptr;
    
    daemonize();
    sprintf(current->comm,"CHECK_STACK");
 
    for(;;schedule()) 
    {
         for_each_task(p)
         {
                 if((p->mm != NULL) && (p->pid != 1))
                 {
  
                     stack_addr = p->mm->start_stack;
  
                     stack_ptr = p->thread.esp;
 
                     vma = find_vma(p->mm,stack_addr);
  
                      if(!vma)
                      return 0;
  
                      stack_size = (vma->vm_end - vma->vm_start)/PAGE_SIZE;
  
                      if(stack_size >= (STACK_LIMIT - 1024))
                      {
                          printk(KERN_CRIT"Process %s pid: %d\n",p->comm,p->pid);
                          printk(KERN_CRIT"Stack size %lu k\n",stack_size);
      
                          vma->vm_flags &= ~(VM_WRITE | VM_GROWSDOWN);
      
                          return 0;
                       }
     
                   }
            }
    }         
 
 return 0;
}
 

int init_module()
{
int th_pid[THREAD];
int i;

    for(i = 0;i < THREAD;i++)
    th_pid[i] = kernel_thread(check_stack,NULL,CLONE_SIGHAND);

 if(th_pid[i] < 0)
 printk(KERN_CRIT"Cannot create thread\n");

return 0;
}

void cleanup_module()
{
}


att,
Breno
----- Original Message ----- 
From: "William Lee Irwin III" <wli@holomorphy.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: 
"Breno" <brenosp@brasilsec.com.br>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Saturday, September 13, 2003 12:25 AM
Subject: Re: stack overflow


> On Sad, 2003-09-13 at 00:06, William Lee Irwin III wrote:
> >> What he actually wants is in-kernel user stack overflow checking, which
> >> is basically impossible since user stacks are demand paged. He's been
> >> told this before and failed to absorb it.
>
> On Sat, Sep 13, 2003 at 12:18:32AM +0100, Alan Cox wrote:
> > We will fault and error on a user stack exceed. You need to use
> > sigaltstack to catch it for obvious reasons. You can also use mmap and
> > drop in red zones on user space stacks
>
> Stack rlimits are fine and we already do those; the rest sounds like
> something userspace has to do.
>
>
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

