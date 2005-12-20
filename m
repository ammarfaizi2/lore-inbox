Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVLTFTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVLTFTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 00:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVLTFTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 00:19:07 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:8455 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750800AbVLTFTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 00:19:06 -0500
Date: Tue, 20 Dec 2005 06:18:21 +0100
From: Willy Tarreau <willy@w.ods.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, greg@kroah.com, axboe@suse.de
Subject: Re: [RFC] Let non-root users eject their ipods?
Message-ID: <20051220051821.GM15993@alpha.home.local>
References: <1135047119.8407.24.camel@leatherman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135047119.8407.24.camel@leatherman>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Mon, Dec 19, 2005 at 06:51:58PM -0800, john stultz wrote:
> All,
> 	I'm getting a little tired of my roommates not knowing how to safely
> eject their usb-flash disks from my system and I'd personally like it if
> I could avoid bringing up a root shell to eject my ipod. Sure, one could
> suid the eject command, but that seems just as bad as changing the
> permissions in the kernel (eject wouldn't be able to check if the user
> has read/write permissions on the device, allowing them to eject
> anything).

You may find my question stupid, but what is wrong with umount ? That's
how I proceed with usb-flash and I've never sent any eject command to
it (I even didn't know that the ioctl would be accepted by an sd device).

> I've looked around trying to find some references to why this isn't
> currently allowed or how safe this is, but I couldn't find anything
> except the 2.6.8/k3b thread from awhile back and it didn't speak to why
> eject would need root permissions even if the user has r/w permissions
> on the device.
> 
> I really know nothing about scsi ioctls, so this is probably the wrong
> solution, but I figured I'd offer my head upon a stake so others could
> learn what not to do and why, and maybe start some discussion on what
> the proper fix should be (for the kernel or the distributions to make)
> since non root users really should be able to eject the flash disk they
> just plugged in.
>
> So below is a patch that allows non-root users to eject their ipods. (It
> seems it should be safe_for_write() but eject opens the device for
> RDONLY, so eject may be wrong here as well). 

If there is a special ioctl to be called after the device has been
unmounted, then probably it would be easier to call it in umount() ?
The advantage is that mount/umount are already suid on distros which
allow user access, and you just have to put a 'users' option in the
fstab for this.

> Comments, flames?
> 
> thanks
> -john

Cheers,
Willy


> 
> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> --- a/block/scsi_ioctl.c
> +++ b/block/scsi_ioctl.c
> @@ -188,6 +188,9 @@ static int verify_command(struct file *f
>  		safe_for_write(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL),
>  		safe_for_write(GPCMD_LOAD_UNLOAD),
>  		safe_for_write(GPCMD_SET_STREAMING),
> +
> +		/* let me eject my damn ipod */
> +		safe_for_read(ALLOW_MEDIUM_REMOVAL),
>  	};
>  	unsigned char type = cmd_type[cmd[0]];
>  
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
