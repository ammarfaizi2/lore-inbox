Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWGEFSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWGEFSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 01:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWGEFSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 01:18:41 -0400
Received: from 1wt.eu ([62.212.114.60]:51209 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932320AbWGEFSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 01:18:40 -0400
Date: Wed, 5 Jul 2006 07:18:29 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Linux 2.4.33-rc2
Message-ID: <20060705051829.GA23186@1wt.eu>
References: <20060621192756.GB13559@dmt> <20060703220736.GA272@1wt.eu> <0e6ma2961ro2evtrnacgmla7j52j738q76@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6ma2961ro2evtrnacgmla7j52j738q76@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

On Wed, Jul 05, 2006 at 11:51:35AM +1000, Grant Coady wrote:
> On Tue, 4 Jul 2006 00:07:36 +0200, Willy Tarreau <w@1wt.eu> wrote:
(...)
> >What I notice is that in 2.4.32, d_delete(dentry) was performed
> >between down(&dir->i_zombie) and up(&dir->i_zombie), while now
> >it's completely outside. I wonder if this can cause race conditions
> >or not, but at least, I'm sure that we have changed the locking
> >sequence, which might have some impact.
> >
> >Do you think I'm searching in the wrong direction ? I worry a
> >bit, because getting a deadlock after only one day, it's a bit
> >early :-/
> >
> Assuming you mean something like the patch below?  Doesn't cause any 
> problems (yet, still testing) like eat files or segfault here as 
> reported for -rc1 +/- various patches ;)

yes, exactly this. I don't know if it's correct and/or needed. In 2.6,
the d_delete() is performed outside the lock. I'd like someone's advise
on this one. Also, I'll look for an NFS client stress test to try to
reproduce the problem, because I don't like it when problems like this
only appear once a day. And playing with the VFS does not make me happy
at all.

> Cheers,
> Grant.

Cheers,
Willy

> --- linux-2.4.33-rc2/fs/namei.c	2006-06-22 07:27:47.000000000 +1000
> +++ linux-2.4.33-rc2b/fs/namei.c	2006-07-05 11:43:19.000000000 +1000
> @@ -1497,13 +1497,14 @@
>  			lock_kernel();
>  			error = dir->i_op->unlink(dir, dentry);
>  			unlock_kernel();
> +			if (!error)
> +				d_delete(dentry);
>  		}
>  	}
>  	double_up(&dir->i_zombie, &inode->i_zombie);
>  	iput(inode);
>  
>  	if (!error) {
> -		d_delete(dentry);
>  		inode_dir_notify(dir, DN_DELETE);
>  	}
>  	return error;
