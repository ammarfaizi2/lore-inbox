Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbUBZXfM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbUBZXek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:34:40 -0500
Received: from alt.aurema.com ([203.217.18.57]:5510 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261285AbUBZXbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:31:34 -0500
Date: Fri, 27 Feb 2004 10:29:55 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, peter@chubb.wattle.id.au, linux-kernel@vger.kernel.org,
       dan@debian.org
Subject: Re: /proc visibility patch breaks GDB, etc.
Message-ID: <20040227102955.B21764@aurema.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com,
	peter@chubb.wattle.id.au, linux-kernel@vger.kernel.org,
	dan@debian.org
References: <16445.37304.155370.819929@wombat.chubb.wattle.id.au> <20040225224410.3eb21312.akpm@osdl.org> <16446.19305.637880.99704@napali.hpl.hp.com> <20040226120959.35b284ff.akpm@osdl.org> <20040227085941.A21764@aurema.com> <20040226151917.404af252.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040226151917.404af252.akpm@osdl.org>; from akpm@osdl.org on Thu, Feb 26, 2004 at 03:19:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 03:19:17PM -0800, Andrew Morton wrote:
> Kingsley Cheung <kingsley@aurema.com> wrote:
> >
> > Am I correct to assume though that the corresponding change in
> > proc_task_lookup() should stay?  The existing behaviour there was that
> > one could do say,
> > 
> > cat /proc/<pid>/task/<tid>/stat, where tid could be any thread and not
> > a part of the thread group pid.  
> 
> That sounds especially broken - let's hope that nobody has started using it
> (but how did you even discover this?  Code audit?)

Completely an accident on my part.  While writing code to traverse
threads in a group and obtain their data usage, I was comparing what I
could see from the output with the shell and I just happened to do a
typo on the tid value... To my suprise it worked.

> 
> How's this?

Looks like proc_pid_lookup() was never changed at all :)

> 
> diff -puN fs/proc/base.c~proc-thread-visibility-revert fs/proc/base.c
> --- 25/fs/proc/base.c~proc-thread-visibility-revert	Thu Feb 26 15:17:48 2004
> +++ 25-akpm/fs/proc/base.c	Thu Feb 26 15:17:48 2004
> @@ -1582,13 +1582,14 @@ struct dentry *proc_pid_lookup(struct in
>  	read_unlock(&tasklist_lock);
>  	if (!task)
>  		goto out;
> -	if (!thread_group_leader(task))
> -		goto out_drop_task;
>  
>  	inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO);
>  
> -	if (!inode)
> -		goto out_drop_task;
> +
> +	if (!inode) {
> +		put_task_struct(task);
> +		goto out;
> +	}
>  	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
>  	inode->i_op = &proc_tgid_base_inode_operations;
>  	inode->i_fop = &proc_tgid_base_operations;
> @@ -1613,8 +1614,6 @@ struct dentry *proc_pid_lookup(struct in
>  		goto out;
>  	}
>  	return NULL;
> -out_drop_task:
> -	put_task_struct(task);
>  out:
>  	return ERR_PTR(-ENOENT);
>  }
> 
> _

-- 
		Kingsley
