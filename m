Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVEIJcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVEIJcB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 05:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVEIJcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 05:32:01 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:55511 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261175AbVEIJbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 05:31:52 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
From: Alexander Nyberg <alexn@dsv.su.se>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@engr.sgi.com>, aq <aquynh@gmail.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
References: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain
Date: Mon, 09 May 2005 11:31:47 +0200
Message-Id: <1115631107.936.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Index: linux-2.6.12-rc3-mm3/include/linux/cn_fork.h
> ===================================================================
> --- linux-2.6.12-rc3-mm3.orig/include/linux/cn_fork.h	2003-01-30 11:24:37.000000000 +0100
> +++ linux-2.6.12-rc3-mm3/include/linux/cn_fork.h	2005-05-09 09:50:28.000000000 +0200
> @@ -0,0 +1,86 @@
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
> +	pid_t ppid;	/* the parent PID */
> +	pid_t cpid;	/* the child PID  */
> +};
> +
> +/* Code above is only inside the kernel */
> +#ifdef __KERNEL__
> +
> +extern int cn_already_initialized;
> +
> +#ifdef CONFIG_FORK_CONNECTOR
> +
> +#define CN_FORK_INFO_SIZE	sizeof(struct cn_fork_msg)
> +#define CN_FORK_MSG_SIZE 	(sizeof(struct cn_msg) + CN_FORK_INFO_SIZE)
> +
> +extern int cn_fork_enable;
> +extern struct cb_id cb_fork_id;
> +
> +DECLARE_PER_CPU(unsigned long, fork_counts);
> +
> +static inline void fork_connector(pid_t parent, pid_t child)
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
> +		forkmsg->ppid = parent;
> +		forkmsg->cpid = child;
> +
> +		put_cpu_var(fork_counts);
> +
> +		cn_netlink_send(msg, CN_IDX_FORK, GFP_ATOMIC);

Why is this GFP_ATOMIC?

> +	}
> +}
> +#else
> +static inline void fork_connector(pid_t parent, pid_t child) 
> +{
> +	return; 
> +}
> +#endif /* CONFIG_FORK_CONNECTOR */
> +#endif /* __KERNEL__ */
> +
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
> +++ linux-2.6.12-rc3-mm3/kernel/fork.c	2005-05-09 08:03:15.000000000 +0200
> @@ -41,6 +41,7 @@
>  #include <linux/profile.h>
>  #include <linux/rmap.h>
>  #include <linux/acct.h>
> +#include <linux/cn_fork.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -63,6 +64,14 @@ DEFINE_PER_CPU(unsigned long, process_co
>  
>  EXPORT_SYMBOL(tasklist_lock);
>  
> +#ifdef CONFIG_FORK_CONNECTOR
> +/* 
> + * fork_counts is used by the fork_connector() inline routine as 
> + * the sequence number of the netlink message.
> + */
> +static DEFINE_PER_CPU(unsigned long, fork_counts); 
> +#endif /* CONFIG_FORK_CONNECTOR */
> +

The above should go into cn_fork.c

>  int nr_processes(void)
>  {
>  	int cpu;
> @@ -1252,6 +1261,8 @@ long do_fork(unsigned long clone_flags,
>  			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
>  				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
>  		}
> +		
> +		fork_connector(current->pid, p->pid);

Are you sure this is what you want? ->pid has a special meaning to the
kernel and doesn't necessarily mean the same to user-space, so I think
you want ->tgid here. If you look at sys_getpid() and sys_gettid()
you'll see what I mean.

>  	} else {
>  		free_pidmap(pid);
>  		pid = PTR_ERR(p);
> 


