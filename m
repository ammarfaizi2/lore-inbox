Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264743AbTFCIjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 04:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264754AbTFCIjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 04:39:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54263 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264743AbTFCIjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 04:39:51 -0400
Message-ID: <3EDC61E7.3060806@mvista.com>
Date: Tue, 03 Jun 2003 01:52:55 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: BalaKrishna Mallipeddi <bkmallipeddi@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem : While adding a new system call to Montavista Linux
 on PPC architecture
References: <20030602070446.39795.qmail@web10708.mail.yahoo.com>
In-Reply-To: <20030602070446.39795.qmail@web10708.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BalaKrishna Mallipeddi wrote:
> Hi,
>     While adding a new System call in Montavista linux
> on ppc architecture  i am getting error:
>       
> I implemented the system call and compiled the kernel.
> The kernel is compiled succesfully. While testing the
> system call by writing a user program i am getting
> error as ollows:
> 
> test_syscall.c: In function `rfs_open':
> test_syscall.c:4: `__NR_rfs_open' undeclared (first
> use in this function)
> test_syscall.c:4: (Each undeclared identifier is
> reported only once
> test_syscall.c:4: for each function it appears in.)
> 
> 
> How I implemented the system call is as follows:
> All the paths i have given is from the montavista
> Linux source tree.
> 1) Call Implementation:
>     I coded my system call in the directory "kernel"  
>  of the Linux source tree with the name "rfs_open.c". 
>  
> The system call is as follows:
> 
>     #include <linux/rfs_open.h>
As written here, there is nothing in the above file that the kernel 
needs.  rfs_open.h should not be in the kernel tree, but in user land 
and included by the user program.  More usually, you would build a 
library file with the system call in it and link with that.  When you 
build the library you need the kernel headers you refer to in 
rfs_open.h.  Once you have built the library with the call stub, you 
no longer need to refer to the kernel headers (which is a good thing).
>                                                       
>                             asmlinkage int
> sys_rfs_open(void)
>     {
>         printk("I am rfs_open\n");
>         return 0;
>     }
> 
> 2) Added a library function:
>     I added my library function in the directory
> "include/linux" with the name "rfs_open.h". The
> function is as follows:
>     
>     #ifndef _LINUX_RFS_OPEN_H
>     #define _LINUX_RFS_OPEN_H
>                                                       
>                          
>     #include <linux/linkage.h>
>     #include <linux/unistd.h>
>                                                       
>                          
>         _syscall0(int,rfs_open);
>                                                       
>                          
>     #endif

As above, this should not be in the kernel, but in user land.
> 
> 3) Got the system call number:
>    I assigned a number to my system call in the file
> unistd.h in the directory "include/asm", where "asm"
> links to "asm-ppc". The line added in unistd.h is as
> follows:
>      #define __NR_rfs_open           208
> 
> 4) Created entry in the System call table:
>    I created an entry in the System Call table which
> is in the file misc.S( for i386 architecture this
> System call table is in entry.S) in the directory
> "arch/ppc/kernel/misc.S" The line added in misc.S is
> as follows:
>     .long sys_rfs_open

I assume you made sure that the .long is in the same call number slot 
(i.e. 208).
> 
> 5)  Updated the Makefile for my system call to be
> compiled and linked in to the kernel. After updating 
> it is as follows:
>   export-objs = signal.o sys.o kmod.o context.o
> ksyms.o pm.o exec_domain.o \
>   printk.o cpufreq.o trace.o rfs_open.o 

You don't need to export the call name unless you want to be able to 
call it directly from a module, NOT a good idea.
>                                                       
>                          
>   obj-y     = sched.o fork.o exec_domain.o panic.o
> printk.o \
>   module.o exit.o itimer.o info.o time.o softirq.o
> resource.o \
>   sysctl.o acct.o capability.o ptrace.o timer.o user.o
> \
>   signal.o sys.o kmod.o context.o rfs_open.o          
>   
> 6) I compiled the kernel  and it is successfully
> compiled.
> 
> 7) My system call testing program looks as follows:
> 
>    #include <sys/syscall.h>
>    #include <stdio.h>
>    #include <errno.h>
>    _syscall0(int,rfs_open);
replace the above line with an include of your rfs_open.h file.
> 
>    int main()
>    {
>         rfs_open();
>         return(0);
>    }
> 
>    I am greatful if any one help me.
> 
> Thanks & regards
> BalaKrishna Mallipeddi.
> 
> =====
> BalaKrishna Mallipeddi
> Member Technical Staff Software
> Innomedia Technologies Pvt. Ltd.,
> #3278, 12th Main, HAL 2nd stage,
> Bangalore-560008,
> INDIA
> Phone : 5278389 + 123
> 


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

