Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWALJ6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWALJ6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWALJ6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:58:49 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:29664 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1030340AbWALJ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:58:48 -0500
Date: Thu, 12 Jan 2006 10:59:01 +0100
From: Sander <sander@humilis.net>
To: Neil Brown <neilb@suse.de>
Cc: sander@humilis.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: SOLVED: Re: Kernel BUG at fs/sysfs/symlink.c:87 happens with 2.6.15 too
Message-ID: <20060112095901.GA18956@favonius>
Reply-To: sander@humilis.net
References: <20060111151308.GA30047@favonius> <20060111192055.GB19209@favonius> <17349.35975.929839.197710@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17349.35975.929839.197710@cse.unsw.edu.au>
X-Uptime: 10:08:12 up 55 days, 23:35, 31 users,  load average: 4.37, 3.79, 3.66
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote (ao):
> sx8 creates device names with a '/' in them as we can see from:
> > 
> > [ 2281.547827] md: bind<sda1>
> > [ 2281.547877] md: bind<sx8/0p1>
>                              ^
> 
> That's unfortunate.  We will have to remove them.
> You will find that the names in /sys/block look like
>     /sys/block/sx8!0
> 
> The following patch should achieve the same substitution for
> md.

Thanks Neil!

2.6.15 with your patch works (lets me create raid on the Promise SX8
SATA controller).

I don't quite understand why I'm the first one to hit this (the Promise
SX8 is good value for money and with decent Linux support?), but it
seems your patch is needed in both vanilla and -mm.

Thanks again, Sander


> --------------------------
> Remove slashed from disk names when creation dev names in sysfs
> 
> e.g. The sx8 driver uses names like sx8/0.
> This would make a md component dev name like
>    /sys/block/md0/md/dev-sx8/0
> which is no allowed.  So we change the '/' to '!' just like
> fs/partitions/check.c(register_disk) does.
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./drivers/md/md.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff ./drivers/md/md.c~current~ ./drivers/md/md.c
> --- ./drivers/md/md.c~current~	2006-01-12 09:43:11.000000000 +1100
> +++ ./drivers/md/md.c	2006-01-12 09:44:39.000000000 +1100
> @@ -1238,6 +1238,7 @@ static int bind_rdev_to_array(mdk_rdev_t
>  	mdk_rdev_t *same_pdev;
>  	char b[BDEVNAME_SIZE], b2[BDEVNAME_SIZE];
>  	struct kobject *ko;
> +	char *s;
>  
>  	if (rdev->mddev) {
>  		MD_BUG();
> @@ -1277,6 +1278,8 @@ static int bind_rdev_to_array(mdk_rdev_t
>  	bdevname(rdev->bdev,b);
>  	if (kobject_set_name(&rdev->kobj, "dev-%s", b) < 0)
>  		return -ENOMEM;
> +	while ( (s=strchr(rdev->kobj.k_name, '/')) != NULL)
> +		*s = '!';
>  			
>  	list_add(&rdev->same_set, &mddev->disks);
>  	rdev->mddev = mddev;

-- 
Humilis IT Services and Solutions
http://www.humilis.net
