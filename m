Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUHQPhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUHQPhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268290AbUHQPhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:37:35 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:61189 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268293AbUHQPRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:17:51 -0400
Date: Tue, 17 Aug 2004 16:17:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Christoph Hellwig <hch@infradead.org>, Warren Togami <wtogami@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
Message-ID: <20040817161742.B22892@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	Warren Togami <wtogami@redhat.com>, linux-kernel@vger.kernel.org
References: <411F37CC.3020909@redhat.com> <20040817125303.A21238@infradead.org> <412208A6.7020104@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412208A6.7020104@shadowconnect.com>; from Markus.Lidel@shadowconnect.com on Tue, Aug 17, 2004 at 03:31:18PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 03:31:18PM +0200, Markus Lidel wrote:
> > Now to i2o_scsi:
> >  - the logic of "demand-allocating" Scsi_Hosts looks rather bad to me,
> >    life would be much simpler with a Scsi_Host per i2o device.
> 
> But wouldn't it be a waste of resources to allocate a Scsi_Host 
> structure for every I2O device? Note that the i2o_scsi "sees" all disks 
> even if they are in a RAID array, so in most cases there are at least 3 
> Scsi_Host adapters...

I wouldn't wasted ressources but it seems Alan found another problem.

> We also now know which disk is on which controller, this information is 
> lost with your approach...

You could still keep that information in your data structure.  But what
do you actually need it for?

> >  - the slave_configure/i2o_scsi_probe_dev logical is quite horriblebut
> >    fortunately with the suggestion above it would just go away
> 
> Yep, i know that it would be better to extend scsi_add_device, so it's 
> possible to pass a pointer to i2o_scsi_slave_alloc. This is only a 
> workaround, which breaks as soon as things are done in parallel :-(

Just keep some lookup data structure so you can find the device data
by host/target/lun numbers.

> >  - the global list of hosts and wlaking it on exit is a very bad design,
> >    that's something the ->remove callback should do on per-device basis
> 
> But what if the I2O device isn't removed?

you're using the driver model, and that calls ->remove and every device
when the driver is unregistered.

> >  - please reorder the functions a little so you don't need forward-declarations
> 
> most of the forward-declarations are not needed at all, should i remove 
> unneeded completely?

Yes, please.

Okay, some brainstorming to get the data structures and lookup right:

What really seems to miss in your model is a callback to i2o_scsi
from the main i2o code when a new i2o_controller is found, if you implemented
that we'd allocate/deallocate the Scsi_Host in that callback and
->probe/->remove could be sure it'd always have it.

Anyway, I think we could live without that.

i2o_scsi_get_host would get inlined into i2o_scsi_probe.
i2o_scsi_remove basically needs a full rewrite, you need to find a way
to store a scsi_device ini i2o_dev and it becomes completely trivial.

Not sure about how to sanitize the scsi_devie probing logic
in i2o_scsi_probe yet.
