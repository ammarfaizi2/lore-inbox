Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUJLRjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUJLRjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUJLRit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:38:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22943 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266236AbUJLRec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:34:32 -0400
Message-ID: <416C159A.8040907@pobox.com>
Date: Tue, 12 Oct 2004 13:34:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>, Mark Lord <lsml@rtr.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca>	<416547B6.5080505@rtr.ca>	<20041007150709.B12688@i		nfradead.org>	<4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com>	<4165A	4	5D.2090200@rtr.ca>	<4165A766.1040104@pobox.com>	<4165A85D.7080704@rtr.ca>		<4	165AB1B.8000204@pobox.com>	<4165ACF8.8060208@rtr.ca>		<20041007221537.A17	712@infradead.org>	<1097241583.2412.15.camel@mulgrave>		<4166AF2F.6070904@rtr.ca> <1097249266.1678.40.camel@mulgrave>		<4166B48E.3020006@rtr.ca> <1097250465.2412.49.camel@mulgrave> 	<416C0D55.1020603@rtr.ca> <1097601478.2044.103.camel@mulgrave> <416C12CC.1050301@rtr.ca>
In-Reply-To: <416C12CC.1050301@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> James Bottomley wrote:
>  >
> 
>> So, it's perfectly legal to call schedule_work from within the work
>> queue function, because all you do is add the work to the list for the
>> daemon thread to execute when it gets to it.  There's nothing
>> synchronous about a workqueue.  If a work function sleeps, then its
>> true, it takes the worker thread longer to get to the next work item,
>> but as long as the work function awakes, it will get there.
> 
> 
> Good.  That is exactly how I suspected it worked.
> In which case, deadlock *will* happen in the scenario described,
> and the qstor driver should therefore NOT use schedule_work()
> as the means of invoking the scsi_add_device()/scsi_remove_device()
> functions.  A separate thread appears needed.

Did you read my message???

QStor doesn't do domain validation, which is the only place where the 
SCSI core also calls schedule_work().

Your conclusion is incorrect AFAICS.


> As part of handling the command in the LLD, the qstor_intr() handler
> may use a (schedule_work) function to perform bottom-half processing
> for that very same command.  If the worker thread is stuck sleeping
> in the mid-layer, then it will never get around to the qstor bottom-half
> processing that is needed to complete the original activity.
> 
> Dead-lock.
> 
> Right?

If you are creating a deadlock within your own driver, that's a separate 
issue.  There is no deadlock with the SCSI core.

However...  tasklets are for bottom-half processing, not threads.

	Jeff


