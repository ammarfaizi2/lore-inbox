Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314809AbSD2Gwi>; Mon, 29 Apr 2002 02:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314819AbSD2Gwh>; Mon, 29 Apr 2002 02:52:37 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:25085 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S314809AbSD2Gwg>; Mon, 29 Apr 2002 02:52:36 -0400
Date: Sun, 28 Apr 2002 23:52:14 -0700
From: Chris Wright <chris@wirex.com>
To: Wanghong Yuan <wyuan1@ews.uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to enable printk
Message-ID: <20020428235214.B8654@figure1.int.wirex.com>
Mail-Followup-To: Wanghong Yuan <wyuan1@ews.uiuc.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020427.194302.02285733.davem@redhat.com><467685860.avixxmail@nexxnet.epcnet.de> <20020428.204911.63038910.davem@redhat.com> <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Wanghong Yuan (wyuan1@ews.uiuc.edu) wrote:
> Hi,
> 
> It may be a simple question. But I cannot see the result of printk in
> console like the following. Do i need to enable it somewhere? Thanks

Take a look a man 8 dmesg.  Also Documentation/sysctl/kernel.txt.

> /*-O2 -Wall -DMODULE -D__KERNEL__ -DLINUX -c testsys.c */
> 
> #include <linux/sys.h>
> #include <linux/mm.h>
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/sched.h>
> #include <sys/syscall.h>
> #include <asm/uaccess.h>
> 
> 
> /* The system call number we attempt to install ourselves as. */
> static int syscall_num = 165;

I hope you know this can't be done safely (race free).

> asmlinkage int sys_test(int pid, int period, int cycles, int* ptr)
> 
> {
> 
>  put_user(current->pid, ptr);
>  return pid-10000;
> 
> }
> 
> extern int sys_call_table[];
> 
> #ifdef MODULE
> int init_module(void)
> {
>   printk("yes\n");
>   sys_call_table[syscall_num] = (int)sys_test;
>   return 0;
> }
> 
> void cleanup_module(void)
> {
>   sys_call_table[syscall_num] = 0;

this could cause a problem.  you should save the original entry when you
insmod and restore it here ;-)

> }
> 
> #endif /* MODULE */

btw, take a look at how the module_init() and module_exit() macros are used
in the kernel.

hope that helps,
-chris
