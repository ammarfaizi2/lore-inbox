Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbVHSDt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVHSDt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVHSDt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:49:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:40154 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932545AbVHSDt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:49:27 -0400
Message-ID: <430556BF.5070004@pobox.com>
Date: Thu, 18 Aug 2005 23:49:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
CC: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: libata error handling
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org>
In-Reply-To: <20050807054850.GA13335@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tejun,

In an email I cannot find anymore, you asked why I was interested in 
converting libata to use the fine-grained EH hooks in the SCSI layer, 
rather than continued with the current ->eh_strategy_handler() method.

Several reasons:

1) The fine-grained hooks of the SCSI layer are somewhat standard for 
block devices.  The events they signify -- timeout, abort cmd, dev 
reset, bus reset, and host reset -- map precisely to the events that we 
must deal with at the ATA level.

But be warned of false sharing, as I talk about in #2...

2) When libata SAT translation layer becomes optional, and libata drives 
a "true" block device, use of ->eh_strategy_handler() will actually be 
an obstacle due to false sharing of code paths.  ->eh_strategy_handler() 
is indeed a single "do it all" EH entrypoint, but within that entrypoint 
you must perform several SCSI-specific tasks.

3) ->eh_strategy_handler() has continually proven to be a method of 
error handling poorly supported by the SCSI layer.  There are many 
assumption coded into the SCSI layer that this is -not- the path taken 
by LLD EH code, and libata must constantly work around these assumptions.

4) libata is the -only- user of ->eh_strategy_handler(), and oddballs 
must be stomped out.  It creates a maintenance burden on the SCSI layer 
that should be eliminated.


