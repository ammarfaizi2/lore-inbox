Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUJLSP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUJLSP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUJLSPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:15:05 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:34221 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266561AbUJLSMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:12:14 -0400
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <416C19B9.7000806@rtr.ca>
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@i
				nfradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<416
	5	A	4	5D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.
	ca	>		<4	165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca>		<200410072215
	37.	A17	712@infradead.org>	<1097241583.2412.15.camel@mulgrave>		<4166AF2F.60
	7090	4@rtr.ca>
	<1097249266.1678.40.camel@mulgrave>		<4166B48E.3020006@rtr.ca>	<1097250465.2
	412.49.camel@mulgrave>
		<416C0D55.1020603@rtr.ca>	<1097601478.2044.103.camel@mulgrave> 
	<416C12CC.1050301@rtr.ca> <1097602220.2044.119.camel@mulgrave>
	<416C157A.6030400@rtr.ca> <416C177B.6030504@pobox.com> 
	<416C19B9.7000806@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Oct 2004 13:12:03 -0500
Message-Id: <1097604730.1763.177.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 12:51, Mark Lord wrote:
> That's how it works already, thanks, except that it
> does have a few calls to in_interrupt() rather than
> simply passing itself a flag parameter to convey the
> same information -- I'll fix that now.
> 
> Except that it uses schedule_work() rather than a tasklet.
> The bottom half is only there for abnormal conditions
> like major chip errors and hotplug events.
> 
> So the only new suggestion here is to use a tasklet for
> the bottom-half processing rather than schedule_work()?
> 
> I thought work queues were the preferred mechanism for
> infrequent uses such as this these days?  A tasklet is no
> problem here though, so long as worker threads (schedule_work)
> do not also rely on tasklets.

Really, no, you don't want to be doing what you are doing in
qs_process_sff_entry()

At certain points you decide you have too much work, disable interrupts
on the card and reschedule the routine in a work queue.

Please, please don't do this.  It's a sure fire recipe for a hang. 
Suppose a prior task in the workqueue needs to page something in from
swap and you're the swap device for instance....

What you need to do is to gather as much information as will reset the
interrupt and then process the data as a tasklet.  For your hotplug
events, they should be fire and forget as schedule_work().

*never* disable interrupts and have re-enabling them contingent on a
workqueue thread.

James


