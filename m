Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWIVUwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWIVUwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWIVUwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:52:24 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38925 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1750785AbWIVUwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:52:23 -0400
Date: Fri, 22 Sep 2006 16:52:23 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: David Brownell <david-b@pacbell.net>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.17: dmesg flooded with "ohci_hcd 0000:00:02.0:
 wakeup"
In-Reply-To: <200609222253.44568.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.44L0.0609221648330.8223-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006, Andrey Borzenkov wrote:

> > It's the usual case of fixing one bug triggering another, in your case
> > because the fix ran into a previously unseen hardware bug.  One other
> > way to work around that bug would be disabling CONFIG_PM, but I suspect
> > you don't want to go that route...
> >
> > > Here you are. I am still puzzled where all these "suspends" come from - I
> > > did not try any suspend in the meantime ...
> >
> > It's the driver putting the controller into a low power state.  Your
> > hardware seems to have a bug whereby that doesn't work correctly,
> > making it immediately leave that state.  (And the driver messaging is
> > fine for what should be an uncommon event; plus it highlighted your
> > hardware bug.)  Notice the "initreset quirk" message -- another bug
> > in that hardware.  Workarounds in both cases are simple.
> >
> > When I get a moment, I'll have a patch for you to try.  Meanwhile,
> > either workaround I showed above should prevent the attempt to enter
> > that low power mode.
> >
> 
> 
> I updated to 2.6.18 and got the same issue; any patch to try?

> > > ohci_hcd 0000:00:02.0: suspend root hub
> > > hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
> > > hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> > > ohci_hcd 0000:00:02.0: suspend root hub
> > > hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
> > > hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> > > ohci_hcd 0000:00:02.0: suspend root hub
> > > hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000, resume root
> > > hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
> > > ohci_hcd 0000:00:02.0: suspend root hub
> >
> > .... etc

I had to add special code in uhci-hcd for controllers where the 
resume-detect mechanism was broken.  When the root hub on one of those 
bad machines is suspended, the driver uses polling instead of interrupts 
to detect port status changes.

Alan Stern

