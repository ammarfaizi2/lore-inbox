Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSLFTGU>; Fri, 6 Dec 2002 14:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSLFTGU>; Fri, 6 Dec 2002 14:06:20 -0500
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:7934 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S265587AbSLFTGS> convert rfc822-to-8bit; Fri, 6 Dec 2002 14:06:18 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: s390 update.
Date: Fri, 6 Dec 2002 20:11:04 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212061944.22688.schwidefsky@de.ibm.com>
Cc: com.ibm@arndb.de, idrys@gmx.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
big sellout for s/390. We have progressed with the common i/o layer rework
to a point where its working fine again. There are some leftovers but
we can fix these later without causing another huge patch. Dependent on
the cio rework are the device drivers. There are patches to get 3215, iucv,
dasd, tape, lcs and ctc working with the new cio layer.
Changes worth noticing:
 * Remove the award winning channel device layer ("How to NOT write kernel
   driver"). It gets replaced by ccwgroups.
 * Overall conversion to the new device model (sysfs).
 * CIO is now completly asynchronous and has a proper state machine for
   the ccw devices. Channel path verification while the device is up 
   should work now.
 * Clean separation between a subchannel and a ccw device (not every
   subchannel is a ccw device). 
 * Better integration of qdio.
 * Rewritten tape device driver.
 * Rewritten lcs network driver.

The patch overview:

01: Kconfig and defconfig again. New options: DEBUG_KERNEL, DEBUG_SLAB,
    KALLSYMS and DEBUG_SPINLOCK_SLEEP.
02: gcc 3.3 allocates variables that are initialized to zero to the .bss
    section instead of .data. This caused some mischief with memory_size
    that is detected and stored before .bss is cleared.
03: Add s390 elf relocations to include/linux/elf.h
04: Suppress kern info message about debug levels if DEBUG is off. This
    removes quite a lot of unnecessary noise in the boot messages.
05: Adapt s390 backend to changed do_fork call.
06: Add missing include in ptrace.c
07: Documentation changes for the s390 debugging guide.
08: Remove channel device layer.
09: This is the big one: the reworked common i/o layer.  I can't see a way
    to split this into meaningful parts. It is basically: delete the old
    code, add the new code.
10: Add the ccwgroup driver. This is the replacement for chandev and is
    surprisingly simple. Grouping is done by echoing a string containing
    the subchannels identifiers of a group to an entry in the sysfs.
    E.g. for lcs "echo 0:0100,0:0101 > /sysfs/bus/ccwgroup/drivers/lcs/group".
    This creates a ccw group with the first subchannel as group leader. The
    lcs driver then creates additional attributes in 
    /sysfs/bus/ccw/devices/0:0100 that are used to configure the lcs device.
    Same method is used for ctc but with different attributes. The burden
    to find the subchannels which belong to a device is put into the
    userspace where it belongs (configure scripts).
11: Update for the documentation about the common io layer.
12: 3215 adaptions for the new channel subsystem interface.
13: sysfs changes for the iucv driver.
14: dasd changes related to the new channel subsystem driver.
15: The rewritten tape device driver.
16: Add cu3088 metadriver. ctc and lcs both use the cu type 3088. To support
    these two in the new driver model a metadriver for 3088 subchannels
    is introduced. ctc and lcs plug into it to get their subchannels. The
    3088 driver just gets all 3088 subchannels for safe-keeping until
    ctc or lcs will pick their channels at the time the ccwgroup is created.
17: Convert ctc to the new channel subsystem and 3088 driver.
18: Complete rewrite of the lcs driver. It now uses the new channel subsystem
    interface and the 3088 driver. It shrunk a lot and is imho now much
    easier to read and understand.
19: Some improvements for the rewritten sclp driver I sent last time.
    Most of them are concerned about error recovery.

I keep the finger crossed that everythings applies on the bitkeeper tree.

blue skies,
  Martin.

P.S. some of the patches are too big for lkm. I only post the description
     file on lkm. If anybody needs the patches just send me a mail and I'll
     forward them.

