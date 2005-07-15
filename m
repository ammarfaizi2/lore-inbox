Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVGOLKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVGOLKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVGOLI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:08:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263301AbVGOLHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:07:31 -0400
Date: Fri, 15 Jul 2005 04:06:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       joern@wohnheim.fh-wedel.de
Subject: Re: [PATCH] generic_file_sendpage
Message-Id: <20050715040611.05907f4a.akpm@osdl.org>
In-Reply-To: <42D79468.3050808@tu-harburg.de>
References: <42D79468.3050808@tu-harburg.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <j.blunck@tu-harburg.de> wrote:
>
> This is a generic sendpage() for regular files.
> 

> +static inline size_t
> +filemap_copy_from_kernel(struct page *page, unsigned long offset,
> +			 const char *buf, unsigned bytes)
> +{
> +	char *kaddr;
> +
> +	kaddr = kmap(page);
> +	memcpy(kaddr + offset, buf, bytes);
> +	kunmap(page);

Use kmap_atomic().

Move the flush_dcache_page() into here.

> +static ssize_t
> +__generic_kernel_file_write(struct file *file, const char *buf,
> +			    size_t count, loff_t *ppos)
> +{
> +	struct address_space * mapping = file->f_mapping;
> +	struct address_space_operations *a_ops = mapping->a_ops;
> +	struct inode 	*inode = mapping->host;
> +	long		status = 0;
> +	loff_t		pos;
> +	struct page	*page;
> +	struct page	*cached_page = NULL;
> +	const int	isblk = S_ISBLK(inode->i_mode);
> +	ssize_t		written;
> +	ssize_t		err;
> +	size_t		bytes;
> +	struct pagevec	lru_pvec;
> +
> +	/* There is no sane reason to use O_DIRECT */
> +	BUG_ON(file->f_flags & O_DIRECT);

err, this seems like an easy way for people to make the kernel go BUG.

> +	if (unlikely(signal_pending(current)))
> +		return -EINTR;

This doesn't help.  The reason we've avoided file-to-file sendfile() is
that it can cause applications to get uninterruptibly stuck in the kernel
for ages.  This code doesn't solve that problem.  It needs to handle
signal_pending() inside the main loop.

And it probably needs to return a sane value (number of bytes copied)
rather than -EINTR.

I don't know if we want to add this feature, really.  It's such a
specialised thing.
