Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319091AbSIDHhj>; Wed, 4 Sep 2002 03:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319090AbSIDHhj>; Wed, 4 Sep 2002 03:37:39 -0400
Received: from rj.SGI.COM ([192.82.208.96]:44680 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S319089AbSIDHhe>;
	Wed, 4 Sep 2002 03:37:34 -0400
Date: Wed, 4 Sep 2002 00:40:26 -0700 (PDT)
From: Jeremy Higdon <jeremy@classic.engr.sgi.com>
Message-Id: <10209040040.ZM49716@classic.engr.sgi.com>
In-Reply-To: Doug Ledford <dledford@redhat.com>
        "Re: aic7xxx sets CDR offline, how to reset?" (Sep  3,  6:50pm)
References: <alan@lxorguk.ukuu.org.uk> 
	<200209032132.g83LWdD09043@localhost.localdomain> 
	<20020903185036.G12201@redhat.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Doug Ledford <dledford@redhat.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: aic7xxx sets CDR offline, how to reset?
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 3,  6:50pm, Doug Ledford wrote:
> 
> > alan@lxorguk.ukuu.org.uk said:
> > > Next you only need to return stuff if commands have been issued
> > > between the aborting command and a barrier. Since most sane systems
> > > will never be causing REQ_BARRIER
> 
> Hmmm...I thought a big reason for adding REQ_BARRIER was to be able to 
> support more robust journaling with order requirement verification.  If 
> that's true, then REQ_BARRIER commands could become quite common on disks 
> using ext3.

Hmm.  There do seem to be a lot of loopholes/race conditions where the
barrier just won't work right in the face of error recovery.  I wouldn't
want to use barriers on any system where data integrity was crucial.

For example, in Fibrechannel using class 3 (the usual)

	send command (command frame corrupted; device does not receive)
	send barrier (completes normally)
	... (lots of time goes by, many more commands are processed)
	timeout original command whose command frame was corrupted

The only safe way to run such a filesystem is to hold the barriers in
the driver until all previous commands are successfully completed.

There was also the problem of the queue full to the barrier command,
etc.

Did I miss the answer to these?  I don't recall seeing an answer to
Patrick Mansfield's questions either (original message edited cutting
out a couple of paragraphs):

> On Tue, Sep 03, 2002 at 02:09:44PM -0500, James Bottomley wrote:
> > dledford@redhat.com said:
> > > Leave abort active.  It does actually work in certain scenarios.  The
> > > CD  burner scenario that started this thread is an example of
> > > somewhere that  an abort should actually do the job.
> >
> > Unfortunately, it would destroy the REQ_BARRIER approach in the block layer.
> > At best, abort probably causes a command to overtake a barrier it shouldn't,
> > at worst we abort the ordered tag that is the barrier and transactional
> > integrity is lost.
> >
> > When error correction is needed, we have to return all the commands for that
> > device to the block layer so that ordering and barrier issues can be taken
> > care of in the reissue.  This makes LUN RESET (for those that support it) the
> > minimum level of error correction we can apply.
> >
> > James
> 
> If we only send an abort or reset after a quiesce I don't see why one
> is better than the other.
> 
> Not specific to reset or abort - if a single command gets an error, we
> wait for oustanding commands to complete before starting up the error
> handler thread. If all the commands (error one and outstanding) have
> barriers, those that do not error out will complete out of order from
> the errored command.
> 
> How is this properly handled?
> 
> And what happens if one command gets some sort of check condition (like
> medium error, or aborted command) that causes a retry? Will IO's still
> be correctly ordered?


jeremy
