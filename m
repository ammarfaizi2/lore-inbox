Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUAOTey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbUAOTey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:34:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13805 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261875AbUAOTd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:33:59 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: Doug Ledford <dledford@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jens Axboe <axboe@suse.de>, Arjan Van de Ven <arjanv@redhat.com>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
In-Reply-To: <4006C76B.3090206@tmr.com>
References: <20040112092231.GG29177@suse.de>
	 <1073914073.3114.263.camel@compaq.xsintricity.com>
	 <4006C76B.3090206@tmr.com>
Content-Type: text/plain
Message-Id: <1074195041.3137.32.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 15 Jan 2004 14:30:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-15 at 12:01, Bill Davidsen wrote:
> Doug Ledford wrote:
> > On Mon, 2004-01-12 at 04:22, Jens Axboe wrote:
> > 
> >>On Mon, Jan 12 2004, Arjan van de Ven wrote:
> >>
> >>>On Mon, Jan 12, 2004 at 10:19:46AM +0100, Jens Axboe wrote:
> >>>
> >>>>... and still exists in your 2.4.21 based kernel.
> >>>
> >>>The RHL 2.4.21 kernels don't have the locking patch at all...
> >>
> >>But RHEL3 does:
> >>
> >>http://kernelnewbies.org/kernels/rhel3/SOURCES/linux-2.4.21-iorl.patch
> >>
> >>and the bug is there.
> > 
> > 
> > But in RHEL3 the bug is fixed already (not in a released kernel, but the
> > fix went into our internal kernel some time back and will be in our next
> > update kernel).  From my internal bk tree for this stuff:
> 
> "not in a released kernel..." Do I read this right? That you have a fix 
> for a critical bug and it hasn't been pushed to customers yet?

No, you don't read this right.  We have a fix for a correctness issue
that has almost 0% chance of ever triggering in real life, has exactly 0
bug reports of it ever happening, and which has been integrated into our
tree.  Obviously, we always push new kernels to all of our customers
every time we have this situation, or about twice a day...

>  How about 
> security bugs, has the fix you pushed in RH-9.0 been push to EL customers?
> 
> > [dledford@compaq RHEL3-scsi]$ bk changes -r1.23
> > ChangeSet@1.23, 2003-11-10 17:19:54-05:00, dledford@compaq.xsintricity.com
> >   drivers/scsi/scsi_error.c
> >       Don't panic if the eh thread is dead, instead do the same thing that
> >       scsi_softirq_handler does and just complete the command as a failed
> >       command.
> >       Change when we wake the eh thread in scsi_times_out to accomodate
> >       the changes to the mlqueue operations.
> >       Clear blocked status on the host and all devices in scsi_restart_operations
> > ->    Don't grab the host_lock in scsi_restart_operations, we aren't doing
> >       anything that needs it.  Just goose the queues unconditionally,
> >       scsi_request_fn() will know to not send commands if they shouldn't
> >       go for some reason.
> >       Make sure we account SCSI_STATE_MLQUEUE commands as not being failed
> >       commands in scsi_unjam_host.
> > 
> > But, Jens is right, it's a real bug.  I just fixed it in a different
> > way.  And my fix is dependent on other changes in our scsi stack as
> > well.
> 
> Yes, thanks to Peter for that fix, nice that someone provides timely 
> fixes...

Puh-Leeze.  If you actually read the source code, you would see just how
damn near impossible this bug is.  But, since you obviously didn't, let
me enlighten you:

1)  The offending code is part of the error handler code, specifically
the section that kicks drives back into gear after recovery is complete.

2)  The only section of code it's racing against is scsi_request_fn.

3)  The race only happens if scsi_request_fn() detects that
host->in_recovery is not set.

So, a sample would be something like this

CPU1

spin_lock_irqsave(device_lock)
scsi_request_fn()
  check host->in_recovery == 0
  [ start window ]
  make a couple other sanity checks
  [ end window ]
  spin_lock(host_lock)
  modify host command counts
  spin_unlock(host_lock)
  finish prepping command
  spin_unlock(device_lock)
  scsi_dispatch_cmd()
  spin_lock(device_lock)
  return
spin_unlock(device_lock)

Now, in that little, itty, bitty window in scsi_request_fn(), we have to
A) get some kind of error that starts the error handler subsystem, B)
all outstanding commands have to complete (since we don't start the
error handler thread until the controller is quiescient), C) we have to
resolve the problem and get to the point of kicking the host back in
gear, and finally D) we have to grab the host_lock before
scsi_request_fn tries to and then we have to try and grab the specific
device_lock that scsi_request_fn is holding.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606


