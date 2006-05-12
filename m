Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWELWPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWELWPi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 18:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWELWPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 18:15:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750823AbWELWPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 18:15:37 -0400
Date: Fri, 12 May 2006 15:15:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
In-Reply-To: <20060512215151.GG17120@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0605121508590.3866@g5.osdl.org>
References: <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com>
 <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org>
 <1147456038.3769.39.camel@mulgrave.il.steeleye.com>
 <1147460325.3769.46.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.64.0605121209020.3866@g5.osdl.org> <20060512203850.GC17120@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0605121346060.3866@g5.osdl.org> <20060512205804.GD17120@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0605121409250.3866@g5.osdl.org> <20060512215151.GG17120@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Russell King wrote:
> 
> From: Todd Blumer <todd@sdgsystems.com>
> On a PXA27x handheld (iPAQ hx4700), when we eject a mounted SD memory
> card, we get a kernel panic (kernel trying to clean up non-existent
> device). One hack patch to avoid the panic is:
> 
> --- fs/partitions/check.c       10 Apr 2006 22:57:27 -0000      1.15
> +++ fs/partitions/check.c       4 May 2006 20:30:15 -0000
> @@ -491,6 +491,7 @@
>                         kfree(disk_name);
>                 }
>                 put_device(disk->driverfs_dev);
> +               disk->driverfs_dev = 0; /* HACK - what's the right solution? */
>         }
>         kobject_uevent(&disk->kobj, KOBJ_REMOVE);
>         kobject_del(&disk->kobj);

Btw, on the face it of, I really think that this patch is correct 
regardless of any other issues.

We're clearly getting rid of "disk->driverfs_dev" (that's what the 
"put_device()" does). So we should clear it out - using 
"disk->driverfs_dev" afterwards is clearly not _valid_, because we've 
dropped the reference.

Of course, we shouldn't assign zero to it. We should assign NULL. 
Alternatively, we could poison it (so that anybody who tries to use it 
gets a nice oops ASAP).

Now, regardless of whether that is correct or not, it might not be the 
only problem, of course. It sounds like there is something else going on 
here too.

			Linus
