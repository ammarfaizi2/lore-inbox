Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279134AbRJWAUF>; Mon, 22 Oct 2001 20:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279137AbRJWATq>; Mon, 22 Oct 2001 20:19:46 -0400
Received: from air-1.osdl.org ([65.201.151.5]:26892 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S279136AbRJWATd>;
	Mon, 22 Oct 2001 20:19:33 -0400
Date: Mon, 22 Oct 2001 17:19:57 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@osdlab.pdx.osdl.net>
To: Pavel Machek <pavel@Elf.ucw.cz>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <20011021190902.A21849@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0110221702260.25103-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > That would give us the following scenario:
> >
> >  - The device for suspend-to-disk is identified and a flag is set
> >    in it's device structure. This flag (or a different one to make
> >    things clear eventually) is "broadcast" all the way up the tree
> >    so it's parent brigdes/controllers are marked as well.
>
> You don't need this.

Correct. Suspend-to-disk is a process, not a discrete action. It goes much
like Ben described:

>From the system point of view (slightly different from the driver's point
of view):

- notify devices of pending suspension; check for failures
- tell devices to suspend state; write this state to disk
- turn all devices off
- power off (aka suspend system)

> >  - All devices get "suspend_prepare".
> >  - All devices get "suspend_save_state" and block normal IOs
> >  - All devices not marked above get "suspend"
>
> ... not needed. You are going powerdown (suspend-to-disk ends in
> powerdown, right?), so you don't care about state devices are in. You don't need to suspend them.
>
> You just write state to disk and powerdown, now.

Uhm...That would probably work. But, I would rather explicitly turn off
all the devices. In the world of ACPI, S4 and S5 (Suspend to disk and
soft-off respectively) don't power the system completely off; some power
remains to capture wake events.

[ One point to note is that in an ACPI-enabled system, we use S5 to power
the system off. But, there are things still running in the system.
Everything is not shut off until you perform a mechanical off (unplug it).
This means that you can get wake events and cause the system to boot after
you think you've turned it off. This is why some people are experiencing
reboots when the system should be powering down. ]

By explicitly turning off as many devices as possible, we're playing more
on the safe side of things, and possibly reducing the amount of power that
is being consumed.


Btw, I updated the model to support an n-stage suspend process, with 3
stages explicitly defined, as per some discussion about it. Those stages
are:

        SUSPEND_NOTIFY
        SUSPEND_SAVE_STATE
        SUSPEND_POWER_DOWN

To suspend the device tree, one would do something like:

	/* Tell all the devices we're going to sleep.
	 * This also allows them to allocate memory before the swap
	 * device stops taking orders.
	 */
	device_suspend(3, SUSPEND_NOTIFY);

	/* if someone failed, get out now */

	/* Now tell them to stop I/O and save their state */
	device_suspend(3, SUSPEND_SAVE_STATE);

	/* Write the state to disk... */

	/* Finally, turn all of the devices off. */
	device_suspend(3, SUSPEND_POWER_DOWN);

	/* Now, put the system to sleep. */


I also updated the docs. It can all be found at:

http://kernel.org/pub/linux/kernel/people/mochel/device/


	-pat

