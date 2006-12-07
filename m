Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030736AbWLGFjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030736AbWLGFjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030820AbWLGFjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:39:16 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:58791 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030736AbWLGFjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:39:15 -0500
Message-ID: <4577A91E.70501@oracle.com>
Date: Wed, 06 Dec 2006 21:39:42 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: linux-kernel@vger.kernel.org, H Peter Anvin <hpa@zytor.com>,
       Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Add retain_initrd boot option
References: <20614.1165469597@neuling.org>
In-Reply-To: <20614.1165469597@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Neuling wrote:
> Add retain_initrd option to control freeing of initrd memory after
> extraction.  By default, free memory as previously. 
> 
> The first boot will need to hold a copy of the in memory fs for the
> second boot.  This image can be large (much larger than the kernel),
> hence we can save time when the memory loader is slow.  Also, it reduces
> the memory footprint while extracting the first boot since you don't
> need another copy of the fs.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> Removed unnecessary init of do_retain_initrd as suggested by Randy
> Dunlap.
> 
>  Documentation/kernel-parameters.txt |    2 ++
>  init/initramfs.c                    |   18 ++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6-ozlabs/Documentation/kernel-parameters.txt
> ===================================================================
> --- linux-2.6-ozlabs.orig/Documentation/kernel-parameters.txt
> +++ linux-2.6-ozlabs/Documentation/kernel-parameters.txt
> @@ -1366,6 +1366,8 @@ and is between 256 and 4096 characters. 
>  	resume=		[SWSUSP]
>  			Specify the partition device for software suspend
>  
> +	retain_initrd	[RAM] Keep initrd memory after extraction
> +
>  	rhash_entries=	[KNL,NET]
>  			Set number of hash buckets for route cache
>  
> Index: linux-2.6-ozlabs/init/initramfs.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/init/initramfs.c
> +++ linux-2.6-ozlabs/init/initramfs.c
> @@ -487,6 +487,17 @@ static char * __init unpack_to_rootfs(ch
>  	return message;
>  }
>  
> +static int do_retain_initrd;
> +
> +static int __init retain_initrd_param(char *str)
> +{
> +	if (*str)
> +		return 0;
> +	do_retain_initrd = 1;
> +	return 1;
> +}
> +__setup("retain_initrd", retain_initrd_param);
> +
>  extern char __initramfs_start[], __initramfs_end[];
>  #ifdef CONFIG_BLK_DEV_INITRD
>  #include <linux/initrd.h>
> @@ -494,10 +505,13 @@ extern char __initramfs_start[], __initr
>  
>  static void __init free_initrd(void)
>  {
> -#ifdef CONFIG_KEXEC
>  	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
>  	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);

I'm still not seeing how using crashk_res is valid here when
CONFIG_KEXEC=n.  Can you explain that, please?
You did test this with KEXEC=y and KEXEC=n, right?

> +	if (do_retain_initrd)
> +		goto skip;
> +
> +#ifdef CONFIG_KEXEC
>  	/*
>  	 * If the initrd region is overlapped with crashkernel reserved region,
>  	 * free only memory that is not part of crashkernel region.
> @@ -515,7 +529,7 @@ static void __init free_initrd(void)
>  	} else
>  #endif
>  		free_initrd_mem(initrd_start, initrd_end);
> -
> +skip:
>  	initrd_start = 0;
>  	initrd_end = 0;
>  }


-- 
~Randy
