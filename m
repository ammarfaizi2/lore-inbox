Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTDPQPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTDPQPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:15:49 -0400
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:1540
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S264476AbTDPQPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:15:46 -0400
Message-ID: <003b01c30435$27ac0ab0$030aa8c0@unknown>
From: "Shawn Starr" <spstarr@sh0n.net>
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
References: <3E8BCB3A.8080806@colorfullife.com>
Subject: Re: 2.5.66-bk5 spinlock warnings/errors - Specifically ide-io:109 spinlock notice
Date: Wed, 16 Apr 2003 12:28:00 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to apply this and see what happens, unless it was already added to
.67-bk latest?

Shawn.

----- Original Message -----
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Shawn Starr" <spstarr@sh0n.net>
Cc: "Narayan Desai" <desai@mcs.anl.gov>; <linux-kernel@vger.kernel.org>
Sent: Thursday, April 03, 2003 1:48 AM
Subject: Re: 2.5.66-bk5 spinlock warnings/errors - Specifically ide-io:109
spinlock notice


> Shawn wrote:
>
> >>List:     linux-kernel
> >>Subject:  2.5.66-bk5 spinlock warnings/errors
> >From:     Narayan Desai <desai () mcs ! anl ! gov>
> >>Date:     2003-04-02 4:01:02
> >
> >>hda: dma_timer_expiry: dma status == 0x24
> >>drivers/ide/ide-io.c:109: spin_lock(drivers/ide/ide.c:c037abe8) already
> >>locked by drivers/ide/ide-io.c/948 drivers/ide/ide-io.c:990:
> >>spin_unlock(drivers/ide/ide.c:c037abe8) not locked
> >>hda: lost interrupt
> >>hda: dma_intr: bad DMA status (dma_stat=30)
> >>hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> >
> >I had this problem last night while making a huge debian package (tar.bz2
> >stage). It occured once.
> >
> >
> The attached patch should fix the problem:
> the dma_timer_expiry handler calls HWGROUP(drive)->handler in the wrong
> context. Instead of calling ->handler directly, the ->expiry handler
> must inform the caller that ->handler must be called, and then the
> caller must do some setup before calling ->handler.
>
> --
>     Manfred
>


----------------------------------------------------------------------------
----


> // $Header$
> // Kernel Version:
> //  VERSION = 2
> //  PATCHLEVEL = 5
> //  SUBLEVEL = 66
> //  EXTRAVERSION =
> --- 2.5/include/linux/ide.h 2003-03-25 17:49:52.000000000 +0100
> +++ build-2.5/include/linux/ide.h 2003-03-30 10:04:08.000000000 +0200
> @@ -1043,6 +1043,8 @@
>  typedef ide_startstop_t (ide_handler_t)(ide_drive_t *);
>  typedef ide_startstop_t (ide_post_handler_t)(ide_drive_t *);
>  typedef int (ide_expiry_t)(ide_drive_t *);
> +#define EXPIRY_ABORT (0)
> +#define EXPIRY_CALLHANDLER (-1)
>
>  typedef struct hwgroup_s {
>   /* irq handler, if active */
> --- 2.5/drivers/ide/ide-io.c 2003-03-25 17:49:40.000000000 +0100
> +++ build-2.5/drivers/ide/ide-io.c 2003-03-30 10:05:28.000000000 +0200
> @@ -973,7 +973,7 @@
>   }
>   if ((expiry = hwgroup->expiry) != NULL) {
>   /* continue */
> - if ((wait = expiry(drive)) != 0) {
> + if ((wait = expiry(drive)) > 0) {
>   /* reset timer */
>   hwgroup->timer.expires  = jiffies + wait;
>   add_timer(&hwgroup->timer);
> @@ -998,7 +998,7 @@
>   /* local CPU only,
>   * as if we were handling an interrupt */
>   local_irq_disable();
> - if (hwgroup->poll_timeout != 0) {
> + if (hwgroup->poll_timeout != 0 || wait == EXPIRY_CALLHANDLER) {
>   startstop = handler(drive);
>   } else if (drive_is_ready(drive)) {
>   if (drive->waiting_for_dma)
> --- 2.5/drivers/ide/ide-dma.c 2003-03-25 17:49:40.000000000 +0100
> +++ build-2.5/drivers/ide/ide-dma.c 2003-03-30 10:05:54.000000000 +0200
> @@ -483,9 +483,9 @@
>   return WAIT_CMD;
>
>   if (dma_stat & 4) /* Got an Interrupt */
> - HWGROUP(drive)->handler(drive);
> + return EXPIRY_CALLHANDLER;
>
> - return 0;
> + return EXPIRY_ABORT;
>  }
>
>  /**
>

