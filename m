Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVB1TRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVB1TRj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVB1TRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:17:20 -0500
Received: from chello212017098056.surfer.at ([212.17.98.56]:8204 "EHLO hofr.at")
	by vger.kernel.org with ESMTP id S261712AbVB1TQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 14:16:54 -0500
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200502281913.j1SJDUG23870@hofr.at>
Subject: Re: Signals/ Communication from kernel to user!
In-Reply-To: <042701c51dab$561ef650$280e000a@blr.velankani.com> from Ravindra
 Nadgauda at "Feb 28, 2005 09:06:57 pm"
To: Ravindra Nadgauda <rnadgauda@velankani.com>
Date: Mon, 28 Feb 2005 20:13:30 +0100 (CET)
CC: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> Hello,
>    We wanted to establish a communication from kernel module (possibly a
> driver) to a user level process.
> 
>    Wanted to know whether signals can be used for this purpose OR there any
> other (better) methods of communication??
>
a bit brute force but you can simply run through the task list and kick
the pid of your user-space app (example for 2.4 kernel): 

hofrat

---snip---
/*
 * Copywrite 2002 Der Herr Hofrat
 * License GPL V2
 * Author der.herr@hofr.at
 */
/*
 * run through the task list of linux search for the passed pid and send it
 * a SIGKILL . run as  insmod pid=#  to send process with pid # a kill signal
 */ 

#include <bits/signum.h>  /* signal number macros SIGHUP etc. */ 
#include <linux/kernel.h> /* printk level */
#include <linux/module.h> /* kernel version etc. */
#include <linux/sched.h>  /* task_struct */

MODULE_LICENSE("GPL v2");
MODULE_AUTHOR("Der Herr Hofrat");
MODULE_DESCRIPTION("Signal to a user-space app from a kernel module");

int pid=0; 
MODULE_PARM(pid,"i");

int 
ksignal(int pid,int signum) 
{
	struct task_struct *p;

	/* run through the task list of linux until we find our pid */
	for_each_task(p){
		if(p->pid == pid){
			printk("sending signal %d for pid %d\n",signum,(int)p->pid);
			/* don't have a sig_info struct to send along - pass 0 */
			return send_sig(signum,p,0);
		}
	}
	/* did not find the requested pid */
	return -1;
}

int
init_module(void)
{
	/* send pid a SIGKILL */
	ksignal(pid,SIGKILL);
	return 0;
}

void 
cleanup_module(void) 
{
	printk("out of here\n");
}
