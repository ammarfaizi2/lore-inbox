Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVHCMVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVHCMVC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 08:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVHCMUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 08:20:44 -0400
Received: from koto.vergenet.net ([210.128.90.7]:46998 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S262239AbVHCMTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 08:19:16 -0400
Date: Wed, 3 Aug 2005 20:54:37 +0900
From: Horms <horms@debian.org>
To: Frans Pop <aragorn@tiscali.nl>, 320379@bugs.debian.org
Cc: rgooch@atnf.csiro.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#320379: Errors during initrd loading when / is on LVM over RAID
Message-ID: <20050803115432.GT23916@verge.net.au>
References: <200507290041.49606.aragorn@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507290041.49606.aragorn@tiscali.nl>
X-Cluestick: seven
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 12:41:38AM +0200, Frans Pop wrote:
> Package: kernel
> Tags: patch
> 
> After switching from a 2.4.27 to 2.6.8 kernel for an old desktop Iuse as
> a server, I noticed the following messages on console and kern.log.
> Note: the errors are not harmful, just ugly; the system boots normally.
> 
> kernel: Inspecting /boot/System.map-2.6.8-2-686
> kernel: Loaded 27390 symbols from /boot/System.map-2.6.8-2-686.
> kernel: Symbols match kernel version 2.6.8.
> kernel: No module symbols loaded - kernel modules not enabled.
> kernel: ould not append to parent for /disc
> kernel: devfs_mk_dir: invalid argument.<4>devfs_mk_dev: could not append to parent for /disc
> last message repeated 151 times
> 
> 
> Cleaned for a missing \n in a printk and with added debug printk's in
> fs/devfs/base.c, this looks like:
> kernel: devfs_mk_dir: invalid argument, buf: .
> kernel: _devfs_append_entry: -EEXIST for :disc
> kernel: devfs_mk_dev: could not append to parent for /disc
> (repeated)
> 
> The last error is a consequence of the error in devfs_mk_dir, so can
> be ignored. The basic problem is that buf is empty.
> 
> Tracing back I ended up in fs/partitions/check.c, which has the following code
> in function register_disk:
> 
> 	/* No minors to use for partitions */
> 	if (disk->minors == 1) {
> 		if (disk->devfs_name[0] != '\0')
> 			devfs_add_disk(disk);
> 		return;
> 	}
> 
> 	/* always add handle for the whole disk */
> 	devfs_add_partitioned(disk);
> 
> This looks unlogical: why does the first statement check for empty
> disk->devfs_name and is the second one called blindly?
> 
> Changing the last statement to:
> 	if (disk->devfs_name[0] != '\0')
> 		devfs_add_partitioned(disk);
> 	else
> 		printk(KERN_WARNING "%s: No devfs_name for %s.\n", __FUNCTION__, disk->disk_name);
> resulted in the errors disappearing and the following log output:
> 
> kernel: register_disk: No devfs_name for md_d0.
> kernel: register_disk: No devfs_name for md_d64.
> kernel: register_disk: No devfs_name for md_d128.
> kernel: register_disk: No devfs_name for md_d192.
> kernel: register_disk: No devfs_name for md_d4.
> kernel: register_disk: No devfs_name for md_d68.
> kernel: register_disk: No devfs_name for md_d132.
> kernel: register_disk: No devfs_name for md_d196.
> (repeated to md_d255)
> 
> I've debugged using kernel version 2.6.8, but a check showed this code is
> unchanged in 2.6.11 and 2.6.12.
> 
> Please review my reasoning. If I'm correct, the attached patch may fix
> the errors (and fix the missing \n). If you think the patch is correct,
> I would appreciate advice how best to get it upstream.
> The other option would of course be that something is more fundamentally
> broken and that disk->devfs_name should be filled in these cases, but
> I doubt that.

Hi Frans,

The null devfs_name check seems fine to me,
I've CCed Richard Gooch for comment, hopefully
he can offer one despite devfs being debricated
upstream.

The \n fix is obviously ok, but again its going away upstream,
so I doubt they care, and I'm not excited about this kind
of fix for Sarge.

> 
> Cheers,
> FJP
> 

> --- fs/partitions/check.c.orig	2005-05-19 12:52:23.000000000 +0200
> +++ fs/partitions/check.c	2005-07-29 00:36:04.523385998 +0200
> @@ -348,7 +348,8 @@
>  	}
>  
>  	/* always add handle for the whole disk */
> -	devfs_add_partitioned(disk);
> +	if (disk->devfs_name[0] != '\0')
> +		devfs_add_partitioned(disk);
>  
>  	/* No such device (e.g., media were just removed) */
>  	if (!get_capacity(disk))
> --- fs/devfs/base.c.orig	2005-07-29 00:32:03.329992027 +0200
> +++ fs/devfs/base.c	2005-07-29 00:32:52.000008934 +0200
> @@ -1644,7 +1644,7 @@
>  	va_start(args, fmt);
>  	n = vsnprintf(buf, 64, fmt, args);
>  	if (n >= 64 || !buf[0]) {
> -		printk(KERN_WARNING "%s: invalid argument.", __FUNCTION__);
> +		printk(KERN_WARNING "%s: invalid argument.\n", __FUNCTION__);
>  		return -EINVAL;
>  	}
>  




-- 
Horms
