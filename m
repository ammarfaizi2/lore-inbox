Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266678AbTADERy>; Fri, 3 Jan 2003 23:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266682AbTADERy>; Fri, 3 Jan 2003 23:17:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62989 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266678AbTADERx>;
	Fri, 3 Jan 2003 23:17:53 -0500
Message-ID: <3E166234.1040508@pobox.com>
Date: Fri, 03 Jan 2003 23:25:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 INITRD + DEVFS crash
References: <20030104041219.GA3066@gondor.apana.org.au>
In-Reply-To: <20030104041219.GA3066@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> INITRD loading fails when DEVFS is enabled in the kernel as initrd_release
> calls del_gendisk which tries to free DEVFS partitions even though the
> create partitions function was never called.
[...]
> --- fs/partitions/check.c	3 Jan 2003 01:36:55 -0000	1.1.1.3
> +++ fs/partitions/check.c	4 Jan 2003 04:04:05 -0000
> @@ -522,7 +522,8 @@
>  	disk->io_ticks = 0;
>  	disk->time_in_queue = 0;
>  	disk->stamp = disk->stamp_idle = 0;
> -	devfs_remove_partitions(disk);
> +	if (disk->minors != 1)
> +		devfs_remove_partitions(disk);
>  	if (disk->driverfs_dev) {
>  		sysfs_remove_link(&disk->kobj, "device");
>  		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");


hmmmm.   I'm not disputing the problem, but your solution sorta says to 
me that there is a reference counting problem elsewhere.  [disclaimer: 
random guess]  Maybe the initrd+devfs needs an additional reference 
increment somewhere?

