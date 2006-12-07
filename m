Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937832AbWLGAZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937832AbWLGAZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937833AbWLGAZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:25:21 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:40914 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937832AbWLGAZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:25:20 -0500
Date: Wed, 6 Dec 2006 16:25:48 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linux-kernel@vger.kernel.org, H Peter Anvin <hpa@zytor.com>,
       Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] free initrds boot option
Message-Id: <20061206162548.7c145d2c.randy.dunlap@oracle.com>
In-Reply-To: <4410.1165450723@neuling.org>
References: <4410.1165450723@neuling.org>
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

On Thu, 07 Dec 2006 11:18:43 +1100 Michael Neuling wrote:

> Add free_initrd= option to control freeing of initrd memory after
> extraction.  By default, free memory as previously.

Please add doc. for this in Documentation/kernel-parameters.txt.

> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> Useful for kexec when you want to reuse the same initrd.  Testing on
> POWERPC with CPIOs 
> 
>  init/initramfs.c |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6-ozlabs/init/initramfs.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/init/initramfs.c
> +++ linux-2.6-ozlabs/init/initramfs.c
> @@ -487,6 +487,17 @@ static char * __init unpack_to_rootfs(ch
>  	return message;
>  }
>  
> +static int do_free_initrd = 1;
> +
> +int __init free_initrd_param(char *p)
> +{
> +	if (p && strncmp(p, "0", 1) == 0)
> +		do_free_initrd = 0;
> +
> +	return 0;
> +}
> +early_param("free_initrd", free_initrd_param);
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
>  
> +	if (!do_free_initrd)
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
