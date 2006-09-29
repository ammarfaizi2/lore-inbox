Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161439AbWI2GaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161439AbWI2GaM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161437AbWI2GaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:30:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161439AbWI2GaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:30:10 -0400
Date: Thu, 28 Sep 2006 23:29:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>, "David M. Grimes" <dgrimes@navisite.com>,
       Atal Shargorodsky <atal@codefidence.com>,
       Gilad Ben-Yossef <gilad@codefidence.com>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 001 of 8] knfsd: Add nfs-export support to tmpfs
Message-Id: <20060928232953.6da08f19.akpm@osdl.org>
In-Reply-To: <1060929030839.24024@suse.de>
References: <20060929130518.23919.patches@notabene>
	<1060929030839.24024@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 13:08:39 +1000
NeilBrown <neilb@suse.de> wrote:

> +static int shmem_encode_fh(struct dentry *dentry, __u32 *fh, int *len, int connectable)
> +{
> +	struct inode *inode = dentry->d_inode;
> +
> +	if (*len < 2)
> +		return 255;
> +
> +	if (hlist_unhashed(&inode->i_hash)) {
> +		/* Unfortunately insert_inode_hash is not idempotent,
> +		 * so as we hash inodes here rather than at creation
> +		 * time, we need a lock to ensure we only try
> +		 * to do it once
> +		 */
> +		static DEFINE_SPINLOCK(lock);
> +		spin_lock(&lock);
> +		if (hlist_unhashed(&inode->i_hash))
> +			insert_inode_hash(inode);
> +		spin_unlock(&lock);
> +	}

This looks fishy.

How do we get two callers in here at the same time for the same inode?

Why don't other filesystems have the same problem?


