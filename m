Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUCBD3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 22:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbUCBD3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 22:29:52 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:39031 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261545AbUCBD3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 22:29:47 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-rc1: OOPS when daisy-chaining ieee1394 devices
Date: Mon, 1 Mar 2004 22:29:34 -0500
User-Agent: KMail/1.6
Cc: Ben Collins <bcollins@debian.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403012229.35742.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Got the following oops when trying to power up DVD burner daisy chained to
a WD hard drive. Reproducible with latest -bk as well as with ieee1394 patch
from -mm tree. This is a regression as it was somewhat worked with earlier
2.6 kernels (well, earlier kernels could only log in into the last powered
device, reconnecting to devices sitting earlier in chain was always failing),
but there was no oopses.

Mar  1 17:33:59 core kernel: ohci1394: fw-host0: SelfID received, but NodeID invalid (probably new bus reset occurred): 0000FFC0
Mar  1 17:33:59 core kernel: ieee1394: Error parsing configrom for node 0-00:1023
Mar  1 17:33:59 core kernel: ieee1394: Node changed: 0-00:1023 -> 0-01:1023
Mar  1 17:34:07 core kernel: ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0030e001e0ac0f63]
Mar  1 17:34:08 core kernel: SCSI subsystem initialized
Mar  1 17:34:08 core kernel: sbp2: $Rev: 1144 $ Ben Collins <bcollins@debian.org>
Mar  1 17:34:08 core kernel: scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
Mar  1 17:34:09 core kernel: ieee1394: sbp2: Logged into SBP-2 device
Mar  1 17:34:09 core kernel: ieee1394: sbp2: Node 0-00:1023: Max speed [S400] - Max payload [2048]
Mar  1 17:34:09 core kernel:   Vendor: WDC WD20  Model: 00JB-00DUA3       Rev:
Mar  1 17:34:09 core kernel:   Type:   Direct-Access                      ANSI SCSI revision: 06
Mar  1 17:34:09 core kernel: SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
Mar  1 17:34:09 core kernel: sda: asking for cache data failed
Mar  1 17:34:09 core kernel: sda: assuming drive cache: write through
Mar  1 17:34:09 core kernel:  sda: sda1
Mar  1 17:34:09 core kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Mar  1 17:34:24 core kernel: kjournald starting.  Commit interval 5 seconds

<at this point I powered up DVD>

Mar  1 18:10:38 core kernel: ieee1394: Error parsing configrom for node 0-00:1023
Mar  1 18:10:38 core kernel: ieee1394: Node changed: 0-00:1023 -> 0-01:1023
Mar  1 18:10:38 core kernel: ieee1394: Node changed: 0-01:1023 -> 0-02:1023
Mar  1 18:10:38 core kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Mar  1 18:10:38 core kernel:  printing eip:
Mar  1 18:10:38 core kernel: e1b3b8d8
Mar  1 18:10:38 core kernel: *pde = 00000000
Mar  1 18:10:38 core kernel: Oops: 0000 [#1]
Mar  1 18:10:38 core kernel: PREEMPT
Mar  1 18:10:38 core kernel: CPU:    0
Mar  1 18:10:38 core kernel: EIP:    0060:[<e1b3b8d8>]    Tainted: P
Mar  1 18:10:38 core kernel: EFLAGS: 00010282
Mar  1 18:10:38 core kernel: EIP is at __this_module+0x78/0xffffe3d4 [sd_mod]
Mar  1 18:10:38 core kernel: eax: e1b3e1e1   ebx: d409e5e1   ecx: 00000004   edx: dfd7f264
Mar  1 18:10:38 core kernel: esi: e1b3b860   edi: d409e544   ebp: dfd63f44   esp: dfd63f2c
Mar  1 18:10:38 core kernel: ds: 007b   es: 007b   ss: 0068
Mar  1 18:10:38 core kernel: Process knodemgrd_0 (pid: 10, threadinfo=dfd62000 task=dfe06060)
Mar  1 18:10:38 core kernel: Stack: c0249d73 d409e544 d409e57c d409e57c d9dea0c8 d9dea078 dfd63f60 c0249d3b
Mar  1 18:10:38 core kernel:        d409e544 d9dea0b0 d9dea0b0 d2beee50 d2beee00 dfd63f7c c0249d3b d9dea078
Mar  1 18:10:38 core kernel:        d2beee38 d2beee38 ce576458 00000004 dfd63f9c c0249e5b d2beee00 00000002
Mar  1 18:10:38 core kernel: Call Trace:
Mar  1 18:10:38 core kernel:  [<c0249d73>] nodemgr_ud_update_pdrv+0x83/0xd0
Mar  1 18:10:38 core kernel:  [<c0249d3b>] nodemgr_ud_update_pdrv+0x4b/0xd0
Mar  1 18:10:38 core kernel:  [<c0249d3b>] nodemgr_ud_update_pdrv+0x4b/0xd0
Mar  1 18:10:38 core kernel:  [<c0249e5b>] nodemgr_probe_ne+0x9b/0xc0
Mar  1 18:10:38 core kernel:  [<c0249ed6>] nodemgr_node_probe+0x56/0xa0
Mar  1 18:10:38 core kernel:  [<c024a27a>] nodemgr_host_thread+0x16a/0x1a0
Mar  1 18:10:38 core kernel:  [<c024a110>] nodemgr_host_thread+0x0/0x1a0
Mar  1 18:10:38 core kernel:  [<c01072d9>] kernel_thread_helper+0x5/0xc
Mar  1 18:10:38 core kernel:
Mar  1 18:10:38 core kernel: Code: 80 39 00 00 00 00 00 00 34 1c 00 00 00 00 00 00 01 00 00 00

-- 
Dmitry
