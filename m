Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTLPPiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 10:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTLPPiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 10:38:46 -0500
Received: from mail-1.tiscali.it ([195.130.225.147]:52299 "EHLO
	mail-1.tiscali.it") by vger.kernel.org with ESMTP id S261825AbTLPPim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 10:38:42 -0500
Date: Tue, 16 Dec 2003 16:38:44 +0100
From: Luca <kronos@kronoz.cjb.net>
To: bcollins@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.0-test11] IEEE1394: sleeping function called from invalid context
Message-ID: <20031216153844.GA2806@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
on linux 2.6.0-test11 (UP with PREEMPT) when doing a "modprobe ohci1349" I
see this:

ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[e0800000-e08007ff]  Max
Packet=[2048]
Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011d446>] __might_sleep+0xa6/0xb0
 [<c013e490>] kmem_cache_alloc+0x20/0x60
 [<c011d7d2>] dup_task_struct+0x22/0x90
 [<c011e3b6>] copy_process+0xd6/0xb10
 [<c011ee62>] do_fork+0x72/0x170
 [<c011c024>] schedule+0x434/0x4f0
 [<c01cd08a>] vsnprintf+0x3aa/0x3f0
 [<c01072fe>] kernel_thread+0x6e/0x80
 [<e0a1dfd0>] nodemgr_host_thread+0x0/0x180 [ieee1394]
 [<c010727c>] kernel_thread_helper+0x0/0x14
 [<e0a1e3bd>] nodemgr_add_host+0xdd/0x120 [ieee1394]
 [<e0a1dfd0>] nodemgr_host_thread+0x0/0x180 [ieee1394]
 [<e0a1a760>] highlevel_add_host+0x30/0x70 [ieee1394]
 [<e0a19e2f>] hpsb_add_host+0x5f/0x80 [ieee1394]
 [<e09d23c3>] ohci1394_pci_probe+0x473/0x4c0 [ohci1394]
 [<c01d16ad>] pci_device_probe_static+0x2d/0x50
 [<c01d16f0>] __pci_device_probe+0x20/0x40
 [<c01d172e>] pci_device_probe+0x1e/0x40
 [<c023a512>] bus_match+0x32/0x60
 [<c023a610>] driver_attach+0x40/0x80
 [<c023a8ad>] bus_add_driver+0x7d/0xa0
 [<c023ac96>] driver_register+0x36/0x40
 [<c01d18e6>] pci_register_driver+0x56/0x80
 [<e096800e>] ohci1394_init+0xe/0x40 [ohci1394]
 [<c0134368>] sys_init_module+0x118/0x240
 [<c010906f>] syscall_call+0x7/0xb

ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000312d02c]

AFAIK the problem is that highlevel_add_host
(drivers/ieee1394/highlevel.c:401) calls ->add_host() (in this case 
nodemgr_add_host) with a rwlock and with preemption disabled. kernel_thread
ends up calling alloc_task_struct (kmem_cache_alloc with GFP_KERNEL) with 
preemption disabled.

The same thing happens when unloading the module:

Debug: sleeping function called from invalid context at kernel/sched.c:1751
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011d446>] __might_sleep+0xa6/0xb0
 [<c011c2fb>] wait_for_completion+0x1b/0xf0
 [<c01287f6>] kill_proc_info+0x46/0x60
 [<c0128a4b>] kill_proc+0x1b/0x20
 [<e0a1e475>] nodemgr_remove_host+0x35/0x60 [ieee1394]
 [<e0a1a7d4>] highlevel_remove_host+0x34/0x70 [ieee1394]
 [<e0a19eac>] hpsb_remove_host+0x5c/0x65 [ieee1394]
 [<e09d244c>] ohci1394_pci_remove+0x3c/0x1d0 [ohci1394]
 [<c01d176c>] pci_device_remove+0x1c/0x40
 [<c023a698>] device_release_driver+0x48/0x60
 [<c023a6cf>] driver_detach+0x1f/0x40
 [<c023a90a>] bus_remove_driver+0x3a/0x70
 [<c023acae>] driver_unregister+0xe/0x35
 [<c01d1920>] pci_unregister_driver+0x10/0x20
 [<e09d285d>] ohci1394_cleanup+0xd/0x20 [ohci1394]
 [<c0132a5f>] sys_delete_module+0x17f/0x1a0
 [<c01465e4>] sys_munmap+0x44/0x70
 [<c010906f>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011bc2c>] schedule+0x3c/0x4f0
 [<c0109db9>] dump_stack+0x19/0x20
 [<c011d446>] __might_sleep+0xa6/0xb0
 [<c011c37d>] wait_for_completion+0x9d/0xf0
 [<c011c130>] default_wake_function+0x0/0x20
 [<c011c130>] default_wake_function+0x0/0x20
 [<e0a1e475>] nodemgr_remove_host+0x35/0x60 [ieee1394]
 [<e0a1a7d4>] highlevel_remove_host+0x34/0x70 [ieee1394]
 [<e0a19eac>] hpsb_remove_host+0x5c/0x65 [ieee1394]
 [<e09d244c>] ohci1394_pci_remove+0x3c/0x1d0 [ohci1394]
 [<c01d176c>] pci_device_remove+0x1c/0x40
 [<c023a698>] device_release_driver+0x48/0x60
 [<c023a6cf>] driver_detach+0x1f/0x40
 [<c023a90a>] bus_remove_driver+0x3a/0x70
 [<c023acae>] driver_unregister+0xe/0x35
 [<c01d1920>] pci_unregister_driver+0x10/0x20
 [<e09d285d>] ohci1394_cleanup+0xd/0x20 [ohci1394]
 [<c0132a5f>] sys_delete_module+0x17f/0x1a0
 [<c01465e4>] sys_munmap+0x44/0x70
 [<c010906f>] syscall_call+0x7/0xb


This time highlevel_remove_host takes a rwlock and calls nodemgr_remove_host
and then we call wait_for_completion with a lock held.

Not sure about the fix... maybe hl_drivers list should be protected with a 
rw_semaphore instead of a rwlock.

Luca
PS: please CC replies
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
K.R.O.N.O.S
Kinetic Replicant Optimized for Nocturnal Observation and Sabotage
