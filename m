Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262308AbSI1TIo>; Sat, 28 Sep 2002 15:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbSI1TIo>; Sat, 28 Sep 2002 15:08:44 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:38564 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262308AbSI1TIn>;
	Sat, 28 Sep 2002 15:08:43 -0400
Date: Sat, 28 Sep 2002 21:14:04 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209281914.VAA06013@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix 2.5.39 floppy driver
Cc: viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.5.39 floppy driver is still broken. Jens' fix to ll_rw_block
was included in 2.5.39, so the kernel doesn't reboot at the first
I/O operation as it did in 2.5.38, but several problems remain:

1. Accessing /dev/fd0H1440 oopses fs/block_dev.c:do_open().
   Fixed by applying Al Viro's O100-get_gendisk-C38 patch.

2. The capacity of floppies is halved.
   Fixed by applying Al Viro's O101-floppy_sizes-C38 patch.

3. /dev/fd0 size autodetection doesn't work properly. The very
   first read or write only transmits 2K (or 4K with Al's patches)
   of data. I/O works after a reopen of /dev/fd0.
   Explanation: the floppy interrupt handler updates floppy_sizes[],
   but doesn't set_capacity() on the corresponding gendisk, causing
   the detected size for /dev/fd0 to not be applied until the next
   time /dev/fd0 is opened.
   Quick fix: add the missing set_capacity() calls.
   With Al's two patches and this one floppies work reliably for me.

/Mikael

--- linux-2.5.39/drivers/block/floppy.c.~1~	Sat Sep 28 12:42:00 2002
+++ linux-2.5.39/drivers/block/floppy.c	Sat Sep 28 18:49:27 2002
@@ -778,6 +778,7 @@
 				       "disk change\n");
 			current_type[drive] = NULL;
 			floppy_sizes[TOMINOR(drive)] = MAX_DISK_SIZE << 1;
+			set_capacity(&disks[drive], floppy_sizes[TOMINOR(drive)]);
 		}
 
 		/*USETF(FD_DISK_NEWCHANGE);*/
@@ -2426,6 +2427,7 @@
 			}
 			current_type[current_drive] = _floppy;
 			floppy_sizes[TOMINOR(current_drive) ]= _floppy->size+1;
+			set_capacity(&disks[current_drive], floppy_sizes[TOMINOR(current_drive)]);
 			break;
 	}
 
@@ -2435,6 +2437,7 @@
 				_floppy->name,current_drive);
 		current_type[current_drive] = _floppy;
 		floppy_sizes[TOMINOR(current_drive)] = _floppy->size+1;
+		set_capacity(&disks[current_drive], floppy_sizes[TOMINOR(current_drive)]);
 		probing = 0;
 	}
 
