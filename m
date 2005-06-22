Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVFVOJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVFVOJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFVOJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:09:47 -0400
Received: from gw.alcove.fr ([81.80.245.157]:40121 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261274AbVFVOJI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:09:08 -0400
Subject: Re: [linux-usb-devel] usb sysfs intf files no longer created when
	probe fails
From: Stelian Pop <stelian@popies.net>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1119448257.4587.2.camel@localhost.localdomain>
References: <1119448257.4587.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Wed, 22 Jun 2005 16:07:11 +0200
Message-Id: <1119449231.4594.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 22 juin 2005 à 15:50 +0200, Stelian Pop a écrit :

> I use the 'atp' input driver from http://popies.net/atp/ to drive this
> touchpad. When removing the driver I also get an oops, possibly related
> to the previous failure to create the sysfs file:
> usbcore: deregistering driver atp
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: C009F5F8 LR: C00A1728 SP: C3AD9DE0 REGS: c3ad9d30 TRAP: 0300    Not
> tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 0000000C, DSISR: 40000000
> TASK = ccc94150[7148] 'rmmod' THREAD: c3ad8000
> Last syscall: 129
> GPR00: 00000000 C3AD9DE0 CCC94150 C6ED3D48 C02C889C DE6273C7 00000000
> 00000000
> GPR08: 00000001 C6ED3CD4 DFFF9410 00000000 64A79ADA 1001A18C 100C0000
> 100A0000
> GPR16: 00000000 100FEF88 24222482 100C0000 100F2CE8 100F2BE8 10001430
> 00000000
> GPR24: 10000000 00000000 00000000 C02C889C DE76819C DE984678 00000000
> E1074280
> NIP [c009f5f8] sysfs_hash_and_remove+0x3c/0x170
> LR [c00a1728] sysfs_remove_link+0x14/0x24
> Call trace:
> [c00a1728] sysfs_remove_link+0x14/0x24
> [c0132ebc] __device_release_driver+0x48/0x90
> [c0133030] driver_detach+0xb0/0xdc
> [c01327c8] bus_remove_driver+0x50/0x6c
> [c01332a8] driver_unregister+0x18/0x38
> [c01a1760] usb_deregister+0x3c/0x58
> [e1072cac] atp_exit+0x18/0x40c [atp]
> [c00360ac] sys_delete_module+0x19c/0x214
> [c0004660] ret_from_syscall+0x0/0x44

Some more details which may be relevant.

The atp module is automatically loaded on boot. However, it looks like
its probe function was not called or didn't succeed on the first
invocation, in the previous tests I had to remove and reload the module
to make it work.

This time however, after the rmmod, when insmod'ing it again I get:
	usbcore: deregistering driver atp
	input: atp connected
	Oops: kernel access of bad area, sig: 11 [#1]
	NIP: C00A039C LR: C00A037C SP: CD801D60 REGS: cd801cb0 TRAP: 0300
Not Tainted
	MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
	DAR: 0000000C, DSISR: 40000000
	TASK = cdea5790[4797] 'modprobe' THREAD: cd800000
	Last syscall: 128
	GPR00: DAF0F458 CD801D60 CDEA5790 DAF0F458 00000000 00000000 DAF0F47C
00000020
	GPR08: DFFF9410 DAF0F45C 0000000C DAF0F464 0A6FFDC0 1001E294 00000000
100013C4
	GPR16: 00000000 00000000 00000000 00000000 100013C4 1001EA00 1001EB70
00000000
	GPR24: 00000000 10018868 C0340000 00000000 E2273294 DE49EC80 00000000
DAF0F458
	NIP [c00a039c] sysfs_new_dirent+0x64/0x94
	LR [c00a037c] sysfs_new_dirent+0x44/0x94
	Call trace:
	[c00a03f0] sysfs_make_dirent+0x24/0x90
	[c00a1614] sysfs_add_link+0x94/0xd0
	[c00a16c8] sysfs_create_link+0x78/0xc4
	[c0132bfc] device_bind_driver+0x54/0x68
	[c0132c98] driver_probe_device+0x88/0xe4
	[c0132e34] __driver_attach+0x8c/0x98
	[c0132228] bus_for_each_dev+0x74/0xa4
	[c0132e64] driver_attach+0x24/0x34
	[c0132750] bus_add_driver+0x98/0xc0
	[c013327c] driver_register+0x38/0x4c
	[c01a16c0] usb_register+0x68/0xcc
	[e106a018] atp_init+0x18/0x48 [atp]
	[c0038268] sys_init_module+0x228/0x328
	[c0004660] ret_from_syscall+0x0/0x44

However, on my previous test I was able to rmmod the driver, reload it
again without any oops (and use it, it was functional), the oops
appeared only on the second rmmod. This looks like a synchronisation
issue somewhere...

Stelian.
-- 
Stelian Pop <stelian@popies.net>

