Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbSI3XsV>; Mon, 30 Sep 2002 19:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbSI3XsV>; Mon, 30 Sep 2002 19:48:21 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:32765 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261397AbSI3XsT>; Mon, 30 Sep 2002 19:48:19 -0400
Date: Mon, 30 Sep 2002 19:54:13 -0400
From: Doug Ledford <dledford@redhat.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>,
       Matthew Jacob <mjacob@feral.com>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while doingfiletransfers
Message-ID: <20020930235413.GH25340@redhat.com>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>,
	Matthew Jacob <mjacob@feral.com>,
	"Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
	Mathieu Chouquet-Stringer <mathieu@newview.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200209272113.g8RLD1420775@localhost.localdomain> <2645346224.1033162127@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2645346224.1033162127@aslan.btc.adaptec.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 03:28:47PM -0600, Justin T. Gibbs wrote:
> > Linux is perfectly happy just to have you return 1 in queuecommand if the 
> > device won't accept the tag.  The can_queue parameter represents the
> > maximum  number of outstanding commands the mid-layer will ever send.
> > The mid-layer is  happy to re-queue I/O below this limit if it cannot be
> > accepted by the drive.   In fact, that's more or less what queue plugging
> > is about.
> > 
> > The only problem occurs if you return 1 from queuecommand with no other 
> > outstanding I/O for the device.
> > 
> > There should be no reason in 2.5 for a driver to have to implement an
> > internal  queue.
> 
> Did this really get fixed in 2.5?  The internal queuing was completely
> broken in 2.4.  Some of the known breakages were:
> 
> 1) Device returns queue full with no outstanding commands from us
>    (usually occurs in multi-initiator environments).

This may be fixed.

> 2) No delay after busy status so devices that will continually
>    report BUSY if you hammer them with commands never come ready.

This is still broken.  Plus, it has a limited number of retries before it 
simply returns an I/O error, so it basically hammers the device (so it 
can't get unbusy) until a set number of retries have completed then it 
returns an I/O error, giving all sorts of false I/O errors on devices that 
use BUSY status.

> 3) Queue is restarted as soon as any command completes even if
>    you really need to throttle down the number of tags supported
>    by the device.
> 
> 4) No tag throttling.  If tag throttling is in 2.5, does it ever
>    increment the tag depth to handle devices that report temporary
>    resource shortages (Atlas II and III do this all the time, other
>    devices usually do this only in multi-initiator environments).

The current 2.5 mid layer is still tag stupid.  It has no concept of tag 
depth adjustment (although I have a patch here that implements this bit, 
it really needs updating to the current kernels).

> 5) Proper transaction ordering across a queue full.  The aic7xxx
>    driver "requeues" all transactions that have not yet been sent
>    to the device replacing the transaction that experienced the queue
>    full back at the head so that ordering is maintained.
> 
> No thought was put into any of these issues in 2.4, so I decided not
> to even think about trusting the mid-layer for this functionality.

No, you still can't yet, but we hope to have that fixed before the next 
stable kernel series.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
