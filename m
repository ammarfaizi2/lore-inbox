Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTIKQBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbTIKQBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:01:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48053 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261346AbTIKQBR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:01:17 -0400
Date: Thu, 11 Sep 2003 17:01:16 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Memory mapped IO vs Port IO
Message-ID: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's a lot of drivers in the tree that allow you to access the device
either via IO port space or IO mem space.  Here's some examples:

config SCSI_SYM53C8XX_IOMAPPED
        bool "use normal IO"
        depends on SCSI_SYM53C8XX_2
        help
          If you say Y here, the driver will preferently use normal IO
	  rather than memory mapped IO.

config 8139TOO_PIO
        bool "Use PIO instead of MMIO"
        depends on 8139TOO
        help
          This instructs the driver to use programmed I/O ports (PIO) instead
          of PCI shared memory (MMIO).  This can possibly solve some problems
          in case your mainboard has memory consistency issues.  If unsure,
          say N.

config TULIP_MMIO
        bool "Use PCI shared mem for NIC registers"
        depends on TULIP
        help
          Use PCI shared memory for the NIC registers, rather than going through
          the Tulip's PIO (programmed I/O ports).  Faster, but could produce
          obscure bugs if your mainboard has memory controller timing issues.
          If in doubt, say N.

As you can see, everybody asks the question differently, and sometimes
you should answer Y and sometimes N to get MMIO.  There are other drivers
which don't ask the question at all and you have to edit the .c file to
turn it on or off.  I'll also note the acronym `PIO' is ambiguous --
sometimes it refers to Port IO and sometimes to Programmed IO (which
can be a memory access).

Personally, when I'm configuring a new kernel for a machine, I don't
want to learn about the suboptions for each device -- I've got dozens of
other things to configure right.  My favourite solution to this problem
wuld be to ask the question once only and have it apply to all devices:

config MMIO
	bool "Prefer Memory-mapped I/O accesses over Port I/O"
	help
	  Many devices are accessible via both memory mapped I/O and
	  port I/O.  Say Y here to access them via the slightly faster
	  memory mapped I/O method.  If you experience problems, you may
	  wish to say N here.

If that's not acceptable, can I suggest that we at least ask a standard
question?

config WWWW_MMIO
	bool "Use Memory mapped I/O in preference to Port I/O"
	depends on WWWW
	help
	  This device's registers can be accessed by either memory
	  mapped I/O or port I/O.  Memory mapped I/O is faster, so you
	  are advised to say Y here.

(yes, we could wordsmith these questions into the ground; the key point
of this mail is whether we ask one question at the start of configuration
or whether we ask one question per device.)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
