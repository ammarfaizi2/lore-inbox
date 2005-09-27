Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbVI0S1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVI0S1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVI0S1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:27:11 -0400
Received: from quechua.inka.de ([193.197.184.2]:52352 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1750920AbVI0S1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:27:10 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.13.2: USB wedged
Organization: private Linux site, southern Germany
From: Olaf Titz <olaf@bigred.inka.de>
Date: Tue, 27 Sep 2005 20:14:37 +0200
Message-ID: <E1EKJyP-0001lb-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes when trying to print big jobs on an HP LJ 1022 it happens
that all processes accessing USB get stuck in D state.
I captured the following relevant stack traces, but apparently this does not
include kernel threads (there was another "khubd" stuck):

Sep 27 19:45:50 bigred kernel: usb           D C04760C0     0 10777      1         12440 10778 (NOTLB)
Sep 27 19:45:50 bigred kernel: c4057d90 00000086 c66c4100 c04760c0 cee8c3c0 cfbdd180 00000296 c1315cc8
Sep 27 19:45:50 bigred kernel:        c4057da8 00000296 c1315cc8 0000071b d901b00a 00000479 c66c4100 c66c4228
Sep 27 19:45:50 bigred kernel:        c4056000 c4057e2c c4057dac c4057de4 c02c2dce 00000000 c66c4100 c0117590
Sep 27 19:45:50 bigred kernel: Call Trace:
Sep 27 19:45:50 bigred kernel:  [wait_for_completion+110/160] wait_for_completion+0x6e/0xa0
Sep 27 19:45:50 bigred kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Sep 27 19:45:50 bigred kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Sep 27 19:45:50 bigred kernel:  [pg0+273911419/1068921856] usb_start_wait_urb+0x9b/0x170 [usbcore]
Sep 27 19:45:50 bigred kernel:  [pg0+273911248/1068921856] timeout_kill+0x0/0x10 [usbcore]
Sep 27 19:45:50 bigred kernel:  [pg0+273911739/1068921856] usb_internal_control_msg+0x6b/0x80 [usbcore]
Sep 27 19:45:50 bigred kernel:  [pg0+273911913/1068921856] usb_control_msg+0x99/0xc0 [usbcore]
Sep 27 19:45:50 bigred kernel:  [pg0+273719458/1068921856] usblp_ctrl_msg+0xa2/0xd0 [usblp]
Sep 27 19:45:50 bigred kernel:  [pg0+273719834/1068921856] usblp_check_status+0x4a/0xe0 [usblp]
Sep 27 19:45:50 bigred kernel:  [pg0+273722129/1068921856] usblp_write+0x251/0x290 [usblp]
Sep 27 19:45:50 bigred kernel:  [pipe_readv+678/832] pipe_readv+0x2a6/0x340
Sep 27 19:45:50 bigred kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Sep 27 19:45:50 bigred kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Sep 27 19:45:50 bigred kernel:  [pipe_read+55/64] pipe_read+0x37/0x40
Sep 27 19:45:50 bigred kernel:  [vfs_write+428/448] vfs_write+0x1ac/0x1c0
Sep 27 19:45:50 bigred kernel:  [sys_write+81/128] sys_write+0x51/0x80
Sep 27 19:45:50 bigred kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Sep 27 19:45:50 bigred kernel: epson         D C04760C0     0 12453  12440                     (NOTLB)
Sep 27 19:45:50 bigred kernel: ce803ee0 00000082 ccd3fa20 c04760c0 c71a9b7c b7e21140 cee76280 00000000
Sep 27 19:45:50 bigred kernel:        c0147d80 cee76280 bfd3c8e8 00002b1c 20ab4836 000007c2 ccd3fa20 ccd3fb48
Sep 27 19:45:50 bigred kernel:        cf54e024 ccd3fa20 00000246 cf54e02c c02c2601 00000001 ccd3fa20 c0117590
Sep 27 19:45:50 bigred kernel: Call Trace:
Sep 27 19:45:50 bigred kernel:  [__handle_mm_fault+368/448] __handle_mm_fault+0x170/0x1c0
Sep 27 19:45:50 bigred kernel:  [__down+97/192] __down+0x61/0xc0
Sep 27 19:45:50 bigred kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Sep 27 19:45:50 bigred kernel:  [__down_failed+7/12] __down_failed+0x7/0xc
Sep 27 19:45:50 bigred kernel:  [pg0+273883692/1068921856] .text.lock.usb+0x16/0xba [usbcore]
Sep 27 19:45:50 bigred kernel:  [pg0+273949406/1068921856] usb_device_read+0x9e/0x120 [usbcore]
Sep 27 19:45:50 bigred kernel:  [vfs_read+428/448] vfs_read+0x1ac/0x1c0
Sep 27 19:45:50 bigred kernel:  [sys_read+81/128] sys_read+0x51/0x80
Sep 27 19:45:50 bigred kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

This _may_ have something to do with a flaky USB 2.0 hub/multi-card
reader combo (which sometimes disconnects, then immediately
re-connects) on the same USB 2.0 root hub as the printer.
Unfortunately I don't see in the log whether such an event has
occurred at the time the print job started.

Olaf

