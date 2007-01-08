Return-Path: <linux-kernel-owner+w=401wt.eu-S1161267AbXAHMgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161267AbXAHMgz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 07:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbXAHMgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 07:36:55 -0500
Received: from amsfep20-int.chello.nl ([62.179.120.15]:46478 "EHLO
	amsfep20-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161267AbXAHMgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 07:36:54 -0500
Subject: Re: [PATCH -rt] scheduling while atomic in remove_proc_entry()
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Daniel Walker <dwalker@mvista.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20061229211237.690413000@mvista.com>
References: <20061229211237.690413000@mvista.com>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 13:20:02 +0100
Message-Id: <1168258802.6235.18.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-29 at 13:12 -0800, Daniel Walker wrote:

> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> ---
>  fs/proc/generic.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.19/fs/proc/generic.c
> ===================================================================
> --- linux-2.6.19.orig/fs/proc/generic.c
> +++ linux-2.6.19/fs/proc/generic.c
> @@ -555,7 +555,6 @@ static void proc_kill_inodes(struct proc
>  	/*
>  	 * Actually it's a partial revoke().
>  	 */
> -	filevec_add_drain_all();
>  	lock_list_for_each_entry(filp, &sb->s_files, f_u.fu_llist) {
>  		struct dentry * dentry = filp->f_path.dentry;
>  		struct inode * inode;
> @@ -738,6 +737,8 @@ void remove_proc_entry(const char *name,
>  		break;
>  	}
>  	spin_unlock(&proc_subdir_lock);
> +
> +	filevec_add_drain_all();
>  out:
>  	return;
>  }

Well, no. Draining after the inspect 'all' loop doesn't make sense, but
looking at 2.6.20-rc3-rt0 remove_proc_entry() looks sane.

