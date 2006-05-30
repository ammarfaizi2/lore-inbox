Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWE3Beg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWE3Beg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWE3Bbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:31:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932109AbWE3Bbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:31:32 -0400
Date: Mon, 29 May 2006 18:35:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 37/61] lock validator: special locking: dcache
Message-Id: <20060529183539.08d3463c.akpm@osdl.org>
In-Reply-To: <20060529212608.GK3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212608.GK3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:26:08 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> teach special (recursive) locking code to the lock validator. Has no
> effect on non-lockdep kernels.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  fs/dcache.c            |    6 +++---
>  include/linux/dcache.h |   12 ++++++++++++
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> Index: linux/fs/dcache.c
> ===================================================================
> --- linux.orig/fs/dcache.c
> +++ linux/fs/dcache.c
> @@ -1380,10 +1380,10 @@ void d_move(struct dentry * dentry, stru
>  	 */
>  	if (target < dentry) {
>  		spin_lock(&target->d_lock);
> -		spin_lock(&dentry->d_lock);
> +		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
>  	} else {
>  		spin_lock(&dentry->d_lock);
> -		spin_lock(&target->d_lock);
> +		spin_lock_nested(&target->d_lock, DENTRY_D_LOCK_NESTED);
>  	}
>  
>  	/* Move the dentry to the target hash queue, if on different bucket */
> @@ -1420,7 +1420,7 @@ already_unhashed:
>  	}
>  
>  	list_add(&dentry->d_u.d_child, &dentry->d_parent->d_subdirs);
> -	spin_unlock(&target->d_lock);
> +	spin_unlock_non_nested(&target->d_lock);
>  	fsnotify_d_move(dentry);
>  	spin_unlock(&dentry->d_lock);
>  	write_sequnlock(&rename_lock);
> Index: linux/include/linux/dcache.h
> ===================================================================
> --- linux.orig/include/linux/dcache.h
> +++ linux/include/linux/dcache.h
> @@ -114,6 +114,18 @@ struct dentry {
>  	unsigned char d_iname[DNAME_INLINE_LEN_MIN];	/* small names */
>  };
>  
> +/*
> + * dentry->d_lock spinlock nesting types:
> + *
> + * 0: normal
> + * 1: nested
> + */
> +enum dentry_d_lock_type
> +{
> +	DENTRY_D_LOCK_NORMAL,
> +	DENTRY_D_LOCK_NESTED
> +};
> +
>  struct dentry_operations {
>  	int (*d_revalidate)(struct dentry *, struct nameidata *);
>  	int (*d_hash) (struct dentry *, struct qstr *);

DENTRY_D_LOCK_NORMAL isn't used anywhere.

