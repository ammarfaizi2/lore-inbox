Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945992AbWANDs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945992AbWANDs6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 22:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945993AbWANDs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 22:48:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:57305 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1945992AbWANDs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 22:48:58 -0500
Date: Fri, 13 Jan 2006 19:44:04 -0800
From: Greg KH <greg@kroah.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] kobject: don't oops on null kobject.name
Message-ID: <20060114034404.GA23061@kroah.com>
References: <200601132209_MC3-1-B5D3-F9A9@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601132209_MC3-1-B5D3-F9A9@compuserve.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 10:07:33PM -0500, Chuck Ebbert wrote:
> In-Reply-To: <20060114000246.GA7549@kroah.com>
> 
> On Fri, 13 Jan 2006, Greg KH wrote:
> 
> > Hm, I looked at the only user of kobjects in the kernel that I know of
> > that doesn't use sysfs (the cdev code) and even it sets the kobject name
> > to something sane, so I think we should be safe with this.
> 
> Well, something is still wrong.
> 
> I applied your patch to prevent registration of objects with null names on
> top of my patch, then applied this to see if my test still triggered, and
> the message was printed:

What was the message?  What traceback?

So, I think the point is that it isn't a kobject_add() issue, right?


> 
> 
> --- 2.6.15a.orig/lib/kobject.c
> +++ 2.6.15a/lib/kobject.c
> @@ -72,8 +72,10 @@ static int get_kobj_path_length(struct k
>  	 * Add 1 to strlen for leading '/' of each level.
>  	 */
>  	do {
> -		if (kobject_name(parent) == NULL)
> +		if (kobject_name(parent) == NULL) {
> +			printk("get_kobj_path_length: encountered NULL name\n");
>  			return 0;
> +		}
>  		length += strlen(kobject_name(parent)) + 1;
>  		parent = parent->parent;
>  	} while (parent);
> 
> 
> To reproduce:
> 
> Start with vanilla 2.6.15 and apply the three patches, which I called:
> 
>         kobject_dont_register_null_name.patch  <- my original
>         kobject_handle_null_object_name.patch  <- Greg's
>         kobject_debug_null_path.patch          <- included above
> 
> On a machine with an ATAPI CD-ROM, boot with "hdx=ide-scsi" where
> hdx is the CD-ROM's drivename.  Then try to mount a CD:
> 
>         mount -t iso9660 /dev/hdx /mnt/cdrom
> 
> Note that hdx is being controlled by ide-scsi so this should fail.  You
> will see the message from my new patch print in the kernel log.
> 
> NOTE:  This won't happen on 2.6.15-current because
> fs/super.c::kill_block_super() no longer calls kobject_uevent().

So everything's fixed and we don't have to worry about it anymore :)

Seriously, I agree, we still need to fix it for -stable.

thanks,

greg k-h
