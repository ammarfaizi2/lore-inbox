Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269981AbUJHNWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbUJHNWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269965AbUJHNVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:21:05 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:14516 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269968AbUJHNTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:19:55 -0400
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20041007221537.A17712@infradead.org>
References: <4161A06D.8010601@rtr.ca> <416547B6.5080505@rtr.ca>
	<20041007150709.B12688@infradead.org> <4165624C.5060405@rtr.ca>
	<416565DB.4050006@pobox.com> <4165A45D.2090200@rtr.ca>
	<4165A766.1040104@pobox.com> <4165A85D.7080704@rtr.ca>
	<4165AB1B.8000204@pobox.com> <4165ACF8.8060208@rtr.ca> 
	<20041007221537.A17712@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Oct 2004 08:19:38 -0500
Message-Id: <1097241583.2412.15.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 16:15, Christoph Hellwig wrote:
>  - please use the kernel/kthread.c interface for your kernel thread

Actually, the driver has no need for a thread at all.  Since you're
simply using it to fire hotplug events, use schedule_work instead.

I also noticed the following in a lightening review:

- Kill these constructs:
+	/* scsi_done expects to be called while locked */
+	if (!in_interrupt())
+		spin_lock_irqsave(uhba->lock, flags);

scsi_done() doesn't require a lock

- Your emulated commands assume they're non-sg and issued through the
kernel (i.e. you don't kmap and you don't do SG).  This will blow up on
the first inquiry submitted via SG_IO for instance.

I'm sure there are others, but I don't have time to do a thorough review
at the moment.

James


