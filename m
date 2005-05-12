Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVELCbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVELCbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 22:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVELCbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 22:31:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:5518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261310AbVELCay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 22:30:54 -0400
Date: Wed, 11 May 2005 19:29:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix of dcache race leading to busy inodes on umount
Message-Id: <20050511192942.07614243.akpm@osdl.org>
In-Reply-To: <42822A2A.6000909@sw.ru>
References: <42822A2A.6000909@sw.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> This patch fixes dcache race between shrink_dcache_XXX functions
> and dput().


> -void dput(struct dentry *dentry)
> +static void dput_recursive(struct dentry *dentry, struct dcache_shrinker *ds)
>  {
> -	if (!dentry)
> -		return;
> -
> -repeat:
>  	if (atomic_read(&dentry->d_count) == 1)
>  		might_sleep();
>  	if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
>  		return;
> +	dcache_shrinker_del(ds);
>  
> +repeat:
>  	spin_lock(&dentry->d_lock);
>  	if (atomic_read(&dentry->d_count)) {
>  		spin_unlock(&dentry->d_lock);
> @@ -182,6 +253,7 @@ unhash_it:
>  
>  kill_it: {
>  		struct dentry *parent;
> +		struct dcache_shrinker lds;
>  
>  		/* If dentry was on d_lru list
>  		 * delete it from there
> @@ -191,18 +263,43 @@ kill_it: {
>    			dentry_stat.nr_unused--;
>    		}
>    		list_del(&dentry->d_child);
> +		parent = dentry->d_parent;
> +		dcache_shrinker_add(&lds, parent, dentry);
>  		dentry_stat.nr_dentry--;	/* For d_free, below */
>  		/*drops the locks, at that point nobody can reach this dentry */
>  		dentry_iput(dentry);
> -		parent = dentry->d_parent;
>  		d_free(dentry);
>  		if (dentry == parent)

Aren't we leaving local variable `lds' on the global list here?

>  			return;
>  		dentry = parent;
> -		goto repeat;
> +		spin_lock(&dcache_lock);
> +		dcache_shrinker_del(&lds);
> +		if (atomic_dec_and_test(&dentry->d_count))
> +			goto repeat;
> +		spin_unlock(&dcache_lock);
>  	}
>  }
> 

--- 25/fs/dcache.c~fix-of-dcache-race-leading-to-busy-inodes-on-umount-fix	2005-05-11 19:24:23.000000000 -0700
+++ 25-akpm/fs/dcache.c	2005-05-11 19:27:27.000000000 -0700
@@ -269,8 +269,12 @@ kill_it: {
 		/*drops the locks, at that point nobody can reach this dentry */
 		dentry_iput(dentry);
 		d_free(dentry);
-		if (dentry == parent)
+		if (unlikely(dentry == parent)) {
+			spin_lock(&dcache_lock);
+			dcache_shrinker_del(&lds);
+			spin_unlock(&dcache_lock);
 			return;
+		}
 		dentry = parent;
 		spin_lock(&dcache_lock);
 		dcache_shrinker_del(&lds);
_

