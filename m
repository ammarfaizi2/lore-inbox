Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269636AbUINSGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269636AbUINSGJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbUINSBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:01:13 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:45976 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269492AbUINRxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:53:13 -0400
Message-ID: <41472FA0.2090108@rtr.ca>
Date: Tue, 14 Sep 2004 13:51:28 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
References: <41471163.10709@rtr.ca> <414723B0.1090600@pobox.com>
In-Reply-To: <414723B0.1090600@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >In particular, releasing the lock and sleeping would be very wrong
 >in the ->queuecommand and error handling paths
 >(alas...  I would love to sleep in the fine-grained eh hooks)

Mmm.. definitely no sleeps in queuecommand(), but sleeping seems
necessary in host_reset_handler() -- the alternative is to just
busywait inline.. which would really not be good.

Isn't the protocol for the eh host_reset_handler() basically
just "do the reset, and return whether it worked or not?".
If so, the driver really has to hang around until the reset
completes so that correct status can be returned.  This generally
takes a couple of milliseconds in practice (measured it).

Is there a better way to do that?

I really would prefer never to have to reset the drives,
but when they have a queuing error, many of them simply
won't talk to us again without a reset.  The driver avoids
the reset as much as it can for other situations, though.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
