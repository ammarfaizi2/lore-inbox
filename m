Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUHDEtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUHDEtI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 00:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266691AbUHDEtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 00:49:08 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:4537 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S266717AbUHDEtD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 00:49:03 -0400
Subject: What PM should be and do (Was Re: Solving suspend-level confusion)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200408032030.41410.david-b@pacbell.net>
References: <20040730164413.GB4672@elf.ucw.cz>
	 <200408031928.08475.david-b@pacbell.net> <1091588163.5225.77.camel@gaston>
	 <200408032030.41410.david-b@pacbell.net>
Content-Type: text/plain
Message-Id: <1091594872.3191.71.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 04 Aug 2004 14:47:52 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.

On Wed, 2004-08-04 at 13:30, David Brownell wrote:
> Me either.  But renumbering the PM_SUSPEND_* values would let folk
> start discussing what PM should be (and do) without that particular
> pressure.

I'll happily give a go at kicking off a new thread along these lines
(roughly!).

>From my point of view, I really want the core PM code to provide:

- support for telling what class of device a driver is handling (I'm
particularly interested in keeping the keyboard, screen and storage
devices alive while suspending).
- support for state management of part of the tree (I want to put the
other devices to sleep at the start of suspending)
- support for grouping together a bunch of devices into an arbitrary
subtree (quiesce that keyboard, screen and storage device - and their
parents - while I do my lowlevel stuff... okay, now resume them so I can
save the rest of the image)

Perhaps the way to achieve the partial tree stuff is to make the code
for handling device lists more generic, so that there would be groups of
devices and each group has an dpm_active, dpm_off and dpm_off_irq list
of its own. Devices could go into a 'main group' by default, and be
shifted to a different group for operations like the above. Suspending
and resuming then moves the devices within the lists for the group.
Parents would only need to be moved in a case like mine, where the main
group was going to sleep.

As far as PM_SUSPEND_* values go, then, I guess I'd like to see:

PM_SUSPEND_LIVE
PM_SUSPEND_PAUSED (live but not doing or accepting work, state saved in
persistent memory)
PM_SUSPEND_DOWN (paused, maybe powered down)

I'd thus be keeping the keyboard etc between LIVE and PAUSED until the
image is completely written, and putting other devices in DOWN virtually
straight away.

Nigel

