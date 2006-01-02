Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWABNfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWABNfQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 08:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWABNfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 08:35:16 -0500
Received: from pat.uio.no ([129.240.130.16]:51438 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750720AbWABNfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 08:35:14 -0500
Date: Mon, 2 Jan 2006 14:35:07 +0100
From: Haakon Riiser <haakon.riiser@fys.uio.no>
To: linux-kernel@vger.kernel.org
Subject: Panic in SCSI subsystem
Message-ID: <20060102133507.GA1664@fox.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.95, required 12,
	autolearn=disabled, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, a little information on my current system:

  Distro: Fedora Core 3 (fully updated)
  Kernel: 2.6.12-1.1381_FC3 (the bug also occurs on the latest 2.6.14 kernel
          from Fedora Core 4)
  Motherboard: Asus K8V SE Deluxe (Socket 754, VIA K8T800)
  CPU: Sempron 3000+
  Memory: 2 x TwinMOS 256 MB DDR400 (CL2.5)
  PATA disk: Maxtor 6Y160P0
  SATA disks: 4 x 250 GB Seagate Barracuda 7200.8 SATA NCQ
  SATA controller: Promise SATA-II 150 TX4 PCI

The system boots from the PATA disk, which among other things
contains the OS.  The four SATA disks are set up in a software
RAID5 array using mdadm, and this is where I store all my important
data.

Until recently, this file server contained a 650 MHz Pentium III
CPU and an Asus P3B-F motherboard.  This configuration worked
flawlessly.

After upgrading the motherboard/CPU/memory on my file server to
the configuration listed on top, I started getting kernel panics
in the SCSI subsystem.  Once it happens, the machine freezes
completely, so I only have the logs that appear on screen.
The following is copied down by hand, so I left out the full
memory adresses preceeding each line in the stack trace:

  ata7: called with no error (51)!
  Kernel panic - not syncing: drivers/scsi/scsi.c:297: spin_is_locked
   on uninitialized spinlock deadc014. (Not tainted)

  panic+0x42/0x1c0
  scsi_put_command+0x19c/0x2bf [scsi_mod]
  scsi_next_command+0xc/0x14 [scsi_mod]
  scsi_end_request+0xed/0x200 [scsi_mod]
  mempool_free+0x67/0x1aa
  scsi_io_completion+0x151/0x4d4 [scsi_mod]
  sd_rw_intr+0x156/0x30f [sd_mod]
  scsi_finish_command+0x8e/0xc1 [scsi_mod]
  net_rx_action+0xbb/0x2bc
  scsi_softirq+0x9d/0xcd [scsi_mod]
  __do_softirq+0x3e/0x8a
  do_softirq+0x39/0x40
  =======================================
  do_IRQ+0x53/0x85
  common_interrupt+0x1a/0x20
  acpi_processor_idle+0x01/0x27f
  acpi_processor_idle+0x101/0x27f
  cpu_idle+0x3c/0x51
  start_kernel+0x175/0x1b1
  unknown_bootoption+0x0/0x1b0

The above log isn't the same every time, but it always includes
SCSI related stuff like scsi_finish_command.  I upgraded around
a month ago, and until yesterday, it only crashed three or four
times.  Now, after the last crash, the time between crashes has
been reduced from about a week to about five minutes -- the system
is completely unusable!  I noticed that every time I boot the
system, the RAID array starts the resyncing process.  It always
crashes before finishing, forcing it to start from scratch on
every boot.  I'm guessing that the stress from the resync operation
is what's causing it to crash within five minutes.  I don't know
what prompted it to start resyncing in the first place, though.
(Btw, how dangerous is a crash in the resync process?  Is there
a high risk of data corruption?)

Until I know more, I have downgraded to my old CPU/motherboard.
It's still resyncing, so I don't know if the problem has gone away,
but it's been up for almost 100 minutes, and I still haven't seen a
single "ataN: called with no error (51)!" that usually preceeds the
kernel panic, so I think it's still working with my old hardware.

One last thing:  The new motherboard actually has four SATA
connectors (two that connects to an onboard Promise TX2 controller,
and two that connects to an onboard VIA controller), so I tried
taking out my Promise TX4 card, and connecting the disks to the
onboard connectors.  This didn't make any difference -- the system
panics in exactly the same way as before.

Any help is greatly appreciated!

-- 
 Haakon
