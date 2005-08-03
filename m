Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVHCS5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVHCS5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 14:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVHCS5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 14:57:47 -0400
Received: from pop-borzoi.atl.sa.earthlink.net ([207.69.195.70]:59380 "EHLO
	pop-borzoi.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S262397AbVHCS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 14:57:46 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: AdvanSys vs. 2.6.12.3/PPC
Message-Id: <E1E0OQo-0000tO-F5@penngrove.fdns.net>
Date: Wed, 03 Aug 2005 11:57:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an AdvanSys SCSI card which works on a PowerMac 8500/G3 under 2.4.27
(from a reasonably current Debian Installation CD), but fails when compiled
on 2.6.11.7 or 2.6.12.3, with Debian patch and local fixes applied.  It gets
as far is identifying the controller and a disk drive, but appears to hang
in 'modprobe'.  It appears to be servicing interrupts but not getting out of
sd_spinup_disk().  Alas, i can't run 2.4.27, as i need the new ZD1201 driver
which would be hard to back-port (i tried once early on, before acceptance
into 2.6).  Any clues would be gratefully appreciated!  Caveat: Driver says 
"#warning this driver is still not properly converted to the DMA API".

				-- JM

Attachments:
  Patches to advansys.c [eliminate compiler warnings plus Debian 2.4.27 patch:
			 047_advansys_le32.diff]
  kern.log extracts
  /proc/scsi/advancsys/2  [n.b. "ConnectCom.net is for sale"]
  diff of /proc/scsi/advancsys/2 taken a few seconds apart
-------------------------------------------------------------------------------
--- advansys.c.orig	2005-04-07 11:57:27.000000000 -0700
+++ advansys.c	2005-08-03 10:33:59.000000000 -0700
@@ -2051,7 +2051,8 @@
 #define ADV_VADDR_TO_U32   virt_to_bus
 #define ADV_U32_TO_VADDR   bus_to_virt
 
-#define AdvPortAddr  ulong              /* Virtual memory address size */
+//#define AdvPortAddr  ulong              /* Virtual memory address size */
+typedef void *AdvPortAddr;
 
 /*
  * Define Adv Library required memory access macros.
@@ -3148,7 +3149,7 @@
 STATIC void  DvcAdvWritePCIConfigByte(ADV_DVC_VAR *, ushort, uchar);
 STATIC ADV_PADDR DvcGetPhyAddr(ADV_DVC_VAR *, ADV_SCSI_REQ_Q *,
                 uchar *, ASC_SDCNT *, int);
-STATIC void  DvcDelayMicroSecond(ADV_DVC_VAR *, ushort);
+STATIC void  DvcDelayMicroSecond(ADV_DVC_VAR *, int);
 
 /*
  * Adv Library functions available to drivers.
@@ -3234,10 +3235,10 @@
 #define AdvWriteDWordLramNoSwap(iop_base, addr, dword) \
     ((ADV_MEM_WRITEW((iop_base) + IOPW_RAM_ADDR, (addr)), \
       ADV_MEM_WRITEW((iop_base) + IOPW_RAM_DATA, \
-                     cpu_to_le16((ushort) ((dword) & 0xFFFF)))), \
+                     ((le32_to_cpu(dword)) & 0xFFFF))), \
      (ADV_MEM_WRITEW((iop_base) + IOPW_RAM_ADDR, (addr) + 2), \
       ADV_MEM_WRITEW((iop_base) + IOPW_RAM_DATA, \
-                     cpu_to_le16((ushort) ((dword >> 16) & 0xFFFF)))))
+                     ((le32_to_cpu(dword) >> 16) & 0xFFFF))))
 
 /* Read word (2 bytes) from LRAM assuming that the address is already set. */
 #define AdvReadWordAutoIncLram(iop_base) \
@@ -11594,7 +11595,7 @@
 }
 
 STATIC void
-DvcDelayMicroSecond(ADV_DVC_VAR *asc_dvc, ushort micro_sec)
+DvcDelayMicroSecond(ADV_DVC_VAR *asc_dvc, int micro_sec)
 {
     udelay(micro_sec);
 }
-------------------------------------------------------------------------------
Aug  3 10:50:06 penngrove kernel: Linux version 2.6.12.3 (kd6pag@penngrove.fdns.net) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 Mon Aug 1 12:49:43 PDT 2005
	...
Aug  3 10:50:06 penngrove kernel: PowerMac motherboard: PowerMac 8500/8600
Aug  3 10:50:06 penngrove kernel: Memory: 223744k available (1852k kernel code, 996k data, 160k init, 0k highmem)
Aug  3 10:50:06 penngrove kernel: Calibrating delay loop... 796.67 BogoMIPS (lpj=398336)
	...
Aug  3 09:58:28 penngrove kernel: PCI: Enabling device 0000:00:0e.0 (0014 -> 0017)
Aug  3 09:58:31 penngrove kernel: scsi2 : AdvanSys SCSI 3.3K: PCI Ultra-Wide: PCIMEM 0xCFAD6000-0xCFAD603F, IRQ 0x18
Aug  3 09:58:33 penngrove kernel:   Vendor: SEAGATE   Model: ST15150N          Rev: 4611
Aug  3 09:58:33 penngrove kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Aug  3 10:56:50 penngrove kernel: SysRq : HELP : loglevel0-8 reBoot tErm Full kIll saK showMem Nice powerOff showPc unRaw Sync showTasks Unmount 
     ...
Aug  3 10:57:35 penngrove kernel: modprobe      D 0FF7F7D8     0  2856   2757                     (NOTLB)
Aug  3 10:57:35 penngrove kernel: Call trace:
Aug  3 10:57:35 penngrove kernel:  [c0006f2c] __switch_to+0x48/0x70
Aug  3 10:57:35 penngrove kernel:  [c01ca7c8] schedule+0x378/0x794
Aug  3 10:57:35 penngrove kernel:  [c01cad90] wait_for_completion+0xb4/0x158
Aug  3 10:57:35 penngrove kernel:  [c013bf40] scsi_wait_req+0x74/0xbc
Aug  3 10:57:35 penngrove kernel:  [c0146458] sd_spinup_disk+0x94/0x360
Aug  3 10:57:35 penngrove kernel:  [c0147068] sd_revalidate_disk+0x9c/0x148
Aug  3 10:57:35 penngrove kernel:  [c01472d4] sd_probe+0x1c0/0x304
Aug  3 10:57:35 penngrove kernel:  [c01149c0] driver_probe_device+0x4c/0xa0
Aug  3 10:57:35 penngrove kernel:  [c0114a6c] device_attach+0x58/0xe0
Aug  3 10:57:35 penngrove kernel:  [c0114e60] bus_add_device+0x90/0x114
Aug  3 10:57:35 penngrove kernel:  [c01134e8] device_add+0x108/0x1dc
Aug  3 10:57:35 penngrove kernel:  [c01409d4] scsi_sysfs_add_sdev+0x4c/0x1b8
Aug  3 10:57:35 penngrove kernel:  [c013ed7c] scsi_add_lun+0x308/0x360
Aug  3 10:57:35 penngrove kernel:  [c013eef4] scsi_probe_and_add_lun+0x120/0x22c
Aug  3 10:57:35 penngrove kernel:  [c013f7d0] scsi_scan_target+0xf0/0x16c
Aug  3 10:57:35 penngrove kernel: scsi_eh_2     S 00000000     0  2861      1          2968  2839 (L-TLB)
Aug  3 10:57:35 penngrove kernel: Call trace:
Aug  3 10:57:35 penngrove kernel:  [c0006f2c] __switch_to+0x48/0x70
Aug  3 10:57:35 penngrove kernel:  [c01ca7c8] schedule+0x378/0x794
Aug  3 10:57:35 penngrove kernel:  [c01ca408] __down_interruptible+0xd8/0x120
Aug  3 10:57:35 penngrove kernel:  [c013b734] scsi_error_handler+0xdc/0x100
Aug  3 10:57:35 penngrove kernel:  [c0006dc4] kernel_thread+0x44/0x60
     ...
-------------------------------------------------------------------------------
AdvanSys SCSI 3.3K: PCI Ultra-Wide: PCIMEM 0xCF916000-0xCF91603F, IRQ 0x18

ROM BIOS Version: Disabled or Pre-3.1
BIOS either disabled or Pre-3.1. If it is pre-3.1, then a newer version
can be found at the ConnectCom FTP site: ftp://ftp.connectcom.net/pub

Device Information for AdvanSys SCSI Host 2:
Target IDs Detected: 6, 7, (7=Host Adapter)

EEPROM Settings for AdvanSys SCSI Host 2:
 Serial Number: AE82A743A091
 Host SCSI ID: 7, Host Queue Size: 253, Device Queue Size: 63
 termination: 0 (Automatic), bios_ctrl: 0xffef
 Target ID:            0 1 2 3 4 5 6 7 8 9 A B C D E F
 Disconnects:          Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y
 Command Queuing:      Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y
 Start Motor:          Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y
 Synchronous Transfer: Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y
 Ultra Transfer:       Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y
 Wide Transfer:        Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y

Linux Driver Configuration and Information for AdvanSys SCSI Host 2:
 host_busy 0, last_reset 0, max_id 16, max_lun 8, max_channel 0
 unique_id 0, can_queue 253, this_id 7, sg_tablesize 255, cmd_per_lun 1
 unchecked_isa_dma 0, use_clustering 1
 flags 0xc, last_reset 0x0, jiffies 0x2c2990, asc_n_io_port 0x40
 io_port 0x800, n_io_port 0x40

Linux Driver Statistics for AdvanSys SCSI Host 2:
 queuecommand 461753, reset 0, biosparam 0, interrupt 461753
 callback 461753, done 461753, build_error 0, build_noreq 0, build_nosg 0
 exe_noerror 461753, exe_busy 0, exe_error 0, exe_unknown 0
 cont_cnt 461753, cont_xfer 4.0 kb avg_xfer 0.0 kb
 Active and Waiting Request Queues (Time Unit: 1000 HZ):
 target 6
   active: cnt [cur 0, max 1, tot 461747], time [min 0, max 3, avg 0.0]
   waiting: cnt [cur 0, max 0, tot 0], time [min 0, max 0, avg 0.0]

Adv Library Configuration and Statistics for AdvanSys SCSI Host 2:
 iop_base 0xcf916000, cable_detect: D, err_code 0
 chip_version 64, lib_version 0x50e, mcode_date 0x1593, mcode_version 0x50f
 Queuing Enabled: 6:Y
 Queue Limit: 6:63
 Command Pending: 6:0
 Wide Enabled: 6:N
 Transfer Bit Width: 6:8
 Synchronous Enabled: 6:Y
  6: Transfer Period Factor: 25 (10.0 Mhz), REQ/ACK Offset: 15
-------------------------------------------------------------------------------
--- /tmp/1.tmp [/proc/scsi/advansys/2]	2005-08-03 10:58:26.000000000 -0700
+++ /tmp/2.tmp [/proc/scsi/advansys/2]	2005-08-03 10:58:29.000000000 -0700
@@ -23,17 +23,17 @@
  host_busy 0, last_reset 0, max_id 16, max_lun 8, max_channel 0
  unique_id 0, can_queue 253, this_id 7, sg_tablesize 255, cmd_per_lun 1
  unchecked_isa_dma 0, use_clustering 1
- flags 0xc, last_reset 0x0, jiffies 0x4400c, asc_n_io_port 0x40
+ flags 0xc, last_reset 0x0, jiffies 0x44b91, asc_n_io_port 0x40
  io_port 0x800, n_io_port 0x40
 
 Linux Driver Statistics for AdvanSys SCSI Host 2:
- queuecommand 32969, reset 0, biosparam 0, interrupt 32969
- callback 32969, done 32969, build_error 0, build_noreq 0, build_nosg 0
- exe_noerror 32969, exe_busy 0, exe_error 0, exe_unknown 0
- cont_cnt 32969, cont_xfer 4.0 kb avg_xfer 0.0 kb
+ queuecommand 33461, reset 0, biosparam 0, interrupt 33461
+ callback 33461, done 33461, build_error 0, build_noreq 0, build_nosg 0
+ exe_noerror 33461, exe_busy 0, exe_error 0, exe_unknown 0
+ cont_cnt 33461, cont_xfer 4.0 kb avg_xfer 0.0 kb
  Active and Waiting Request Queues (Time Unit: 1000 HZ):
  target 6
-   active: cnt [cur 0, max 1, tot 32963], time [min 0, max 3, avg 0.0]
+   active: cnt [cur 0, max 1, tot 33455], time [min 0, max 3, avg 0.0]
    waiting: cnt [cur 0, max 0, tot 0], time [min 0, max 0, avg 0.0]
 
 Adv Library Configuration and Statistics for AdvanSys SCSI Host 2:
===============================================================================
