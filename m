Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUEDWii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUEDWii (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUEDWii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:38:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:61648 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261232AbUEDWig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:38:36 -0400
Date: Tue, 4 May 2004 15:40:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: mbligh@aracnet.com, rmk@arm.linux.org.uk, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap 22 flush_dcache_mmap_lock
Message-Id: <20040504154057.73770fe8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0405042320100.2156-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0405042315160.2156-100000@localhost.localdomain>
	<Pine.LNX.4.44.0405042320100.2156-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> --- rmap21/include/asm-i386/cacheflush.h	2003-10-08 20:24:56.000000000 +0100
> +++ rmap22/include/asm-i386/cacheflush.h	2004-05-04 21:21:50.956096280 +0100
> @@ -10,6 +10,8 @@
>  #define flush_cache_range(vma, start, end)	do { } while (0)
>  #define flush_cache_page(vma, vmaddr)		do { } while (0)
>  #define flush_dcache_page(page)			do { } while (0)
> +#define flush_dcache_mmap_lock(mapping)		do { } while (0)
> +#define flush_dcache_mmap_unlock(mapping)	do { } while (0)

Looks like this patch will break a lot of architectures.  Was that
intentional?

If not, and if you expect that all other architectures do not need the lock
then the above could be cast as:

#ifndef flush_dcache_mmap_lock
#define flush_dcache_mmap_lock(mapping)		do { } while (0)
#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
#endif

in some generic file.

wrt overloading of tree_lock: The main drawback is that the VM lock ranking
is now dependent upon the architecture.  That, plus the dang thing is
undocumented!

And it seems strange to be grabbing that lock expecting that it will
protect the tree which is elsewhere protected by a different lock.  You
sure this is correct?

I wonder if it wouldn't be better to simply make i_shared_lock irq-safe?
