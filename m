Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266550AbUFWNEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUFWNEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 09:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266571AbUFWNEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 09:04:13 -0400
Received: from smtp-out4.xs4all.nl ([194.109.24.5]:9745 "EHLO
	smtp-out4.xs4all.nl") by vger.kernel.org with ESMTP id S266550AbUFWNDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 09:03:20 -0400
Message-ID: <20040623150316.vhnnok480socc00o@www.wagland.net>
Date: Wed, 23 Jun 2004 15:03:16 +0200
From: Paul Wagland <paul@kungfoocoder.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: 2.6.7 Oops loading the aic79xx module
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We have had a problem in the recent past with severe instability on one of our
primary file servers, one of the differences on this machine was that hotplug
was updated, and it seemed to be a little more aggressive in loading modules,
in particular it was loading the aic79xx module for SCSI card. That's fine, but
this card has no attached devices, and we hypothesise that it was the Oops that
occurred when loading this driver that was the cause of the instability. We
have modified hotplug so that it now blacklists this driver, since we don't
uyse it anyway, but I thought that I would report this to the lists...

Anyway, here is the Oops:

--------------
hub 1-0:1.0: 4 ports detected
kobject_register failed for aic79xx (-17)
 [<c01b3c1b>] kobject_register+0x5b/0x60
 [<c0204310>] bus_add_driver+0x50/0xb0
 [<c01be59e>] pci_register_driver+0x6e/0xa0
 [<f925ad0f>] ahd_linux_pci_init+0xf/0x20 [aic79xx]
 [<f9251d05>] ahd_linux_detect+0x45/0x90 [aic79xx]
 [<f912500f>] ahd_linux_init+0xf/0x22 [aic79xx]
 [<c013ab98>] sys_init_module+0x118/0x240
 [<c01061fb>] syscall_call+0x7/0xb

Unable to handle kernel paging request at virtual address f927667c
 printing eip:
c01b3b30
*pde = 3507d067
*pte = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: tg3 ohci_hcd usbcore serverworks ide_core cfi_probe gen_probe
scb2_flash mtdcore chipreg map_funcs sworks_agp agpgart evdev rtc reiserfs ext3
jbd mbcache dm_mod cciss scsi_mod unix
CPU:    0
EIP:    0060:[<c01b3b30>]    Not tainted
EFLAGS: 00010292   (2.6.7-686-smp-pw-1)
EIP is at kobject_add+0x70/0x100
eax: c030dea4   ebx: f9147d00   ecx: f927667c   edx: f9147d1c
esi: ffffffea   edi: c030deac   ebp: f9147ce4   esp: f6f17f3c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1289, threadinfo=f6f16000 task=c29e4230)
Stack: c030deac f9147d00 f9147d00 ffffffea 00000000 c01b3be8 f9147d00 f9147d00
       c030de40 f9147d00 c030de40 c0204310 f9147d00 f913fc5a f9147cc0 00000001
       f9147d60 c02d5784 c01be59e f9147ce4 c02d57a0 f9147de0 f6f16000 f912500f
Call Trace:
 [<c01b3be8>] kobject_register+0x28/0x60
 [<c0204310>] bus_add_driver+0x50/0xb0
 [<c01be59e>] pci_register_driver+0x6e/0xa0
 [<f912500f>] tg3_init+0xf/0x1b [tg3]
 [<c013ab98>] sys_init_module+0x118/0x240
 [<c01061fb>] syscall_call+0x7/0xb

Code: 89 11 89 4a 04 8b 43 28 8b 30 8d 4e 48 89 c8 ba ff ff 00 00
 <6>NET: Registered protocol family 17
ACPI: Processor [CPU0] (supports C1)
---------------

Here is the output from lspci on the device:
---------------
% sudo lspci -vv -s 1:3
0000:01:03.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev
01)
        Subsystem: Compaq Computer Corporation Compaq 64-Bit/66MHz Dual Channel
Wide Ultra3 SCSI Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 15
        BIST result: 00
        Region 0: I/O ports at 3000
        Region 1: Memory at f7ef0000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:03.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev
01)
        Subsystem: Compaq Computer Corporation Compaq 64-Bit/66MHz Dual Channel
Wide Ultra3 SCSI Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin B routed to IRQ 15
        BIST result: 00
        Region 0: I/O ports at 3400
        Region 1: Memory at f7ee0000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
---------------

If there is any more information that we can provide, please let me know and I
will try to provide it. There is a possibility of testing fixes on the machine,
but only if they have a high confidence, since this is a production box...

Cheers,
Paul
