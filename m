Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUJLREY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUJLREY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUJLREI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:04:08 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:28099 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266274AbUJLRAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:00:51 -0400
Message-ID: <416C0D55.1020603@rtr.ca>
Date: Tue, 12 Oct 2004 12:59:01 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@i	nfradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165A4	5D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca>	<4	165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca>		<20041007221537.A17712@infradead.org>	<1097241583.2412.15.camel@mulgrave> 	<4166AF2F.6070904@rtr.ca> <1097249266.1678.40.camel@mulgrave> 	<4166B48E.3020006@rtr.ca> <1097250465.2412.49.camel@mulgrave>
In-Reply-To: <1097250465.2412.49.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Fri, 2004-10-08 at 10:38, Mark Lord wrote:
> 
>>Can deadlock occur here, since qstor.c is already using schedule_work()
>>as part of it's internal bottom-half handling for abnormal conditions?
>>
>>Eg.  hotplug event -> schedule_work -> mid-layer -> queuecommand
>>       --> sleep  :: interrupt -> schedule_work -> deadlock?
>>
> 
> 
> Since you wouldn't go straight from schedule_work->mid-layer, I assume
> you mean that when the workqueue thread runs the work?

Yes.  The workqueue thread will invoke the mid-layer function,
which will do a queuecommand, which will return to the mid-layer,
which will then SLEEP waiting for the command to complete,
which will sleep that workqueue thread.

As part of the interrupt processing to complete the command in the LLD,
it is possible that schedule_work may be necessary, requiring that
a workqueue thread be run.  If this means the same thread that is
already sleeping courtesy of the mid-layer, then we could have a problem.

Comments?
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
