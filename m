Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWEDMhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWEDMhW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 08:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWEDMhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 08:37:22 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:5530 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S932295AbWEDMhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 08:37:21 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200605041232.k44CWnFn004411@wildsau.enemy.org>
Subject: cdrom: a dirty CD can freeze your system
To: linux-kernel@vger.kernel.org
Date: Thu, 4 May 2006 14:32:48 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good day,

kernel-version: 2.6.16.13 preemptible

I've been experimenting with damaged CDs this day. I observed that
a dirty or (partly) unreadable CD will (1) block the process which is
trying to read from the CD - it will be in state "D" - uninterruptible
sleep and (2) sometimes(?) probably freeze your system such that even
a manual reboot wont work (e.g., because it's not possible to log in, or
keystrokes are no longer accepted) and a power-cycle is required.

the uninterruptible process will force a reboot - it wont go away.

one can observe that freeze in that icmp echo requests will be sent
back with several seconds delay (depending on how much buffering is
done).

the kernel log shows:
hdb: DMA timeout retry
hdb: timeout waiting for DMA
hdb: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: drive not ready for command
hdb: ATAPI reset complete
hdb: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: ATAPI reset complete
hdb: DMA timeout retry
hdb: timeout waiting for DMA
hdb: status timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: drive not ready for command
hdb: ATAPI reset complete

... and so on (so the drive is (BUSY | READY | SEEK )

even sending an "hdparm -w" to the drive wont work, in contrast, it will
make it worse because it eventuelly will trigger a kernel panic.

just for sake of completeness, data is read from the device via "SG_IO"
ioctl and "READ CD" command accorinding to the MMC specs. the program
works well for undamaged CDs.

please tell me a way to savely
(1) reset the IDE interface, e.g via IDE-TASKFILE (or, for testing,
    a sequence of outb() to the chip)
(2) reset the CD-drive - sending a WIN_DEVICE_RESET (linux/hdreg.h line 196)
    doesnt seem to be enough.

kind regards,
herbert rosmanith

