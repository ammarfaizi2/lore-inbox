Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUIIPs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUIIPs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUIIPsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:48:20 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29057 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266009AbUIIPqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:46:02 -0400
Date: Thu, 9 Sep 2004 17:44:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch][9/9] block: remove bio walking
Message-ID: <20040909154453.GG1737@suse.de>
References: <200409082127.04331.bzolnier@elka.pw.edu.pl> <200409091553.13918.bzolnier@elka.pw.edu.pl> <20040909150444.C6434@flint.arm.linux.org.uk> <200409091628.25304.bzolnier@elka.pw.edu.pl> <20040909155420.D6434@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909155420.D6434@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09 2004, Russell King wrote:
> Essentially, kernel PIO writes data into the page cache, and that action
> may leave data in the CPU's caches.  Since the kernels mappings may not
> be coherent with mappings in userspace, data written to the kernel
> mappings may remain in the data cache, and stale data would be visible
> to user space.
> 
> There has been talk about using flush_dcache_page() to resolve
> this issue, but I'm not sure what the outcome was.  Certainly
> flush_dcache_page() is supposed to be used before the data in the
> kernels page cache is read or written.

Have you ever tested bouncing on arm? It seems to be lacking a
flush_dcache_page() indeed, how does this look?

===== mm/highmem.c 1.51 vs edited =====
--- 1.51/mm/highmem.c	2004-07-29 06:58:32 +02:00
+++ edited/mm/highmem.c	2004-09-09 17:44:14 +02:00
@@ -301,6 +301,7 @@
 		vfrom = page_address(fromvec->bv_page) + tovec->bv_offset;
 
 		bounce_copy_vec(tovec, vfrom);
+		flush_dcache_page(tovec->bv_page);
 	}
 }
 

-- 
Jens Axboe

