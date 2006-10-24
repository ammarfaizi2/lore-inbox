Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWJXJtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWJXJtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 05:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWJXJtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 05:49:20 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:27575 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030258AbWJXJtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 05:49:19 -0400
Subject: Re: [PATCH] sys_unshare: remove a broken CLONE_SIGHAND code
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Janak Desai <janak@us.ibm.com>,
       Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061023155320.GA4208@oleg>
References: <20061023155320.GA4208@oleg>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 11:49:57 +0200
Message-Id: <1161683397.24143.14.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 19:53 +0400, Oleg Nesterov wrote:
> sys_unshare(CLONE_SIGHAND) is broken, the code under 'if (new_sigh)' is
> never executed but very wrong. Just remove it to avoid a confusion,
> task_lock() has nothing to do with ->sighand changing.
> 
> Also, change the comment in unshare_sighand(). Yes, CLONE_THREAD implies
> CLONE_SIGHAND, but still it looks confusing. Also, we don't need to check
> current->sighand != NULL.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Good thing, this confused me when figuring out the ->siglock rules, its
tricky enough without being put off balance by dead code.

> --- rc2-mm2/kernel/fork.c~	2006-10-22 19:28:17.000000000 +0400
> +++ rc2-mm2/kernel/fork.c	2006-10-23 19:23:19.000000000 +0400
> @@ -1523,15 +1523,13 @@ static int unshare_mnt_namespace(unsigne
>  }
>  
>  /*
> - * Unsharing of sighand for tasks created with CLONE_SIGHAND is not
> - * supported yet
> + * Unsharing of sighand is not supported yet
>   */
>  static int unshare_sighand(unsigned long unshare_flags, struct sighand_struct **new_sighp)
>  {
>  	struct sighand_struct *sigh = current->sighand;
>  
> -	if ((unshare_flags & CLONE_SIGHAND) &&
> -	    (sigh && atomic_read(&sigh->count) > 1))
> +	if ((unshare_flags & CLONE_SIGHAND) && atomic_read(&sigh->count) > 1)
>  		return -EINVAL;
>  	else
>  		return 0;
> @@ -1605,7 +1603,7 @@ asmlinkage long sys_unshare(unsigned lon
>  	int err = 0;
>  	struct fs_struct *fs, *new_fs = NULL;
>  	struct mnt_namespace *ns, *new_ns = NULL;
> -	struct sighand_struct *sigh, *new_sigh = NULL;
> +	struct sighand_struct *new_sigh = NULL;
>  	struct mm_struct *mm, *new_mm = NULL, *active_mm = NULL;
>  	struct files_struct *fd, *new_fd = NULL;
>  	struct sem_undo_list *new_ulist = NULL;
> @@ -1650,7 +1648,7 @@ asmlinkage long sys_unshare(unsigned lon
>  		}
>  	}
>  
> -	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
> +	if (new_fs || new_ns || new_mm || new_fd || new_ulist ||
>  				new_uts || new_ipc) {
>  
>  		task_lock(current);
> @@ -1672,12 +1670,6 @@ asmlinkage long sys_unshare(unsigned lon
>  			new_ns = ns;
>  		}
>  
> -		if (new_sigh) {
> -			sigh = current->sighand;
> -			rcu_assign_pointer(current->sighand, new_sigh);
> -			new_sigh = sigh;
> -		}
> -
>  		if (new_mm) {
>  			mm = current->mm;
>  			active_mm = current->active_mm;
> 

