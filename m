Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318931AbSICVI5>; Tue, 3 Sep 2002 17:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318935AbSICVIx>; Tue, 3 Sep 2002 17:08:53 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53110 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318931AbSICVIs>; Tue, 3 Sep 2002 17:08:48 -0400
Date: Tue, 3 Sep 2002 17:13:21 -0400
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <20020903171321.A12201@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <dledford@redhat.com> <200209031909.g83J9iG07312@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209031909.g83J9iG07312@localhost.localdomain>; from James.Bottomley@SteelEye.com on Tue, Sep 03, 2002 at 02:09:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 02:09:44PM -0500, James Bottomley wrote:
> dledford@redhat.com said:
> > Leave abort active.  It does actually work in certain scenarios.  The
> > CD  burner scenario that started this thread is an example of
> > somewhere that  an abort should actually do the job. 
> 
> Unfortunately, it would destroy the REQ_BARRIER approach in the block layer.  

REQ_BARRIER is used for filesystem devices (disks mainly) while the 
devices that might benefit most from working aborts would likely be other 
devices.  But, regardless, the REQ_BARRIER ordering *can* be preserved 
while using abort processing.  Since the command that needs aborting is, 
as you are hypothesizing, before the REQ_BARRIER command, and since it 
hasn't completed, then the REQ_BARRIER command can not be complete and 
neither can any of the commands behind the REQ_BARRIER.  On direct access 
devices you are only concerned about ordering around the barrier, not 
ordering of the actual tagged commands, so for abort you can actually call 
abort on all the commands past the REQ_BARRIER command first, then the 
REQ_BARRIER command, then the hung command.  That would do the job and 
preserve REQ_BARRIER ordering while still using aborts.

> At best, abort probably causes a command to overtake a barrier it shouldn't, 
> at worst we abort the ordered tag that is the barrier and transactional 
> integrity is lost.
> 
> When error correction is needed, we have to return all the commands for that 
> device to the block layer so that ordering and barrier issues can be taken 
> care of in the reissue.

Not really, this would be easily enough done in the ML_QUEUE area of the 
scsi layer, but it matters not to me.  However, if you throw a BDR, then 
you have cancelled all outstanding commands and (typically) initiated a 
hard reset of the device which then requires a device settle time.  All of 
this is more drastic and typically takes longer than the individual aborts 
which are completed in a single connect->disconnect cycle without ever 
hitting a data phase and without triggering a full device reset and 
requiring a settle time.

>  This makes LUN RESET (for those that support it) the 
> minimum level of error correction we can apply.

Not true.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
