Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270009AbUJHPRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbUJHPRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 11:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270012AbUJHPRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 11:17:54 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:55230 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S270009AbUJHPRs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 11:17:48 -0400
Message-ID: <4166AF2F.6070904@rtr.ca>
Date: Fri, 08 Oct 2004 11:15:59 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <416547B6.5080505@rtr.ca>	<20041007150709.B12688@infradead.org> <4165624C.5060405@rtr.ca>	<416565DB.4050006@pobox.com> <4165A45D.2090200@rtr.ca>	<4165A766.1040104@pobox.com> <4165A85D.7080704@rtr.ca>	<4165AB1B.8000204@pobox.com> <4165ACF8.8060208@rtr.ca> 	<20041007221537.A17712@infradead.org> <1097241583.2412.15.camel@mulgrave>
In-Reply-To: <1097241583.2412.15.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
>
> Actually, the driver has no need for a thread at all.  Since you're
> simply using it to fire hotplug events, use schedule_work instead.

That worries me some, because the mid-layer will perform blocking I/O
and the like, and I'm not sure how much that stuff may depend on its
own usage (any?) of workqueues.  If you believe it to be safe,
then I'll nuke the kthread entirely.

> I also noticed the following in a lightening review:
> 
> - Kill these constructs:
> +	/* scsi_done expects to be called while locked */
> +	if (!in_interrupt())
> +		spin_lock_irqsave(uhba->lock, flags);
> 
> scsi_done() doesn't require a lock

Really?  I wonder why the mid-layer is so religious about
doing the lock around every invocation of it today?

But again, if we're sure that this is the case, then it certainly
make's life simpler in the driver.

> - Your emulated commands assume they're non-sg and issued through the
> kernel (i.e. you don't kmap and you don't do SG).  This will blow up on
> the first inquiry submitted via SG_IO for instance.

The SG is tested for and simply failed -- there is no need today for
SG usage on those code paths.  If there turns out to be a need for that
interface with this driver in the future, we can add it.  Just like most
of the other drivers currently treat it.

What is the "kmap" semantic, and how should it be applied here?

Thanks
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
