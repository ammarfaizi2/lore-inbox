Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVEaOx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVEaOx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 10:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVEaOx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 10:53:59 -0400
Received: from pop.gmx.net ([213.165.64.20]:56282 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261331AbVEaOxv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 10:53:51 -0400
Date: Tue, 31 May 2005 16:53:50 +0200 (MEST)
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: mtk-lkml@gmx.net, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       andros@citi.umich.edu, matthew@wil.cx, schwidefsky@de.ibm.com
MIME-Version: 1.0
References: <20050503231408.7c045648.sfr@canb.auug.org.au>
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question
X-Priority: 3 (Normal)
X-Authenticated: #2864774
Message-ID: <32555.1117551230@www14.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Sorry for the long delay in replying; other things intervened.

> On Tue, 3 May 2005 12:00:18 +0200 (MEST) "Michael Kerrisk"
> <mtk-lkml@gmx.net> wrote:
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
> you are right (IMHO) that the current process should *not* be counted as 
> a writer in the case of trying to obtain a F_RDLCK lease.
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

I applied this against 2.6.12-rc4, and it fixes the problem 
(and I've also teasted various other facets of file leases 
and this change causes no obvious breakage elsewhere).

Are you going to push this fix into 2.6.12?

Cheers,

Michael

-- 
Geschenkt: 3 Monate GMX ProMail gratis + 3 Ausgaben stern gratis
++ Jetzt anmelden & testen ++ http://www.gmx.net/de/go/promail ++
