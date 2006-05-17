Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWEQVWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWEQVWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 17:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWEQVWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 17:22:43 -0400
Received: from xenotime.net ([66.160.160.81]:21996 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751135AbWEQVWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 17:22:42 -0400
Date: Wed, 17 May 2006 14:25:10 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc subsystem, use ENOIOCTLCMD where appropriate
Message-Id: <20060517142510.b3fcfb7d.rdunlap@xenotime.net>
In-Reply-To: <20060517013033.10d08a8f@inspiron>
References: <20060517013033.10d08a8f@inspiron>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2006 01:30:33 +0200 Alessandro Zummo wrote:

> 
> 
> Appropriately use -ENOIOCTLCMD when
> the ioctl is not implemented by a driver.

so this return value does not go back to userspace?
Comment in linux/errno.h says:
/* Should never be seen by user programs */

and ENOTTY is the return value for "Inappropriate ioctl for device":

http://marc.theaimsgroup.com/?l=linux-fsdevel&m=106739260707476&w=2
http://marc.theaimsgroup.com/?l=lustre-devel&m=106737825024915&w=2



> Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
> 
> ---
>  drivers/rtc/rtc-dev.c    |    6 +++---
>  drivers/rtc/rtc-sa1100.c |    2 +-
>  drivers/rtc/rtc-test.c   |    2 +-
>  drivers/rtc/rtc-vr41xx.c |    2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> --- linux-rtc.orig/drivers/rtc/rtc-test.c	2006-05-17 01:21:35.000000000 +0200
> +++ linux-rtc/drivers/rtc/rtc-test.c	2006-05-17 01:22:39.000000000 +0200
> @@ -71,7 +71,7 @@ static int test_rtc_ioctl(struct device 
>  		return 0;
>  
>  	default:
> -		return -EINVAL;
> +		return -ENOIOCTLCMD;
>  	}
>  }
>  
> --- linux-rtc.orig/drivers/rtc/rtc-vr41xx.c	2006-05-17 01:21:59.000000000 +0200
> +++ linux-rtc/drivers/rtc/rtc-vr41xx.c	2006-05-17 01:22:29.000000000 +0200
> @@ -270,7 +270,7 @@ static int vr41xx_rtc_ioctl(struct devic
>  		epoch = arg;
>  		break;
>  	default:
> -		return -EINVAL;
> +		return -ENOIOCTLCMD;
>  	}
>  
>  	return 0;
> --- linux-rtc.orig/drivers/rtc/rtc-sa1100.c	2006-05-17 01:18:19.000000000 +0200
> +++ linux-rtc/drivers/rtc/rtc-sa1100.c	2006-05-17 01:23:26.000000000 +0200
> @@ -247,7 +247,7 @@ static int sa1100_rtc_ioctl(struct devic
>  		rtc_freq = arg;
>  		return 0;
>  	}
> -	return -EINVAL;
> +	return -ENOIOCTLCMD;
>  }
>  
>  static int sa1100_rtc_read_time(struct device *dev, struct rtc_time *tm)
> --- linux-rtc.orig/drivers/rtc/rtc-dev.c	2006-05-17 01:18:19.000000000 +0200
> +++ linux-rtc/drivers/rtc/rtc-dev.c	2006-05-17 01:26:01.000000000 +0200
> @@ -141,13 +141,13 @@ static int rtc_dev_ioctl(struct inode *i
>  	/* try the driver's ioctl interface */
>  	if (ops->ioctl) {
>  		err = ops->ioctl(class_dev->dev, cmd, arg);
> -		if (err != -EINVAL)
> +		if (err != -ENOIOCTLCMD)
>  			return err;
>  	}
>  
>  	/* if the driver does not provide the ioctl interface
>  	 * or if that particular ioctl was not implemented
> -	 * (-EINVAL), we will try to emulate here.
> +	 * (-ENOIOCTLCMD), we will try to emulate here.
>  	 */
>  
>  	switch (cmd) {
> @@ -233,7 +233,7 @@ static int rtc_dev_ioctl(struct inode *i
>  		break;
>  
>  	default:
> -		err = -EINVAL;
> +		err = -ENOIOCTLCMD;
>  		break;
>  	}
>  
> -

---
~Randy
