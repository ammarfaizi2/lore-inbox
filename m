Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUHHBeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUHHBeL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 21:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUHHBeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 21:34:11 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:34700 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S264530AbUHHBeG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 21:34:06 -0400
From: David Brownell <david-b@pacbell.net>
To: ncunningham@linuxmail.org
Subject: Re: What PM should be and do (Was Re: Solving suspend-level confusion)
Date: Sat, 7 Aug 2004 17:54:19 -0700
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200408032030.41410.david-b@pacbell.net> <1091594872.3191.71.camel@laptop.cunninghams>
In-Reply-To: <1091594872.3191.71.camel@laptop.cunninghams>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408071754.19448.david-b@pacbell.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - support for state management of part of the tree (I want to put the
> other devices to sleep at the start of suspending)

Hmm, sounds like maybe you're thinking about something that
I might prefer to think of as a set.   Maybe organized by role
("display", "disk array 2", etc) or maybe by something that
monitors device usage (and which might help you by keeping
most things suspended most of the time).


> - support for grouping together a bunch of devices into an arbitrary
> subtree (quiesce that keyboard, screen and storage device - and their
> parents - while I do my lowlevel stuff... okay, now resume them so I can
> save the rest of the image)

OK, that's definitely a set not a tree.  And given USB, putting a keyboard
into that a set creates a problem until remote wakeup works through PCI!

Example of a simple tree:  a USB flash "disk" as the only device
attached to a laptop.  That's actually several devices, something
along these lines:

  - PCI device, maybe bound to ohci_hcd
  - USB root hub implemented by that driver
  - USB devices, at least for device and one interface
  - SCSI host implemented by usb-storage
  - SCSI disk implemented by various SCSI layers 
  - block device implemented by SCSI
  - maybe a couple partitions

Suspending that device should cause almost all of those to suspend.
If there were another USB device on that root hub, it might not be
possible to suspend the root hub.
 

> Perhaps the way to achieve the partial tree stuff is to make the code
> for handling device lists more generic, so that there would be groups of
> devices and each group has an dpm_active, dpm_off and dpm_off_irq list
> of its own. Devices could go into a 'main group' by default, and be
> shifted to a different group for operations like the above. Suspending
> and resuming then moves the devices within the lists for the group.
> Parents would only need to be moved in a case like mine, where the main
> group was going to sleep.

Hmm, I'd rather have the lists be dynamically constructed.  For example,
"this device and all its children" should be suspended bottom-up,
and resumed top-down  Would those groups be there for users to
work with?

And I'm not sure I understand what you mean about changing parents.
After all, a given board will only be wired in one way, and no change
in software can remove constraints like "A must suspend before B"
or "if one of these N devices needs the 48 MHz clock, that PLL must
still be running and so the system can't sleep".

- Dave

