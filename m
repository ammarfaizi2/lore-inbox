Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVHYQQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVHYQQM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVHYQQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:16:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:53720 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932260AbVHYQQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:16:11 -0400
Date: Thu, 25 Aug 2005 11:13:25 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: John Rose <johnrose@austin.ibm.com>, benh@kernel.crashing.org,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
Message-ID: <20050825161325.GG25174@austin.ibm.com>
References: <20050823231817.829359000@bilge> <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com> <1124898331.24668.33.camel@sinatra.austin.ibm.com> <20050824162959.GC25174@austin.ibm.com> <17165.3205.505386.187453@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17165.3205.505386.187453@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 10:10:45AM +1000, Paul Mackerras was heard to remark:
> Linas Vepstas writes:
> 
> > The meta-issue that I'd like to reach consensus on first is whether
> > there should be any hot-plug recovery attempted at all.  Removing
> > hot-plug-recovery support will make many of the issues you raise 
> > to be moot.
> 
> Yes, this probably the thorniest issue we have.
> 
> My feeling is that the unplug half of it is probably fairly
> uncontroversial, but the replug half is a can of worms.  Would you
> agree with that?

Actually, no.  There are three issues:
1) hotplug routines are called from within kernel. GregKH has stated on
   multiple occasions that doing this is wrong/bad/evil. This includes
   calling hot-unplug.

2) As a result, the code to call hot-unplug is a bit messy. In
   particular, there's a bit of hoop-jumping when hotplug is built as
   as a module (and said hoops were wrecked recently when I moved the
   code around, out of the rpaphp directory).

3) Hot-unplug causes scripts to run in user-space. There is no way to 
   know when these scripts are done, so its not clear if we've waited
   long enough before calling hot-add (or if waiting is even necessary).

> Is it udev that handles the hotplug notifications on the userspace
> side in all cases (do both RHEL and SLES use udev, for instance)?

Yes, and it seems to work fine despite the fact that the current 
sles9/rhel4 use rather oooooold versions of udev, which is criminal,
according to Kay Seivers.  I have not tested new versions of udev; 
I assume new versions will work "even better".

> How hard is it to add a new sort of notification, on the kernel side
> and in udev?

Why? To acheive what goal?  (Keep in mind that user-space eeh solutions
seem to fail when the affected device is storage, since block devices
and filesystems don't like the underlying storage to wink out.)

> I think what I'd like to see is that when a slot gets isolated and the
> driver doesn't have recovery code, the kernel calls the driver's
> unplug function and generates a hotplug event to udev.  Ideally this
> would be a variant of the remove event which would say "and by the
> way, please try replugging this slot when you've finished handling the
> remove event" or something along those lines.

Ahh, yes, this addresses the timing issue raised in point 3).  However,
I'm thinking that the timing issue is not really an issue, depending on
how udev is designed.  For example, consider a 100% cpu loaded, heavy
i/o loaded PC, and now we rapidly unplug and replug some USB key.
Presumably, udev will handle this gracefully.  The kernel error recovery
essentially looks the same to udev: the burp on the bus looks like a
rapid-fire unplug-replug.

BTW, zSeries has similar concerns, where channels can come and go,
causing thousands of unplug/replug udev events in rapid succession. 
(This was discussed on the udev mailing lists in the past).  It might
be interesting to have the zSeries folks discuss the current EEH design,
as this is something they have far more experience with than any of 
the pc or unix crowd.  I personally have not discussed with any zSeries 
people.

--linas

