Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTE0WRy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264244AbTE0WRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:17:54 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:50568 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S264219AbTE0WRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:17:50 -0400
Subject: Re: [PATCH] mark shrinkable slabs as being reclaimable
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@digeo.com
In-Reply-To: <200305252319.h4PNJkpJ027852@hera.kernel.org>
References: <200305252319.h4PNJkpJ027852@hera.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054074662.26966.4.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Tue, 27 May 2003 23:31:02 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, akpm@digeo.com
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-25 at 23:11, Linux Kernel Mailing List wrote:
> ChangeSet 1.1308, 2003/05/25 15:11:47-07:00, akpm@digeo.com
> 
> 	[PATCH] mark shrinkable slabs as being reclaimable
> 	
> 	All slabs which can be reclaimed via VM presure are marked as being
> 	shrinkable, so the core slab code will keep count of their pages.

If my understanding of this is correct -- stuff that will be freed on
prune_icache() or other memory pressure should be marked such -- then...

> diff -Nru a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
> --- a/fs/jffs/inode-v23.c	Sun May 25 16:19:51 2003
> +++ b/fs/jffs/inode-v23.c	Sun May 25 16:19:51 2003
> @@ -1806,9 +1806,11 @@
>  	jffs_proc_root = proc_mkdir("jffs", proc_root_fs);
>  #endif
>  	fm_cache = kmem_cache_create("jffs_fm", sizeof(struct jffs_fm),
> -				     0, SLAB_HWCACHE_ALIGN, NULL, NULL);
> +				     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT, 
> +				     NULL, NULL);

No.

>  	node_cache = kmem_cache_create("jffs_node",sizeof(struct jffs_node),
> -				       0, SLAB_HWCACHE_ALIGN, NULL, NULL);
> +				       0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT, 
> +				       NULL, NULL);

No.

> diff -Nru a/fs/jffs2/malloc.c b/fs/jffs2/malloc.c
> --- a/fs/jffs2/malloc.c	Sun May 25 16:19:51 2003
> +++ b/fs/jffs2/malloc.c	Sun May 25 16:19:51 2003
> @@ -73,7 +73,8 @@
>  
>  	inode_cache_slab = kmem_cache_create("jffs2_inode_cache",
>  					     sizeof(struct jffs2_inode_cache),
> -					     0, JFFS2_SLAB_POISON, NULL, NULL);
> +					     0, JFFS2_SLAB_POISON|SLAB_RECLAIM_ACCOUNT, 
> +					     NULL, NULL);

No.

> --- a/fs/jffs2/super.c	Sun May 25 16:19:51 2003
> +++ b/fs/jffs2/super.c	Sun May 25 16:19:51 2003
> @@ -299,7 +299,7 @@
>  
>  	jffs2_inode_cachep = kmem_cache_create("jffs2_i",
>  					     sizeof(struct jffs2_inode_info),
> -					     0, SLAB_HWCACHE_ALIGN,
> +					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
>  					     jffs2_i_init_once, NULL);

Yes.

-- 
dwmw2


