Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbTENKoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 06:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTENKoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 06:44:13 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:55056 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261855AbTENKoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 06:44:10 -0400
Date: Wed, 14 May 2003 11:56:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] PAG support, try #2
Message-ID: <20030514115653.A15202@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	openafs-devel@openafs.org
References: <24225.1052909011@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <24225.1052909011@warthog.warthog>; from dhowells@redhat.com on Wed, May 14, 2003 at 11:43:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 11:43:31AM +0100, David Howells wrote:
> +extern long sys_setpag(pag_t);
> +extern long sys_getpag(void);

These have to be a marked asmlinkage.  What's the reason you have
the syscall in this header anyway?

> +static kmem_cache_t *vfs_token_cache;
> +static kmem_cache_t *vfs_pag_cache;

So do you have an estimate for the number of users here yet?
Adding two more slab caches that are unused for 99% of the users
might not be the best choice if there's no strong need.

> +inline pag_t vfs_leave_pag(void)

Inline but not static seems strange..

> +/*
> + * join an existing PAG (+ve), run without PAG (0), or create and join new PAG (-1)
> + * - PAG IDs must be +ve, >0 and unique
> + * - returns ID of PAG joined or 0 if now running without a PAG
> + */
> +long sys_setpag(pag_t pag)
> +{
> +	if (pag > 0)		return vfs_join_pag(pag);
> +	else if (pag == 0)	return vfs_leave_pag();
> +	else if (pag == -1)	return vfs_new_pag();
> +	else			return -EINVAL;
> +}

We already discussed the coding style issue, but anyway, why aren't
these three separate syscalls?

> +void vfs_pag_put(struct vfs_pag *vfspag)
> +{
> +	struct vfs_token *vtoken;
> +
> +	if (vfspag && atomic_dec_and_lock(&vfspag->usage, &vfs_pag_lock)) {
> +		rb_erase(&vfspag->node, &vfs_pag_tree);
> +		spin_unlock(&vfs_pag_lock);
> +
> +		while (!list_empty(&vfspag->tokens)) {

What protects vfspag->tokens?

> +/*
> + * search for a token covering a particular filesystem key in the specified pag list
> + */

Please linwrap after 80 chars.

> +
> +	if (p->vfspag)
> +		vfs_pag_get(p->vfspag);
> +

Shouldn't vfs_pag_get hanlde a NULL argument instead?

> diff -uNr linux-2.5.69/kernel/Makefile linux-2.5.69-pag/kernel/Makefile
> --- linux-2.5.69/kernel/Makefile	2003-05-06 15:04:56.000000000 +0100
> +++ linux-2.5.69-pag/kernel/Makefile	2003-05-13 10:45:27.000000000 +0100
> @@ -3,7 +3,7 @@
>  #
>  
>  obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
> -	    exit.o itimer.o time.o softirq.o resource.o \
> +	    cred.o exit.o itimer.o time.o softirq.o resource.o \

What happened to the suggestion to make the pag code optional?  It's
really easy to stub it out properly and most people don't need it.

