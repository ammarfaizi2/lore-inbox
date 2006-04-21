Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWDUJVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWDUJVa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 05:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWDUJV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 05:21:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34876 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751097AbWDUJV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 05:21:29 -0400
Date: Fri, 21 Apr 2006 11:21:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, davem@davemloft.net
Subject: Re: [PATCH] sys_vmsplice
Message-ID: <20060421092158.GE4717@suse.de>
References: <20060421080239.GC4717@suse.de> <20060421021702.20049dcd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421021702.20049dcd.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > ...
> >
> > sys_splice() moves data to/from pipes with a file input/output. sys_vmsplice()
> > moves data to a pipe, with the input being a user address range instead.
> > 
> > ...
> >
> > +static void *user_page_pipe_buf_map(struct file *file,
> > +				    struct pipe_inode_info *pipe,
> > +				    struct pipe_buffer *buf)
> > +{
> > +	return kmap(buf->page);
> > +}
> > +
> > +static void user_page_pipe_buf_unmap(struct pipe_inode_info *pipe,
> > +				     struct pipe_buffer *buf)
> > +{
> > +	kunmap(buf->page);
> > +}
> 
> All these new kmaps and kunmaps hurt.  It's supposed to be
> kinda-deprecated and scales poorly.  Oh well.

I know, it's not a new complaint and I fully agree. It's not too bad to
fix, it just needs 1/2 new pipe_buffer_ops hooks to split the mapping
from the 'checking' part. For now we blissfully ignore highmem boxes and
rejoice on 64-bit machines :-)

> > -	while (i < nr_pages)
> > -		page_cache_release(pages[i++]);
> > +	while (i < spd->nr_pages)
> > +		page_cache_release(spd->pages[i++]);
> 
> grumble.  I'm going to march over there and take away your `i' key.  Or
> make it emit "page_nr".

;-)

> > +static long do_vmsplice(struct file *file, void __user *buffer, size_t len,
> > +			unsigned int flags)
> > +{
> > +	unsigned long uaddr = (unsigned long) buffer;
> > +	struct pipe_inode_info *pipe;
> > +	struct page *pages[PIPE_BUFFERS];
> > +	unsigned int nr_pages;
> > +	struct splice_pipe_desc spd = {
> > +		.pages = pages,
> > +		.len = len,
> > +		.flags = flags,
> > +		.ops = &user_page_pipe_buf_ops,
> > +	};
> > +
> > +	pipe = file->f_dentry->d_inode->i_pipe;
> > +	if (unlikely(!pipe))
> > +		return -EBADF;
> > +
> > +	spd.offset = uaddr & ~PAGE_CACHE_MASK;
> > +	nr_pages = (len + spd.offset + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
> 
> Can I feed this 16TB of memory?   If so, we just overflowed `nr_pages'.

I'll make it a long type instead.

> > --- a/include/asm-powerpc/unistd.h
> > +++ b/include/asm-powerpc/unistd.h
> > @@ -303,8 +303,9 @@ #define __NR_ppoll		281
> >  #define __NR_unshare		282
> >  #define __NR_splice		283
> >  #define __NR_tee		284
> > +#define __NR_vmsplice		285
> >  
> > -#define __NR_syscalls		285
> > +#define __NR_syscalls		286
> >  
> 
> Every time we do this the spufs build breaks:
> 
> long spu_sys_callback(struct spu_syscall_block *s)
> {
> 	long (*syscall)(u64 a1, u64 a2, u64 a3, u64 a4, u64 a5, u64 a6);
> 
> 	BUILD_BUG_ON(ARRAY_SIZE(spu_syscall_table) != __NR_syscalls);

I'll leave the ppc syscall update out of it.

-- 
Jens Axboe

