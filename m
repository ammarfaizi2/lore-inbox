Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVIWUrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVIWUrp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVIWUrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:47:45 -0400
Received: from mail.dvmed.net ([216.237.124.58]:21690 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751233AbVIWUro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:47:44 -0400
Message-ID: <433469DF.1060900@pobox.com>
Date: Fri, 23 Sep 2005 16:47:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, torvalds@osdl.org
CC: joshk@triplehelix.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] updated version of Jens' SATA suspend-to-ram patch
References: <20050923163334.GA13567@triplehelix.org> <20050923180711.GH22655@suse.de>
In-Reply-To: <20050923180711.GH22655@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Sep 23 2005, Joshua Kwan wrote:
>>I had some time yesterday and decided to help Jens out by rediffing the
>>now-infamous SATA suspend-to-ram patch [1] against current git and
>>test-building it.

Very strange.  I cannot find this patch at all in my email folders.

Can someone resend it to me?



> --- linux-2.6.13/drivers/scsi/libata-core.c~	2005-09-01 12:22:19.000000000 +0200
> +++ linux-2.6.13/drivers/scsi/libata-core.c	2005-09-01 12:24:38.000000000 +0200
> @@ -3738,8 +3738,8 @@
>  	unsigned long flags;
>  	int rc;
>  
> -	qc = ata_qc_new_init(ap, dev);
> -	BUG_ON(qc == NULL);
> +	while ((qc = ata_qc_new_init(ap, dev)) == NULL)
> +		msleep(10);
>  
>  	qc->tf.command = cmd;
>  	qc->tf.flags |= ATA_TFLAG_DEVICE;

Worried now!

If this patch is needed, something VERY VERY WRONG is going on.  This 
patch indicates that the queueing state machine has been violated, and 
something is trying to IGNORE the command synchronization :(

Further, you cannot always assume that msleep() is valid in that 
context.  It should be the caller that waits (libata suspend code), not 
ata_do_simple_cmd() itself.

Does anyone have a link to James Bottomley's proposed patch?  That one 
seemed to do what was necessary -- send a SYNCHRONIZE_CACHE command then 
turn it over to the LLD for further suspend.


Linus wrote:
> Ok. Can we have this in -mm for a few days just to shake out anything 
> interesting, and then merge it into mainline?

Once we get a decent patch, I can merge it into my libata-dev.git 
repository, which is automatically propagated to -mm.

	Jeff


