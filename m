Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135637AbREBQiv>; Wed, 2 May 2001 12:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135635AbREBQin>; Wed, 2 May 2001 12:38:43 -0400
Received: from host194.steeleye.com ([216.33.1.194]:20495 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S135634AbREBQi1>; Wed, 2 May 2001 12:38:27 -0400
Message-Id: <200105021637.f42Gbxq01667@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi 
In-Reply-To: Message from Doug Ledford <dledford@redhat.com> 
   of "Wed, 02 May 2001 11:20:14 EDT." <3AF025AE.511064F3@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 May 2001 12:37:58 -0400
From: Eddie Williams <Eddie.Williams@steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Doug,

Great to hear your progress on this.  As I had not heard anything about this 
effort since this time last year I had assumed you put this project on the 
shelf.  I will be happy to test these interfaces when they are ready.

Eddie

> "Eric Z. Ayers" wrote:
> > 
> > Doug Ledford writes:
> > (James Bottomley commented about the need for SCSI reservation kernel patches)
> >  >
> >  > I agree.  It's something that needs fixed in general, your software needs it
> >  > as well, and I've written (about 80% done at this point) some open source
> >  > software geared towards getting/holding reservations that also requires the
> >  > same kernel patches (plus one more to be fully functional, an ioctl to allow a
> >  > SCSI reservation to do a forced reboot of a machine).  I'll be releasing that
> >  > package in the short term (once I get back from my vacation anyway).
> >  >
> > 
> > Hello Doug,
> > 
> > Does this package also tell the kernel to "re-establish" a
> > reservation for all devices after a bus reset, or at least inform a
> > user level program?  Finding out when there has been a bus reset has
> > been a stumbling block for me.
> 
> It doesn't have to.  The kernel changes are minimal (basically James' SCSI
> reset patch that he's been carrying around, the scsi reservation conflict
> patch, and I need to write a third patch that makes the system optionally
> reboot immediately on a reservation conflict and which is controlled by an
> ioctl, but I haven't done that patch yet).  All of the rest is implemented in
> user space via the /dev/sg entries.  As such, it doesn't have any more
> information about bus resets than you do.  However, because of the policy
> enacted in the code, it doesn't need to.  Furthermore, because there are so
> many ways to loose a reservation silently, it's foolhardy to try and keep
> reservation consistency any way other than something similar to what I outline
> below.
> 
> The package is meant to be a sort of "scsi reservation" library.  The
> application that uses the library is responsible for setting policy.  I wrote
> a small, simple application that actually does a decent job of implementing
> policy on the system.  The policy it does implement is simple:
> 
> If told to get a reservation, then attempt to get it.  If the attempt is
> blocked by an existing reservation and we aren't suppossed to reset the drive,
> then exit.  If it's blocked and we are suppossed to reset the drive, then send
> a device reset, then wait 5 seconds, then try to get the reservation.  If we
> again fail, then the other machine is still alive (as proven by the fact that
> it re-established its reservation after the reset) and we exit, else we now
> have the reservation.
> 
> If told to forcefully get a reservation, then attempt to get it.  If the
> attempt fails, then reset the device and try again immediately (no 5 second
> wait), if it fails again, then exit.
> 
> If told to hold a reservation, then resend your reservation request once every
> 2 seconds (this actually has very minimal CPU/BUS usage and isn't as big a
> deal as requesting a reservation every 2 seconds might sound).  The first time
> the reservation is refused, consider the reservation stolen by another machine
> and exit (or optionally, reboot).
> 
> The package is meant to lock against itself (in other words, a malicious user
> with write access to the /dev/sg entries could confuse this locking mechanism,
> but it will work cooperatively with other copies of itself running on other
> machines), the requirements for the locking to be safe are as follows:
> 
> 1)  A machine is not allowed to mount or otherwise use a drive in any way
> shape or form until it has successfully acquired a reservation.
> 
> 2)  Once a machine has a reservation, it is not allowed to ever take any
> action to break another machines reservation, so that if the reservation is
> stolen, this machine is required to "gracefully" step away from the drive
> (rebooting is the best way to accomplish this since even the act of unmounting
> the drive will attempt to write to it).
> 
> 3)  The timeouts in the program must be honored (resend your reservation, when
> you hold it, every 2 seconds so that a passive attempt to steal the
> reservation will see you are still alive within the 5 second timeout and leave
> you be, which is a sort of heartbeat in and of itself).
> 
> Anyway, as I said in my previous email, it's about 80% complete.  It currently
> is up and running on SCSI-2 LUN based reservations.  There is code to do
> SCSI-2 and SCSI-3 extent based reservations but it hasn't been tested due to
> lack of devices that support extent based reservations (my test bed is a
> multipath FC setup, so I'm doing all my testing on FC drives over two FC
> controllers in the same machine).  I've still got to add the SCSI-3 Persistent
> Reservation code to the library (again, I'm lacking test drives for this
> scenario).  The library itself requires that the program treat all
> reservations as extent/persistent reservations and it silently falls back to
> LUN reservations when neither of those two are available.  My simple program
> that goes with the application just makes extent reservations of the whole
> disc, so it acts like a LUN reservation regardless, but there is considerably
> more flexibility in the library if a person wishes to program to it.
> 
> 
> -- 
> 
>  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
>       Please check my web site for aic7xxx updates/answers before
>                       e-mailing me about problems
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org


