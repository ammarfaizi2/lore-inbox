Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263565AbUECCjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUECCjz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUECCjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:39:55 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:38711 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263565AbUECCjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:39:48 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-rc3 ia64 smp_call_function() called with interrupts disabled
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 May 2004 12:39:44 +1000
Message-ID: <3633.1083551984@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.6-rc3, modprobe sg calls vfree() with interrupts disabled.  On
ia64, vfree calls smp_flush_tlb_all() which calls smp_call_function().
Calling smp_call_function() with interrupts disabled can deadlock.

Badness in smp_call_function at arch/ia64/kernel/smp.c:312

Call Trace:
 [<a0000001000190a0>] show_stack+0x80/0xa0
                                sp=e00001307811fc40 bsp=e0000130781191c0
 [<a000000100058a50>] smp_call_function+0x3d0/0x3e0
                                sp=e00001307811fe10 bsp=e000013078119160
 [<a000000100057e60>] smp_flush_tlb_all+0x40/0x80
                                sp=e00001307811fe30 bsp=e000013078119140
 [<a000000100142850>] unmap_vm_area+0xf0/0x120
                                sp=e00001307811fe30 bsp=e000013078119108
 [<a000000100142ed0>] remove_vm_area+0x150/0x1e0
                                sp=e00001307811fe30 bsp=e0000130781190e0
 [<a000000100142fb0>] __vunmap+0x50/0x1e0
                                sp=e00001307811fe30 bsp=e0000130781190a0
 [<a0000002002ae4d0>] sg_add+0x2d0/0xbe0 [sg]
                                sp=e00001307811fe30 bsp=e000013078119038
 [<a00000010047da40>] class_interface_register+0x1e0/0x2a0
                                sp=e00001307811fe30 bsp=e000013078119000
 [<a0000001005371b0>] scsi_register_interface+0x30/0x60
                                sp=e00001307811fe30 bsp=e000013078118fe0
 [<a0000002002d0200>] init_sg+0x140/0x190 [sg]
                                sp=e00001307811fe30 bsp=e000013078118fb8
 [<a000000100104b40>] sys_init_module+0x3c0/0x660
                                sp=e00001307811fe30 bsp=e000013078118f48
 [<a000000100011be0>] ia64_ret_from_syscall+0x0/0x20
                                sp=e00001307811fe30 bsp=e000013078118f40


