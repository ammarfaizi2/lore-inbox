Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264886AbUE0RCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbUE0RCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbUE0RCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:02:38 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2181 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264886AbUE0RCg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:02:36 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6] don't put IDE disks in standby mode on halt on Alpha
Date: Thu, 27 May 2004 18:54:21 +0200
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040527194920.A1709@jurassic.park.msu.ru>
In-Reply-To: <20040527194920.A1709@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405271854.21499.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 of May 2004 17:49, Ivan Kokshaysky wrote:
> Spinning the disks down across a 'halt' on Alpha is even
> worse than doing that on reboot on i386 (assuming the
> boot device is IDE disk).
> Typically, the sequence to boot another kernel is:
> # halt
> kernel shuts down, firmware re-initializes,
> then on firmware prompt we type something like
>
> >>> boot -file new_kernel_image.gz

How is it different from reboot?
[ I don't know much about alpha. ]

> Unfortunately, the firmware does not expect the IDE drive
> to be in standby mode and reports 'bootstrap failure' on
> the first and all subsequent boot attempts until the
> drive spins up, which is extremely annoying and
> confuses users a lot.

So how does it work in 2.4?

> This patch allows architectures override the default
> behavior (don't spin the disks down on reboot only)
> in asm/ide.h.

No more <asm/ide.h> crap, please.

> Ivan.
>
> --- 2.6/drivers/ide/ide-disk.c	Fri May 21 21:06:12 2004
> +++ linux/drivers/ide/ide-disk.c	Fri May 21 21:48:09 2004
> @@ -1723,7 +1723,7 @@ static void ide_device_shutdown(struct d
>  {
>  	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
>
> -	if (system_state == SYSTEM_RESTART) {
> +	if (ide_shutdown_omit_standby(system_state)) {
>  		ide_cacheflush_p(drive);
>  		return;
>  	}
> --- 2.6/include/linux/ide.h	Fri May 21 21:47:13 2004
> +++ linux/include/linux/ide.h	Fri May 21 21:48:09 2004
> @@ -1709,4 +1709,8 @@ static inline int ata_can_queue(ide_driv
>
>  extern struct bus_type ide_bus_type;
>
> +#ifndef ide_shutdown_omit_standby
> +#define ide_shutdown_omit_standby(sys_state)	(sys_state == SYSTEM_RESTART)
> +#endif
> +
>  #endif /* _IDE_H */
> --- 2.6/include/asm-alpha/ide.h	Fri May 21 21:47:54 2004
> +++ linux/include/asm-alpha/ide.h	Fri May 21 21:48:34 2004
> @@ -52,6 +52,8 @@ static inline unsigned long ide_default_
>  #define ide_init_default_irq(base)	ide_default_irq(base)
>  #endif
>
> +#define ide_shutdown_omit_standby(sys_state)	(sys_state !=
> SYSTEM_POWER_OFF) +
>  #include <asm-generic/ide_iops.h>
>
>  #endif /* __KERNEL__ */

