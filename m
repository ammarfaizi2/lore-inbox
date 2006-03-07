Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932606AbWCGBx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbWCGBx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWCGBx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:53:29 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:40833 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932606AbWCGBx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:53:29 -0500
Date: Mon, 6 Mar 2006 17:57:45 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 2/6] sysvmsg: containerize
Message-ID: <20060307015745.GG27645@sorel.sous-sol.org>
References: <20060306235248.20842700@localhost.localdomain> <20060306235250.35676515@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306235250.35676515@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Hansen (haveblue@us.ibm.com) wrote:
> --- work/include/linux/init_task.h~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
> +++ work-dave/include/linux/init_task.h	2006-03-06 15:41:56.000000000 -0800
> @@ -2,6 +2,7 @@
>  #define _LINUX__INIT_TASK_H
>  
>  #include <linux/file.h>
> +#include <linux/ipc.h>
>  #include <linux/rcupdate.h>
>  
>  #define INIT_FDTABLE \

missing INIT_IPC_CONTEXT type of macro?

> diff -puN include/linux/ipc.h~sysvmsg-container include/linux/ipc.h
> --- work/include/linux/ipc.h~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
> +++ work-dave/include/linux/ipc.h	2006-03-06 15:41:56.000000000 -0800
> @@ -68,6 +68,10 @@ struct kern_ipc_perm
>  	void		*security;
>  };
>  
> +struct ipc_context;
> +extern struct ipc_context *ipc_context;
> +
> +extern struct ipc_msg_context *init_ipc_context(void);
>  #endif /* __KERNEL__ */
>  
>  #endif /* _LINUX_IPC_H */
> diff -puN include/linux/sched.h~sysvmsg-container include/linux/sched.h
> --- work/include/linux/sched.h~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
> +++ work-dave/include/linux/sched.h	2006-03-06 15:41:56.000000000 -0800
> @@ -793,6 +793,7 @@ struct task_struct {
>  	int link_count, total_link_count;
>  /* ipc stuff */
>  	struct sysv_sem sysvsem;
> +	struct ipc_context *ipc_context;

how does this propagate on clone (presently it's just side-effect of
dup_task_struct starting from init_task, with no dynamic lifetime),
how is it meant to be changed?

>  /* CPU-specific state of this task */
>  	struct thread_struct thread;
>  /* filesystem information */
> diff -puN ipc/msg.c~sysvmsg-container ipc/msg.c
> --- work/ipc/msg.c~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
> +++ work-dave/ipc/msg.c	2006-03-06 15:41:56.000000000 -0800
> @@ -60,35 +60,30 @@ struct msg_sender {
>  #define SEARCH_NOTEQUAL		3
>  #define SEARCH_LESSEQUAL	4
>  
> -static atomic_t msg_bytes = ATOMIC_INIT(0);
> -static atomic_t msg_hdrs = ATOMIC_INIT(0);
> +#define msg_lock(ctx, id)	((struct msg_queue*)ipc_lock(&ctx->ids,id))
> +#define msg_unlock(ctx, msq)	ipc_unlock(&(msq)->q_perm)
> +#define msg_rmid(ctx, id)	((struct msg_queue*)ipc_rmid(&ctx->ids,id))
> +#define msg_checkid(ctx, msq, msgid)	\
> +	ipc_checkid(&ctx->ids,&msq->q_perm,msgid)
> +#define msg_buildid(ctx, id, seq) \
> +	ipc_buildid(&ctx->ids, id, seq)
>  
> -static struct ipc_ids msg_ids;
> -
> -#define msg_lock(id)	((struct msg_queue*)ipc_lock(&msg_ids,id))
> -#define msg_unlock(msq)	ipc_unlock(&(msq)->q_perm)
> -#define msg_rmid(id)	((struct msg_queue*)ipc_rmid(&msg_ids,id))
> -#define msg_checkid(msq, msgid)	\
> -	ipc_checkid(&msg_ids,&msq->q_perm,msgid)
> -#define msg_buildid(id, seq) \
> -	ipc_buildid(&msg_ids, id, seq)
> -
> -static void freeque (struct msg_queue *msq, int id);
> -static int newque (key_t key, int msgflg);
> +static void freeque (struct ipc_msg_context *, struct msg_queue *msq, int id);
> +static int newque (struct ipc_msg_context *context, key_t key, int id);
>  #ifdef CONFIG_PROC_FS
>  static int sysvipc_msg_proc_show(struct seq_file *s, void *it);
>  #endif
>  
> -void __init msg_init (void)
> +void __init msg_init (struct ipc_msg_context *context)
>  {
> -	ipc_init_ids(&msg_ids,msg_ctlmni);
> +	ipc_init_ids(&context->ids,msg_ctlmni);
>  	ipc_init_proc_interface("sysvipc/msg",
>  				"       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n",
> -				&msg_ids,
> +				&context->ids,
>  				sysvipc_msg_proc_show);

Does that mean /proc interface only gets init_task context?
Along those lines, I think now ipcs -a is incomplete from admin
perspective.  Suppose that's a feature from the container/vserver
POV.

> --- work/ipc/util.h~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
> +++ work-dave/ipc/util.h	2006-03-06 15:41:56.000000000 -0800
> @@ -12,7 +12,7 @@
>  #define SEQ_MULTIPLIER	(IPCMNI)
>  
>  void sem_init (void);
> -void msg_init (void);
> +void msg_init (struct ipc_msg_context *context);
>  void shm_init (void);
>  
>  struct ipc_id_ary {
> @@ -30,6 +30,18 @@ struct ipc_ids {
>  	struct ipc_id_ary* entries;
>  };
>  
> +struct ipc_msg_context {
> +	atomic_t bytes;
> +	atomic_t hdrs;
> +
> +	struct ipc_ids ids;
> +	struct kref count;
> +};
> +
> +struct ipc_context {
> +	struct ipc_msg_context msg;
> +};

This looks a little suspect.  ref count embedded in embedded object.
My first thought was, sem and shared memory would introduce same, and
now we'd have 3 independent refounts for top level object.  However,
it's not used, and doesn't appear to be mirrored in the sem and shared
mem contexts.  Perhaps it is just a leftover?

thanks,
-chris
