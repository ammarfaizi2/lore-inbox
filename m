Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWGKOLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWGKOLo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWGKOLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:11:44 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:4614 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750816AbWGKOLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:11:43 -0400
Message-ID: <44B3B16D.8050100@sw.ru>
Date: Tue, 11 Jul 2006 18:10:53 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Pavel Emelianov <xemul@openvz.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 7/7] forbid the use of the unshare syscall on ipc
 namespaces
References: <20060711075051.382004000@localhost.localdomain> <20060711075433.856729000@localhost.localdomain>
In-Reply-To: <20060711075433.856729000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch looks as an overkill for me.

If you really care about things you describe, you can forbid unsharing in cases:

1.
        undo_list = tsk->sysvsem.undo_list;
        if (undo_list)
                REFUSE_UNSHARE;
2. vma exists with vma->vm_ops == &shm_vm_ops;
3. file opened with f_op == &shm_file_operations

I also dislike exec() operation for such sort of things since you can have no executable
at hands due to changed fs namespace.

Thanks,
Kirill


> This patch forbids the use of the unshare() syscall on ipc namespaces.
> 
> The purpose of this restriction is to protect the system from
> inconsistencies when the namespace is unshared. e.g. shared memory ids
> will be removed but not the memory mappings, semaphore ids will be
> removed but the semundos not cleared.
> 
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> Cc: Andrew Morton <akpm@osdl.org>
> Cc: Pavel Emelianov <xemul@openvz.org>
> Cc: Kirill Korotaev <dev@openvz.org>
> Cc: Andrey Savochkin <saw@sw.ru>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Herbert Poetzl <herbert@13thfloor.at>
> Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
> Cc: Serge E. Hallyn <serue@us.ibm.com>
> Cc: Dave Hansen <haveblue@us.ibm.com>
> 
> ---
>  kernel/fork.c |   23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> Index: 2.6.18-rc1-mm1/kernel/fork.c
> ===================================================================
> --- 2.6.18-rc1-mm1.orig/kernel/fork.c
> +++ 2.6.18-rc1-mm1/kernel/fork.c
> @@ -1604,7 +1604,6 @@ asmlinkage long sys_unshare(unsigned lon
>  	struct sem_undo_list *new_ulist = NULL;
>  	struct nsproxy *new_nsproxy = NULL, *old_nsproxy = NULL;
>  	struct uts_namespace *uts, *new_uts = NULL;
> -	struct ipc_namespace *ipc, *new_ipc = NULL;
>  
>  	check_unshare_flags(&unshare_flags);
>  
> @@ -1612,12 +1611,12 @@ asmlinkage long sys_unshare(unsigned lon
>  	err = -EINVAL;
>  	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
>  				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
> -				CLONE_NEWUTS|CLONE_NEWIPC))
> +				CLONE_NEWUTS))
>  		goto bad_unshare_out;
>  
>  	/* Also return -EINVAL for all unsharable namespaces. May be a
>  	 * -EACCES would be more appropriate ? */
> -	if (unshare_flags & CLONE_NEWUSER)
> +	if (unshare_flags & (CLONE_NEWUSER|CLONE_NEWIPC))
>  		goto bad_unshare_out;
>  
>  	if ((err = unshare_thread(unshare_flags)))
> @@ -1636,20 +1635,18 @@ asmlinkage long sys_unshare(unsigned lon
>  		goto bad_unshare_cleanup_fd;
>  	if ((err = unshare_utsname(unshare_flags, &new_uts)))
>  		goto bad_unshare_cleanup_semundo;
> -	if ((err = unshare_ipcs(unshare_flags, &new_ipc)))
> -		goto bad_unshare_cleanup_uts;
>  
> -	if (new_ns || new_uts || new_ipc) {
> +	if (new_ns || new_uts) {
>  		old_nsproxy = current->nsproxy;
>  		new_nsproxy = dup_namespaces(old_nsproxy);
>  		if (!new_nsproxy) {
>  			err = -ENOMEM;
> -			goto bad_unshare_cleanup_ipc;
> +			goto bad_unshare_cleanup_uts;
>  		}
>  	}
>  
>  	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
> -				new_uts || new_ipc) {
> +				new_uts) {
>  
>  		task_lock(current);
>  
> @@ -1697,22 +1694,12 @@ asmlinkage long sys_unshare(unsigned lon
>  			new_uts = uts;
>  		}
>  
> -		if (new_ipc) {
> -			ipc = current->nsproxy->ipc_ns;
> -			current->nsproxy->ipc_ns = new_ipc;
> -			new_ipc = ipc;
> -		}
> -
>  		task_unlock(current);
>  	}
>  
>  	if (new_nsproxy)
>  		put_nsproxy(new_nsproxy);
>  
> -bad_unshare_cleanup_ipc:
> -	if (new_ipc)
> -		put_ipc_ns(new_ipc);
> -
>  bad_unshare_cleanup_uts:
>  	if (new_uts)
>  		put_uts_ns(new_uts);
> 
> --
> 

