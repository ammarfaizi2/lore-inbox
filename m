Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUC0SNY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 13:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbUC0SNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 13:13:24 -0500
Received: from hal-5.inet.it ([213.92.5.24]:25240 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S261846AbUC0SNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 13:13:21 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.5-rc2-mm4 (and 3) IRQ problem
Date: Sat, 27 Mar 2004 19:13:09 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403271913.09728.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a problem with ethernet driver (e1000) on 2.6.5-rc2-mm4, here the 
syslog excerpt:

========================
Mar 27 18:39:23 kefk kernel: e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
Mar 27 18:39:23 kefk kernel: irq 18: nobody cared!
Mar 27 18:39:23 kefk kernel: Call Trace:
Mar 27 18:39:23 kefk kernel:  [<c010882b>] __report_bad_irq+0x2a/0x8b
Mar 27 18:39:23 kefk kernel:  [<c0108937>] note_interrupt+0x91/0xaf
Mar 27 18:39:23 kefk kernel:  [<c0108c4a>] do_IRQ+0x151/0x19a
Mar 27 18:39:23 kefk kernel:  [<c034b4c8>] common_interrupt+0x18/0x20
Mar 27 18:39:23 kefk kernel:  [<c0104c2e>] default_idle+0x0/0x2c
Mar 27 18:39:23 kefk kernel:  [<c0104c57>] default_idle+0x29/0x2c
Mar 27 18:39:23 kefk kernel:  [<c0104cbb>] cpu_idle+0x2e/0x3c
Mar 27 18:39:23 kefk kernel:  [<c0430a02>] start_kernel+0x196/0x1c5
Mar 27 18:39:23 kefk kernel:  [<c0430436>] unknown_bootoption+0x0/0x126
Mar 27 18:39:23 kefk kernel:
Mar 27 18:39:23 kefk kernel: handlers:
Mar 27 18:39:23 kefk kernel: [<c02a7b0b>] (ata_interrupt+0x0/0x173)
Mar 27 18:39:23 kefk kernel: [<c02d2f9c>] (usb_hcd_irq+0x0/0x67)
Mar 27 18:39:23 kefk kernel: Disabling IRQ #18
===========================

I've seen the same problem on -mm3, but that version has other problems that 
prevents me to do more tests.

A similar issue was present in earlier kernel when I've tried to use SATA 
driver compiled as modules, same behaviour, solved by compiling SATA driver 
as built-in, not as module. (I've both normal ATA and SATA controllers active 
on my mb)

under 2.6.5-rc2-mm1, this is the output of cat /proc/interrupts; as you can 
see there is also a nvidia module, but the problem arises event without that 
module. irq 18 is shared between eth0,libata and uhci_hcd.

[root@kefk root]# cat /proc/interrupts
           CPU0       CPU1
  0:    1002506          0    IO-APIC-edge  timer
  1:       4722          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  9:          0          0   IO-APIC-level  acpi
 12:       8826          0    IO-APIC-edge  i8042
 14:      11920          0    IO-APIC-edge  ide0
 15:         23          0    IO-APIC-edge  ide1
 16:     278123          0   IO-APIC-level  uhci_hcd, uhci_hcd, nvidia
 17:       2337          0   IO-APIC-level  Intel ICH5
 18:      56240          0   IO-APIC-level  libata, uhci_hcd, eth0
 19:         55          0   IO-APIC-level  uhci_hcd
 22:        279          0   IO-APIC-level  aic7xxx
 23:          0          0   IO-APIC-level  ehci_hcd
NMI:          0          0
LOC:    1002427    1002439
ERR:          0
MIS:          0

The MB is a ABIT IC7-G (i875p) ICH5, the kernel is compiled with SMP/SMT 
support active.

Please let me know if more details are needed.

A small question, not related to the above issue:
reverting 4k-stacks-always-on.patch can lead to problems or it's safe? I've to 
run nvidia binary driver so I've to use 8k instead of 4k; it would be better 
(for my standpoint) to have the possibility to disable 4k from config, but to 
do so I've to revert this patch. Apart from losing time to do a patch -R :), 
using 8k can be a problem?

Many thanks for any answer.

-- 
Fabio Coatti       http://www.ferrara.linux.it/members/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
