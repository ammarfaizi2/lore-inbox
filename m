Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289863AbSAKEQf>; Thu, 10 Jan 2002 23:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289865AbSAKEQZ>; Thu, 10 Jan 2002 23:16:25 -0500
Received: from node10450.a2000.nl ([24.132.4.80]:6016 "EHLO awacs.dhs.org")
	by vger.kernel.org with ESMTP id <S289863AbSAKEQN>;
	Thu, 10 Jan 2002 23:16:13 -0500
Date: Fri, 11 Jan 2002 05:16:12 +0100
From: Pascal Haakmat <a.haakmat@chello.nl>
To: linux-kernel@vger.kernel.org
Subject: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Message-ID: <20020111051612.A961@awacs.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having some (apparently) filesystem related problems with kernel
2.4.16-xfs-lowlatency. 

Symptoms are Oopses in fs related code (all of which seem related to fs code):

Dec 24 00:29:21 awacs kernel: Call Trace:
[xfs_inactive_free_eofblocks+17/720] [load_msg+176/240]
[block_write+1347/1376] [do_remount+122/172] [do_mount+537/740]
[kernel_thread+35/48]

Jan 8 23:39:06 awacs kernel: Call Trace: [xfs_sync+21/28]
[linvfs_write_super+43/48] [sync_supers+220/272] [sync_old_buffers+47/144]
[kupdate+297/304] [_stext+0/68] [kernel_thread+26/48] [kernel_thread+35/48]

Jan 9 02:58:59 awacs kernel: Call Trace: [do_flushpage+38/44]
[truncate_complete_page+19/72] [truncate_list_pages+286/388]
[truncate_inode_pages+98/152] [pagebuf_inval+26/32] [fs_tosspages+45/52]
[xfs_itruncate_start+143/152] [xfs_setattr+2317/4024] [xfs_setattr+0/4024]
[<e09080a8>] [<e098605c>] [<e097f90e>] [<e098605c>] [<e097b7c0>]
[linvfs_notify_change+402/444] [xfs_setattr+0/4024] [notify_change+123/288]
[do_truncate+74/96] [linvfs_permission+29/36] [open_namei+1092/1376]
[filp_open+59/92] [sys_open+54/208] [system_call+51/56]

Jan 10 21:41:38 awacs kernel: Call Trace: [xfs_sync+21/28]
[linvfs_write_super+43/48] [sync_supers+220/272] [sync_old_buffers+47/144]
[kupdate+297/304] [_stext+0/68] [kernel_thread+26/48] [kernel_thread+35/48]

... or messages like the one in the subject:

ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdc: lost interrupt

... and (perhaps) sometimes file data corruption that disappears on reboot.
The problem is quite reproducable (i.e. the machine will go down within
days) but only happens under (heavy) load or after some time has passed and
there has been some file I/O (say 50 megabytes, that is a guess).

The system is a dual 600MHz PIII on a 440GX mainboard with 512MB RAM and two
IDE disks:

MAXTOR 4K060H3  (~60GB)
Maxtor 91531U3  (~15GB)

/proc/pci:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440GX - 82443GX Host bridge (rev 0).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge (rev 0).
      Master Capable.  Latency=64.  Min Gnt=136.
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0xffa0 [0xffaf].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0xef80 [0xef9f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 2).
      IRQ 9.
  Bus  0, device  13, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 32 bit memory at 0xffafef00 [0xffafefff].
  Bus  0, device  18, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (#2) (rev 16).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xe000 [0xe0ff].
      Non-prefetchable 32 bit memory at 0xffafee00 [0xffafeeff].
  Bus  0, device  14, function  0:
    SCSI storage controller: Adaptec AHA-2940U2/W / 7890 (rev 0).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=39.Max Lat=25.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 64 bit memory at 0xffaff000 [0xffafffff].
  Bus  0, device  16, function  0:
    Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 2).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=12.Max Lat=128.
      I/O at 0xef00 [0xef3f].
  Bus  0, device  20, function  0:
    Multimedia audio controller: IC Ensemble Inc ICE1712 [Envy24] (rev 2).
      IRQ 5.
      Master Capable.  Latency=64.  
      I/O at 0xef40 [0xef5f].
      I/O at 0xefa0 [0xefaf].
      I/O at 0xef60 [0xef6f].
      I/O at 0xee80 [0xeebf].
  Bus  1, device   0, function  0:
    VGA compatible controller: Intel Corp. i740 (rev 33).
      IRQ 11.
      Prefetchable 32 bit memory at 0xf5000000 [0xf5ffffff].
      Non-prefetchable 32 bit memory at 0xff980000 [0xff9fffff].

/proc/ide/piix:

                                Intel PIIX4 Ultra 33 Chipset.
				--------------- Primary Channel
---------------- Secondary Channel -------------
                 enabled                          enabled
		 --------------- drive0 --------- drive1 -------- drive0
---------- drive1 ------
DMA enabled:    yes              yes             yes               no 
UDMA enabled:   yes              yes             yes               no 
UDMA enabled:   2                2               2                 X
UDMA
DMA
PIO

