Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136074AbREBXPm>; Wed, 2 May 2001 19:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136072AbREBXPd>; Wed, 2 May 2001 19:15:33 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:5703 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136058AbREBXPR>; Wed, 2 May 2001 19:15:17 -0400
Message-ID: <3AF09544.AEE1AE2F@redhat.com>
Date: Wed, 02 May 2001 19:16:20 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Max TenEyck Woodbury <mtew@cds.duke.edu>
CC: Eric.Ayers@intec-telecom-systems.com,
        James Bottomley <James.Bottomley@steeleye.com>,
        "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
In-Reply-To: <200105011445.KAA01117@localhost.localdomain>
						<3AEEDFFC.409D8271@redhat.com> <15086.60620.745722.345084@gargle.gargle.HOWL> <3AF025AE.511064F3@redhat.com> <3AF04648.73F5BFCE@cds.duke.edu> <3AF0483C.49C8CF90@redhat.com> <3AF08077.7CF53A2D@cds.duke.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max TenEyck Woodbury wrote:
> 
> Doug Ledford wrote:
> >
> > Max TenEyck Woodbury wrote:
> >>
> >> Umm. Reboot? What do you think this is? Windoze?
> >
> > It's the *only* way to guarantee that the drive is never touched by more
> > than one machine at a time (notice, I've not been talking about a shared
> > use drive, only one machine in the cluster "owns" the drive at a time,
> > and it isn't for single transactions that it owns the drive, it owns
> > the drive for as long as it is alive, this is a limitation of the
> > filesystes currently available in mainstream kernels).  The reservation
> > conflict and subsequent reboot also *only* happens when a reservation
> > has been forcefully stolen from a machine. In that case, you are talking
> > about a machine that has been failed over against its will, and the
> > absolute safest thing to do in order to make sure the failed over machine
> > doesn't screw the whole cluster up, is to make it reboot itself and
> > re-enter the cluster as a new failover slave node instead of as a master
> > node.  If you want a shared common access device with write locking
> > semantics, as you seem to be suggesting later on, then you need a
> > different method of locking than what I put in this, I knew that as I
> > wrote it and that was intentional.
> 
> That was partly meant to be a joke, but it was also meant to make you stop
> and think about what you are doing. From what little context I read, you
> seem to be looking for a high availability solution. Rebooting a system,
> even if there is a hot backup, should only be used as a last resort.

This is something that only happens when a machine has been forcefully failed
over against its will.  I guess you would need to see the code to tell what
I'm talking about, but in the description I gave of the code, if it doesn't
get a reservation, it exits.  The way the code is intended to be used is
something like this:

Given machine A as cluster master and machine B as a cluster slave.  Machine A
starts the reservation program with something like this as the command line:

reserve --reserve --hold /dev/sdc

This will result in the program grabbing a reservation on drive sdc (or
exiting with a non-0 status on failure) and then sitting in a loop where it
re-issues the reservation every 2 seconds.

Under normal operation, the reserve program is not started at all on machine
B.  However, machine B does use the normal heartbeat method (be that the
heartbeat package or something similar, but not reservations) to check that
machine A is still alive.  Given a failure in the communications between
machine B and machine A, which would typically mean it is time to fail over
the cluster, machine B can test the status of machine A by throwing a reset to
the drive to break any existing reservations, waiting 4 seconds, then trying
to run it's own reservation.  This can be accomplished with the command:

reserve --reset --reserve --hold /dev/sdc

If the program fails to get the reservation then that means machine A was able
to resend it's reservation.  Obviously then, machine A isn't dead.  Machine B
can then decide that the heartbeat link is dead but machine A is still fine
and not try any further failover actions, or it could decide that machine A
has a working reserve program but key services or network connectivity may be
dead, in which case a forced failover would be in order.  To accomplish that,
machine B can issue this command:

reserve --preempt --hold /dev/sdc

This will break machine A's reservation and take the drive over from machine
A.  It's at this point, and this point only, that machine A will see a
reservation conflict.  It has been forcefully failed over, so
resetting/rebooting the machine is a perfectly fine alternative (and the
reason it is recommended is because at this point in time, machine B may
already be engaged in recovering the filesystem on the shared drive, and
machine A may still have buffers it is trying to flush to the same drive, so
in order to make sure machine A doesn't let some dirty buffer get through a
break in machine B's reservation caused by something as inane as another
machine on the bus starting up and throwing an initial reset, we should reset
machine A *as soon as we know it has been forcefully failed over and is no
longer allowed to write to the drive*).  Arguments with this can be directed
to Stephen Tweedie, who is largely responsible for beating me into doing it
this way ;-)


> Another problem is that reservations do *not* guarantee ownership over
> the long haul. There are too many mechanisms that break reservations to
> build a complete strategy on them.

See above about the reason for needing to reset the machine ;-)  The overall
package is cooperative in nature, so we don't rely on reservations except for
the actual failover.  However, due to this very issue, we need to kill the
machine that was failed over as soon as possible after the failover to avoid
any possible races with open windows in the new drive owner's reservation.

[ snipped comments about fine tooth analysis of other clustering software ]

The hardware shortcomings are known to us.  The actual preferred method of
doing this would be to have each machine in the cluster have access to a
serial operated power switch so that when machine B failed over the cluster,
it could actually power down machine A to avoid those race conditions, only
touching the drive itself after machine A was already powered down.  Race
windows gone.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
