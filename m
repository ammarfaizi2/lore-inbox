Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbSLKNzf>; Wed, 11 Dec 2002 08:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbSLKNzf>; Wed, 11 Dec 2002 08:55:35 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:13768 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S267158AbSLKNzc>; Wed, 11 Dec 2002 08:55:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [PATCH] dm.c - device-mapper I/O path fixes
Date: Wed, 11 Dec 2002 07:16:53 -0600
X-Mailer: KMail [version 1.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
References: <02121016034706.02220@boiler> <20021211121915.GB20782@reti> <200212111330.gBBDTTa06416@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200212111330.gBBDTTa06416@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Message-Id: <02121107165303.29515@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 December 2002 12:19, Denis Vlasenko wrote:
> On 11 December 2002 10:19, Joe Thornber wrote:
> > dec_pending(): only bother spin locking if io->error is going to be
> > updated. [Kevin Corry]
> >
> > --- diff/drivers/md/dm.c	2002-12-11 12:00:29.000000000 +0000
> > +++ source/drivers/md/dm.c	2002-12-11 12:00:34.000000000 +0000
> > @@ -238,10 +238,11 @@
> >  	static spinlock_t _uptodate_lock = SPIN_LOCK_UNLOCKED;
> >  	unsigned long flags;
> >
> > -	spin_lock_irqsave(&_uptodate_lock, flags);
> > -	if (error)
> > +	if (error) {
> > +		spin_lock_irqsave(&_uptodate_lock, flags);
> >  		io->error = error;
> > -	spin_unlock_irqrestore(&_uptodate_lock, flags);
> > +		spin_unlock_irqrestore(&_uptodate_lock, flags);
> > +	}
> >
> >  	if (atomic_dec_and_test(&io->io_count)) {
> >  		if (atomic_dec_and_test(&io->md->pending))
>
> This seems pointless, end result:
>
> 	spin_lock_irqsave(&_uptodate_lock, flags);
>  	io->error = error;
> 	spin_unlock_irqrestore(&_uptodate_lock, flags);

Are you saying the "if (error)" part is pointless? If so, I have to disagree. 
A bio may be split into several sub-bio's. When each of those split bio's 
completes, they are going to call this function. But if only one of those 
split bio's has an error, then the error might get lost without that "if" 
statement.

However, it might be a good idea to consider how bio's keep track of errors. 
When a bio is created, it is marked UPTODATE. Then, if any part of a bio 
takes an error, the UPTODATE flag is turned off. When the whole bio 
completes, if the UPTODATE flag is still on, there were no errors during the 
i/o. Perhaps the "error" field in "struct dm_io" could be modified to use 
this method of error tracking? Then we could change dec_pending() to be 
something like:

if (error)
	clear_bit(DM_IO_UPTODATE, &io->error);

with a "set_bit(DM_IO_UPTODATE, &ci.io->error);" in __bio_split().

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
