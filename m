Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136008AbREBVqE>; Wed, 2 May 2001 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135998AbREBVpz>; Wed, 2 May 2001 17:45:55 -0400
Received: from compton.acpub.duke.edu ([152.3.233.74]:65261 "EHLO
	compton.acpub.duke.edu") by vger.kernel.org with ESMTP
	id <S135997AbREBVpp>; Wed, 2 May 2001 17:45:45 -0400
Message-ID: <3AF08077.7CF53A2D@cds.duke.edu>
Date: Wed, 02 May 2001 17:47:35 -0400
From: Max TenEyck Woodbury <mtew@cds.duke.edu>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Eric.Ayers@intec-telecom-systems.com,
        James Bottomley <James.Bottomley@steeleye.com>,
        "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
In-Reply-To: <200105011445.KAA01117@localhost.localdomain>
					<3AEEDFFC.409D8271@redhat.com> <15086.60620.745722.345084@gargle.gargle.HOWL> <3AF025AE.511064F3@redhat.com> <3AF04648.73F5BFCE@cds.duke.edu> <3AF0483C.49C8CF90@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> 
> Max TenEyck Woodbury wrote:
>>
>> Umm. Reboot? What do you think this is? Windoze?
> 
> It's the *only* way to guarantee that the drive is never touched by more
> than one machine at a time (notice, I've not been talking about a shared
> use drive, only one machine in the cluster "owns" the drive at a time,
> and it isn't for single transactions that it owns the drive, it owns
> the drive for as long as it is alive, this is a limitation of the
> filesystes currently available in mainstream kernels).  The reservation
> conflict and subsequent reboot also *only* happens when a reservation
> has been forcefully stolen from a machine. In that case, you are talking
> about a machine that has been failed over against its will, and the
> absolute safest thing to do in order to make sure the failed over machine
> doesn't screw the whole cluster up, is to make it reboot itself and
> re-enter the cluster as a new failover slave node instead of as a master
> node.  If you want a shared common access device with write locking
> semantics, as you seem to be suggesting later on, then you need a
> different method of locking than what I put in this, I knew that as I
> wrote it and that was intentional.

That was partly meant to be a joke, but it was also meant to make you stop
and think about what you are doing. From what little context I read, you
seem to be looking for a high availability solution. Rebooting a system,
even if there is a hot backup, should only be used as a last resort.

Another problem is that reservations do *not* guarantee ownership over 
the long haul. There are too many mechanisms that break reservations to 
build a complete strategy on them. Unfortunately, this ground was covered
during the 'cluster wars' between IBM and DEC and the field is strewn
with patents, so finding an open source solution may be tough.

>> ...
>> 
>> In other words, the reservation acts as a spin-lock to make sure updates
>> occur atomically.
> 
> Apples to oranges, as I described above.  This is for a failover cluster, not
> a shared data, load balancing cluster.

Load balancing clusters do need a good locking method, but so do failover
clusters. 

It's been 12 years since I did much with this, but I did do a fine tooth
analysis of parts of DECs clustering code looking for ways it could fail.
(The results were a few internal SPRs. I'm not at liberty to discuss the
details, even if I could remember them. However, I can say without giving
anything away that there were places where a hardware locking mechanism,
like reservation, would have simplified the code and improved performance.)

It was precisely the kinds of things associated with hardware failover
that lead DEC to do clusters in the first place. The load balancing stuff
was secondary, even if it did sell more systems in the long run. You may
be able to get through the patent minefield by retrofitting the load 
balancing lock mechanisms to failover.

It may be that you can make it work, but the tested solution requires
software to back up the hardware. Good Luck, you'll probably need a
lot of it. (no sarcasm intended.)

mtew@cds.duke.edu
