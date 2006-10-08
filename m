Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWJHHDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWJHHDe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 03:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWJHHDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 03:03:34 -0400
Received: from dvhart.com ([64.146.134.43]:1417 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750842AbWJHHDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 03:03:33 -0400
Message-ID: <4528A26F.9000804@mbligh.org>
Date: Sun, 08 Oct 2006 00:02:07 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Panic in pci_call_probe from 2.6.18-mm2 and 2.6.18-mm3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if you've seen this already ... catching up on test results.

This was on NUMA-Q, on both -mm2 and -mm3. -mm1 didn't suffer from this
problem.

Full logs:

mm2 - http://test.kernel.org/abat/50727/debug/console.log
mm3 - http://test.kernel.org/abat/51442/debug/console.log

config - http://test.kernel.org/abat/51442/build/dotconfig

I'm guessing from the 00000004 that the pcibus_to_node(dev->bus)
is failing because bus->sysdata is NULL. The disassembly and
structure offsets seem to line up for that.

#define pcibus_to_node(bus) (
	(struct pci_sysdata *)((bus)->sysdata))->node

struct pci_sysdata {
         int             domain;         /* PCI domain */
         int             node;           /* NUMA node */
};


BUG: unable to handle kernel NULL pointer dereference at virtual address 
00000004
  printing eip:
c02060d4
*pde = 0042c001
*pte = 00000000
Oops: 0000 [#1]
SMP
last sysfs file:
Modules linked in:
CPU:    2
EIP:    0060:[<c02060d4>]    Not tainted VLI
EFLAGS: 00010286   (2.6.18-mm2-autokern1 #1)
EIP is at pci_call_probe+0x19/0xb5
eax: 00000000   ebx: e778b400   ecx: e7400030   edx: c03b89a0
esi: e778b400   edi: 0000ffff   ebp: e69a2fa0   esp: e740dea4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=e740c000 task=e7400030 task.ti=e740c000)
Stack: ffffffed e778b400 c03b89a0 c02061a3 c03b89a0 e778b400 c03b873c 
c03b89a0
        e778b400 c03b89d4 c02061d6 c03b89a0 e778b400 e778b400 c03b89d4 
e778b448
        c0224800 e778b448 c03b89d4 e778b448 00000000 c03b89d4 c0224936 
e69a2fa0
Call Trace:
  [<c02061a3>] __pci_device_probe+0x33/0x47
  [<c02061d6>] pci_device_probe+0x1f/0x34
  [<c0224800>] really_probe+0x31/0xb9
  [<c0224936>] driver_probe_device+0x93/0x9c
  [<c02249b5>] __driver_attach+0x0/0x7c
  [<c02249fc>] __driver_attach+0x47/0x7c
  [<c0223e98>] bus_for_each_dev+0x47/0x6d
  [<c01fd05a>] kobject_add+0xa9/0xf2
  [<c0224a45>] driver_attach+0x14/0x18
  [<c02249b5>] __driver_attach+0x0/0x7c
  [<c022437b>] bus_add_driver+0x53/0xd0
  [<c0224d99>] driver_register+0x74/0x77
  [<c02063ea>] __pci_register_driver+0x6b/0x7a
  [<c04146c3>] qla1280_init+0xc/0xf
  [<c04007ff>] do_initcalls+0x55/0xe8
  [<c0184095>] proc_mkdir+0x12/0x16
  [<c0135136>] init_irq_proc+0x21/0x2f
  [<c01003b8>] init+0x0/0x148
  [<c010040d>] init+0x55/0x148
  [<c01033c7>] kernel_thread_helper+0x7/0x10
