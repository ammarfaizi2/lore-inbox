Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbULMMou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbULMMou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbULMMot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:44:49 -0500
Received: from em.njupt.edu.cn ([202.119.230.11]:56705 "HELO njupt.edu.cn")
	by vger.kernel.org with SMTP id S262245AbULMMoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:44:30 -0500
Message-ID: <302944969.22286@njupt.edu.cn>
X-WebMAIL-MUA: [10.10.136.115]
From: "Zhenyu Wu" <y030729@njupt.edu.cn>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Date: Mon, 13 Dec 2004 21:36:09 +0800
Reply-To: "Zhenyu Wu" <y030729@njupt.edu.cn>
X-Priority: 3
Subject: Re: about kernel_thread!
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You copy the method used in other kernel modules. This involves
> a semaphore and having the module removing routine send the task
> a signal. FYI, there is a wait_for_completion() routine and a
> complete_and_exit() routine already defined.

Thank you, my kernel version is 2.4.20. If i use return to terminate the thread,
then i can remove the module without errors, but if not, there are still errors,
Below is my simple test:

#define __KERNEL__ 
#define MODULE 
#include <linux/kernel.h> 
#include <linux/module.h> 
#include <linux/sched.h> 
#include <linux/spinlock.h> 
static int child(void *para) 
{ 
DECLARE_WAIT_QUEUE_HEAD(child_wait); 
int ret; 
struct task_struct *tsk = current; 
daemonize(); 
printk("child's pid =%d\n",tsk->pid); 
sprintf(tsk->comm,"%s","child"); 
for (;;) { 
static long recalc = 0,limit = 0; 
if (time_after(jiffies, recalc + 5*HZ)) { 
recalc = jiffies; 
printk("%s,pid=%d\n",(char*)para,tsk->pid); 
if(limit++ == 5) {                        // if limit ==5, break, then return
will
                                          //terminate this thread
break; 
} 
} 
interruptible_sleep_on_timeout(&child_wait,5*HZ); 
} 
return 0; 
} 
int init_module(void) 
{ 
int ret; 
printk("insmod's pid =%d\n",current->pid); 
ret = kernel_thread(child,"child",0);        //I create a thread here 
return 0; 
} 
int cleanup_module() 
{ 
return 0; 
} 



