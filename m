Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269660AbUINSMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269660AbUINSMy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269664AbUINSJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:09:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41875 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269522AbUINR4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:56:55 -0400
Message-ID: <414730D9.3000003@pobox.com>
Date: Tue, 14 Sep 2004 13:56:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
References: <41471163.10709@rtr.ca> <414723B0.1090600@pobox.com> <41472FA0.2090108@rtr.ca>
In-Reply-To: <41472FA0.2090108@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>  >In particular, releasing the lock and sleeping would be very wrong
>  >in the ->queuecommand and error handling paths
>  >(alas...  I would love to sleep in the fine-grained eh hooks)
> 
> Mmm.. definitely no sleeps in queuecommand(), but sleeping seems
> necessary in host_reset_handler() -- the alternative is to just
> busywait inline.. which would really not be good.
> 
> Isn't the protocol for the eh host_reset_handler() basically
> just "do the reset, and return whether it worked or not?".
> If so, the driver really has to hang around until the reset
> completes so that correct status can be returned.  This generally
> takes a couple of milliseconds in practice (measured it).
> 
> Is there a better way to do that?
> 
> I really would prefer never to have to reset the drives,
> but when they have a queuing error, many of them simply
> won't talk to us again without a reset.  The driver avoids
> the reset as much as it can for other situations, though.


James and I occasionally talk about this.  This is a _big_ reason why I 
use the ->eh_strategy_handler() rather than the more fine-grained ->eh 
hooks:  you get unlocked, unfettered sleep priveleges inside the scsi EH 
thread.

The SCSI LLD API really needs to -not- spinlock on the EH hooks, and 
instead simply guarantee that ->queuecommand and other hooks will not be 
called while the driver is in EH.

ISTR James didn't disagree, so maybe a patch can be worked out...

Of course, you could always just use ->eh_strategy_handler and do 100% 
of the error handling yourself.  That's the route libata chose.

	Jeff


