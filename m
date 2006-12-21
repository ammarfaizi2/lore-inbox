Return-Path: <linux-kernel-owner+w=401wt.eu-S1422997AbWLURvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422997AbWLURvf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 12:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422996AbWLURvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 12:51:35 -0500
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:59794 "EHLO
	mail-gw1.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422993AbWLURve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 12:51:34 -0500
To: rmk+lkml@arm.linux.org.uk
CC: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-reply-to: <20061221165744.GD3958@flint.arm.linux.org.uk> (message from
	Russell King on Thu, 21 Dec 2006 16:57:44 +0000)
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221165744.GD3958@flint.arm.linux.org.uk>
Message-Id: <E1GxS4e-0000pb-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 21 Dec 2006 18:51:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 21, 2006 at 04:53:56PM +0100, Miklos Szeredi wrote:
> > I'll first answer the last paragraph.
> > 
> > > I suggest that in order for fuse to work reliably on ARM, it is modified
> > > to behave more like a reasonable device driver, and use the functions
> > > defined in asm/uaccess.h when it wants to access the current processes
> > > VM space.
> > 
> > Fuse needs to use get_user_pages() to work around certain deadlock
> > scenarios (see Documentation/filesystems/fuse.txt), that are
> > problematic with copy_*_user().
> 
> Hmm, okay (though the documentation doesn't really provide enough
> explaination for me to get a grasp of exactly what's going on.)

The root of the problem is that copy_to_user() may cause page faults
on the userspace buffer, and the page fault might (in case of a
maliciously crafted filesystem) recurse into the filesystem itself.

This applies to get_user_pages() as well, but in that case the
function taking the fault is different from the one doing the copy,
hence the original request can be aborted while in get_user_pages().

It cannot be aborted during the copy (since data belonging to the
original request is still being used), but unlike copy_to_user(),
memcpy() will never block.

> > > However, and this is the problem, we need cache maintainence _after_
> > > that memcpy() has completed - with a write allocate VIVT cache, the
> > > memcpy() itself will allocate cache lines in the kernel mapping of
> > > the page which will need to be written back for the user process to
> > > see that data.
> > 
> > Yes, note the flush_dcache_page() call in fuse_copy_finish().  That
> > could be replaced by the flush_kernel_dcache_page() (added by James
> > Bottomley together with flush_anon_page()) when all relevant
> > architectures have defined it.
> 
> I'm not entirely convinced that it can be replaced.  What if the page
> is in the page cache and is shared with other processes?  That quite
> clearly falls under flush_dcache_page()'s remit.

But flush_dcache_page() has already been called in get_user_pages(),
so the user mappings are flushed before copying the data to the kernel
mapping, and only the kernel mapping need to be flushed _after_ the
copying.

> > > Now, throw in SMP or preempt with a multi-threaded userspace program
> > > touching the page in question, and the problem just gets much much
> > > worse.  In such a scenario, we can not guarantee, no matter how much
> > > cache maintainence is applied to the kernel, that this API comes
> > > anywhere near to being safe.
> > 
> > This is only problematic if multiple threads are touching the same
> > page, no?  If the page(s) used for reading/writing requests are
> > exclusive to each thread, then there should be no problem.  This is a
> > reasonable requirement towards the userspace filesystem I think.
> 
> Such a restriction needs to be clearly documented against get_user_pages()
> so that users don't expect something from it which it can't deliver.

Agreed.

Miklos
