Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268936AbRHLDN2>; Sat, 11 Aug 2001 23:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268940AbRHLDNS>; Sat, 11 Aug 2001 23:13:18 -0400
Received: from zurich.ai.mit.edu ([18.43.0.244]:11786 "EHLO zurich.ai.mit.edu")
	by vger.kernel.org with ESMTP id <S268936AbRHLDNL>;
	Sat, 11 Aug 2001 23:13:11 -0400
To: linux-kernel@vger.kernel.org
Subject: Booting from USB floppy?
User-Agent: IMAIL/1.11; Edwin/3.110; MIT-Scheme/7.5.18.pre
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VlgK-0005GO-00@trixia.ai.mit.edu>
From: Chris Hanson <cph@zurich.ai.mit.edu>
Date: Sat, 11 Aug 2001 23:12:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to build Debian 2.2 boot/root floppies for the HP
OmniBook 500 laptop, which (in some configurations) has only a USB
floppy drive.  I've been unable to get the kernel to load the root
floppy.  These tests were done using Linux 2.4.6.

At this point, I think this isn't possible without some real work in
the kernel.  I'd like to get some feedback about whether this is a
correct deduction.  To that end, here is my analysis.

1. The function mount_root() in "fs/super.c" specially detects floppy
   devices and handles them differently than other devices that might
   be specified by the "root=" parameter, such as "root=/dev/sda" in
   this case.  So handling a floppy drive that appears to be a SCSI
   floppy looks like it can't be done without patching that code.

2. If that is worked around, there is a further problem: the USB
   storage driver sets up the SCSI translator asynchronously.  Prior
   to this, the device "/dev/sda" doesn't exist, which means there's a
   race condition between the USB-SCSI initialization and the boot
   process accessing the root device.  I discovered this by specifying
   "root=/dev/sda", and seeing that the kernel didn't initialize the
   USB floppy device before it tried to open "/dev/sda", and failed
   with a "no such device" error.  So fixing this would also requiring
   synchronizing the race -- but it's not clear how you'd figure out
   that synchronization would even be needed here.

Does this seem like a reasonably correct analysis of the situation?
Is it easier than I think?  Is anyone else working on booting from USB
floppies?

Please CC me to any replies, since I don't read this list.

TIA,
Chris
