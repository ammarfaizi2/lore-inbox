Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVHZAFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVHZAFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 20:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVHZAFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 20:05:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39849 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964980AbVHZAFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 20:05:10 -0400
Date: Thu, 25 Aug 2005 17:02:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [PATCH 2/2] pipe: do not return POLLERR for fifo_poll
Message-Id: <20050825170217.666edda3.akpm@osdl.org>
In-Reply-To: <ilomki.fs3loe.5j02sm6rx63x13ip2d9643lta.beaver@cs.helsinki.fi>
References: <ilomk8.i0yljb.2ul6sqfgelx5ik5dngkbmbkeu.beaver@cs.helsinki.fi>
	<ilomki.fs3loe.5j02sm6rx63x13ip2d9643lta.beaver@cs.helsinki.fi>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> This patch changes fifo_poll not to return POLLERR to take care of a FIXME
> in fs/pipe.c stating that "Most unices do not set POLLERR for fifos." The
> comment has been there since 2.3.99-pre3 so either apply this patch or
> alternatively, I can send a new one removing the unnecessary abstraction.
> 
> ...
> --- 2.6-mm.orig/fs/pipe.c
> +++ 2.6-mm/fs/pipe.c
> @@ -399,8 +399,8 @@ pipe_ioctl(struct inode *pino, struct fi
>  }
>  
>  /* No kernel lock held - fine */
> -static unsigned int
> -pipe_poll(struct file *filp, poll_table *wait)
> +static inline unsigned int
> +__pipe_poll(struct file *filp, poll_table *wait, int can_err)
>  {
>  	unsigned int mask;
>  	struct inode *inode = filp->f_dentry->d_inode;
> @@ -420,15 +420,24 @@ pipe_poll(struct file *filp, poll_table 
>  
>  	if (filp->f_mode & FMODE_WRITE) {
>  		mask |= (nrbufs < PIPE_BUFFERS) ? POLLOUT | POLLWRNORM : 0;
> -		if (!info->readers)
> +		if (can_err && !info->readers)
>  			mask |= POLLERR;
>  	}
>  
>  	return mask;
>  }
>  
> -/* FIXME: most Unices do not set POLLERR for fifos */
> -#define fifo_poll pipe_poll
> +static unsigned int
> +pipe_poll(struct file *filp, poll_table *wait)
> +{
> +	return __pipe_poll(filp, wait, 1);
> +}
> +
> +static unsigned int
> +fifo_poll(struct file *filp, poll_table *wait)
> +{
> +	return __pipe_poll(filp, wait, 0);
> +}
>  
>  static int
>  pipe_release(struct inode *inode, int decr, int decw)

A userspace-visible change, no?

So there's a risk in changing it.  What do we get in return?  Worried.
