Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWCXULS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWCXULS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWCXULS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:11:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64472 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751416AbWCXULR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:11:17 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, ebiederm@xmission.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, sam@vilain.net
Subject: Re: [RFC][PATCH 2/2] Virtualization of IPC
References: <44242B1B.1080909@sw.ru> <44242DFE.3090601@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Mar 2006 13:09:20 -0700
In-Reply-To: <44242DFE.3090601@sw.ru> (Kirill Korotaev's message of "Fri, 24
 Mar 2006 20:35:58 +0300")
Message-ID: <m14q1niozz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> This patch introduces IPC namespaces, which allow to create isolated IPC users
> or containers.
> Introduces CONFIG_IPC_NS and ipc_namespace structure.
> It also uses current->ipc_ns as a pointer to current namespace, which reduces
> places where additional argument to functions should be added.

I don't see where we are freeing the shared memory segments,
the message queues and the semaphores when the last user of the namespace
goes away.  Am I missing something?

> --- a/include/linux/ipc.h
> +++ b/include/linux/ipc.h
> @@ -70,6 +70,50 @@ struct kern_ipc_perm
>  
>  #endif /* __KERNEL__ */
>  
> +#include <linux/config.h>
> +
> +#ifdef CONFIG_IPC_NS
> +#include <asm/atomic.h>
> +
> +struct ipc_ids;
> +struct ipc_namespace {
> +	atomic_t cnt;
> +
> +	struct ipc_ids *sem_ids;
> +	int sem_ctls[4];
> +	int used_sems;
> +
> +	struct ipc_ids *msg_ids;
> +	int msg_ctlmax;
> +	int msg_ctlmnb;
> +	int msg_ctlmni;
> +
> +	struct ipc_ids *shm_ids;
> +	size_t	shm_ctlmax;
> +	size_t 	shm_ctlall;
> +	int 	shm_ctlmni;
> +	int	shm_total;
> +};

I believe there is a small problem with this implementation.
per namespace counts and limits are fine.  But I think we want
to maintain true global limits as well.   I know
concerns of that nature have been expressed in regards
to Daves patch.

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1193,6 +1193,7 @@ static task_t *copy_process(unsigned lon
>  	attach_pid(p, PIDTYPE_TGID, p->tgid);
>  	attach_pid(p, PIDTYPE_PID, p->pid);
>  	get_uts_ns(p->uts_ns);
> +	get_ipc_ns(p->ipc_ns);
>  
>  	nr_threads++;
>  	total_forks++;

Again please move the get outside of the tasklist_lock.

Eric
