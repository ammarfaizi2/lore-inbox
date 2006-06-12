Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWFLECP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWFLECP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 00:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWFLECP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 00:02:15 -0400
Received: from stats.hypersurf.com ([209.237.0.12]:19716 "EHLO
	stats.hypersurf.com") by vger.kernel.org with ESMTP
	id S1751270AbWFLECO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 00:02:14 -0400
Message-ID: <029801c68dd5$1e8ee6f0$1200a8c0@GMM>
From: "HighPoint Linux Team" <linux@highpoint-tech.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       <akpm@osdl.org>
References: <200606111706.52930.linux@highpoint-tech.com> <200606111918.08529.linux@highpoint-tech.com> <1150038042.4128.11.camel@mulgrave.il.steeleye.com>
Subject: Re: [PATCH] hptiop: HighPoint RocketRAID 3xxx controller driver
Date: Mon, 12 Jun 2006 12:03:01 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
>> Should host->can_queue be set to (cmd_per_lun * max_lun) ?
>
> It depends on how the controller behaves.  Setting can_queue and
> cmd_per_lun tends to work for most SCSI controllers because the 
> actual scsi devices have queue depths << this number.  If your 
> controller will behave like this (i.e. will not allow the internal
> queue for a single lun to fill up to this depth) then you can keep
> this setting (although, again, since this is probably fixed by the
> firmware, you want to set cmd_per_lun to this value to avoid
> excessive QUEUE_FULL returns). If the controller will happily load
> all the available slots up for a single lun, then you might want
> to think about reducing cmd_per_lun to some fraction of can_queue
> (you could even set it to can_queue - 2 like the 3ware controller).

The hptiop firmware works as the latter case. Should it be modified
like this:
  host->can_queue = le32_to_cpu(iop_config.max_requests);
- host->cmd_per_lun = le32_to_cpu(iop_config.max_requests);
+ host->cmd_per_lun = host->can_queue - 2;

While the 3ware driver sets both can_queue and cmd_per_lun to 254:

(3w-9xxx.h)
#define TW_Q_LENGTH           256
#define TW_MAX_CMDS_PER_LUN   254

(3w-9xxx.c)
.can_queue   = TW_Q_LENGTH-2,
.cmd_per_lun = TW_MAX_CMDS_PER_LUN

Should can_queue be set to TW_Q_LENGTH ?

HighPoint Linux Team

