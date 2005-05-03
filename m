Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbVECNz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVECNz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 09:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVECNz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 09:55:59 -0400
Received: from citi.umich.edu ([141.211.133.111]:15527 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S261547AbVECNzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 09:55:45 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Michael Kerrisk" <mtk-lkml@gmx.net>, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, andros@citi.umich.edu, matthew@wil.cx,
       schwidefsky@de.ibm.com, michael.kerrisk@gmx.net, andros@citi.umich.edu
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question 
In-reply-to: <20050503231408.7c045648.sfr@canb.auug.org.au> 
References: <20050502210411.06226103.sfr@canb.auug.org.au> 
 <2606.1115114418@www14.gmx.net> <20050503231408.7c045648.sfr@canb.auug.org.au>
Comments: In-reply-to Stephen Rothwell <sfr@canb.auug.org.au>
   message dated "Tue, 03 May 2005 23:14:08 +1000."
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 May 2005 09:55:42 -0400
From: "William A.(Andy) Adamson" <andros@citi.umich.edu>
Message-Id: <20050503135542.BFBC61BB0E@citi.umich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Michael,
> 
> On Tue, 3 May 2005 12:00:18 +0200 (MEST) "Michael Kerrisk" <mtk-lkml@gmx.net> wrote:
> >
> > Indeed the problem referred to is fixed, but it looks like another 
> > one may have been introduced.
> > 
> > It now appears (I tested on 2.6.11.6) that if a process opens 
> > a file O_RDWR and then tries to place a read lease via that
> > file descriptor, then the F_SETLEASE fails with EAGAIN, 
> > even though no other process has the file open for writing.  
> > (On the other hand, if the process opens the file 
> > O_WRONLY, then it can place either a read or a write lease.  
> > This is how I think things always worked, but it seems 
> > inconsistent with the aforementioned behaviour.)  
> > 
> > Some further testing showed the following (both open() 
> > and fcntl(F_SETLEASE) from same process):
> > 
> >  open()  |  lease requested
> >   flag   | F_RDLCK  | F_WRLCK
> > ---------+----------+----------
> > O_RDONLY | okay     |  okay
> > O_WRONLY | EAGAIN   |  okay
> > O_RDWR   | EAGAIN   |  okay
> > 
> > This seems strange (I imagine the caller should be excluded 
> > from the list of processes being checked to see if the file 
> > is opened for writing), and differs from earlier kernel
> > versions.  What is the intended behaviour here?
> 
> Thanks for the testing.  My expectation is that it shouldn't matter how
> the current process opened the file for either type of lease.  However,
> you are right (IMHO) that the current process should *not* be counted as a
> writer in the case of trying to obtain a F_RDLCK lease.

i believe the current implementation is correct. opening a file for write 
means that you can not have a read lease, caller included.


-->Andy


> 
> How does this (completely untested, not even compiled) patch look?
> 
> diff -ruNP linus/fs/locks.c linus-leases.1/fs/locks.c
> --- linus/fs/locks.c	2005-04-26 15:38:00.000000000 +1000
> +++ linus-leases.1/fs/locks.c	2005-05-03 23:00:14.000000000 +1000
> @@ -1288,7 +1288,8 @@
>  		goto out;
>  
>  	error = -EAGAIN;
> -	if ((arg == F_RDLCK) && (atomic_read(&inode->i_writecount) > 0))
> +	if ((arg == F_RDLCK) && (atomic_read(&inode->i_writecount)
> +				 > ((filp->f_mode & FMODE_WRITE) ? 1 : 0)))
>  		goto out;
>  	if ((arg == F_WRLCK)
>  	    && ((atomic_read(&dentry->d_count) > 1)
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/


