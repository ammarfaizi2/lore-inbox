Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUJLRro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUJLRro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUJLRg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:36:26 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:44950 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266555AbUJLRa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:30:28 -0400
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <416C12CC.1050301@rtr.ca>
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@i
			nfradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165
	A	4	5D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca
	>		<4	165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca>		<20041007221537.
	A17	712@infradead.org>	<1097241583.2412.15.camel@mulgrave>		<4166AF2F.607090
	4@rtr.ca> <1097249266.1678.40.camel@mulgrave>		<4166B48E.3020006@rtr.ca>
	<1097250465.2412.49.camel@mulgrave> 	<416C0D55.1020603@rtr.ca>
	<1097601478.2044.103.camel@mulgrave>  <416C12CC.1050301@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Oct 2004 12:30:14 -0500
Message-Id: <1097602220.2044.119.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 12:22, Mark Lord wrote:
> Good.  That is exactly how I suspected it worked.
> In which case, deadlock *will* happen in the scenario described,
> and the qstor driver should therefore NOT use schedule_work()
> as the means of invoking the scsi_add_device()/scsi_remove_device()
> functions.  A separate thread appears needed.
> 
> Again, the scenario is:  schedule_work is used to have a work function
> invoked asynchronously, which then invokes scsi_add_device(),
> which then queues a command to the device and SLEEPS awaiting
> completion of the (INQUIRY) command.
> 
> As part of handling the command in the LLD, the qstor_intr() handler
> may use a (schedule_work) function to perform bottom-half processing
> for that very same command.  If the worker thread is stuck sleeping
> in the mid-layer, then it will never get around to the qstor bottom-half
> processing that is needed to complete the original activity.
> 
> Dead-lock.

In that scenario, you use a separate workqueue.

However, when I last looked at your driver you were only using the
thread to provide user context for hotplug events ... where did this
back end finishing thread come from?

James


