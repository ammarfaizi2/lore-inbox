Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265368AbSKFOTg>; Wed, 6 Nov 2002 09:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265381AbSKFOTa>; Wed, 6 Nov 2002 09:19:30 -0500
Received: from signup.localnet.com ([207.251.201.46]:2455 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S265368AbSKFOTR>;
	Wed, 6 Nov 2002 09:19:17 -0500
To: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net
Subject: 2.5 bk current ohci1394 breakage
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 06 Nov 2002 09:25:42 -0500
Message-ID: <m3wunqkc61.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been partially able to upgrade to 2.5, but am unable to use my
sbp2 disk (where all my bk clones and other source mirrors are).

Booted into bk 2.5.46+ current as of a few hours ago (I cannot access
the bk tree, so I cannot specify the exact cset) with init=/bin/bash
for testing, I get this when modprobing 1394 modules:

modprobe ieee1394 is OK.

modprobe ohci1394 gives:

ohci1394: $Rev: 601 $ Ben Collins <bcollins@debian.org>
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[f6ffd000-f6ffd7ff]  Max Packet=[2048]
Debug: sleeping function called from illegal context at mm/page_alloc.c:428
Call Trace:
 [<c0116b28>] __might_sleep+0x54/0x5c
 [<c0133dcc>] __alloc_pages+0x24/0x254
 [<c0216cb7>] scrup+0x6b/0xf8
 [<c0134024>] __get_free_pages+0x28/0x60
 [<c0116dd3>] dup_task_struct+0x47/0xbc
 [<c0117808>] copy_process+0xa0/0xa90
 [<c011826c>] do_fork+0x74/0x128
 [<c0118de6>] __call_console_drivers+0x3e/0x50
 [<c0108967>] kernel_thread+0x77/0x8c
 [<e08184f8>] nodemgr_host_thread+0x0/0xa0 [ieee1394]
 [<c01088e4>] kernel_thread_helper+0x0/0xc
 [<e0818776>] nodemgr_add_host+0x8a/0xf0 [ieee1394]
 [<e08184f8>] nodemgr_host_thread+0x0/0xa0 [ieee1394]
 [<e0815bd8>] highlevel_add_host+0x30/0x5c [ieee1394]
 [<e081574c>] hpsb_add_host+0x40/0x58 [ieee1394]
 [<e08219c7>] ohci1394_pci_probe+0x49f/0x4b4 [ohci1394]
 [<e08236e8>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<c01caa99>] pci_device_probe+0x41/0x5c
 [<e0823674>] ohci1394_pci_tbl+0x0/0x38 [ohci1394]
 [<e08236e8>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<e08236e8>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<e08236c0>] ohci1394_pci_driver+0x0/0xa0 [ohci1394]
 [<c0208077>] bus_match+0x37/0x60
 [<c0208170>] driver_attach+0x4c/0x80
 [<e08236e8>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<e08236e8>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<e0823700>] ohci1394_pci_driver+0x40/0xa0 [ohci1394]
 [<c0208428>] bus_add_driver+0x60/0x80
 [<e08236e8>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<e08236e8>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<e0821d68>] .rodata+0x88/0x780 [ohci1394]
 [<e0823710>] ohci1394_pci_driver+0x50/0xa0 [ohci1394]
 [<c02089f5>] driver_register+0x69/0x84
 [<e08236e8>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<c01cab92>] pci_register_driver+0x42/0x54
 [<e08236e8>] ohci1394_pci_driver+0x28/0xa0 [ohci1394]
 [<e0821caf>] ohci1394_init+0xb/0x3c [ohci1394]
 [<e08236c0>] ohci1394_pci_driver+0x0/0xa0 [ohci1394]
 [<c011a12d>] sys_init_module+0x515/0x5ec
 [<e081f060>] get_phy_reg+0x0/0xa8 [ohci1394]
 [<c010a3bf>] syscall_call+0x7/0xb

ieee1394: Host added: Node[00:1023]  GUID[424fc0002de51021]  [Linux OHCI-1394]

A mod probe of sbp2 without a cable in the 1394 port works, but when a
drive in connected a modprobe of sbp2 gives another call trace and
locks up the box hard.  SysRq worked once to reboot but usually even
it would not do anything.

Obviously from the call trace above the bug is in the helper thread.  
That function looks like:

patch    1.12 | static int nodemgr_host_thread(void *__hi)
patch    1.12 | {
patch    1.12 | 	struct host_info *hi = (struct host_info *)__hi;
patch    1.12 | 
patch    1.12 | 	/* No userlevel access needed */
patch    1.12 | 	daemonize();
patch    1.12 | 
bcollins 1.13 | 	strcpy(current->comm, "knodemgrd");
bcollins 1.15 | 	
patch    1.12 | 	/* Sit and wait for a signal to probe the nodes on the bus. This
bcollins 1.13 | 	 * happens when we get a bus reset. */
bcollins 1.15 | 	while (!down_interruptible(&hi->reset_sem) &&
bcollins 1.15 | 	       !down_interruptible(&nodemgr_serialize)) {
bcollins 1.13 | 		nodemgr_node_probe(hi->host);
bcollins 1.15 | 		up(&nodemgr_serialize);
bcollins 1.15 | 	}
patch    1.12 | #ifdef CONFIG_IEEE1394_VERBOSEDEBUG
patch    1.12 | 	HPSB_DEBUG ("NodeMgr: Exiting thread for %s", hi->host->driver->name);
patch    1.12 | #endif
patch    1.12 | 
patch    1.12 | 	complete_and_exit(&hi->exited, 0);
patch    1.12 | }

Above from linux.bkbits.net; the code at svn.linux1394.org is the same
in TRUNK.

Does something in the while loop need to change to work with current
kernels?

-JimC

