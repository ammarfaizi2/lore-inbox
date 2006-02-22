Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWBVSre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWBVSre (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWBVSre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:47:34 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:43220
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751395AbWBVSrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:47:33 -0500
Date: Wed, 22 Feb 2006 10:47:29 -0800
From: Greg KH <gregkh@suse.de>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH 0/3] sysfs representation of stacked devices (dm/md) (rev.2)
Message-ID: <20060222184729.GA13638@suse.de>
References: <43FC8C00.5020600@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FC8C00.5020600@ce.jp.nec.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 11:06:24AM -0500, Jun'ichi Nomura wrote:
> Hello,
> 
> This is a revised set of pathces which provides common
> representation of dependencies between stacked devices (dm and md)
> in sysfs.
> 
> Variants of bd_claim/bd_release are added to accept a kobject
> and create symlinks between the claimed bdev and the holder.
> 
> dm/md will give a child of its gendisk kobject to bd_claim.
> For example, if dm-0 maps to sda, we have the following symlinks;
>    /sys/block/dm-0/slaves/sda --> /sys/block/sda
>    /sys/block/sda/holders/dm-0 --> /sys/block/dm-0
> 
> Comments are welcome.
> 
> A few points I would appreciate comments/reviews from maintainers:
>   About sysfs
>     - I confirmed sysfs_remove_symlink() and kobject_del() don't
>       allocate memory in 2.6.15 and it seems true on the git head.
>       I would like to make sure it's true in future versions of kernel
>       because they are called during device-mapper's table swapping
>       where I/O to free memory could deadlock on the dm device.
>       What is the recommended way to do that?

But it can possibly sleep.

Hm, wait, the put_device stuff can possibly sleep, the "raw"
kobject_del() stuff looks safe.  Either way, they don't create new
memory, unless you do something really wierd in your release callback.

So you should be safe here.

But if you want to be absolutly safe, look at the thread on lkml about
changing the scsi code to do the final release in a non-interrupt
context.  That looks like it might be the same thing you want to do
here to guarantee that nothing bad happens.

thanks,

greg k-h
