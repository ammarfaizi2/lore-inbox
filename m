Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbVHEICD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVHEICD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbVHEH7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 03:59:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27321 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262911AbVHEH7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 03:59:09 -0400
Date: Fri, 5 Aug 2005 00:57:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, prasadav@us.ibm.com
Subject: Re: [-mm patch] relayfs: add read() support
Message-Id: <20050805005753.031db798.akpm@osdl.org>
In-Reply-To: <17138.53203.430849.147593@tut.ibm.com>
References: <17138.53203.430849.147593@tut.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Zanussi <zanussi@us.ibm.com> wrote:
>
> +static ssize_t relayfs_read(struct file *filp,
>  +			    char __user *buffer,
>  +			    size_t count,
>  +			    loff_t *ppos)
>  +{
>  +	struct inode *inode = filp->f_dentry->d_inode;
>  +	struct rchan_buf *buf = RELAYFS_I(inode)->buf;
>  +	unsigned int read_start, read_end, avail, start_subbuf;
>  +	unsigned int buf_size = buf->chan->subbuf_size * buf->chan->n_subbufs;
>  +	void *from;
>  +
>  +	avail = relayfs_read_avail(buf, &start_subbuf);
>  +	if (*ppos >= avail)
>  +		return 0;
>  +
>  +	read_start = relayfs_read_start(*ppos, avail, start_subbuf, buf);
>  +	if (read_start == 0 && *ppos)
>  +		return 0;
>  +	
>  +	read_end = relayfs_read_end(read_start, avail, start_subbuf, buf);
>  +	if (read_end == read_start)
>  +		return 0;
>  +	
>  +	from = buf->start + start_subbuf * buf->chan->subbuf_size + read_start;
>  +	if (from >= buf->start + buf_size)
>  +		from -= buf_size;
>  +
>  +	count = min(count, read_end - read_start);
>  +	if (copy_to_user(buffer, from, count))
>  +		return -EFAULT;
>  +
>  +	*ppos = read_start + count;
>  +	
>  +	return count;
>  +}

The use of `unsigned int' in here will cause >4G reads to fail on 64-bit
platforms.  I think you want size_t throughout.
