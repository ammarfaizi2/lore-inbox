Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270548AbTGNGmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 02:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270549AbTGNGmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 02:42:24 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:28081 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S270548AbTGNGmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 02:42:19 -0400
Date: Mon, 14 Jul 2003 08:57:11 +0200
From: Ookhoi <ookhoi@humilis.net>
To: linux-kernel@vger.kernel.org
Cc: osst@linux1.onstream.nl, linux-scsi@vger.rutgers.edu
Subject: 2.5.75: Onstream DI-30 tapedrive blocks during backup
Message-ID: <20030714065710.GA30822@favonius>
Reply-To: ookhoi@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Uptime: 07:06:05 up 31 days, 17:50, 35 users,  load average: 1.00, 1.00, 1.00
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On http://www.codemonkey.org.uk/post-halloween-2.5.txt is this:

"ide_scsi is completely broken in 2.5.x. Known problem. If you need it
either use 2.4 or fix it 8)"

Which is why after a few GB of data my OnStream DI-30 tapedrive goes
belly up I assume.

I'll do my story here anyway as a datapoint.

The funny thing (to me) is, with a kernel with debugging turned on, the
machine oopses and hangs (sysrq works), while without debugging turned
on the tapedrive just stops to respond (which makes tar hang in D
state). If I eject the tape with the button on the drive and re-insert
it, I can do backups again (which never succeeds btw).


Linux version 2.5.75 (ookhoi@favonius) (gcc version 3.3.1 20030626 (Debian prerelease)) #1 Fri Jul 11 15:46:52 CEST 2003

[cut]

Kernel command line: root=/dev/hdb1 hdd=ide-scsi
ide_setup: hdd=ide-scsi

[cut]

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x6400-0x6407, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0x6408-0x640f, BIOS settings: hdc:DMA, hdd:DMA
hdb: Maxtor 6E040L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-ROM 48X/TKU, ATAPI CD/DVD-ROM drive
hdd: OnStream DI-30, ATAPI TAPE drive
ide1 at 0x170-0x177,0x376 on irq 15
hdb: max request size: 128KiB
hdb: host protected area => 1
hdb: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=79656/16/63, UDMA(66)
 hdb: hdb1

[cut]

SCSI subsystem initialized
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: E-IDE     Model: CD-ROM 48X/TKU    Rev: T40 
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: OnStream  Model: DI-30             Rev: 1.08
  Type:   Sequential-Access                  ANSI SCSI revision: 02
osst :I: Tape driver with OnStream support version 0.99.0
osst :I: $Id: osst.c,v 1.68 2002/12/23 16:33:36 riede Exp $
osst :I: Attached OnStream DI-30 tape at scsi1, channel 0, id 0, lun 0 as osst0
Bad page state at destroy_compound_page
flags:0x01080000 mapping:00000000 mapped:0 count:0
Backtrace:
Call Trace:
 [<c013511d>] bad_page+0x5d/0x90
 [<c01351bb>] destroy_compound_page+0x2b/0x90
 [<c013542b>] free_pages_bulk+0x20b/0x210
 [<c01354ec>] __free_pages_ok+0xbc/0xd0
 [<c0135dea>] __free_pages+0x3a/0x50
 [<c8965fe0>] normalize_buffer+0x40/0x70 [osst]
 [<c8965404>] os_scsi_tape_close+0x34/0x70 [osst]
 [<c014e05a>] __fput+0xea/0x100
 [<c014c8bb>] filp_close+0x4b/0x80
 [<c014c941>] sys_close+0x51/0x60
 [<c010922f>] syscall_call+0x7/0xb

Trying to fix it up, but a reboot is needed

==> This is after a few GB of data is written to the tape with tar.
    Then it goes like this and hangs:

hdd: irq timeout: status=0xd8 { Busy }
hdd: DMA disabled
ide-scsi: abort called for 980
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c011980d>] __might_sleep+0x5d/0x70
 [<c89512ca>] scsi_sleep+0x6a/0x90 [scsi_mod]
 [<c8951240>] scsi_sleep_done+0x0/0x20 [scsi_mod]
 [<c890a912>] idescsi_abort+0xa2/0xb0 [ide_scsi]
 [<c8950c17>] scsi_try_to_abort_cmd+0x47/0x60 [scsi_mod]
 [<c8950d4a>] scsi_eh_abort_cmds+0x4a/0x80 [scsi_mod]
 [<c8951715>] scsi_unjam_host+0x85/0xb0 [scsi_mod]
 [<c89517f8>] scsi_error_handler+0xb8/0xf0 [scsi_mod]
 [<c8951740>] scsi_error_handler+0x0/0xf0 [scsi_mod]
 [<c01073a9>] kernel_thread_helper+0x5/0xc

hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: drive not ready for command
hdd: status error: status=0x01 { Error }
hdd: status error: error=0x04
ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
hdd: status timeout: status=0xd1 { Busy }
ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
hdd: ATAPI reset complete


Please let me know if I should provide more info on this.
