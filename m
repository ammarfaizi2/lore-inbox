Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbUA0WMl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbUA0WMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:12:12 -0500
Received: from [212.53.96.198] ([212.53.96.198]:30428 "EHLO mail.econophone.ch")
	by vger.kernel.org with ESMTP id S265640AbUA0WHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:07:10 -0500
Subject: OOPS report: cdrecord -scanbus *after* usb device removal
From: =?ISO-8859-1?Q?Jo=EBl?= Bourquard <numlock@freesurf.ch>
Reply-To: numlock@freesurf.ch
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Message-Id: <1075241217.3851.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 23:06:58 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, I've had lots of fun with the 2.6 kernels. They work
great, faster, and I hope they become the standard soon. A big thanks to
the developers !

Ok. This is my first bug report, so if anything is missing, please tell
me. Thanks.

Kernel is 2.6.2-rc2 with the following things added:
- LUFS
- cryptoloop
- vmware
- small unusual_devs.h and wlan monitor patch.

I can reproduce a OOPS every time I do this:
1 - connect my usb2.0 cd-rw drive
2 - "cdrecord -scanbus"
3 - disconnect the drive
4 - "cdrecord -scanbus"

Disconnection is fine, but an OOPS happens in step 4, every time I
tried. This is probably valid for all 2.6.x. The 2.5.x versions had an
issue with my NEC USB2 controller, so I didn't use them.

The following things gets logged during the procedure:
=====================================================================
hub 1-0:1.0: new USB device on port 2, assigned address 2
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: GENERIC   Model: CDRCB02           Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
request_module: failed /sbin/modprobe -- char-major-97-0. error = 256
usb 1-2: USB disconnect, address 2
Unable to handle kernel paging request at virtual address 312f322d
printing eip:
c0161c49
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0161c49>]    Tainted: P  
EFLAGS: 00010202
EIP is at cdev_get+0x29/0xc0
eax: d8624000   ebx: 312f322d   ecx: 00000015   edx: d8625f28
esi: 00000001   edi: d93a52a0   ebp: d8624000   esp: d8625ed4
ds: 007b   es: 007b   ss: 0068
Process cdrecord (pid: 5188, threadinfo=d8624000 task=d93ee120)
Stack: debd4260 d9072300 d93a52a0 00000000 c0161b2f d93a52a0 c0221f8d
01500000 
       d93a52a0 dea2ecd8 d8624000 c0161b10 00000000 d8624000 00000000
00000000 
       00000000 c01619c1 df760c00 01500000 d8625f28 00000000 d85a4d40
dea2ecd8 
Call Trace:
[<c0161b2f>] exact_lock+0xf/0x20
[<c0221f8d>] kobj_lookup+0xfd/0x200
[<c0161b10>] exact_match+0x0/0x10
[<c01619c1>] chrdev_open+0x191/0x210
[<c01575bb>] dentry_open+0x14b/0x220
[<c0157468>] filp_open+0x68/0x70
[<c015791b>] sys_open+0x5b/0x90
[<c010b489>] sysenter_past_esp+0x52/0x71

Code: 83 3b 02 0f 84 7d 00 00 00 ff 83 a0 00 00 00 b8 00 e0 ff ff 
<6>note: cdrecord[5188] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
[<c011fcb7>] schedule+0x597/0x5a0
[<c0148afb>] zap_pmd_range+0x4b/0x70
[<c0148b6b>] unmap_page_range+0x4b/0x80
[<c0148d76>] unmap_vmas+0x1d6/0x230
[<c014cc88>] exit_mmap+0x78/0x190
[<c0121715>] mmput+0x65/0xc0
[<c0125761>] do_exit+0x151/0x3e0
[<c010c57c>] die+0xec/0xf0
[<c011dd79>] do_page_fault+0x1f9/0x519
[<c01400ee>] buffered_rmqueue+0xbe/0x160
[<c014023f>] __alloc_pages+0xaf/0x360
[<c013c21c>] find_get_page+0x2c/0x60
[<c013d3bf>] filemap_nopage+0x26f/0x370
[<c011db80>] do_page_fault+0x0/0x519
[<c010bee5>] error_code+0x2d/0x38
[<c0161c49>] cdev_get+0x29/0xc0
[<c0161b2f>] exact_lock+0xf/0x20
[<c0221f8d>] kobj_lookup+0xfd/0x200
[<c0161b10>] exact_match+0x0/0x10
[<c01619c1>] chrdev_open+0x191/0x210
[<c01575bb>] dentry_open+0x14b/0x220
[<c0157468>] filp_open+0x68/0x70
[<c015791b>] sys_open+0x5b/0x90
[<c010b489>] sysenter_past_esp+0x52/0x71
=====================================================================

Hope this helps !

Regards,
Joël

