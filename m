Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTDDATg (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 19:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbTDDATg (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 19:19:36 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:62956 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263596AbTDDAT1 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 19:19:27 -0500
Date: Fri, 4 Apr 2003 02:30:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, arrays@hp.com, steve.cameron@hp.com
Subject: Re: [PATCH] reduce stack in cpqarray.c::ida_ioctl()
Message-ID: <20030404003044.GB16832@wohnheim.fh-wedel.de>
References: <20030403120308.620e5a14.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030403120308.620e5a14.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 April 2003 12:03:08 +0000, Randy.Dunlap wrote:
> 
> Comments on the patch?

Your patch looks just fine. The original code is a bit odd, though.
If you want to change that in one go, read on. If not, please ignore
this.

> diff -Naur ./drivers/block/cpqarray.c%IDAIOC ./drivers/block/cpqarray.c
> --- ./drivers/block/cpqarray.c%IDAIOC	2003-03-24 14:00:03.000000000 -0800
> +++ ./drivers/block/cpqarray.c	2003-04-02 20:05:57.000000000 -0800
> @@ -1021,7 +1021,7 @@
>  	int diskinfo[4];
>  	struct hd_geometry *geo = (struct hd_geometry *)arg;
>  	ida_ioctl_t *io = (ida_ioctl_t*)arg;
> -	ida_ioctl_t my_io;
> +	ida_ioctl_t *my_io;
>  
>  	switch(cmd) {
>  	case HDIO_GETGEO:
> @@ -1046,11 +1046,19 @@
>  		return 0;
>  	case IDAPASSTHRU:
>  		if (!capable(CAP_SYS_RAWIO)) return -EPERM;
> -		if (copy_from_user(&my_io, io, sizeof(my_io)))
> -			return -EFAULT;
> -		error = ida_ctlr_ioctl(ctlr, dsk, &my_io);
> -		if (error) return error;
> -		return copy_to_user(io, &my_io, sizeof(my_io)) ? -EFAULT : 0;
> +		my_io = kmalloc(sizeof(ida_ioctl_t), GFP_KERNEL);
> +		if (!my_io)
> +			return -ENOMEM;
> +		if (copy_from_user(my_io, io, sizeof(*my_io))) {
> +			error = -EFAULT;
> +			goto iocfree;
> +		}
> +		error = ida_ctlr_ioctl(ctlr, dsk, my_io);
> +		if (error) goto iocfree;

Wouldn't an extra line be nicer?

> +		error = copy_to_user(io, my_io, sizeof(*my_io)) ? -EFAULT : 0;

copy_to_user returns the bytes successfully copied.
error is set to -EFAULT, if there was actually data transferred?

How about:
+		error = copy_to_user(io, my_io, sizeof(*my_io)) < sizeof(*my_io) ? -EFAULT : 0;

> +  iocfree:
> +		kfree(my_io);
> +		return error;
>  	case IDAGETCTLRSIG:
>  		if (!arg) return -EINVAL;
>  		put_user(hba[ctlr]->ctlr_sig, (int*)arg);

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
