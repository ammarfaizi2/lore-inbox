Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVHEKfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVHEKfh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVHEKdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:33:31 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:7061 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S262960AbVHEKck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:32:40 -0400
Date: Fri, 5 Aug 2005 12:40:25 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: rc5 seemed to kill a disk that rc4-mm1 likes.  Also some X trouble.
Message-ID: <20050805104025.GA14688@aitel.hist.no>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.13-rc5 seemed to kill a scsi disk (sdb) for me, where 2.6.13-rc4-mm1
have no problems with the same disk.

Machine: opteron running a x86-64 kernel, with built-in SATA as well as
a symbios scsi controller.  Two videocards running independent xservers.
The sdb disk is on the symbios controller.


Using 2.6.13-rc5 I suddenly got this in my logs:

Aug  3 22:06:00 tenkende-august -- MARK --
Aug  3 22:17:15 tenkende-august kernel: sd 0:0:0:0: ABORT operation started.
Aug  3 22:17:15 tenkende-august kernel: sd 0:0:0:0: ABORT operation timed-out.
Aug  3 22:17:15 tenkende-august kernel: sd 0:0:1:0: ABORT operation started.
Aug  3 22:17:15 tenkende-august kernel: sd 0:0:1:0: ABORT operation timed-out.
Aug  3 22:17:15 tenkende-august kernel: sd 0:0:0:0: DEVICE RESET operation start
ed.
Aug  3 22:17:15 tenkende-august kernel: sd 0:0:0:0: DEVICE RESET operation timed
-out.
Aug  3 22:17:15 tenkende-august kernel: sd 0:0:1:0: DEVICE RESET operation start
ed.
Aug  3 22:17:15 tenkende-august kernel: sd 0:0:1:0: DEVICE RESET operation timed
-out.
Aug  3 22:17:15 tenkende-august kernel: sd 0:0:0:0: BUS RESET operation started.
Aug  3 22:17:15 tenkende-august kernel: sym0: SCSI BUS reset detected.
Aug  3 22:17:15 tenkende-august kernel: sym0: SCSI BUS has been reset.
Aug  3 22:17:15 tenkende-august kernel: sd 0:0:0:0: BUS RESET operation complete
.
Aug  3 22:17:15 tenkende-august kernel:  target0:0:1: FAST-40 WIDE SCSI 80.0 MB/
s ST (25 ns, offset 31)
Aug  3 22:17:15 tenkende-august kernel: sdb: Current: sense key: No Sense
Aug  3 22:17:15 tenkende-august kernel:     Additional sense: No additional sens
e information
Aug  3 22:17:15 tenkende-august kernel: sdb: Current: sense key: No Sense
Aug  3 22:17:15 tenkende-august kernel:     Additional sense: No additional sens
e information

This "no additiomnal sense" then repeats for many screenfulls.
Two sdb partitions got dropped from RAID-1 as they failed, the
md devices got remoutned read-only.

I thought the disk had died - it was my oldest so it'd be reasonable.
Rebooting 2.6.13-rc5 did not bring the disk back - it came up useless again.

I switched back to 2.6.13-rc4-mm1 at this point for another reason,
my X display aquired a nasty tendency to go blank for no reason during work,
something I could fix by changing resolution baqck and forth.  X also tended to get
stuck for a minute now and then - a problem I haven't seen since early 2.6.

These troubles disappeared by going back to 2.6.13-rc4-mm1.  Even more interesting,
the sdb disk seems fine again.  There were no errors as I copied
all data to another disk, and no errors when I ran a badblocks write-test
(the nondestructive write test) on it. 

The two kernels have some config differences.  The 2.6.13-rc5 kernel
has ACPI+CPUFREQ configured, that the 2.6.13-rc4-mm1 doesn't have.

An lspci, in case hw driver trouble is suspected:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 
01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
0000:00:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
0000:00:06.0 Multimedia audio controller: Trident Microsystems 4DWave NX (rev 02)
0000:00:08.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] 
(rev 01)
0000:00:08.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] 
(Secondary) (rev 01)
0000:00:0b.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705 Gigabit 
Ethernet (rev 03)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID 
Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C 
PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller 
(rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller 
(rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller 
(rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 
AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01)
 
I can run more tests, but don't know what would be the most interesting.
rc5 without powermanagement?  rc4-mm1 with it? Or the newest git kernel?
Or is this the effect of some known problem?

Helge Hafting
