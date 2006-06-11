Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWFKPAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWFKPAr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 11:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWFKPAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 11:00:47 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:20687 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751619AbWFKPAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 11:00:47 -0400
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: HighPoint Linux Team <linux@highpoint-tech.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200606111918.08529.linux@highpoint-tech.com>
References: <200606111706.52930.linux@highpoint-tech.com>
	 <200606111918.08529.linux@highpoint-tech.com>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 10:00:42 -0500
Message-Id: <1150038042.4128.11.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-11 at 19:18 +0800, HighPoint Linux Team wrote:
>                 dprintk("hptiop_queuecmd : no free req\n");
> -               scp->result = DID_BUS_BUSY << 16;
> +               scp->result = SCSI_MLQUEUE_HOST_BUSY;
>                 goto cmd_done;

As jeff said, this needs to become a return SCSI_MLQUEUE_HOST_BUSY.

> On Sunday 11 June 2006 05:07 pm, HighPoint Linux Team wrote:
> >>
> >>	host->can_queue = le32_to_cpu(iop_config.max_requests);
> >>	host->cmd_per_lun = le32_to_cpu(iop_config.max_requests);
> >> 
> >> You might want to think about adjusting this.  For the single LUN case,
> >> it's fine.  For the multi-lun case it may allow commands to a single LUN
> >> to starve everything else.
> >
> >There will be no multi-lun support for the controller so this is not
> >an issue.
> 
> Sorry, a mistake. Multi-lun is supported.
> Should host->can_queue be set to (cmd_per_lun * max_lun) ?

It depends on how the controller behaves.  Setting can_queue and
cmd_per_lun tends to work for most SCSI controllers because the actual
scsi devices have queue depths << this number.  If your controller will
behave like this (i.e. will not allow the internal queue for a single
lun to fill up to this depth) then you can keep this setting (although,
again, since this is probably fixed by the firmware, you want to set
cmd_per_lun to this value to avoid excessive QUEUE_FULL returns).  If
the controller will happily load all the available slots up for a single
lun, then you might want to think about reducing cmd_per_lun to some
fraction of can_queue (you could even set it to can_queue - 2 like the
3ware controller).

Most of the other actual raid controllers seem to have much smaller
per-lun queues, so they mainly set smaller, fixed size values for
cmd_per_lun.

James


