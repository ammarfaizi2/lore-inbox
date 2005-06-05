Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVFEGrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVFEGrx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 02:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFEGrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 02:47:53 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41668 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261468AbVFEGrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 02:47:51 -0400
Message-ID: <42A2A00F.9050402@pobox.com>
Date: Sun, 05 Jun 2005 02:47:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 08/09] blk: update IDE to use the
 new blk_ordered.
References: <20050605055337.6301E65A@htj.dyndns.org> <20050605055337.ADD601D4@htj.dyndns.org>
In-Reply-To: <20050605055337.ADD601D4@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> @@ -176,6 +176,18 @@ static ide_startstop_t __ide_do_rw_disk(
>  			lba48 = 0;
>  	}
>  
> +	if (blk_fua_rq(rq) &&
> +	    (!rq_data_dir(rq) || !drive->select.b.lba || !lba48)) {
> +		if (!rq_data_dir(rq))
> +			printk(KERN_WARNING "%s: FUA READ unsupported\n",
> +			       drive->name);
> +		else
> +			printk(KERN_WARNING "%s: FUA request received but "
> +			       "cannot use LBA48\n", drive->name);
> +		ide_end_request(drive, 0, 0);
> +		return ide_stopped;
> +	}
> +


Does this string of tests really need to be added to the main fast path?

It would be better to simply guarantee that this check need never exist 
in the IDE driver, by guaranteeing that the block layer will never send 
a FUA-READ command to a driver that does not wish it.

	Jeff


