Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264264AbRFOI3P>; Fri, 15 Jun 2001 04:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264279AbRFOI24>; Fri, 15 Jun 2001 04:28:56 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:16136 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264264AbRFOI2r>; Fri, 15 Jun 2001 04:28:47 -0400
Message-ID: <3B29C6D8.AD61B4BF@idb.hist.no>
Date: Fri, 15 Jun 2001 10:27:04 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <Pine.LNX.4.10.10106141736570.4809-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

> > Disk speed is difficult.  I may enable and disable swap on any number of
> ...
> > You may be able to get some useful approximations, but you
> > will probably not be able to get good numbers in all cases.
> 
> a useful approximation would be simply an idle flag.
> for instance, if the disk is idle, then cleaning a few
> inactive-dirty pages would make perfect sense, even in
> the absence of memory pressure.

You can't say "the disk".  One disk is common, but so is
setups with several.  You can say "clean pages if
all disks are idle".  You may then loose some opportunities 
if one disk is idle while an unrelated one is busy.

Saying "clean a page if the disk it goes to is idle" may 
look like the perfect solution, but it is surprisingly
hard.  It don't work with two IDE drives on the same
cable - accessing one will delay the other which might be busy.
The same can happen with scsi if the bandwith of the scsi bus
(or the isa/pci/whatever bus) it is connected to is maxed out.

And then there are loop & md devices.  My computer have several
md devices using different partitions on the same two disks,
as well as a few ordinary partitions.  Code to deal correctly
with that in all cases when one disk is busy and the other idle 
is hard.  Probably so complex that it'll be rejected on the
KISS principle alone.

A per-disk "low-priority queue"  in addition to the ordinary
elevator might work well even in the presence of md
devices, as the md devices just pass stuff on to the real
disks.  Basically let the disk driver pick stuff from the low-
priority queue only when the elevator is completely idle.
But this gives another problem - you get the complication
of moving stuff from low to normal priority at times.
Such as when the process does fsync() or the pressure
increases.  

Helge Hafting
