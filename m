Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWFTUZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWFTUZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWFTUYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:24:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55715 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750902AbWFTUYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:24:51 -0400
Date: Tue, 20 Jun 2006 13:24:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm1
Message-Id: <20060620132431.e00a5c68.akpm@osdl.org>
In-Reply-To: <1150825349.2891.219.camel@laptopd505.fenrus.org>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	<20060608050047.GB16729@redhat.com>
	<1150825349.2891.219.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 19:42:29 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

>  /*
> + * Lock a file handle/inode to be used as parent dir for another
> + * NOTE: both fh_lock and fh_unlock are done "by hand" in
> + * vfs.c:nfsd_rename as it needs to grab 2 i_mutex's at once
> + * so, any changes here should be reflected there.
> + */
> +static inline void
> +fh_lock_parent(struct svc_fh *fhp)
> +{
> +	struct dentry	*dentry = fhp->fh_dentry;
> +	struct inode	*inode;
> +
> +	dfprintk(FILEOP, "nfsd: fh_lock(%s) locked = %d\n",
> +			SVCFH_fmt(fhp), fhp->fh_locked);
> +
> +	if (!fhp->fh_dentry) {
> +		printk(KERN_ERR "fh_lock: fh not verified!\n");
> +		return;
> +	}
> +	if (fhp->fh_locked) {
> +		printk(KERN_WARNING "fh_lock: %s/%s already locked!\n",
> +			dentry->d_parent->d_name.name, dentry->d_name.name);
> +		return;
> +	}
> +
> +	inode = dentry->d_inode;
> +	mutex_lock_nested(&inode->i_mutex, I_MUTEX_PARENT);
> +	fill_pre_wcc(fhp);
> +	fhp->fh_locked = 1;
> +}

yikes, five callsites, and fill_pre_wcc() is inlined too.

This is all farily intrusive.
