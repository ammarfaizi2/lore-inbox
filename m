Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUJLRXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUJLRXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUJLRTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:19:01 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:9874 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266460AbUJLRSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:18:03 -0400
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <416C0D55.1020603@rtr.ca>
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@i
		nfradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165A
	4	5D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca>	
	<4	165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca>		<20041007221537.A17
	712@infradead.org>	<1097241583.2412.15.camel@mulgrave>
		<4166AF2F.6070904@rtr.ca> <1097249266.1678.40.camel@mulgrave>
		<4166B48E.3020006@rtr.ca> <1097250465.2412.49.camel@mulgrave> 
	<416C0D55.1020603@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Oct 2004 12:17:52 -0500
Message-Id: <1097601478.2044.103.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 11:59, Mark Lord wrote:
> Yes.  The workqueue thread will invoke the mid-layer function,
> which will do a queuecommand, which will return to the mid-layer,
> which will then SLEEP waiting for the command to complete,
> which will sleep that workqueue thread.
> 
> As part of the interrupt processing to complete the command in the LLD,
> it is possible that schedule_work may be necessary, requiring that
> a workqueue thread be run.  If this means the same thread that is
> already sleeping courtesy of the mid-layer, then we could have a problem.
> 
> Comments?

Erm, perhaps you don't understand the concept of a work queue.  It's a
queue of pending work.  There's a back end daemon servicing the queue
and executing all the items on the queue in sequence.  schedule_work
just adds an item of work to the queue and returns.

So, it's perfectly legal to call schedule_work from within the work
queue function, because all you do is add the work to the list for the
daemon thread to execute when it gets to it.  There's nothing
synchronous about a workqueue.  If a work function sleeps, then its
true, it takes the worker thread longer to get to the next work item,
but as long as the work function awakes, it will get there.

James


