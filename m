Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161034AbVIBVOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbVIBVOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbVIBVOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:14:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34749 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161034AbVIBVOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:14:21 -0400
Subject: Re: IDE HPA
From: Peter Jones <pjones@redhat.com>
Reply-To: pjones@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "ATARAID (eg, Promise Fasttrak, Highpoint 370) related discussions" 
	<ataraid-list@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1125692578.30867.33.camel@localhost.localdomain>
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
Content-Type: text/plain
Organization: Red Hat, Inc.
Date: Fri, 02 Sep 2005 17:14:09 -0400
Message-Id: <1125695649.31292.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 (2.3.8-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 21:22 +0100, Alan Cox wrote:
> On Gwe, 2005-09-02 at 15:14 -0400, Peter Jones wrote:
> > Ugh.  So some BIOSes use it for legitimate reasons (like thinkpads), and
> > some use it to work around BIOS bugs.  Great.
> 
> All are legitimate uses. The partition table tells you which.
> 
> > Mine didn't, but it does have an HPA.  Thankfully we weren't disabling
> > it yet when I installed my laptop -- I know others who weren't so lucky.
> > So this partitioning scheme hasn't always been the case...
> 
> You installed it on Red Hat 7 ? I think 7, may have been 6.x or earlier.

You may be right -- it's likely that I shrank my windows partition on
some other OS or Distro that wasn't designed with to screw up the disk.

> This behaviour goes back pretty much to the creation of the ATA spec for
> HPA. In fact if it was that long ago IBM shipped it with Windows so it
> did have a partition table!

Yes, it did have a partition table -- but the partition table did (and
still does) not include partitions which overlap the HPA.  Right now it
still appears as unused space.

> > It really sounds better (to my naive mind, at least) to whitelist the
> > known-broken BIOSes.
> 
> Not really practical. You'd have to list most older PC systems.

Most older PC systems use HPA?  Really?

The alternatives seem to be:

a) whitelist systems (in the kernel or userland) which use it the
   opposite way, where the space is being used for something
   relatively important (at least conceptually), or
b) bad heuristics to figure out which is which.

Both of these suck.  Have I missed something?

> > Well, installers probably should be aware, yes -- that's why I mentioned
> > userland interfaces to enabling/disabling.  But to me it still seems
> > like we want to disable the HPA during installation and bootup, but only
> > if your BIOS is doing things wrong.
> 
> "Wrong" is a poor term here.
> 
> If the system has a partition table that doesn't cover the post HPA area
> and its about the right size we can be fairly sure the right choice is
> to honour the HPA, if its a randomly different size its a fair bet the
> disk got moved
> 
> If the partition table exceeds the no HPA area of disk but not the full
> disk then its almost certainly right the HPA should be disabled post
> boot. If it exceeds both its a raid 0 volume of some form...

So where would you envision this code to check the partition table, the
HPA/host default disk size, and guess how things should be set up?

>From a userland perspective, it's very difficult to let users know
they'll be screwing themselves by partitioning the entire disk, so we
really should be leaving HPA enabled if the protected area is indeed not
for consumption.

Also, the heuristic is harder than this -- if we reexamine the fakeraid
case, then it's clear we have to look for raid metadata, figure out if
the raid includes stuff inside the HPA or not, and then if it doesn't we
don't care -- but that's assuming there _is_ raid metadata.

Long term, many people hope, possibly unrealistically, that we'll be
able to write out raid metadata for people creating raids on cards which
support fakeraid, and have the BIOS grok it appropriately.  So in that
case, we may well have a blank (or garbage) disk, and we can't check the
partition table or any raid metadata.  Correct me if I'm wrong, but I
don't see a simple heuristic for this case.

(as a side note, I know one user who, at OLS, noticed we fail to
re-initialize HPA after unsuspend, so on at least t40 the disk gets
smaller when you suspend.  This may or may not be fixed, I haven't
checked.  But it's one more sort of pain we get into by disabling it,
whether justified or not.)

I think if we go the heuristic route, then the *safest* option is to
leave it enabled by default and let userland installers/initrd do fixups
by telling the kernel to change the state.  That way it can keep it
correct on suspend/unsuspend, but we don't give users the opportunity to
really screw themselves unless they try pretty hard, and we don't
actually screw the users unless we simply get the heuristic totally
wrong.  It's also consistent with the more general policy of leaving
policy up to the userland.

But your point about how I should send you a patch certainly still
applies.

-- 
  Peter

