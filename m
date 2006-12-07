Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937837AbWLGAai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937837AbWLGAai (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937838AbWLGAai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:30:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58834 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937837AbWLGAah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:30:37 -0500
Date: Wed, 6 Dec 2006 16:30:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Neuling <mikey@neuling.org>
Cc: linux-kernel@vger.kernel.org, H Peter Anvin <hpa@zytor.com>,
       Al Viro <viro@ftp.linux.org.uk>, fastboot@lists.osdl.org
Subject: Re: [PATCH] free initrds boot option
Message-Id: <20061206163021.f434f09b.akpm@osdl.org>
In-Reply-To: <4410.1165450723@neuling.org>
References: <4410.1165450723@neuling.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2006 11:18:43 +1100
Michael Neuling <mikey@neuling.org> wrote:

> Add free_initrd= option to control freeing of initrd memory after
> extraction.  By default, free memory as previously.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> Useful for kexec when you want to reuse the same initrd.  Testing on
> POWERPC with CPIOs 
> 
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

I'd have thought that an option `retain_initrd' would make more sense.

Please always update Documentation/kernel-parameters.txt when adding boot
options.

