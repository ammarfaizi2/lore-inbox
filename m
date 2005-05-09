Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVEIN6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVEIN6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 09:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVEIN6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 09:58:13 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:11238 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261367AbVEIN5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 09:57:52 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
From: Alexander Nyberg <alexn@dsv.su.se>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@engr.sgi.com>, aq <aquynh@gmail.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <1115644436.8540.83.camel@frecb000711.frec.bull.fr>
References: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
	 <1115644436.8540.83.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain
Date: Mon, 09 May 2005 15:57:41 +0200
Message-Id: <1115647061.936.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Index: linux-2.6.12-rc3-mm3/drivers/connector/cn_fork.c
> ===================================================================
> --- linux-2.6.12-rc3-mm3.orig/drivers/connector/cn_fork.c	2003-01-30 11:24:37.000000000 +0100
> +++ linux-2.6.12-rc3-mm3/drivers/connector/cn_fork.c	2005-05-09 14:36:22.000000000 +0200
> @@ -0,0 +1,132 @@
> +/*
> + * cn_fork.c - Fork connector
> + *
> + * Copyright (C) 2005 BULL SA.
> + * Written by Guillaume Thouvenin <guillaume.thouvenin@bull.net>
> + * 
> + * This module implements the fork connector. It allows to send a
> + * netlink datagram, when enabled, from the do_fork() routine. The 
> + * message can be read by a user space application. By this way, 
> + * the user space application is alerted when a fork occurs.
> + *
> + * It uses the userspace <-> kernelspace connector that works on top of
> + * the netlink protocol. The fork connector is enabled or disabled by
> + * sending a message to the connector. The unique sequence number of
> + * messages can be used to check if a message is lost.  
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +
> +#include <linux/cn_fork.h>
> +
> +#define CN_FORK_INFO_SIZE	sizeof(struct cn_fork_msg)
> +#define CN_FORK_MSG_SIZE 	(sizeof(struct cn_msg) + CN_FORK_INFO_SIZE)
> +
> +static int cn_fork_enable = 0;
> +struct cb_id cb_fork_id = { CN_IDX_FORK, CN_VAL_FORK };
> +
> +/* fork_counts is used as the sequence number of the netlink message */
> +static DEFINE_PER_CPU(unsigned long, fork_counts);
> +
> +void fork_connector(pid_t thread, pid_t parent, pid_t child)
> +{
> +	if (cn_fork_enable) {
> +		struct cn_msg *msg;
> +		struct cn_fork_msg *forkmsg;
> +		__u8 buffer[CN_FORK_MSG_SIZE];	
> +
> +		msg = (struct cn_msg *)buffer;
> +			
> +		memcpy(&msg->id, &cb_fork_id, sizeof(msg->id));
> +		
> +		msg->ack = 0; /* not used */
> +		msg->seq = get_cpu_var(fork_counts)++;
> +
> +		msg->len = CN_FORK_INFO_SIZE;
> +		forkmsg = (struct cn_fork_msg *)msg->data;
> +		forkmsg->cpu = smp_processor_id();
> +		forkmsg->tgid = thread;
> +		forkmsg->ppid = parent;
> +		forkmsg->cpid = child;
> +
> +		put_cpu_var(fork_counts);
> +
> +		cn_netlink_send(msg, CN_IDX_FORK, GFP_KERNEL|__GFP_NOFAIL);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(fork_connector);

the export symbol police will get you for this, any intended users?

> +
> +static inline void cn_fork_send_status(void)
> +{
> +	/* TODO: An informational line in log is maybe not enough... */
> +	printk(KERN_INFO "cn_fork_enable == %d\n", cn_fork_enable);
> +}
> +
> +/**
> + * cn_fork_callback - enable or disable the fork connector
> + * @data: message send by the connector 
> + *
> + * The callback allows to enable or disable the sending of information
> + * about fork in the do_fork() routine. To enable the fork, the user 
> + * space application must send the integer 1 in the data part of the 
> + * message. To disable the fork connector, it must send the integer 0.
> + */
> +static void cn_fork_callback(void *data) 
> +{
> +	struct cn_msg *msg = data;
> +	int action;
> +
> +	if (cn_already_initialized && (msg->len == sizeof(cn_fork_enable))) {
> +		memcpy(&action, msg->data, sizeof(cn_fork_enable));
> +		switch(action) {
> +			case FORK_CN_START:
> +				cn_fork_enable = 1;
> +				break;
> +			case FORK_CN_STOP:
> +				cn_fork_enable = 0;
> +				break;
> +			case FORK_CN_STATUS:
> +				cn_fork_send_status();

Why does this not pass down the status to the app asking about it
instead?

> +				break;
> +		}
> +	}
> +}
> +
> +/**
> + * cn_fork_init - initialization entry point
> + *
> + * This routine will be run at kernel boot time because this driver is
> + * built in the kernel. It adds the connector callback to the connector 
> + * driver.
> + */
> +int __init cn_fork_init(void)
> +{
> +	int err;
> +	
> +	err = cn_add_callback(&cb_fork_id, "cn_fork", &cn_fork_callback);
> +	if (err) {
> +		printk(KERN_WARNING "Failed to register cn_fork\n");
> +		return -EINVAL;
> +	}	
> +		
> +	printk(KERN_NOTICE "cn_fork is registered\n");
> +	return 0;
> +}
> +
> +__initcall(cn_fork_init);
> Index: linux-2.6.12-rc3-mm3/include/linux/cn_fork.h
> ===================================================================
> --- linux-2.6.12-rc3-mm3.orig/include/linux/cn_fork.h	2003-01-30 11:24:37.000000000 +0100
> +++ linux-2.6.12-rc3-mm3/include/linux/cn_fork.h	2005-05-09 14:34:36.000000000 +0200
> @@ -0,0 +1,54 @@
> +/*
> + * cn_fork.h - Fork connector
> + *
> + * Copyright (C) 2005 Nguyen Anh Quynh <aquynh@gmail.com>
> + * Copyright (C) 2005 Guillaume Thouvenin <guillaume.thouvenin@bull.net>
> + * 
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#ifndef CN_FORK_H
> +#define CN_FORK_H
> +
> +#include <linux/connector.h>
> +
> +#define FORK_CN_STOP	0
> +#define FORK_CN_START	1
> +#define FORK_CN_STATUS	2
> +
> +struct cn_fork_msg
> +{
> +	int cpu;	/* ID of the cpu where the fork occured */
> +	pid_t tgid;	/* thread leader PID */
> +	pid_t ppid;	/* the parent PID */
> +	pid_t cpid;	/* the child PID  */
> +};
> +

What I meant here was something like:
struct cn_fork_msg {
	int cpu;
	pid_t ppid;	/* parent process id */
	pid_t ptid;	/* parent thread id */
	pid_t cpid;	/* child process id */
	pid_t ctid;	/* child thread id */

};

Now if cpid == ctid it is a group leader but you cannot know this
otherwise. I don't know if you specifically need this but there may be
other users, and this is more complete. If not you may receive multiple
messages with the same child pid. Again I don't know how much you care.

As this is shared with user-space the fields need to switched like this:
ppid = current->tgid, 
ptid = current->pid,
cpid = p->tgid, 
ctid = current->pid

and perhaps a comment to explain why we assign the fields like this.
Please think through what you need to pass down to user-space, it's
important.

> +/* Code above is only inside the kernel */
> +#ifdef __KERNEL__
> +
> +extern int cn_already_initialized;

this should go into linux/connector.h

> +#ifdef CONFIG_FORK_CONNECTOR
> +extern void fork_connector(pid_t, pid_t, pid_t);
> +#else
> +static inline void fork_connector(pid_t thread, pid_t parent, pid_t child) 
> +{ 
> +	return; 
> +}
> +#endif /* CONFIG_FORK_CONNECTOR */
> +
> +#endif /* __KERNEL__ */
> +#endif /* CN_FORK_H */
> Index: linux-2.6.12-rc3-mm3/include/linux/connector.h
> ===================================================================
> --- linux-2.6.12-rc3-mm3.orig/include/linux/connector.h	2005-05-09 07:45:56.000000000 +0200
> +++ linux-2.6.12-rc3-mm3/include/linux/connector.h	2005-05-09 09:50:01.000000000 +0200
> @@ -26,6 +26,8 @@
>  
>  #define CN_IDX_CONNECTOR		0xffffffff
>  #define CN_VAL_CONNECTOR		0xffffffff
> +#define CN_IDX_FORK			0xfeed  /* fork events */
> +#define CN_VAL_FORK			0xbeef
>  
>  /*
>   * Maximum connector's message size.
> Index: linux-2.6.12-rc3-mm3/kernel/fork.c
> ===================================================================
> --- linux-2.6.12-rc3-mm3.orig/kernel/fork.c	2005-05-09 07:45:56.000000000 +0200
> +++ linux-2.6.12-rc3-mm3/kernel/fork.c	2005-05-09 14:23:04.000000000 +0200
> @@ -41,6 +41,7 @@
>  #include <linux/profile.h>
>  #include <linux/rmap.h>
>  #include <linux/acct.h>
> +#include <linux/cn_fork.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -1252,6 +1253,8 @@ long do_fork(unsigned long clone_flags,
>  			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
>  				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
>  		}
> +		
> +		fork_connector(current->tgid, current->pid, p->pid);

With your current implementation this is wrong, first two args should
switched, third arg should be p->tgid. The differences between kernel
and user pid must be hidden as you share struct cn_fork_msg with
user-space.

>  	} else {
>  		free_pidmap(pid);
>  		pid = PTR_ERR(p);
> 
> 


