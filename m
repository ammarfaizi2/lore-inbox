Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135695AbREBRq5>; Wed, 2 May 2001 13:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135685AbREBRqs>; Wed, 2 May 2001 13:46:48 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:56659 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135684AbREBRqe>; Wed, 2 May 2001 13:46:34 -0400
Message-ID: <3AF0483C.49C8CF90@redhat.com>
Date: Wed, 02 May 2001 13:47:40 -0400
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
				<3AEEDFFC.409D8271@redhat.com> <15086.60620.745722.345084@gargle.gargle.HOWL> <3AF025AE.511064F3@redhat.com> <3AF04648.73F5BFCE@cds.duke.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max TenEyck Woodbury wrote:
> 
> Doug Ledford wrote:
> >
> > ...
> >
> > If told to hold a reservation, then resend your reservation request once every
> > 2 seconds (this actually has very minimal CPU/BUS usage and isn't as big a
> > deal as requesting a reservation every 2 seconds might sound).  The first time
> > the reservation is refused, consider the reservation stolen by another machine
> > and exit (or optionally, reboot).
> 
> Umm. Reboot? What do you think this is? Windoze?

It's the *only* way to guarantee that the drive is never touched by more than
one machine at a time (notice, I've not been talking about a shared use drive,
only one machine in the cluster "owns" the drive at a time, and it isn't for
single transactions that it owns the drive, it owns the drive for as long as
it is alive, this is a limitation of the filesystes currently available in
mainstream kernels).  The reservation conflict and subsequent reboot also
*only* happens when a reservation has been forcefully stolen from a machine. 
In that case, you are talking about a machine that has been failed over
against its will, and the absolute safest thing to do in order to make sure
the failed over machine doesn't screw the whole cluster up, is to make it
reboot itself and re-enter the cluster as a new failover slave node instead of
as a master node.  If you want a shared common access device with write
locking semantics, as you seem to be suggesting later on, then you need a
different method of locking than what I put in this, I knew that as I wrote it
and that was intentional.

> Really, You can NOT do clustering well if you don't have a consistent locking
> mechanism. The use of a hardware locking method like 'reservation' may be a
> good way to avoid race conditions, but it should be backed up by the
> appropriate exchange of messages to make sure everybody has the same view of
> the system. For example, you might use it like this:
> 
> 1. Examine the lock list for conflicts. If a conflict is found, the lock
>    request fails.
> 
> 2. Reserve the device with the lock on it. If the reservation fails, delay
>    a short amount of time and return to 1.
> 
> 3. Update the lock list for the device.
> 
> 4. When the list update is complete, release the reservation.
> 
> In other words, the reservation acts as a spin-lock to make sure updates
> occur atomically.

Apples to oranges, as I described above.  This is for a failover cluster, not
a shared data, load balancing cluster.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
