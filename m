Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbUJXJmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUJXJmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 05:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUJXJmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 05:42:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51667 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261404AbUJXJmN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:42:13 -0400
Date: Sun, 24 Oct 2004 03:42:10 -0600
From: Nathan Lynch <nathanl@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, rusty@rustcorp.com.au, mochel@digitalimplant.org,
       Nathan Lynch <nathanl@austin.ibm.com>, anton@samba.org
Message-Id: <20041024094551.28808.28284.87316@biclops>
Subject: [RFC/PATCH 0/4] cpus, nodes, and the device model: dynamic cpu registration
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there-

I know of at least two platforms (ppc64 and ia64) which allow cpus to
be physically or logically added and removed from a running system.
These are distinct operations from onlining or offlining, which is
well supported already.  Right now there is little support in the core
cpu "driver" for dynamic addition or removal.  The patch series which
follows implements support for this in a way which will (hopefully)
reduce code duplication and enforce some uniformity across the
relevant architectures.

For starters, the current situation is that cpu sysdevs are registered
from architecture code at boot.  Already we have inconsistencies
betweeen the arches -- ia64 registers only online cpus, ppc64
registers all "possible" cpus.  I propose to move the initial cpu
sysdev registrations to the cpu "driver" itself (drivers/base/cpu.c),
and to register only "present" cpus at boot.

But that breaks all the arch code which explicitly registers cpu
sysdevs.  For instance, ppc64 wants to hang all kinds of attributes
off of the cpu devices for performance counter stuff.  So code such as
this needs to be converted to register a sysdev_driver with the cpu
device class, which will allow the ppc64 code to be notified when a
cpu is added or removed.  In the patches that follow I include the
changes necessary for ppc64, as an example.  (An arch sweep or
temporary compatibility hack can come later if I get positive
responses to this approach.)

Also, there is the matter of the base numa "node" driver.  Currently
the cpu driver makes symlinks from nodes to their cpus.  This seems
backwards to me, so I have changed the node driver to create or remove
the symlinks upon cpu addition or removal, respectively, also using
the sysdev_driver approach.  I've also converted base/drivers/node.c
to doing the boot-time node registration itself, like the cpu code.

Finally, I've added two new interfaces which wrap all this up --
cpu_add() and cpu_remove().  These carry out the necessary update to
cpu_present_map and take care of the cpu device registration.  These
are meant to be invoked from the platform-specific code which
discovers and removes processors.

This is the first real device model-related hacking I've done.  I'm
hoping Greg or Patrick will tell me whether I'm on the right track or
abusing the APIs :)

These patches have been boot-tested on ppc64.  I haven't gotten to
test the removal paths yet.


Nathan
