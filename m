Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSFYLRM>; Tue, 25 Jun 2002 07:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSFYLRL>; Tue, 25 Jun 2002 07:17:11 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:25868 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S315192AbSFYLRK>; Tue, 25 Jun 2002 07:17:10 -0400
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Martin Dalecki <dalecki@evision-ventures.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] IDE locking #2
References: <Pine.LNX.4.44.0206250756430.2033-100000@netfinity.realnet.co.sz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 25 Jun 2002 20:16:02 +0900
In-Reply-To: <Pine.LNX.4.44.0206250756430.2033-100000@netfinity.realnet.co.sz>
Message-ID: <874rfrlibx.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linux.realnet.co.sz> writes:

> Hi Martin, Jens
> 
> This patch gets a little further and is independent of the first one. 
> However it is still not there yet.
> 
> This patch tries to address the following;
> 
> CURRENT
> o remove racy spin_unlock_irq() ... foo() .. spin_lock_irq() scenarios
> o moves locking from interrupt handling helpers/primitives 
> (ide-disk.c:*_intr) to the caller.
> o removes ide__sti() from some areas, personally i think this is an evil
>   macro for many reasons, is it supposed to be disable_irq(ide_irq); 
> __sti(); ?
> 
> o fixes some 'FIXME' entries... adds a couple more ;)
> 
> TODO
> o fix breakage in ide-floppy/tape etc...
> o fix ide device setup/tear down locking
> o remove ide_wait commands from interrupt paths
> 
> Index: linux-2.5.24/drivers/ide//ide-cd.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.5.24/drivers/ide/ide-cd.c,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 ide-cd.c
> --- linux-2.5.24/drivers/ide//ide-cd.c	23 Jun 2002 13:32:22 -0000	1.1.1.1
> +++ linux-2.5.24/drivers/ide//ide-cd.c	23 Jun 2002 20:45:52 -0000
> @@ -319,6 +319,8 @@
>  
>  /****************************************************************************
>   * Generic packet command support and error handling routines.
> + * Note. these are called with the channel lock held and irq disabled in most
> + * cases.
>   */
>  
>  /* Mark that we've seen a media change, and invalidate our internal
> @@ -728,13 +730,13 @@
>  						  int xferlen,
>  						  ata_handler_t handler)
>  {
> -	unsigned long flags;
>  	struct ata_channel *ch = drive->channel;
>  	ide_startstop_t startstop;
>  	struct cdrom_info *info = drive->driver_data;
>  	int ret;
>  
> -	spin_lock_irqsave(ch->lock, flags);
> +	BUG_ON(!spin_is_locked(ch->lock));

spin_is_locked() returns 0 always on the UP system.
Instead, the following macro may be useful. 

#ifdef CONFIG_SMP
#define assert_spin_is_locked(lock)	BUG_ON(!spin_is_locked(lock))
#else
#define assert_spin_is_locked(lock)	do {} while(0)
#endif
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
