Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267166AbSLKObH>; Wed, 11 Dec 2002 09:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267165AbSLKObH>; Wed, 11 Dec 2002 09:31:07 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:32517 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267167AbSLKObG>; Wed, 11 Dec 2002 09:31:06 -0500
Message-Id: <200212111430.gBBETua06759@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Kevin Corry <corryk@us.ibm.com>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [PATCH] dm.c - device-mapper I/O path fixes
Date: Wed, 11 Dec 2002 17:19:33 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, lvm-devel@sistina.com
References: <02121016034706.02220@boiler> <200212111330.gBBDTTa06416@Port.imtp.ilyichevsk.odessa.ua> <02121107165303.29515@boiler>
In-Reply-To: <02121107165303.29515@boiler>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 December 2002 11:16, Kevin Corry wrote:
> > > --- diff/drivers/md/dm.c	2002-12-11 12:00:29.000000000 +0000
> > > +++ source/drivers/md/dm.c	2002-12-11 12:00:34.000000000 +0000
> > > @@ -238,10 +238,11 @@
> > >  	static spinlock_t _uptodate_lock = SPIN_LOCK_UNLOCKED;
> > >  	unsigned long flags;
> > >
> > > -	spin_lock_irqsave(&_uptodate_lock, flags);
> > > -	if (error)
> > > +	if (error) {
> > > +		spin_lock_irqsave(&_uptodate_lock, flags);
> > >  		io->error = error;
> > > -	spin_unlock_irqrestore(&_uptodate_lock, flags);
> > > +		spin_unlock_irqrestore(&_uptodate_lock, flags);
> > > +	}
> > >
> > >  	if (atomic_dec_and_test(&io->io_count)) {
> > >  		if (atomic_dec_and_test(&io->md->pending))
> >
> > This seems pointless, end result:
> >
> > 	spin_lock_irqsave(&_uptodate_lock, flags);
> >  	io->error = error;
> > 	spin_unlock_irqrestore(&_uptodate_lock, flags);
>
> Are you saying the "if (error)" part is pointless? If so, I have to

No. Locking is pointless. What exactly you try to protect here? 

> disagree. A bio may be split into several sub-bio's. When each of
> those split bio's completes, they are going to call this function.
> But if only one of those split bio's has an error, then the error
> might get lost without that "if" statement.
>
> However, it might be a good idea to consider how bio's keep track of
> errors. When a bio is created, it is marked UPTODATE. Then, if any
> part of a bio takes an error, the UPTODATE flag is turned off. When
> the whole bio completes, if the UPTODATE flag is still on, there were
> no errors during the i/o. Perhaps the "error" field in "struct dm_io"
> could be modified to use this method of error tracking? Then we could
> change dec_pending() to be something like:
>
> if (error)
> 	clear_bit(DM_IO_UPTODATE, &io->error);
>
> with a "set_bit(DM_IO_UPTODATE, &ci.io->error);" in __bio_split().

You seem to overestimate my knowledge of this part of the kernel. :(
--
vda
