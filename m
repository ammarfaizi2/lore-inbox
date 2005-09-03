Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVIBXlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVIBXlZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVIBXlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:41:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:45796 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751241AbVIBXlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:41:24 -0400
Subject: Re: IDE HPA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: pjones@redhat.com
Cc: "ATARAID (eg, Promise Fasttrak, Highpoint 370) related discussions" 
	<ataraid-list@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1125695649.31292.45.camel@localhost.localdomain>
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
	 <1125666332.30867.10.camel@localhost.localdomain>
	 <62b0912f05090206331d04afd3@mail.gmail.com>
	 <E1EBCdS-00064p-00@chiark.greenend.org.uk>
	 <62b0912f05090209242ad72321@mail.gmail.com>
	 <1125680712.30867.20.camel@localhost.localdomain>
	 <62b0912f05090210441d3fa248@mail.gmail.com>
	 <1125684567.31292.2.camel@localhost.localdomain>
	 <1125687557.30867.26.camel@localhost.localdomain>
	 <1125688483.31292.20.camel@localhost.localdomain>
	 <1125692578.30867.33.camel@localhost.localdomain>
	 <1125695649.31292.45.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Sep 2005 01:05:24 +0100
Message-Id: <1125705924.30867.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-02 at 17:14 -0400, Peter Jones wrote:
> > You installed it on Red Hat 7 ? I think 7, may have been 6.x or earlier.
> 
> You may be right -- it's likely that I shrank my windows partition on
> some other OS or Distro that wasn't designed with to screw up the disk.

If you shrink existing partitions it won't ever screw you up. The
geometry data for the partition table spans only the non HPA area.

> Yes, it did have a partition table -- but the partition table did (and
> still does) not include partitions which overlap the HPA.  Right now it
> still appears as unused space.

But they are also on the IBM I looked at are obvious because the
geometry in the partition table does not span the HPA so the problem
doesn't arise as confusion.

> > Not really practical. You'd have to list most older PC systems.
> 
> Most older PC systems use HPA?  Really?

Many of those "magic windows drive/bios fixup" type programs work by
having the jumper on the drive set the HPA and the drive report a
smaller size, then the windows magic driver undoes this.


> Both of these suck.  Have I missed something?


I fear not.

> So where would you envision this code to check the partition table, the
> HPA/host default disk size, and guess how things should be set up?

fdisk and friends already have to parse and process the existing
partition tables.

> they'll be screwing themselves by partitioning the entire disk, so we
> really should be leaving HPA enabled if the protected area is indeed not
> for consumption.

Define "not for consumption". It should be *hard* to use it, and it
should not occur by accident. Deliberately is a different matter. And
that should be a run time not boot time action.

> (as a side note, I know one user who, at OLS, noticed we fail to
> re-initialize HPA after unsuspend, so on at least t40 the disk gets
> smaller when you suspend.  This may or may not be fixed, I haven't
> checked.  But it's one more sort of pain we get into by disabling it,
> whether justified or not.)

Known problem. ACPI provides the correct infrastructure for much of this
but the IDE layer doesn't support it. Send patches to Bartlomiej. The
core infrastructure is there because Andre saw the need for the ACPI
taskfile support coming. The HPA restore is just another step in the
state machine for resume and quite doable. Good little project for
someone wanting to play with the IDE layer.

> I think if we go the heuristic route, then the *safest* option is to
> leave it enabled by default and let userland installers/initrd do fixups
> by telling the kernel to change the state. 

Assuming we are talking about hda1/2/... then the partitions are already
clipped by the OS to the volume size. We could conceivably make the size
of the disk itself writable. We don't need to get into programming drive
HPA when we can do it ourselves, and we can clip non HPA capable drives
too should someone find a cause for it.

