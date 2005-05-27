Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVE0O1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVE0O1G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 10:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbVE0O1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 10:27:06 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:1136 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261764AbVE0O1B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 10:27:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YcE2Dd/tXlBtWNKhcVpfc8sZevyz2GeEzk5J3gH4SGjxitB7oqpVJ+rZmPPfIKYNBQWYljNCHgoGMSjdRZic9PYLm3SgTzF9n06H+wmOoW+gAepdbJDJv9ZlHKFz+i44WeoK7GJzSPGMPMFiTc9BgyiVkp30UB6UAM/4FAZOd6U=
Message-ID: <58cb370e05052707274400146a@mail.gmail.com>
Date: Fri, 27 May 2005 16:27:01 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Resend: PATCH: Stop 2.6.12rc rmmod from being able to destroy CD hardware
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       torvalds@osdl.org
In-Reply-To: <1117196287.5743.186.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1117196287.5743.186.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that this was fixed differently almost moth ago by Jens:
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=7da21a02b3587157bd43910ea6d4c76661228ebb;hp=76530da1a9e8ce05963b1f49a098eddc6ec6c534

It would be nice to have features mask in ide-cd.c done right
but this sounds like 2.6.13 material.

On 5/27/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On an rmmod the cdrom layer when used with ide-cd issues a cache flush
> atapi command to devices including those that do not support it.
> According to Jens earlier discussion this isn't merely a minor glitch
> but can destroy some CD hardware due to firmware bugs in the drive (as
> per the Mandrake incident)
> 
> The IDE CD layer uses a mask of unsupported features, this means that
> because ide-cd doesn't know about MRW writables it doesn't set the
> relevant bit for non writables and harm can occur.
> 
> The simple fix is attached, making the driver start from ~0 and mask
> bits the other direction would longer term be safer.
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12rc3/drivers/ide/ide-cd.c linux-2.6.12rc3-minoride/drivers/ide/ide-cd.c
> --- linux.vanilla-2.6.12rc3/drivers/ide/ide-cd.c        2005-04-27 16:01:29.000000000 +0100
> +++ linux-2.6.12rc3-minoride/drivers/ide/ide-cd.c       2005-05-01 14:09:35.000000000 +0100
> @@ -2860,6 +2922,9 @@
>                 devinfo->mask |= CDC_CLOSE_TRAY;
>         if (!CDROM_CONFIG_FLAGS(drive)->mo_drive)
>                 devinfo->mask |= CDC_MO_DRIVE;
> +
> +       /* We must have this masked unless a drive definitely handles it */
> +       devinfo->mask |= CDC_MRW_W;
> 
>         devinfo->disk = info->disk;
>         return register_cdrom(devinfo);
