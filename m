Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266653AbRGEHyG>; Thu, 5 Jul 2001 03:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266654AbRGEHx4>; Thu, 5 Jul 2001 03:53:56 -0400
Received: from mail.aslab.com ([205.219.89.194]:33906 "EHLO mail.aslab.com")
	by vger.kernel.org with ESMTP id <S266653AbRGEHxn>;
	Thu, 5 Jul 2001 03:53:43 -0400
Date: Thu, 5 Jul 2001 00:53:37 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Dale Farnsworth <dale@farnsworth.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for IDE hang after resetting quirk drive
In-Reply-To: <20010703102236.A8708@farnsworth.org>
Message-ID: <Pine.LNX.4.04.10107050053110.16846-100000@mail.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks valid will take!

Cheers,

Andre Hedrick
ASL Kernel Development
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

On Tue, 3 Jul 2001, Dale Farnsworth wrote:

> I have a Promise PDC20265 ide controller with one of the "quirk" drives,
> a Quantum Fireballp LM30.  That drive has a bad sector and accessing
> it would result in a DMA timeout.  Unfortunately, after the IDE driver
> resets the controller, the drive never responded.
> 
> The following patch appears to correct the problem.  It duplicates
> the workaround for "quirky" drives found in ide-features.c
> 
> -Dale
> 
> Dale Farnsworth		dale@farnsworth.org
> 
> --- oldlinux-2.4.5/drivers/ide/ide.c	Tue Jul  3 09:35:57 2001
> +++ linux-2.4.5/drivers/ide/ide.c	Tue Jul  3 09:23:58 2001
> @@ -758,7 +758,10 @@
>  	 */
>  	OUT_BYTE(drive->ctl|6,IDE_CONTROL_REG);	/* set SRST and nIEN */
>  	udelay(10);			/* more than enough time */
> -	OUT_BYTE(drive->ctl|2,IDE_CONTROL_REG);	/* clear SRST, leave nIEN */
> +	if (drive->quirk_list == 2)
> +		OUT_BYTE(drive->ctl, IDE_CONTROL_REG); /* clear SRST and nIEN */
> +	else
> +		OUT_BYTE(drive->ctl|2,IDE_CONTROL_REG);	/* clear SRST only */
>  	udelay(10);			/* more than enough time */
>  	hwgroup->poll_timeout = jiffies + WAIT_WORSTCASE;
>  	ide_set_handler (drive, &reset_pollfunc, HZ/20, NULL);
> 

