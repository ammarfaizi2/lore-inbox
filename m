Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263280AbSLaQHm>; Tue, 31 Dec 2002 11:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSLaQHm>; Tue, 31 Dec 2002 11:07:42 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:39113 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S263280AbSLaQH2>;
	Tue, 31 Dec 2002 11:07:28 -0500
Date: Tue, 31 Dec 2002 17:15:35 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212311615.RAA24207@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org
Subject: [PATCH] ide-scsi ref count bug & oops in 2.4.20-ac2/2.4.21-pre2
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug affects modular ide-scsi in 2.4.20-ac2 and 2.4.21-pre2.
Inserting the ide-scsi module and letting it control an odd number
of drives, and then rmmod:ing ide-scsi, results in the following:

(after inserting ide-scsi; hdc is my CD writer)
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PHILIPS   Model: CDRW2412A         Rev: P1.5
  Type:   CD-ROM                             ANSI SCSI revision: 02

(after rmmod ide-scsi)
scsi : 0 hosts left.
idescsi_cleanup: hdc: failed to unregister! 
hdc: usage 0, busy 0, driver d08a00e0, Dbusy 1
hdc: exit_idescsi_module() called while still busy

Rebooting after this then triggers an oops in ide.c:ide_notify_reboot()'s
call to DRIVER(drive)->cleanup(drive), since DRIVER(drive) [hdc] still
points to the idescsi_driver structure in the unloaded ide-scsi module.

It turns out that there is a long-standing reference counting bug
in all versions of ide-scsi in current 2.2/2.4/2.5 kernels: ide-scsi
abuses DRIVER(drive)->busy as an integer counter when in fact ->busy
is only a 1-bit field.

In 2.4.20-ac2/2.4.21-pre2, idescsi_driver.busy is zero after init
because idescsi_setup() does one ++ and one -- for each drive.
At "rmmod ide-scsi", idescsi_release() does a DRIVER(drive)->busy--
on each ide-scsi drive. Since they all point to the same idescsi_driver,
idescsi_driver.busy is decremented to -(number of drives) % 2.
With an odd number of ide-scsi drives, the driver is marked busy,
idescsi_cleanup() fails to clean up, and ide_notify_reboot() oopses.

ide-scsi.c in other kernels (2.2, 2.4 before 20-ac2/21-pre2, 2.5) also
abuses DRIVER(drive)->busy, but there it has two complementary bugs
that cancel each other. idescsi_setup() increments ->busy for each
ide-scsi drive, and idescsi_release() decrements ->busy for each drive.
busy equals (number of drives) % 2 while ide-scsi is loaded, but is
zero as the module is being removed. ide-scsi unloads cleanly, but ->busy
clearly incorrect and useless.

The patch below applies to 2.4.20-ac2 and 2.4.21-pre2. It's a minimal
fix: instead of decrementing busy, idescsi_release() sets busy to zero
since that's the only valid value at this point. Tested & works for me.

Long-term, someone needs to decide whether idescsi_release() really
needs to loop over all drives. They all point to idescsi_driver, so
a single "idescsi_driver.busy = 0;" should suffice.

/Mikael

--- linux-2.4.20-ac2/drivers/scsi/ide-scsi.c.~1~	2002-12-31 15:31:12.000000000 +0100
+++ linux-2.4.20-ac2/drivers/scsi/ide-scsi.c	2002-12-31 15:59:53.000000000 +0100
@@ -900,7 +900,7 @@
 	for (id = 0; id < MAX_HWIFS * MAX_DRIVES; id++) {
 		drive = idescsi_drives[id];
 		if (drive)
-			DRIVER(drive)->busy--;
+			DRIVER(drive)->busy = 0;
 	}
 	return 0;
 }
