Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbSLKNfQ>; Wed, 11 Dec 2002 08:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbSLKNdx>; Wed, 11 Dec 2002 08:33:53 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:1808 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267148AbSLKNdf>; Wed, 11 Dec 2002 08:33:35 -0500
Message-Id: <200212111330.gBBDTTa06416@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [PATCH] dm.c  -  device-mapper I/O path fixes
Date: Wed, 11 Dec 2002 16:19:07 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Kevin Corry <corryk@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
References: <02121016034706.02220@boiler> <20021211121749.GA20782@reti> <20021211121915.GB20782@reti>
In-Reply-To: <20021211121915.GB20782@reti>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 December 2002 10:19, Joe Thornber wrote:
> dec_pending(): only bother spin locking if io->error is going to be
> updated. [Kevin Corry]
>
> --- diff/drivers/md/dm.c	2002-12-11 12:00:29.000000000 +0000
> +++ source/drivers/md/dm.c	2002-12-11 12:00:34.000000000 +0000
> @@ -238,10 +238,11 @@
>  	static spinlock_t _uptodate_lock = SPIN_LOCK_UNLOCKED;
>  	unsigned long flags;
>
> -	spin_lock_irqsave(&_uptodate_lock, flags);
> -	if (error)
> +	if (error) {
> +		spin_lock_irqsave(&_uptodate_lock, flags);
>  		io->error = error;
> -	spin_unlock_irqrestore(&_uptodate_lock, flags);
> +		spin_unlock_irqrestore(&_uptodate_lock, flags);
> +	}
>
>  	if (atomic_dec_and_test(&io->io_count)) {
>  		if (atomic_dec_and_test(&io->md->pending))

This seems pointless, end result:

	spin_lock_irqsave(&_uptodate_lock, flags);
 	io->error = error;
	spin_unlock_irqrestore(&_uptodate_lock, flags);


BTW, the function we are looking at:

static inline void dec_pending(struct dm_io *io, int error)
       ^^^^^^
is too big for inlining.
--
vda
