Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271225AbTG2CUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271226AbTG2CUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:20:50 -0400
Received: from mgr3.xmission.com ([198.60.22.203]:36740 "EHLO
	mgr3.xmission.com") by vger.kernel.org with ESMTP id S271225AbTG2CUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:20:19 -0400
Date: Mon, 28 Jul 2003 20:19:54 -0600
From: "S. Anderson" <sa@xmission.com>
To: Pavel Rabel <pavel@xal.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Message-ID: <20030728201954.A16103@xmission.xmission.com>
References: <20030728171806.GA1860@xal.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728171806.GA1860@xal.co.uk>; from pavel@xal.co.uk on Mon, Jul 28, 2003 at 06:18:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 06:18:07PM +0100, Pavel Rabel wrote:
> Got this OOPS when trying "modprobe i810fb",
> kernel 2.6.0-test2
> 

I am also getting this oops, or somthing very simmillar.

I am new to kernel hacking, but I will try to explain what why I
think this is happening, and then hopefully someone will know how to fix
it :-).

basicly, in pci_bus_match(), when  *ids is assigned pci_drv->id_table
from a driver, (intel-agp, i810_audio and i810fb mabey others) the value
of ids->vendor is located at place where it cant be handled. Then further
up the line, the oops occurs at the pci_match_device() function when it 
tries to access ids->vendor. hopefully that makes sense.

I have added some debugging printks to pci_bus_match():

--- pci-driver.0.c      2003-07-27 15:40:56.000000000 -0600
+++ pci-driver.c        2003-07-28 19:51:47.000000000 -0600
@@ -48,6 +48,7 @@
 const struct pci_device_id *
 pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev)
 {
+       printk("pci_match_device: &ids->vendor = %p\n", &ids->vendor);
        while (ids->vendor || ids->subvendor || ids->class_mask) {
                if (pci_match_one_device(ids, dev))
                        return ids;
@@ -430,6 +431,12 @@
        if (!ids)
                return 0;
 
+       printk("pci_bus_match: bus=%d, devfn=%d %x %x\n",
+               pci_dev->bus->number, pci_dev->devfn, 
+               pci_dev->vendor,      pci_dev->device);
+       printk(" ^ matching? ^ (%s)  ((( &ids->vendor = %p )))\n", 
+                       pci_drv->name, &ids->vendor);
+
        found_id = pci_match_device(ids, pci_dev);
        if (found_id)
                return 1;

here is the output I get right before the oops + the oops run
through ksymoops

...
Adding 524280k swap on /swapfile.  Priority:-1 extents:209
mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x80000
 (pci_bus_add_devices) bus 3 devfn 0  1260 3890
pci_bus_match: bus=3, devfn=0 1260 3890
 ^ matching? ^ (agpgart-intel)  ((( &ids->vendor = c03f8e98 )))
pci_match_device: &ids->vendor = c03f8e98
Unable to handle kernel paging request at virtual address c03f8e98
 printing eip:
c01f7da3
... 

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address c03f8e98
c01f7da3
*pde = 00102027
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01f7da3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000002a   ebx: c03f8e98   ecx: 00000001   edx: c036f238
esi: c748b004   edi: c748b004   ebp: cf5fde94   esp: cf5fde84
ds: 007b   es: 007b   ss: 0068
Stack: c0327020 c03f8e98 c03a65a0 c03f8e98 cf5fdeb4 c01f84fb c03f8e98 c748b004
       ffffffed c03a65c8 c748b058 c8f12004 cf5fded0 c022b599 c748b058 c03a65c8
       c03a6610 c03a10f4 c748b058 cf5fdeec c022b62a c748b058 c03a65c8 c03a1080
Call Trace:
 [<c01f84fb>] pci_bus_match+0x5f/0x2b0
 [<c022b599>] bus_match+0x21/0x64
 [<c022b62a>] device_attach+0x4e/0x70
 [<c022b7a2>] bus_add_device+0x72/0xb4
 [<c022a0e0>] device_add+0xd0/0x108
 [<c01f4864>] pci_bus_add_devices+0x50/0x300
 [<c026186d>] cb_alloc+0xad/0xc8
 [<c025e802>] socket_insert+0x56/0xa4
 [<c025ea11>] socket_detect_change+0x69/0x70
 [<c025ec07>] pccardd+0x1ef/0x2a0
 [<c025ea18>] pccardd+0x0/0x2a0
 [<c011ae7c>] default_wake_function+0x0/0x20
 [<c011ae7c>] default_wake_function+0x0/0x20
 [<c01070c5>] kernel_thread_helper+0x5/0xc
Code: 83 3b 00 75 a0 83 7b 08 00 75 9a 83 7b 14 00 75 94 31 c0 8d


>>EIP; c01f7da3 <pci_match_device+73/90>   <=====

>>ebx; c03f8e98 <agp_intel_pci_table+0/38>
>>edx; c036f238 <log_wait+18/20>
>>esi; c748b004 <_end+7066900/3fbd98fc>
>>edi; c748b004 <_end+7066900/3fbd98fc>
>>ebp; cf5fde94 <_end+f1d9790/3fbd98fc>
>>esp; cf5fde84 <_end+f1d9780/3fbd98fc>

Trace; c01f84fb <pci_bus_match+5f/2b0>
Trace; c022b599 <bus_match+21/64>
Trace; c022b62a <device_attach+4e/70>
Trace; c022b7a2 <bus_add_device+72/b4>
Trace; c022a0e0 <device_add+d0/108>
Trace; c01f4864 <pci_bus_add_devices+50/300>
Trace; c026186d <cb_alloc+ad/c8>
Trace; c025e802 <socket_insert+56/a4>
Trace; c025ea11 <socket_detect_change+69/70>
Trace; c025ec07 <pccardd+1ef/2a0>
Trace; c025ea18 <pccardd+0/2a0>
Trace; c011ae7c <default_wake_function+0/20>
Trace; c011ae7c <default_wake_function+0/20>
Trace; c01070c5 <kernel_thread_helper+5/c>

Code;  c01f7da3 <pci_match_device+73/90>
00000000 <_EIP>:
Code;  c01f7da3 <pci_match_device+73/90>   <=====
   0:   83 3b 00                  cmpl   $0x0,(%ebx)   <=====
Code;  c01f7da6 <pci_match_device+76/90>
   3:   75 a0                     jne    ffffffa5 <_EIP+0xffffffa5> c01f7d48 <pci_match_device+18/90>
Code;  c01f7da8 <pci_match_device+78/90>
   5:   83 7b 08 00               cmpl   $0x0,0x8(%ebx)
Code;  c01f7dac <pci_match_device+7c/90>
   9:   75 9a                     jne    ffffffa5 <_EIP+0xffffffa5> c01f7d48 <pci_match_device+18/90>
Code;  c01f7dae <pci_match_device+7e/90>
   b:   83 7b 14 00               cmpl   $0x0,0x14(%ebx)
Code;  c01f7db2 <pci_match_device+82/90>
   f:   75 94                     jne    ffffffa5 <_EIP+0xffffffa5> c01f7d48 <pci_match_device+18/90>
Code;  c01f7db4 <pci_match_device+84/90>
  11:   31 c0                     xor    %eax,%eax
Code;  c01f7db6 <pci_match_device+86/90>
  13:   8d 00                     lea    (%eax),%eax


1 warning and 1 error issued.  Results may not be reliable.

