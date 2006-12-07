Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968515AbWLGD4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968515AbWLGD4m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 22:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968697AbWLGD4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 22:56:41 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:54983 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968515AbWLGD4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 22:56:40 -0500
Message-ID: <457790EB.4060302@us.ibm.com>
Date: Wed, 06 Dec 2006 19:56:27 -0800
From: Haren Myneni <haren@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: linux-kernel@vger.kernel.org, H Peter Anvin <hpa@zytor.com>,
       Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       hpa@zytor.com, Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: [PATCH] free initrds boot option
References: <4410.1165450723@neuling.org>
In-Reply-To: <4410.1165450723@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Neuling wrote:

>Add free_initrd= option to control freeing of initrd memory after
>extraction.  By default, free memory as previously.
>
>Signed-off-by: Michael Neuling <mikey@neuling.org>
>---
>Useful for kexec when you want to reuse the same initrd.  Testing on
>POWERPC with CPIOs
>  
>
   
 This option (free_initrd) will not work if the user loads the kdump 
kernel and does the normal kexec boot later on powerpc. The reason is 
initrd will be loaded by yaboot at 36MB and kdump image at 32M (Right 
now it is fixed). It could be possible that we will end up overwriting 
initrd.

> init/initramfs.c |   18 ++++++++++++++++--
> 1 file changed, 16 insertions(+), 2 deletions(-)
>
>Index: linux-2.6-ozlabs/init/initramfs.c
>===================================================================
>--- linux-2.6-ozlabs.orig/init/initramfs.c
>+++ linux-2.6-ozlabs/init/initramfs.c
>@@ -487,6 +487,17 @@ static char * __init unpack_to_rootfs(ch
> 	return message;
> }
>
>+static int do_free_initrd = 1;
>+
>+int __init free_initrd_param(char *p)
>+{
>+	if (p && strncmp(p, "0", 1) == 0)
>+		do_free_initrd = 0;
>+
>+	return 0;
>+}
>+early_param("free_initrd", free_initrd_param);
>+
> extern char __initramfs_start[], __initramfs_end[];
> #ifdef CONFIG_BLK_DEV_INITRD
> #include <linux/initrd.h>
>@@ -494,10 +505,13 @@ extern char __initramfs_start[], __initr
>
> static void __init free_initrd(void)
> {
>-#ifdef CONFIG_KEXEC
> 	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
> 	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
>
>+	if (!do_free_initrd)
>+		goto skip;
>+
>+#ifdef CONFIG_KEXEC
> 	/*
> 	 * If the initrd region is overlapped with crashkernel reserved region,
> 	 * free only memory that is not part of crashkernel region.
>@@ -515,7 +529,7 @@ static void __init free_initrd(void)
> 	} else
> #endif
> 		free_initrd_mem(initrd_start, initrd_end);
>-
>+skip:
> 	initrd_start = 0;
> 	initrd_end = 0;
> }
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

