Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318942AbSICVUQ>; Tue, 3 Sep 2002 17:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318944AbSICVUQ>; Tue, 3 Sep 2002 17:20:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:44965 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318942AbSICVUO>; Tue, 3 Sep 2002 17:20:14 -0400
Date: Tue, 3 Sep 2002 14:24:34 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <20020903142434.A2538@eng2.beaverton.ibm.com>
References: <dledford@redhat.com> <200209031909.g83J9iG07312@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200209031909.g83J9iG07312@localhost.localdomain>; from James.Bottomley@SteelEye.com on Tue, Sep 03, 2002 at 02:09:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James -

On Tue, Sep 03, 2002 at 02:09:44PM -0500, James Bottomley wrote:
> dledford@redhat.com said:
> > Leave abort active.  It does actually work in certain scenarios.  The
> > CD  burner scenario that started this thread is an example of
> > somewhere that  an abort should actually do the job. 
> 
> Unfortunately, it would destroy the REQ_BARRIER approach in the block layer.  
> At best, abort probably causes a command to overtake a barrier it shouldn't, 
> at worst we abort the ordered tag that is the barrier and transactional 
> integrity is lost.
> 
> When error correction is needed, we have to return all the commands for that 
> device to the block layer so that ordering and barrier issues can be taken 
> care of in the reissue.  This makes LUN RESET (for those that support it) the 
> minimum level of error correction we can apply.
> 
> James

If we only send an abort or reset after a quiesce I don't see why one
is better than the other.

Not specific to reset or abort - if a single command gets an error, we
wait for oustanding commands to complete before starting up the error
handler thread. If all the commands (error one and outstanding) have
barriers, those that do not error out will complete out of order from
the errored command.

How is this properly handled? 

And what happens if one command gets some sort of check condition (like
medium error, or aborted command) that causes a retry? Will IO's still
be correctly ordered?

The abort could also be usefull in handling the locking/ownership of the
scsi_cmnd - the abort at the LLD layer can be used by the LLD to cancel
any software timeouts, as well as to flush the command from the hardware.
After the abort, the mid-layer could assume that it once again "owned"
the scsi_cmnd, especially if the LLD abort were a required function.

I would like to see error handling occur without quiescing the entire
adapter before taking any action. Stopping all adapter IO for a timeout
can be a bit expensive - imagine a tape drive and multiple disks on an
adapter, any IO disk timeout or failure will wait for the tape IO to
complete before allowing any other IO, if the tape operation is long or
is going to timeout this could be minutes or hours.

-- Patrick Mansfield
