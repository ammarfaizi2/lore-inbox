Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262856AbUKRSoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbUKRSoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbUKRSnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:43:18 -0500
Received: from colino.net ([213.41.131.56]:38134 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262856AbUKRSlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:41:10 -0500
Date: Thu, 18 Nov 2004 19:38:51 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: OOPS when disconnecting usb key
Message-ID: <20041118193851.30cfaeb2.colin@colino.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs142.2 (GTK+ 2.4.9; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since 2.6.10-rc2, physically disconnecting an USB key (on which write
has been done) results in this:

usb 1-1: USB disconnect, address 5
 target2:0:0: Illegal state transition <NULL>->cancel
Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1717
Call trace:
 [c000528c] check_bug_trap+0x98/0xdc
 [c000547c] ProgramCheckException+0x1ac/0x268
 [c0004a74] ret_from_except_full+0x0/0x4c
 [c0166180] scsi_device_set_state+0xc0/0x14c
 [c0160b3c] scsi_device_cancel+0x34/0x160
 [c0160ca4] scsi_device_cancel_cb+0x18/0x28
 [c0123a10] device_for_each_child+0x64/0xe4
 [c0160cf8] scsi_host_cancel+0x44/0xc0
 [c0160d98] scsi_remove_host+0x24/0x98
 [ea1c40fc] storage_disconnect+0xa4/0x110 [usb_storage]
 [e90152a0] usb_unbind_interface+0x94/0xd4 [usbcore]
 [c0125030] device_release_driver+0x98/0x9c
 [c0125204] bus_remove_device+0x7c/0x128
 [c0123910] device_del+0xa8/0x114
 [e901cb8c] usb_disable_device+0x8c/0x11c [usbcore]
Machine check in kernel mode.
Caused by (from SRR1=141000): Transfer error ack signal
Oops: machine check, sig: 7 [#1]
NIP: 0000FD58 LR: 000003A4 SP: E4CB5CD0 REGS: e4cb5c20 TRAP: 0200    Tainted: GF
MSR: 00141000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = e71626c0[6291] 'khubd' THREAD: e4cb4000Last syscall: 120
GPR00: 00000102 E4CB5CD0 E71626C0 00000005 00030000 272A2000 7C053378 40000000
GPR08: A48100C0 00001032 40000000 24CB5CD0 C0160B50 10028814 E9030000 E7C792B8
GPR16: E4CB5F80 00000000 E7ED524C E7C792B8 00000000 00000000 E9030000 00000000
GPR24: 00000001 E71EF800 C0280000 00000000 00009032 DEF57280 E4CB5D98 0002FFF0
NIP [0000fd58] 0xfd58
LR [000003a4] 0x3a4
Call trace:
 [c0160b3c] scsi_device_cancel+0x34/0x160
 [c0160ca4] scsi_device_cancel_cb+0x18/0x28
 [c0123a10] device_for_each_child+0x64/0xe4
 [c0160cf8] scsi_host_cancel+0x44/0xc0
 [c0160d98] scsi_remove_host+0x24/0x98
 [ea1c40fc] storage_disconnect+0xa4/0x110 [usb_storage]
 [e90152a0] usb_unbind_interface+0x94/0xd4 [usbcore]
 [c0125030] device_release_driver+0x98/0x9c
 [c0125204] bus_remove_device+0x7c/0x128
 [c0123910] device_del+0xa8/0x114
 [e901cb8c] usb_disable_device+0x8c/0x11c [usbcore]
 [e9017940] usb_disconnect+0xcc/0x19c [usbcore]
 [e901945c] hub_thread+0x990/0xcac [usbcore]
 [c0006c8c] kernel_thread+0x44/0x60

I wonder whether it's due to this patchset:
http://linux.bkbits.net:8080/linux-2.5/cset@415eb179H41VOc0u6b4d_tSOe8BUeg
which adds a new way to reach the 'illegal' label.

However I did not try to back it out, I lack a bit time.
Removing the WARN_ON() in scsi_lib.c does not help.

Any idea.
-- 
Colin
  http://colino.net/323/ - Presenting the Mazda 323 Rouge
