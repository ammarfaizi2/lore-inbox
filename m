Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUJLRjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUJLRjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUJLRik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:38:40 -0400
Received: from havoc.gtf.org ([69.28.190.101]:44721 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266245AbUJLRGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:06:25 -0400
Date: Tue, 12 Oct 2004 13:03:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Mark Lord <lkml@rtr.ca>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>, Mark Lord <lsml@rtr.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
Message-ID: <20041012170333.GA9274@havoc.gtf.org>
References: <4165A85D.7080704@rtr.ca> <4165AB1B.8000204@pobox.com> <4165ACF8.8060208@rtr.ca> <20041007221537.A17712@infradead.org> <1097241583.2412.15.camel@mulgrave> <4166AF2F.6070904@rtr.ca> <1097249266.1678.40.camel@mulgrave> <4166B48E.3020006@rtr.ca> <1097250465.2412.49.camel@mulgrave> <416C0D55.1020603@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416C0D55.1020603@rtr.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 12:59:01PM -0400, Mark Lord wrote:
> James Bottomley wrote:
> >On Fri, 2004-10-08 at 10:38, Mark Lord wrote:
> >
> >>Can deadlock occur here, since qstor.c is already using schedule_work()
> >>as part of it's internal bottom-half handling for abnormal conditions?
> >>
> >>Eg.  hotplug event -> schedule_work -> mid-layer -> queuecommand
> >>      --> sleep  :: interrupt -> schedule_work -> deadlock?
> >>
> >
> >
> >Since you wouldn't go straight from schedule_work->mid-layer, I assume
> >you mean that when the workqueue thread runs the work?
> 
> Yes.  The workqueue thread will invoke the mid-layer function,
> which will do a queuecommand, which will return to the mid-layer,
> which will then SLEEP waiting for the command to complete,
> which will sleep that workqueue thread.
> 
> As part of the interrupt processing to complete the command in the LLD,
> it is possible that schedule_work may be necessary, requiring that
> a workqueue thread be run.  If this means the same thread that is
> already sleeping courtesy of the mid-layer, then we could have a problem.

The only schedule_work() call in the SCSI common code is for domain
validation.

All the other stuff is done by the totally independent error handling
threads, or by non-process contexts such as tasklets.

	Jeff



