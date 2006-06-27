Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161339AbWF0Wwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161339AbWF0Wwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161341AbWF0Wwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:52:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161339AbWF0Wwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:52:40 -0400
Date: Tue, 27 Jun 2006 15:55:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, aviro@redhat.com, neilb@suse.de, jblunck@suse.de,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       dhowells@redhat.com
Subject: Re: [PATCH] Destroy the dentries contributed by a superblock on
 unmounting
Message-Id: <20060627155549.786724cf.akpm@osdl.org>
In-Reply-To: <3087.1151403431@warthog.cambridge.redhat.com>
References: <18192.1151320860@warthog.cambridge.redhat.com>
	<17567.31035.471039.999828@cse.unsw.edu.au>
	<17566.12727.489041.220653@cse.unsw.edu.au>
	<17564.52290.338084.934211@cse.unsw.edu.au>
	<15603.1150978967@warthog.cambridge.redhat.com>
	<553.1151156031@warthog.cambridge.redhat.com>
	<20946.1151251352@warthog.cambridge.redhat.com>
	<3087.1151403431@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> The attached patch destroys all the dentries attached to a superblock in one go
>  /*
> + * destroy a single subtree of dentries for unmount
> + * - see the comments on shrink_dcache_for_umount() for a description of the
> + *   locking
> + */
> +static void shrink_dcache_for_umount_subtree(struct dentry *dentry)
> +{
> +	struct dentry *parent;
> +
> +	BUG_ON(!IS_ROOT(dentry));
> +
> +	/* detach this root from the system */
> +	spin_lock(&dcache_lock);
> +	if (!list_empty(&dentry->d_lru)) {
> +		dentry_stat.nr_unused--;
> +		list_del_init(&dentry->d_lru);
> +	}
> +	__d_drop(dentry);
> +	spin_unlock(&dcache_lock);
> +
> +	for (;;) {
> +		/* descend to the first leaf in the current subtree */
> +		while (!list_empty(&dentry->d_subdirs)) {
> +			struct dentry *loop;
> +
> +			/* this is a branch with children - detach all of them
> +			 * from the system in one go */
> +			spin_lock(&dcache_lock);
> +			list_for_each_entry(loop, &dentry->d_subdirs,
> +					    d_u.d_child) {
> +				if (!list_empty(&loop->d_lru)) {
> +					dentry_stat.nr_unused--;
> +					list_del_init(&loop->d_lru);
> +				}
> +
> +				__d_drop(loop);
> +				cond_resched_lock(&dcache_lock);
> +			}
> +			spin_unlock(&dcache_lock);

Is the cond_resched_lock() here safe?  Once we've dropped that lock, the
list cursor `loop' is invalidated?

If all lookup paths to all entries on this list are removed at this time
then OK - but these dentries are still on the LRU..

(An answer-via-comment-patch would suit ;))

