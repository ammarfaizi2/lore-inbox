Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968793AbWLGFGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968793AbWLGFGy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 00:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968792AbWLGFGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 00:06:54 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:49189 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968791AbWLGFGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 00:06:53 -0500
Date: Wed, 6 Dec 2006 21:07:19 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linux-kernel@vger.kernel.org, H Peter Anvin <hpa@zytor.com>,
       Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] free initrds boot option
Message-Id: <20061206210719.ececc3ec.randy.dunlap@oracle.com>
In-Reply-To: <14049.1165462977@neuling.org>
References: <14049.1165462977@neuling.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2006 14:42:57 +1100 Michael Neuling wrote:

> Add retain_initrd option to control freeing of initrd memory after
> extraction.  By default, free memory as previously.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> Updated based on comments from akpm.  
> Added documentation and changed option name to "retain_initrd"
> Tested on POWERPC with CPIOs
> 
>  Documentation/kernel-parameters.txt |    2 ++
>  init/initramfs.c                    |   18 ++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6-ozlabs/init/initramfs.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/init/initramfs.c
> +++ linux-2.6-ozlabs/init/initramfs.c
> @@ -487,6 +487,17 @@ static char * __init unpack_to_rootfs(ch
>  	return message;
>  }
>  
> +static int do_retain_initrd = 0;
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

How does this work when CONFIG_KEXEC=n ??

Tested?

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
> -

---
~Randy
