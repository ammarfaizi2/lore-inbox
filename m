Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWEXBle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWEXBle (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 21:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWEXBle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:41:34 -0400
Received: from xenotime.net ([66.160.160.81]:35815 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932175AbWEXBld convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:41:33 -0400
Date: Tue, 23 May 2006 18:44:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists.
Message-Id: <20060523184407.dc8b4a2b.rdunlap@xenotime.net>
In-Reply-To: <20060524012412.GB7412499@melbourne.sgi.com>
References: <20060524012412.GB7412499@melbourne.sgi.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006 11:24:12 +1000 David Chinner wrote:

> Index: 2.6.x-xfs-new/fs/dcache.c
> ===================================================================
> --- 2.6.x-xfs-new.orig/fs/dcache.c	2006-05-15 16:24:44.212207654 +1000
> +++ 2.6.x-xfs-new/fs/dcache.c	2006-05-16 14:00:46.327462206 +1000
> @@ -114,6 +113,38 @@ static void dentry_iput(struct dentry * 
>  	}
>  }
>  
> +static void
> +dentry_lru_add(struct dentry *dentry)
> +{
> +	list_add(&dentry->d_lru, &dentry->d_sb->s_dentry_lru);
> +	dentry_stat.nr_unused++;
> +}
> +
> +static void
> +dentry_lru_add_tail(struct dentry *dentry)
> +{
> +	list_add_tail(&dentry->d_lru, &dentry->d_sb->s_dentry_lru);
> +	dentry_stat.nr_unused++;
> +}
> +
> +static void
> +dentry_lru_del(struct dentry *dentry)
> +{
> +	if (!list_empty(&dentry->d_lru)) {
> +		list_del(&dentry->d_lru);
> +		dentry_stat.nr_unused--;
> +	}
> +}
> +
> +static void
> +dentry_lru_del_init(struct dentry *dentry)
> +{
> +	if (likely(!list_empty(&dentry->d_lru))) {
> +		list_del_init(&dentry->d_lru);
> +		dentry_stat.nr_unused--;
> +	}
> +}
> +
>  /* 
>   * This is dput
>   *

Please use regular kernel coding style for functions:
don't put qualifiers and names on separate lines.

> @@ -377,6 +399,48 @@ static inline void prune_one_dentry(stru
>  	spin_lock(&dcache_lock);
>  }
>  
> +/*
> + * Shrink the dentry LRU on æ given superblock.

on ? given superblock ?

> + */
> +static void
> +__shrink_dcache_sb(struct super_block *sb, int *count, int flags)
> +{


---
~Randy
