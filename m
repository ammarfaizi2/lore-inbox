Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVASXms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVASXms (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVASXmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:42:47 -0500
Received: from pop-a065d10.pas.sa.earthlink.net ([207.217.121.251]:14577 "EHLO
	pop-a065d10.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261985AbVASXja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:39:30 -0500
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc1 vs. PowerMac 8500/G3 (and VAIO laptop) [usb-storage oops]
Message-Id: <E1CrPQ4-0000pW-00@penngrove.fdns.net>
Date: Wed, 19 Jan 2005 15:39:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, thanks to those involved in the 2.6.10 effort, as that's the first 
kernel in quite some time that seems stable on my PowerMac 8500/G3.  It is
not quite as good on the Sony VAIO laptop, due to software suspend problems
(mostly USB related).

2.6.11-rc1 seemed to help with the VAIO laptop's problems.  However i just
discovered both have trouble with USB storage devices on the PowerMac.  In
addition, there's a minor compilation glitch:

     CC      arch/ppc/kernel/ppc_htab.o
     CC      arch/ppc/kernel/perfmon.o
   arch/ppc/kernel/perfmon.c: In function `dummy_perf':
   arch/ppc/kernel/perfmon.c:55: error: `MMCR0_PMXE' undeclared (first use in this function)
   arch/ppc/kernel/perfmon.c:55: error: (Each undeclared identifier is reported only once
   arch/ppc/kernel/perfmon.c:55: error: for each function it appears in.)
   make[1]: *** [arch/ppc/kernel/perfmon.o] Error 1
   make: *** [arch/ppc/kernel] Error 2

Conditionalizing out the offending line in dummy_perf() gets around this.

However, both a digital camera and a iomega CD/RW get the same oops on
the PPC (see below) when plugged in after booting up.  2.6.8 does not
exhibit this problem (with 2.6.9 having too many unrelated problems to
be worth testing), but both 2.6.10 and 2.6.11-rc1 do.  See below for
log extracts and .config file.

New to 2.6.11-rc1 is that 'lsusb' exhibits 'endian' problems on the PowerMac.

   Bus 004 Device 002: ID 6d04:01c0
   Bus 004 Device 001: ID 0000:0000  
   Bus 003 Device 002: ID ce0a:0112
   Bus 003 Device 001: ID 0000:0000  
   Bus 002 Device 001: ID 0000:0000  
   Bus 001 Device 001: ID 0000:0000  

Instead of

   Bus 004 Device 002: ID 046d:c001 Logitech, Inc. N48/M-BB48 [FirstMouse Plus]
   Bus 004 Device 001: ID 0000:0000  
   Bus 003 Device 002: ID 0ace:1201 GigaFast WF741-UIC Wireless 11 Mbps
   Bus 003 Device 001: ID 0000:0000  
   Bus 002 Device 001: ID 0000:0000  
   Bus 001 Device 001: ID 0000:0000  

I'm testing two USB cards (on OHCI type and the other UHCI/ECHI) and both
seem to exhibit similar symptoms.

As before, suspending the VAIO laptop breaks its firewire device (CD-RW/DVD).

		         -- JM

Attachments: 'dmesg' extracts containing 'oops' [.config upon request]
-------------------------------------------------------------------------------
	...
hub 1-0:1.0: state 5 ports 4 chg fff0 evt 0008
ehci_hcd 0000:00:0f.2: GetStatus port 3 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
hub 1-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:0f.2: port 3 full speed --> companion
ehci_hcd 0000:00:0f.2: GetStatus port 3 status 003801 POWER OWNER sig=j  CONNECT
hub 3-0:1.0: state 5 ports 2 chg fffc evt 0002
uhci_hcd 0000:00:0f.1: port 1 portsc 0093,00
hub 3-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
usb 3-1: new full speed USB device using uhci_hcd and address 3
usb 3-1: ep0 maxpacket = 8
usb 3-1: new device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-1: default language 0x0409
usb 3-1: Product: Nikon Digital Camera E4500
usb 3-1: Manufacturer: NIKON
usb 3-1: SerialNumber: 000003552010
usb 3-1: hotplug
usb 3-1: adding 3-1:1.0 (config #1, interface 0)
usb 3-1:1.0: hotplug
hub 3-0:1.0: state 5 ports 2 chg fffc evt 0002
Initializing USB Mass Storage driver...
usb-storage 3-1:1.0: usb_probe_interface
usb-storage 3-1:1.0: usb_probe_interface - got id
scsi1 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
  Vendor: NIKON     Model: NIKON DSC E4500   Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT 
NIP: C009ABA4 LR: C009ABA4 SP: C13E7DC0 REGS: c13e7d10 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0000006C, DSISR: 40000000
TASK = c12f43f0[3641] 'usb-stor-scan' THREAD: c13e6000
Last syscall: -1 
GPR00: C009ABA4 C13E7DC0 C12F43F0 C01AADE0 00000047 00000047 C13E7DF8 0000000A 
GPR08: FFFFFFFF 00008000 C258B4DC C13E7DC0 42002448 1001E284 100013A4 00000000 
GPR16: 00000000 00000000 00000000 00000000 100013A4 100187B0 00000000 C13E7F18 
GPR24: C13E7F1C 00000001 00000000 C1907708 C13E7DF8 C10E23FC C190770C 0000006C 
NIP [c009aba4] create_dir+0x38/0x1d0
LR [c009aba4] create_dir+0x38/0x1d0
Call trace:
 [c009ad98] sysfs_create_dir+0x48/0x94
 [c00ad688] create_dir+0x28/0x6c
 [c00ad98c] kobject_add+0x5c/0x15c
 [c00eaa40] device_add+0xb8/0x18c
 [c0111f9c] scsi_sysfs_add_sdev+0x78/0x39c
 [c01107c4] scsi_add_lun+0x2f8/0x364
 [c011091c] scsi_probe_and_add_lun+0xec/0x1d8
 [c0111110] scsi_scan_target+0x7c/0xec
 [c01111fc] scsi_scan_channel+0x7c/0x9c
 [c01112f4] scsi_scan_host_selected+0xd8/0x138
 [cfb86cf8] usb_stor_scan_thread+0x6c/0x124 [usb_storage]
 [c0006704] kernel_thread+0x44/0x60
===============================================================================
