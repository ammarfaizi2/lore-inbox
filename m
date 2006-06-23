Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752055AbWFWVEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbWFWVEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbWFWVEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:04:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:28844 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752055AbWFWVEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:04:46 -0400
Date: Fri, 23 Jun 2006 17:04:24 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Linux SCSI Mailing list <linux-scsi@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>, mike.miller@hp.com
Subject: [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Message-ID: <20060623210424.GB18384@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060623210121.GA18384@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623210121.GA18384@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


o cciss driver initialization fails and hits BUG() if underlying device
  was active during the driver initialization. Device might be active
  if previous kernel crashed and this kernel is booting after that using
  kdump.

kernel BUG at drivers/block/cciss.c:2141!
invalid opcode: 0000 [#1]
last sysfs file: /class/sound/timer/dev
CPU:    0
EIP:    0060:[<c59b9ab1>]    Not tainted VLI
EFLAGS: 00010296   (2.6.16-1.2122_FC5kdump #1)
EIP is at sendcmd+0x261/0x29c [cciss]
eax: 00000045   ebx: c3300000   ecx: c36b1cf8   edx: c59bd5c5
esi: 00000000   edi: 00001388   ebp: c3ad1400   esp: c36b1d00
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 687, threadinfo=c36b1000 task=c3760aa0)
Stack: <0>00246dc0 c14aef40 00000012 00000000 c4f00480 00000000 c4f00508
c14aef40
       c59b9da0 00000024 00000000 00000000 00000000 00000000 00000000 c1006ece
       00000246 c35e2c20 000000d0 c4fddc00 c36b1db0 c3ad1400 c12b2570 c4fddc00
Call Trace:
 [<c59b9da0>] cciss_getgeometry+0xa9/0x24a [cciss]
 [<c1006ece>] dma_alloc_coherent+0xb1/0xec     [<c12b2570>]
setup_IO_APIC+0x23/0xcb5
 [<c59bc07e>] cciss_init_one+0x5cd/0x9e7 [cciss]     [<c10cdd6b>]
pci_match_device+0x13/0xb3
 [<c11284ec>] __driver_attach+0x0/0x8b     [<c10cde57>]
pci_device_probe+0x36/0x57
 [<c1128439>] driver_probe_device+0x42/0x8b     [<c112854f>]
__driver_attach+0x63/0x8b
 [<c1127f35>] bus_for_each_dev+0x33/0x55     [<c112839d>]
driver_attach+0x11/0x13
 [<c11284ec>] __driver_attach+0x0/0x8b     [<c1127c56>]
bus_add_driver+0x64/0xfd [<c10cdfe6>] __pci_register_driver+0x7f/0xa1
[<c1031ab2>] sys_init_module+0x1382/0x1514
 [<c11e0316>] do_page_fault+0x17d/0x5db     [<c1002be9>] syscall_call+0x7/0xb
Code: 00 8b b8 d4 03 00 00 81 ff 81 01 00 00 7e 0f 56 68 0d d6 9b c5 e8 53 28
66 fb 58 5a eb 0d 8b 42 04 89 0c b8 ff 02 e9 72 fe ff ff <0f> 0b 5d 08 a0 d2
9b c5 e9 65 fe ff ff 83
bd d4 03 00 00 00 7e

o If crash_boot parameter is set, then ignore the completed command messages
  sent by device which have not been issued in the context of this kernel.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.17-1M-vivek/drivers/block/cciss.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN drivers/block/cciss.c~cciss-initialization-issue-over-kdump-fix drivers/block/cciss.c
--- linux-2.6.17-1M/drivers/block/cciss.c~cciss-initialization-issue-over-kdump-fix	2006-06-23 14:04:55.000000000 -0400
+++ linux-2.6.17-1M-vivek/drivers/block/cciss.c	2006-06-23 14:08:12.000000000 -0400
@@ -1976,6 +1976,13 @@ static int add_sendcmd_reject(__u8 cmd, 
 			ctlr, complete);
 		/* not much we can do. */
 #ifdef CONFIG_CISS_SCSI_TAPE
+		/* We might get notification of completion of commands
+		 * which we never issued in this kernel if this boot is
+		 * taking place after previous kernel's crash. Simply
+		 * ignore the commands in this case.
+		 */
+		if (crash_boot)
+			return 0;
 		return 1;
 	}
 
_
