Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVA2Rvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVA2Rvr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 12:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVA2Rvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 12:51:47 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:25411 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261482AbVA2Rv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 12:51:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=d3172sjyUumGhryLQmjGkHurK/6vUs1vCXvVijcri8L3h/81LXexjZikSRxLuXmd7SaGsw+a5mT7cE1HCa1M1IJa7l7mtlOHzc1K18j7+lPAOIL0Pv5PS5G192PzQWNvuNEg5Z1RXUDjXBHPSA4Qd1MuEzFQnjHfblkFL/5ezfw=
Message-ID: <58cb370e05012909513cc96b17@mail.gmail.com>
Date: Sat, 29 Jan 2005 18:51:25 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] drivers/cdrom/isp16.c: small cleanups
Cc: H.T.M.v.d.Maarel@marin.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20050129171108.GB28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050129171108.GB28047@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 29 Jan 2005 18:11:08 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> This patch makes the needlessly global function isp16_init static.
> 
> As a result, it turned out that both this function and some other code
> are only required #ifdef MODULE.

Your patch is correct but it is wrong. ;)

#ifdefs around isp16_init() need to be removed as
otherwise this driver is not initialized in built-in case.

Bartlomiej

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/cdrom/isp16.c |   13 ++++++++-----
>  drivers/cdrom/isp16.h |    1 -
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> --- linux-2.6.11-rc2-mm1-full/drivers/cdrom/isp16.h.old 2005-01-29 16:46:18.000000000 +0100
> +++ linux-2.6.11-rc2-mm1-full/drivers/cdrom/isp16.h     2005-01-29 16:47:11.000000000 +0100
> @@ -71,4 +71,3 @@
>  #define ISP16_IO_BASE 0xF8D
>  #define ISP16_IO_SIZE 5  /* ports used from 0xF8D up to 0xF91 */
> 
> -int isp16_init(void);
> --- linux-2.6.11-rc2-mm1-full/drivers/cdrom/isp16.c.old 2005-01-29 16:47:19.000000000 +0100
> +++ linux-2.6.11-rc2-mm1-full/drivers/cdrom/isp16.c     2005-01-29 17:46:38.000000000 +0100
> @@ -58,6 +58,7 @@
>  #include <asm/io.h>
>  #include "isp16.h"
> 
> +#ifdef MODULE
>  static short isp16_detect(void);
>  static short isp16_c928__detect(void);
>  static short isp16_c929__detect(void);
> @@ -66,6 +67,7 @@
>  static short isp16_type;       /* dependent on type of interface card */
>  static u_char isp16_ctrl;
>  static u_short isp16_enable_port;
> +#endif  /*  MODULE  */
> 
>  static int isp16_cdrom_base = ISP16_CDROM_IO_BASE;
>  static int isp16_cdrom_irq = ISP16_CDROM_IRQ;
> @@ -106,13 +108,13 @@
> 
>  __setup("isp16=", isp16_setup);
> 
> -#endif                         /* MODULE */
> +#else                          /* MODULE */
> 
>  /*
>   *  ISP16 initialisation.
>   *
>   */
> -int __init isp16_init(void)
> +static int __init isp16_init(void)
>  {
>         u_char expected_drive;
> 
> @@ -366,15 +368,16 @@
>         return 0;
>  }
> 
> +module_init(isp16_init);
> +
> +#endif
> +
>  void __exit isp16_exit(void)
>  {
>         release_region(ISP16_IO_BASE, ISP16_IO_SIZE);
>         printk(KERN_INFO "ISP16: module released.\n");
>  }
> 
> -#ifdef MODULE
> -module_init(isp16_init);
> -#endif
>  module_exit(isp16_exit);
> 
>  MODULE_LICENSE("GPL");
>
