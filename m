Return-Path: <linux-kernel-owner+w=401wt.eu-S1760421AbWLJNQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760421AbWLJNQu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 08:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760449AbWLJNQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 08:16:50 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2575 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760421AbWLJNQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 08:16:49 -0500
Date: Fri, 8 Dec 2006 21:16:23 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Paul Clements <paul.clements@steeleye.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, wouter@grep.be
Subject: Re: [PATCH] nbd: show nbd client pid in sysfs
Message-ID: <20061208211622.GB4924@ucw.cz>
References: <45762745.7010202@steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45762745.7010202@steeleye.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This simple patch allows nbd to expose the nbd-client 
> daemon's PID in /sys/block/nbd<x>/pid. This is helpful 
> for tracking connection status of a device and for 
> determining which nbd devices are currently in use.

Should get a line or two in Documentation/ ?
						Pavel

> Tested against 2.6.19.
> 
> Thanks,
> Paul

> --- ./drivers/block/nbd.c	Wed Nov 29 16:57:37 2006
> +++ ./drivers/block/nbd.c	Tue Nov 28 16:09:31 2006
> @@ -355,14 +389,30 @@ harderror:
>  	return NULL;
>  }
>  
> +static ssize_t pid_show(struct gendisk *disk, char *page)
> +{
> +	return sprintf(page, "%ld\n",
> +		(long) ((struct nbd_device *)disk->private_data)->pid);
> +}
> +
> +static struct disk_attribute pid_attr = {
> +	.attr = { .name = "pid", .mode = S_IRUGO },
> +	.show = pid_show,
> +};
> +	
>  static void nbd_do_it(struct nbd_device *lo)
>  {
>  	struct request *req;
>  
>  	BUG_ON(lo->magic != LO_MAGIC);
>  
> +	lo->pid = current->pid;
> +	sysfs_create_file(&lo->disk->kobj, &pid_attr.attr);
> +
>  	while ((req = nbd_read_stat(lo)) != NULL)
>  		nbd_end_request(req);
> +
> +	sysfs_remove_file(&lo->disk->kobj, &pid_attr.attr);
>  	return;
>  }
>  
> --- ./include/linux/nbd.h	Wed Nov 29 16:57:37 2006
> +++ ./include/linux/nbd.h	Mon Dec  4 23:28:30 2006
> @@ -64,6 +64,7 @@ struct nbd_device {
>  	struct gendisk *disk;
>  	int blksize;
>  	u64 bytesize;
> +	pid_t pid; /* pid of nbd-client, if attached */
>  };
>  
>  #endif


-- 
Thanks for all the (sleeping) penguins.
