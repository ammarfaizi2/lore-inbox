Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbTBGD4N>; Thu, 6 Feb 2003 22:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267451AbTBGD4N>; Thu, 6 Feb 2003 22:56:13 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30201 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267444AbTBGD4K>; Thu, 6 Feb 2003 22:56:10 -0500
Date: Thu, 6 Feb 2003 23:05:44 -0500
From: Doug Ledford <dledford@redhat.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       James Bottomley <James.Bottomley@steeleye.com>, mikeand@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
Message-ID: <20030206230544.E19868@redhat.com>
Mail-Followup-To: Patrick Mansfield <patmans@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	James Bottomley <James.Bottomley@steeleye.com>, mikeand@us.ibm.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20030203233156.39be7770.akpm@digeo.com><167540000.1044346173@[10.10.2.4]> <20030204001709.5e2942e8.akpm@digeo.com><384960000.1044396931@flay> <211570000.1044508407@[10.10.2.4]> <265170000.1044564655@[10.10.2.4]> <275930000.1044570608@[10.10.2.4]> <1044573927.2332.100.camel@mulgrave> <20030206172434.A15559@beaverton.ibm.com> <293060000.1044583265@[10.10.2.4]> <20030206182502.A16364@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030206182502.A16364@beaverton.ibm.com>; from patmans@us.ibm.com on Thu, Feb 06, 2003 at 06:25:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 06:25:02PM -0800, Patrick Mansfield wrote:
> On Thu, Feb 06, 2003 at 06:01:06PM -0800, Martin J. Bligh wrote:
> > 
> > Curious. I've no idea why the changes brought this out then ... I've done
> > hundreds and hundreds of reboots on 2.5 on all sorts of different kernels,
> > and never, ever seen this. Yet in 2.5.59-bk I see it every single time.
> > Very odd.
> > 
> > M.
> 
> Okay:
> 
> There were some bk scsi changes that ignored the queue depth (qlogicisp
> sets them all to one). 
> 
> Current bk (I just pulled and checked) has a fix, the cleaner shinier 
> better scsi_lib.c scsi_request_fn now has this code:
> 
> 	if (sdev->device_busy >= sdev->queue_depth)
> 		break;
> 
> So the oops has to do with the isp handling multiple requests in a row or
> in quick succession.
> 
> Hopefully going to the latest bk will fix your oops.

It might, but please understand this.  The qlogicisp driver does things to
the scsi mid layer that the scsi mid layer does not protect itself against
and as a result is the biggest pile of steaming, unsupportable, crap code
in the universe!  The scsi mid layer was designed from day one to think
that the host->can_queue, sdev->queue_depth, and host->sg_tablesize items
were *static* on a given host/device unless specifically changed by
calling into the adjustment routines (scsi_adjust_queue_depth).  The
qlogicisp driver violates those principles and I make no warranty of any
kind that said driver will continue to operate properly unless someone
takes the time to actually audit the qlogicisp_queuecommand() and
qlogicisp_irq() routine to make sure it is actually doing the right thing
when making those changes!

If I understand correctly, Matthew Jacob's latest isp driver set drives
*all* qlogic hardware (or at least all the older stuff like the qlogicisp
driver drives).  I would much prefer that people simply test out Matthew's
driver and use it instead.  In fact, if it's ready for 2.5 kernel use, I
would strongly recommend that it be considered as a possible replacement
in the linux kernel for the default driver on all qlogic cards not handled
by the new qla2x00 driver version 6 (DaveM may have objections to that 
related to sparc if Matthew's driver isn't sparc friendly, but I don't 
know of any other reason not to switch over).

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
