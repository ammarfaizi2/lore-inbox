Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWAKLlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWAKLlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 06:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWAKLlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 06:41:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932201AbWAKLlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 06:41:49 -0500
Date: Wed, 11 Jan 2006 03:38:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: ericvh@gmail.com (Eric Van Hensbergen)
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.org
Subject: Re: [PATCH]: v9fs: add readpage support
Message-Id: <20060111033821.4b3d4d7b.akpm@osdl.org>
In-Reply-To: <20060111011437.451FD5A809A@localhost.localdomain>
References: <20060111011437.451FD5A809A@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ericvh@gmail.com (Eric Van Hensbergen) wrote:
>
> Subject: [PATCH] v9fs: add readpage support
> 
> v9fs mmap support was originally removed from v9fs at Al Viro's request,
> but recently there have been requests from folks who want readpage
> functionality (primarily to enable execution of files mounted via 9P).
> This patch adds readpage support (but not writepage which contained most of
> the objectionable code).  It passes FSX (and other regressions) so it
> should be relatively safe.
> 
> +
> +static int v9fs_vfs_readpage(struct file *filp, struct page *page)
> +{  
> +	char *buffer = NULL;
> +	int retval = -EIO;
> +	loff_t offset = page_offset(page);
> +	int count = PAGE_CACHE_SIZE;
> +	struct inode *inode = filp->f_dentry->d_inode;
> +	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
> +	int rsize = v9ses->maxdata - V9FS_IOHDRSZ;
> +	struct v9fs_fid *v9f = filp->private_data;
> +	struct v9fs_fcall *fcall = NULL;
> +	int fid = v9f->fid;
> +	int total = 0;
> +	int result = 0;
> +
> +	buffer = kmap(page);
> +	do {
> +		if (count < rsize)
> +			rsize = count;
> +
> +		result = v9fs_t_read(v9ses, fid, offset, rsize, &fcall);
> +
> +		if (result < 0) {
> +			printk(KERN_ERR "v9fs_t_read returned %d\n",
> +			       result);
> +
> +			kfree(fcall);
> +			goto UnmapAndUnlock;
> +		} else
> +			offset += result;
> +
> +		memcpy(buffer, fcall->params.rread.data, result);
> +
> +		count -= result;
> +		buffer += result;
> +		total += result;
> +
> +		kfree(fcall);

Minor thing: from my reading of v9fs_mux_rpc() there's potential for a
double-kfree here.  Either v9fs_mux_rpc() needs to be changed to
unambiguously zero out *rcall (or, better, v9fs_t_read does it) or you need
to zero fcall on each go around the loop.


> +		if (result < rsize)
> +			break;
> +	} while (count);
> +
> +	memset(buffer, 0, count);
> +	flush_dcache_page(page);
> +	SetPageUptodate(page);

if (result < rsize), is the page really up to date?

> +	retval = 0;
> +
> +      UnmapAndUnlock:
> +	kunmap(page);

eww, do you really indent labels like that?

> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 6852f0e..feddc5c 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -289,6 +289,8 @@ v9fs_file_write(struct file *filp, const
>  		total += result;
>  	} while (count);
>  
> +	invalidate_inode_pages2(inode->i_mapping);
> +
>  	return total;
>  }

That's a really scary function you have there.  Can you explain the
thinking behind its use here?  What are we trying to achieve?


