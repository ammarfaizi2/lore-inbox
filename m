Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281469AbRKPRb2>; Fri, 16 Nov 2001 12:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281474AbRKPRbT>; Fri, 16 Nov 2001 12:31:19 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:29694 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S281468AbRKPRa7>; Fri, 16 Nov 2001 12:30:59 -0500
Date: Fri, 16 Nov 2001 12:30:53 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Eric Lammerts <eric@lammerts.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rootfs on USB storage device
Message-ID: <20011116123053.A7379@devserv.devel.redhat.com>
In-Reply-To: <200111160306.fAG36ZW05331@devserv.devel.redhat.com> <Pine.LNX.4.40.0111161403001.991-100000@ally.lammerts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0111161403001.991-100000@ally.lammerts.org>; from eric@lammerts.org on Fri, Nov 16, 2001 at 02:21:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 16 Nov 2001 14:21:04 +0100 (CET)
> From: Eric Lammerts <eric@lammerts.org>
> To: Pete Zaitcev <zaitcev@redhat.com>
> cc: josn@josn.myip.org, Greg KH <greg@kroah.com>,
>    <linux-kernel@vger.kernel.org>

> > I think khubd needs to run to complete whole process and mdelay()
> > locks it out. You need something that calls schedule() for USB
> > detection to work. Try to use schedule_timeout() instead of mdelay().
> 
> This patch works for me.

Looks like a well done patch but what does happen if root= was
indeed incorrect? I wish there was a way to print something
meaningful for the operator.

-- Pete

P.S. - quoting the patch, saved for future reference
> --- linux-2.4.14-pre8-ext3/fs/super.c.orig	Fri Nov 16 00:59:18 2001
> +++ linux-2.4.14-pre8-ext3/fs/super.c	Fri Nov 16 01:07:26 2001
> @@ -1009,11 +1009,13 @@
>  		 * Allow the user to distinguish between failed open
>  		 * and bad superblock on root device.
>  		 */
> -		printk ("VFS: Cannot open root device \"%s\" or %s\n",
> +		printk ("VFS: Cannot open root device \"%s\" or %s, retrying in 1s.\n",
>  			root_device_name, kdevname (ROOT_DEV));
> -		printk ("Please append a correct \"root=\" boot option\n");
> -		panic("VFS: Unable to mount root fs on %s",
> -			kdevname(ROOT_DEV));
> +
> +		/* wait 1 second and try again */
> +		current->state = TASK_INTERRUPTIBLE;
> +		schedule_timeout(HZ);
> +		goto retry;
>  	}
> 
>  	check_disk_change(ROOT_DEV);
