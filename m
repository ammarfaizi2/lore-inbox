Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263298AbVGOKyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbVGOKyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVGOKvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:51:40 -0400
Received: from ns2.suse.de ([195.135.220.15]:37301 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262456AbVGOKt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:49:56 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE LINUX Products GMBH
To: Akinobu Mita <amgta@yacht.ocn.ne.jp>
Subject: Re: [PATCH] mb_cache_shrink() frees unexpected caches
Date: Fri, 15 Jul 2005 12:49:52 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
References: <1121346444.4282.8.camel@localhost.localdomain>
In-Reply-To: <1121346444.4282.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507151249.52294.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thursday 14 July 2005 15:07, Akinobu Mita wrote:
> mb_cache_shrink() tries to free all sort of mbcache in the lru list.
>
> All user of mb_cache_shrink() are ext2/ext3 xattr.
>
> Signed-off-by: Akinobu Mita <amgta@yacht.ocn.ne.jp>
>
> --- 2.6-rc/fs/mbcache.c.orig	2005-07-14 20:40:34.000000000 +0900
> +++ 2.6-rc/fs/mbcache.c	2005-07-14 20:43:42.000000000 +0900
> @@ -329,7 +329,7 @@ mb_cache_shrink(struct mb_cache *cache,
>  	list_for_each_safe(l, ltmp, &mb_cache_lru_list) {
>  		struct mb_cache_entry *ce =
>  			list_entry(l, struct mb_cache_entry, e_lru_list);
> -		if (ce->e_bdev == bdev) {
> +		if (ce->e_cache == cache && ce->e_bdev == bdev) {
>  			list_move_tail(&ce->e_lru_list, &free_list);
>  			__mb_cache_entry_unhash(ce);
>  		}

this patch looks bogus to me. How could the cache contain entries for the same 
block_device from different file systems? The block_device is sufficient to 
identify the file system, and hence its cache entries.

Also, the additional check would only tell ext2 from ext3; the caches are not 
per-filesystem.

-- Andreas.
