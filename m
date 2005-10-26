Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVJZTeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVJZTeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 15:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbVJZTeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 15:34:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964880AbVJZTea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 15:34:30 -0400
Date: Wed, 26 Oct 2005 12:30:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru,
       jean-pierre.dion@bull.net, jbarnes@engr.sgi.com,
       guillaume.thouvenin@bull.net, pbadari@us.ibm.com, linuxram@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       elsa-devel@lists.sourceforge.net, gh@us.ibm.com, bunk@stusta.de,
       sekharan@us.ibm.com
Subject: Re: [PATCH 02/02] Process Events Connector
Message-Id: <20051026123005.54eb78a0.akpm@osdl.org>
In-Reply-To: <1130285528.10680.200.camel@stark>
References: <1130285260.10680.194.camel@stark>
	<1130285528.10680.200.camel@stark>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley <matthltc@us.ibm.com> wrote:
>
> 	This patch adds a connector that reports fork, exec, id change, and
> exit
> events for all processes to userspace.

Looks sane enough to me.  There are of course hooks, but they're minimal.

> ...
> --- /dev/null
> +++ linux-2.6.14-rc4/include/linux/cn_proc.h
> @@ -0,0 +1,125 @@
> +/*
> + * cn_proc.h - process events connector
> + *
> + * Copyright (C) Matt Helsley, IBM Corp. 2005
> + * Based on cn_fork.h by Nguyen Anh Quynh and Guillaume Thouvenin
> + * Original copyright notice follows:
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
> +#ifndef CN_PROC_H
> +#define CN_PROC_H 1

We normally just do

#define CN_PROC_H

> +#include <linux/types.h>
> +#include <linux/connector.h>
> +
> +typedef int __bitwise proc_cn_mcast_op_t;
> +enum proc_cn_mcast_op {
> +	PROC_CN_MCAST_LISTEN = (__force proc_cn_mcast_op_t)1,
> +	PROC_CN_MCAST_IGNORE = (__force proc_cn_mcast_op_t)2
> +};

Why is the __bitwise thingy in here?

Given that you've carefully used `#ifdef __KERNEL__' below, I assume that
this definition is supposed to be shared with userspace, yes?  If so, what
is userspace to make of __bitwise and __force?

Please remove the typedef - just use `enum proc_cn_mcast_op' in those
places where the code requires, umm, an `enum proc_cn_mcast_op'.

> +/*
> + * From the user's point of view, the process
> + * ID is the thread group ID and thread ID is the internal
> + * kernel "pid". So, fields are assigned as follow:
> + *
> + *  In user space     -  In  kernel space
> + *
> + * parent process ID  =  parent->tgid
> + * parent thread  ID  =  parent->pid
> + * child  process ID  =  child->tgid
> + * child  thread  ID  =  child->pid
> + */
> +
> +typedef int __bitwise proc_event_what_t;
> +struct proc_event {
> +	enum what {
> +		/* Use successive bits so the enums can be used to record
> +		 * sets of events as well
> +		 */
> +		PROC_EVENT_NONE = (__force proc_event_what_t)0x00000000,
> +		PROC_EVENT_FORK = (__force proc_event_what_t)0x00000001,
> +		PROC_EVENT_EXEC = (__force proc_event_what_t)0x00000002,
> +		PROC_EVENT_UID  = (__force proc_event_what_t)0x00000004,
> +		PROC_EVENT_GID  = (__force proc_event_what_t)0x00000040,
> +		/* "next" should be 0x00000400 */
> +		/* "last" is the last process event: exit */
> +		PROC_EVENT_EXIT = (__force proc_event_what_t)0x80000000
> +	} what;
> +	int cpu;
> +	union { /* must be last field of proc_event struct */
> +		struct {
> +			int err;
> +		} ack;
> +
> +		struct fork_proc_event {
> +			pid_t parent_pid;
> +			pid_t parent_tgid;
> +			pid_t child_pid;
> +			pid_t child_tgid;
> +		} fork;
> +
> +		struct exec_proc_event {
> +			pid_t process_pid;
> +			pid_t process_tgid;
> +		} exec;
> +
> +		struct id_proc_event {
> +			pid_t process_pid;
> +			pid_t process_tgid;
> +			union {
> +				uid_t ruid; /* current->uid */
> +				gid_t rgid; /* current->gid */
> +			};
> +			union {
> +				uid_t euid;
> +				gid_t egid;
> +			};
> +		} id;
> +
> +		struct exit_proc_event {
> +			pid_t process_pid;
> +			pid_t process_tgid;
> +			int exit_code, exit_signal;
> +		} exit;
> +	};
> +};

We avoid using anonymous unions because older gcc's do not support them. 
Please give this union a name.

This structure is supposed to be passed to userspace, yes?  Are you sure
that it doesn't need conversion for 64-bit kernel/32-bit userspace?

> +#ifdef __KERNEL__
> +#if defined(CONFIG_PROC_EVENTS) || defined(CONFIG_PROC_EVENTS_MODULE)

I don't think this code can possibly work as a module??

> +void proc_fork_connector(struct task_struct *task);
> +void proc_exec_connector(struct task_struct *task);
> +void proc_id_connector (struct task_struct *task, int which_id);
> +void proc_exit_connector(struct task_struct *task);

Coding style nit: three of the above are correct, one isn't.

> +#else
> +static inline void proc_fork_connector(struct task_struct *task)
> +{}
> +
> +static inline void proc_exec_connector(struct task_struct *task)
> +{}
> +
> +static inline void proc_id_connector  (struct task_struct *task,
> +				       int which_id)
> +{}

Two spaces this time ;)  Zero is correct.

> ...
> + * cn_proc.c - process events connector
> ...
> +
> +extern int cn_already_initialized;

Please never put extern decls in .c files.  Put it in a header file which
is shared by the definition and by all users.

> +static atomic_t proc_event_num_listeners = 0;
> +struct cb_id cn_proc_event_id = { CN_IDX_PROC, CN_VAL_PROC };
> +
> +/* proc_counts is used as the sequence number of the netlink message */
> +DEFINE_PER_CPU(__u32, proc_event_counts);

It used to be the case that DEFINE_PER_CPU had to include an
initialisation, to work around a compiler/toolchain bug in older gcc's.  I
have a vague feeling that this got fixed, but we cannot remember how.  It would be
safest here to do

DEFINE_PER_CPU(__u32, proc_event_counts) = { 0 };


I think proc_event_counts can have static scope?

> +static inline void get_seq (__u32 *ts, int *cpu)

Coding style.

> +static void cn_proc_ack (int err, int rcvd_seq, int rcvd_ack)

Coding style.

> +{
> +	struct cn_msg *msg;
> +	struct proc_event *ev;
> +	__u8 buffer[CN_PROC_MSG_SIZE];
> +
> +	if (atomic_read(proc_event_num_listeners) < 1)
> +		return;

What happens if there's a race, and proc_event_num_listeners falls to zero
right here?

> +	msg = (struct cn_msg*)buffer;
> +	ev = (struct proc_event*)msg->data;
> +
> +	msg->seq = rcvd_seq;
> +	ev->cpu = -1;
> +	ev->what = PROC_EVENT_NONE;
> +	ev->ack.err = err;
> +	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
> +	msg->ack = rcvd_ack + 1;
> +	msg->len = sizeof(*ev);
> +	cn_netlink_send(msg, CN_IDX_PROC, GFP_KERNEL);
> +}
> +
> ...
> +/**
> + * cn_proc_mcast_ctl
> + * @data: message sent from userspace via the connector
> + */
> +static void cn_proc_mcast_ctl(void *data)
> +{
> +	struct cn_msg *msg = data;
> +	enum proc_cn_mcast_op *mc_op = NULL;
> +	int err = 0;
> +
> +	if (!(cn_already_initialized &&
> +	    (msg->len == sizeof(*mc_op))))
> +		return;
> +
> +	mc_op = (enum proc_cn_mcast_op*)msg->data;
> +	switch (*mc_op) {
> +		case PROC_CN_MCAST_LISTEN:
> +			atomic_inc(&proc_event_num_listeners);
> +			break;
> +		case PROC_CN_MCAST_IGNORE:
> +			atomic_dec(&proc_event_num_listeners);
> +			break;
> +		default:
> +			err = EINVAL;
> +			break;
> +	}
> +	cn_proc_ack(err, msg->seq, msg->ack);
> +}

We usually indent the body of a switch statement one tabstop the left.

> +/*
> + * cn_proc_init - initialization entry point
> + *
> + * Adds the connector callback to the connector driver.
> + */
> +static int __init cn_proc_init(void)
> +{
> +	int err;
> +
> +	if ((err = cn_add_callback(&cn_proc_event_id, "cn_proc",
> +	 			   &cn_proc_mcast_ctl))) {
> +		printk(KERN_WARNING "cn_proc failed to register\n");
> +		return err;
> +	}
> +	return 0;
> +}

Is KERN_WARNING sufficiently stern?

> +static void __exit cn_proc_fini(void)
> +{
> +	cn_del_callback(&cn_proc_event_id);
> +}

This has no callers?

> +__initcall(cn_proc_init);

Using __initcall is a bit old-fashioned.  module_init() here would be more
typical.

> Index: linux-2.6.14-rc4/include/linux/connector.h
> ===================================================================
> --- linux-2.6.14-rc4.orig/include/linux/connector.h
> +++ linux-2.6.14-rc4/include/linux/connector.h
> @@ -25,10 +25,13 @@
>  #include <asm/types.h>
>  
>  #define CN_IDX_CONNECTOR		0xffffffff
>  #define CN_VAL_CONNECTOR		0xffffffff
>  
> +#define CN_IDX_PROC                    0x1
> +#define CN_VAL_PROC                    0x1
> +

It'd be nice to have a comment explaining what these are.

> +config PROC_EVENTS
> +	boolean "Report process events to userspace"
> +	depends on CONNECTOR=y

Yup, I agree - we can forget about module support.

>  cn-y				+= cn_queue.o connector.o
> Index: linux-2.6.14-rc4/fs/exec.c
> ===================================================================
> --- linux-2.6.14-rc4.orig/fs/exec.c
> +++ linux-2.6.14-rc4/fs/exec.c
> @@ -49,10 +49,11 @@
>  #include <linux/rmap.h>
>  #include <linux/acct.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/mmu_context.h>
> +#include <linux/cn_proc.h>
>  

We normally place the linux/ includes before the asm/ includes.

> Index: linux-2.6.14-rc4/kernel/fork.c
> ===================================================================
> --- linux-2.6.14-rc4.orig/kernel/fork.c
> +++ linux-2.6.14-rc4/kernel/fork.c
> @@ -48,10 +48,12 @@
>  #include <asm/uaccess.h>
>  #include <asm/mmu_context.h>
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
>  
> +#include <linux/cn_proc.h>
> +

Ditto.

> --- linux-2.6.14-rc4.orig/kernel/sys.c
> +++ linux-2.6.14-rc4/kernel/sys.c
> @@ -34,10 +34,12 @@
>  
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
>  #include <asm/unistd.h>
>  
> +#include <linux/cn_proc.h>
> +

Ditto.


