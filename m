Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbUERMc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUERMc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 08:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUERMc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 08:32:57 -0400
Received: from pop.gmx.net ([213.165.64.20]:65184 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263188AbUERMcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 08:32:35 -0400
X-Authenticated: #18147109
From: Gerald Schaefer <gerald.schaefer@gmx.net>
Reply-To: gerald.schaefer@gmx.net
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrink hash sizes on small machines, take 2
Date: Tue, 18 May 2004 14:32:24 +0200
User-Agent: KMail/1.6.2
Cc: mpm@selenic.com
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405181432.24895.gerald.schaefer@gmx.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004, Matt Mackall wrote:
> Base hash sizes on available memory rather than total memory. An
> additional 50% above current used memory is considered reserved for
> the purposes of hash sizing to compensate for the hashes themselves
> and the remainder of kernel and userspace initialization.
> 
> Index: tiny/fs/dcache.c
> ===================================================================
> --- tiny.orig/fs/dcache.c	2004-03-25 13:36:09.000000000 -0600
> +++ tiny/fs/dcache.c	2004-04-10 18:14:42.000000000 -0500
> @@ -28,6 +28,7 @@
>  #include <asm/uaccess.h>
>  #include <linux/security.h>
>  #include <linux/seqlock.h>
> +#include <linux/swap.h>
>  
>  #define DCACHE_PARANOIA 1
>  /* #define DCACHE_DEBUG 1 */
> @@ -1619,13 +1620,21 @@
> 
>  void __init vfs_caches_init(unsigned long mempages)
>  {
> -	names_cachep = kmem_cache_create("names_cache", 
> -			PATH_MAX, 0, 
> +	unsigned long reserve;
> +
> +	/* Base hash sizes on available memory, with a reserve equal to
> +           150% of current kernel size */
> +
> +	reserve = (mempages - nr_free_pages()) * 3/2;
> +	mempages -= reserve;

This calculation doesn't sound right. The value of mempages is set to
num_physpages from the calling function start_kernel(), which also
includes pages from a potential "mem=" kernel parameter (which we use
for reserving memory to load DCSS segments on z/VM).

Whenever the amount of reserved pages goes above some limit (for whatever
reason, not only with "mem="), this calculation results in a negative value
for mempages, respectively a very large value due to "unsigned long".

I am not on the mailing list, so please put me on cc if you answer.

--
Gerald
