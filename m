Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUJLRVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUJLRVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266474AbUJLRV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:21:27 -0400
Received: from havoc.gtf.org ([69.28.190.101]:34226 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266352AbUJLRU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:20:29 -0400
Date: Tue, 12 Oct 2004 13:19:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Mark Lord <lkml@rtr.ca>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>, Mark Lord <lsml@rtr.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
Message-ID: <20041012171922.GA11057@havoc.gtf.org>
References: <4165ACF8.8060208@rtr.ca> <20041007221537.A17712@infradead.org> <1097241583.2412.15.camel@mulgrave> <4166AF2F.6070904@rtr.ca> <1097249266.1678.40.camel@mulgrave> <4166B48E.3020006@rtr.ca> <1097250465.2412.49.camel@mulgrave> <416C0D55.1020603@rtr.ca> <20041012170333.GA9274@havoc.gtf.org> <416C10D9.9090306@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416C10D9.9090306@rtr.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 01:14:01PM -0400, Mark Lord wrote:
> Jeff Garzik wrote:
> >
> >>Yes.  The workqueue thread will invoke the mid-layer function,
> >>which will do a queuecommand, which will return to the mid-layer,
> >>which will then SLEEP waiting for the command to complete,
> >>which will sleep that workqueue thread.
> >>
> >>As part of the interrupt processing to complete the command in the LLD,
> >>it is possible that schedule_work may be necessary, requiring that
> >>a workqueue thread be run.  If this means the same thread that is
> >>already sleeping courtesy of the mid-layer, then we could have a problem.
> >
> >The only schedule_work() call in the SCSI common code is for domain
> >validation.
> 
> This particulare schedule_work() would be invoked from
> the interrupt handler in the LLD -- part of the qstor driver.
> 
> Is there a single thread (per CPU) for doing work from schedule_work(),
> or are there multiple such threads created on demand?
> 
> If there's just a single thread, then this scenario (described above)
> could indeed deadlock, in which case qstor cannot use schedule_work()
> to perform notification of drive hot insert/removal events.
> 
> What do you think, Jeff?

Your assessment is correct, in that, on single-CPU systems there is only
one thread for schedule_work() events.  For each workqueue, there is one
thread per CPU.

That does not preclude (a) using a private workqueue, rather than the
general one or (b) using the kthread API as Christoph suggested.

	Jeff



