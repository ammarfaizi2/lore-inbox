Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267709AbTBGET3>; Thu, 6 Feb 2003 23:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267693AbTBGET2>; Thu, 6 Feb 2003 23:19:28 -0500
Received: from franka.aracnet.com ([216.99.193.44]:43401 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267690AbTBGET1>; Thu, 6 Feb 2003 23:19:27 -0500
Date: Thu, 06 Feb 2003 20:28:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Doug Ledford <dledford@redhat.com>, Patrick Mansfield <patmans@us.ibm.com>
cc: James Bottomley <James.Bottomley@steeleye.com>, mikeand@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
Message-ID: <336270000.1044592134@[10.10.2.4]>
In-Reply-To: <20030206230544.E19868@redhat.com>
References: <20030203233156.39be7770.akpm@digeo.com><167540000.1044346173@[10.10.2.4]> <20030204001709.5e2942e8.akpm@digeo.com><384960000.1044396931@flay> <211570000.1044508407@[10.10.2.4]> <265170000.1044564655@[10.10.2.4]> <275930000.1044570608@[10.10.2.4]> <1044573927.2332.100.camel@mulgrave> <20030206172434.A15559@beaverton.ibm.com> <293060000.1044583265@[10.10.2.4]> <20030206182502.A16364@beaverton.ibm.com> <20030206230544.E19868@redhat.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> There were some bk scsi changes that ignored the queue depth (qlogicisp
>> sets them all to one). 
>> 
>> Current bk (I just pulled and checked) has a fix, the cleaner shinier 
>> better scsi_lib.c scsi_request_fn now has this code:
>> 
>> 	if (sdev->device_busy >= sdev->queue_depth)
>> 		break;
>> 
>> So the oops has to do with the isp handling multiple requests in a row or
>> in quick succession.
>> 
>> Hopefully going to the latest bk will fix your oops.
> 
> It might, but please understand this.  The qlogicisp driver does things to
> the scsi mid layer that the scsi mid layer does not protect itself against
> and as a result is the biggest pile of steaming, unsupportable, crap code
> in the universe!  The scsi mid layer was designed from day one to think
> that the host->can_queue, sdev->queue_depth, and host->sg_tablesize items
> were *static* on a given host/device unless specifically changed by
> calling into the adjustment routines (scsi_adjust_queue_depth).  The
> qlogicisp driver violates those principles and I make no warranty of any
> kind that said driver will continue to operate properly unless someone
> takes the time to actually audit the qlogicisp_queuecommand() and
> qlogicisp_irq() routine to make sure it is actually doing the right thing
> when making those changes!
> 
> If I understand correctly, Matthew Jacob's latest isp driver set drives
> *all* qlogic hardware (or at least all the older stuff like the qlogicisp
> driver drives).  I would much prefer that people simply test out Matthew's
> driver and use it instead.  In fact, if it's ready for 2.5 kernel use, I
> would strongly recommend that it be considered as a possible replacement
> in the linux kernel for the default driver on all qlogic cards not handled
> by the new qla2x00 driver version 6 (DaveM may have objections to that 
> related to sparc if Matthew's driver isn't sparc friendly, but I don't 
> know of any other reason not to switch over).

If you can send me a patch, I'll willingly test it .... I have plenty of
these cards on very racy machines ;-)

M.

