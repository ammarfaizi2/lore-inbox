Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbSLKOlY>; Wed, 11 Dec 2002 09:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267165AbSLKOlY>; Wed, 11 Dec 2002 09:41:24 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:38330 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S267043AbSLKOlX>; Wed, 11 Dec 2002 09:41:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [PATCH] dm.c - device-mapper I/O path fixes
Date: Wed, 11 Dec 2002 08:02:24 -0600
X-Mailer: KMail [version 1.2]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, lvm-devel@sistina.com
References: <02121016034706.02220@boiler> <02121107165303.29515@boiler> <200212111430.gBBETua06759@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200212111430.gBBETua06759@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Message-Id: <02121108022404.29515@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 December 2002 13:19, Denis Vlasenko wrote:
> On 11 December 2002 11:16, Kevin Corry wrote:
> > > > --- diff/drivers/md/dm.c	2002-12-11 12:00:29.000000000 +0000
> > > > +++ source/drivers/md/dm.c	2002-12-11 12:00:34.000000000 +0000
> > > > @@ -238,10 +238,11 @@
> > > >  	static spinlock_t _uptodate_lock = SPIN_LOCK_UNLOCKED;
> > > >  	unsigned long flags;
> > > >
> > > > -	spin_lock_irqsave(&_uptodate_lock, flags);
> > > > -	if (error)
> > > > +	if (error) {
> > > > +		spin_lock_irqsave(&_uptodate_lock, flags);
> > > >  		io->error = error;
> > > > -	spin_unlock_irqrestore(&_uptodate_lock, flags);
> > > > +		spin_unlock_irqrestore(&_uptodate_lock, flags);
> > > > +	}
> > > >
> > > >  	if (atomic_dec_and_test(&io->io_count)) {
> > > >  		if (atomic_dec_and_test(&io->md->pending))
> > >
> > > This seems pointless, end result:
> > >
> > > 	spin_lock_irqsave(&_uptodate_lock, flags);
> > >  	io->error = error;
> > > 	spin_unlock_irqrestore(&_uptodate_lock, flags);
> >
> > Are you saying the "if (error)" part is pointless? If so, I have to
>
> No. Locking is pointless. What exactly you try to protect here?

The "struct dm_io *io" that is passed to dec_pending() can be accessed by 
multiple threads at the same time, thus some form of locking is required.

I had been thinking about whether the "error" field could be an atomic_t, 
which would remove the requirement for the spinlock in dec_pending(). 
However, I don't know how atomic_t's behave with negative values. I know 
atomic_t's are only guaranteed to have 24-bits of precision, yet all arch's 
define atomic_t with a signed integer. Can anyone enlighten me on this?

Perhaps we could make "error" and atomic_t, and store the absolute-value of 
the error code, and always return -error in the bio_endio() call. Or is that 
just too ugly?

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
