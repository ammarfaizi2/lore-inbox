Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbUKWOPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUKWOPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUKWOPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:15:48 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:17893 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261265AbUKWOOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:14:32 -0500
Subject: Re: [PATCH 2.6.9] fork: add a hook in do_fork()
From: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: guillaume.thouvenin@bull.net
In-Reply-To: <20041123080643.GD23974@kroah.com>
References: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
	 <20041123080643.GD23974@kroah.com>
Date: Tue, 23 Nov 2004 15:14:28 +0100
Message-Id: <1101219268.6210.133.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 15:21:33,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 23/11/2004 15:21:35,
	Serialize complete at 23/11/2004 15:21:35
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 So I tried to implement a solution using LSM hook and I have a strange
behavior. Here is the code of the module. It is just to test if I can
get the pid of the parent and its new created child.

--- fork_hook_module.c [BEGIN] ---

#include <linux/module.h>	/* for all modules      */
#include <linux/kernel.h>	/* for KERN_ALERT       */
#include <linux/init.h>		/* for the macros       */
#include <linux/sched.h>	/* for task_struct      */
#include <linux/security.h>     /* for LSM hook         */

static int elsa_task_alloc_security(struct task_struct *p);

struct security_operations elsa_ops = {
	.task_alloc_security = elsa_task_alloc_security,
};

static int elsa_task_alloc_security(struct task_struct *p)
{
	printk(KERN_ALERT "intercept a fork: %d created by %d\n",
	       p->pid, p->parent->pid);

	return 0;
}

static int __init fh_init(void)
{
	printk(KERN_ALERT "fh: fork hook added\n");
	if (register_security(&elsa_ops))
		panic(KERN_ALERT "fh: Unable to register fork hook\n");

	return 0;
}

static void __exit fh_exit(void)
{
	if (unregister_security(&elsa_ops))
		printk(KERN_ALERT
		       "fh: Unable to un-register with fork hook\n");

	printk(KERN_ALERT "fh: fork hook removed\n");
}

module_init(fh_init);
module_exit(fh_exit);

MODULE_AUTHOR("Guillaume Thouvenin");
MODULE_DESCRIPTION("Fork Hook");
MODULE_LICENSE("GPL");

--- fork_hook_module.c [END] ---

When I load the module, the hook is well registered. Now, if I run a
command from a shell, like a 'top', the message in the kernel log like
indicates a wrong parent ID. Here is the output of the top command:

  PID  PPID USER     %CPU CPU COMMAND
 2009  2008 guill     0.0   0 bash
 2109  2108 guill     0.0   0 bash
 2704  2109 guill     0.0   0 top

and here is the message found in the kernel log:

 intercept a fork: 2704 created by 2108

It should be 2109... not 2108
I think that the problem occurs because the security_task_alloc() is
called, the field p->parent is not set. 

Is it true? and if it is, is it possible to move the hook after the
initialization of the variable p->parent?

Regards,
Guillaume

