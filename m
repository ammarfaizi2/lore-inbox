Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWDUVgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWDUVgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWDUVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:36:37 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:24772 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964793AbWDUVgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:36:36 -0400
Message-ID: <4449504D.1040901@garzik.org>
Date: Fri, 21 Apr 2006 17:36:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Pavel Machek <pavel@suse.cz>, Arkadiusz Miskiewicz <arekm@maven.pl>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: sata suspend resume ...
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com> <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com> <20060420134713.GA2360@ucw.cz> <Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com> <20060421163930.GA1648@elf.ucw.cz> <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> --- 2.6.17-rc2/drivers/scsi/libata-core.c	2006-04-19 09:14:11.000000000 +0100
> +++ linux/drivers/scsi/libata-core.c	2006-04-21 20:55:48.000000000 +0100
> @@ -4288,6 +4288,7 @@ int ata_device_resume(struct ata_port *a
>  {
>  	if (ap->flags & ATA_FLAG_SUSPENDED) {
>  		ap->flags &= ~ATA_FLAG_SUSPENDED;
> +		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
>  		ata_set_mode(ap);
>  	}


This is helpful to narrow down the problem, but its a bit of a layering 
violation.  In the current code, all functions called by 
ata_device_{suspend,resume}() are high level functions, which uses 
ata_qc_issue/ata_qc_complete high level API to address the device.

In contrast, ata_busy_sleep() sticks its hands deep into the host state 
machine, and gives the tree a good hard shake.  :)  Consider that 
ata_busy_sleep() doesn't make sense for unusual cases like 
ATA-over-ethernet (AoE), or other tunnelled ATA transports.

It may very well be that ata_busy_sleep() is the proper solution for 
your hardware, but it isn't applicable to all hardware.

So you really want an ata_make_sure_bus_is_awake_and_working() called at 
that location.  ata_busy_sleep()'s purpose is to bring a PATA-like bus 
to the bus-idle state.  So, when working on suspend/resume, the software 
needs to have points at which the bus state is controlled/queried/asserted.

	Jeff


