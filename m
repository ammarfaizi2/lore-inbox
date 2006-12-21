Return-Path: <linux-kernel-owner+w=401wt.eu-S1422973AbWLUQ6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422973AbWLUQ6H (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 11:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422975AbWLUQ6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 11:58:06 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4921 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422973AbWLUQ6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 11:58:05 -0500
Date: Thu, 21 Dec 2006 16:57:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20061221165744.GD3958@flint.arm.linux.org.uk>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 04:53:56PM +0100, Miklos Szeredi wrote:
> I'll first answer the last paragraph.
> 
> > I suggest that in order for fuse to work reliably on ARM, it is modified
> > to behave more like a reasonable device driver, and use the functions
> > defined in asm/uaccess.h when it wants to access the current processes
> > VM space.
> 
> Fuse needs to use get_user_pages() to work around certain deadlock
> scenarios (see Documentation/filesystems/fuse.txt), that are
> problematic with copy_*_user().

Hmm, okay (though the documentation doesn't really provide enough
explaination for me to get a grasp of exactly what's going on.)

> > However, and this is the problem, we need cache maintainence _after_
> > that memcpy() has completed - with a write allocate VIVT cache, the
> > memcpy() itself will allocate cache lines in the kernel mapping of
> > the page which will need to be written back for the user process to
> > see that data.
> 
> Yes, note the flush_dcache_page() call in fuse_copy_finish().  That
> could be replaced by the flush_kernel_dcache_page() (added by James
> Bottomley together with flush_anon_page()) when all relevant
> architectures have defined it.

I'm not entirely convinced that it can be replaced.  What if the page
is in the page cache and is shared with other processes?  That quite
clearly falls under flush_dcache_page()'s remit.

> > Now, throw in SMP or preempt with a multi-threaded userspace program
> > touching the page in question, and the problem just gets much much
> > worse.  In such a scenario, we can not guarantee, no matter how much
> > cache maintainence is applied to the kernel, that this API comes
> > anywhere near to being safe.
> 
> This is only problematic if multiple threads are touching the same
> page, no?  If the page(s) used for reading/writing requests are
> exclusive to each thread, then there should be no problem.  This is a
> reasonable requirement towards the userspace filesystem I think.

Such a restriction needs to be clearly documented against get_user_pages()
so that users don't expect something from it which it can't deliver.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
