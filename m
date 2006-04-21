Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWDUJSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWDUJSE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 05:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWDUJSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 05:18:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35530 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751091AbWDUJSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 05:18:03 -0400
Date: Fri, 21 Apr 2006 02:17:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, davem@davemloft.net
Subject: Re: [PATCH] sys_vmsplice
Message-Id: <20060421021702.20049dcd.akpm@osdl.org>
In-Reply-To: <20060421080239.GC4717@suse.de>
References: <20060421080239.GC4717@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> ...
>
> sys_splice() moves data to/from pipes with a file input/output. sys_vmsplice()
> moves data to a pipe, with the input being a user address range instead.
> 
> ...
>
> +static void *user_page_pipe_buf_map(struct file *file,
> +				    struct pipe_inode_info *pipe,
> +				    struct pipe_buffer *buf)
> +{
> +	return kmap(buf->page);
> +}
> +
> +static void user_page_pipe_buf_unmap(struct pipe_inode_info *pipe,
> +				     struct pipe_buffer *buf)
> +{
> +	kunmap(buf->page);
> +}

All these new kmaps and kunmaps hurt.  It's supposed to be
kinda-deprecated and scales poorly.  Oh well.

> -	while (i < nr_pages)
> -		page_cache_release(pages[i++]);
> +	while (i < spd->nr_pages)
> +		page_cache_release(spd->pages[i++]);

grumble.  I'm going to march over there and take away your `i' key.  Or
make it emit "page_nr".

> +static long do_vmsplice(struct file *file, void __user *buffer, size_t len,
> +			unsigned int flags)
> +{
> +	unsigned long uaddr = (unsigned long) buffer;
> +	struct pipe_inode_info *pipe;
> +	struct page *pages[PIPE_BUFFERS];
> +	unsigned int nr_pages;
> +	struct splice_pipe_desc spd = {
> +		.pages = pages,
> +		.len = len,
> +		.flags = flags,
> +		.ops = &user_page_pipe_buf_ops,
> +	};
> +
> +	pipe = file->f_dentry->d_inode->i_pipe;
> +	if (unlikely(!pipe))
> +		return -EBADF;
> +
> +	spd.offset = uaddr & ~PAGE_CACHE_MASK;
> +	nr_pages = (len + spd.offset + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;

Can I feed this 16TB of memory?   If so, we just overflowed `nr_pages'.

> --- a/include/asm-powerpc/unistd.h
> +++ b/include/asm-powerpc/unistd.h
> @@ -303,8 +303,9 @@ #define __NR_ppoll		281
>  #define __NR_unshare		282
>  #define __NR_splice		283
>  #define __NR_tee		284
> +#define __NR_vmsplice		285
>  
> -#define __NR_syscalls		285
> +#define __NR_syscalls		286
>  

Every time we do this the spufs build breaks:

long spu_sys_callback(struct spu_syscall_block *s)
{
	long (*syscall)(u64 a1, u64 a2, u64 a3, u64 a4, u64 a5, u64 a6);

	BUILD_BUG_ON(ARRAY_SIZE(spu_syscall_table) != __NR_syscalls);


