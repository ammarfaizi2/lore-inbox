Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132904AbRDRAJt>; Tue, 17 Apr 2001 20:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132925AbRDRAJl>; Tue, 17 Apr 2001 20:09:41 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:21731 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S132904AbRDRAJb>; Tue, 17 Apr 2001 20:09:31 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDD91@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'John Fremlin'" <chief@bandits.org>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>
Cc: "'Pavel Machek'" <pavel@suse.cz>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: RE: Let init know user wants to shutdown
Date: Tue, 17 Apr 2001 17:07:30 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[do we want to move this to linux-power?]

> From: John Fremlin [mailto:chief@bandits.org]
> > We are going to need some software that handles button events, as
> > well as thermal events, battery events, polling the battery, AC
> > adapter status changes, sleeping the system, and more.
> 
> Dealing with events should be disjoint from polling the battery or
> powerstatus. Many processes might reasonably simultaneously want to
> provide a display to the user of the current power status.

There should be only one PM policy agent on the system. I don't care about
other processes that query for display purposes, but someone needs to be
alive and checking all the time in order to act on the user's wishes, and
shut down or sleep when the battery hits x minutes remaining, for example.
Let us call this "powerd", for sake of argument.

> However, button presses and so on should be handled by a single
> process. Otherwise the kernel is unreasonably complicated by having to
> deal with multiple processes' veto power, which could just as well and
> more flexibly be handled in userspace.

Exactly, only one entity can be in charge of setting the system's power
policy. So, let's not multiply entities needlessly -- let's make the button
policy manager also be powerd.

> I don't why there needs to be an additional daemon constantly running
> to deal with button presses and power status changes. Apparently init
> is already handling similar things: why should it not be extended to
> include button presses?

Unix philosophy: do one task and do it well. Now that power management is
big enough to be a task in itself (instead of just a minor feature) we
should break it out from unrelated functionality.

> Alternatively, why not forgo a daemon altogether? (This scheme is
> already implemented in the pmpolicy patch, i.e. it is already
> working.)

Because power policy needs to run continuously. Why? Because we need to poll
the battery for battery remaining, and we need to keep a moving average,
because the battery only provides instantaneous power consumption numbers.
Centralizing this means every UI applet can query it, and will show the same
battery remaining value.

Also, because thermal control is not 100% event driven - when we start
passive cooling on the CPU because of a thermal zone overheat, we have to
throttle, and then sample the temperature periodically until the temp goes
below the threshold. (ref: ACPI 2.0 spec chapter 12)

> > We need WAY more flexibility than init provides. 
> 
> Examples please.

See above. I know you may have an affinity for a call_usermodehelper-based
solution, but I hope I have been able to be clear on why I believe an actual
daemon is justified.

Regards -- Andy

PS apm already has apmd (which we would be replacing), so there will be no
net increase in system daemons.

