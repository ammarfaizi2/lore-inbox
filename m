Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVKKPw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVKKPw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 10:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVKKPw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 10:52:58 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:2534 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S1750824AbVKKPw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 10:52:57 -0500
Date: Fri, 11 Nov 2005 16:33:55 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-kernel@vger.kernel.org
Subject: sparc64: Oops in pci_alloc_consistent with cingergyT2
Message-ID: <20051111153354.GA19838@bogon.ms20.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
when loading the cinergyT2 module I see the following Oops on sparc64:

usb 3-2: new high speed USB device using ehci_hcd and address 4
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000318
tsk->{mm,active_mm}->pgd = fffff800015c0000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
modprobe(20322): Oops [#1]
TSTATE: 0000004411009603 TPC: 0000000000423568 TNPC: 000000000042356c Y: 00000000    Not tainted
TPC: <pci_alloc_consistent+0x68/0x1a0>
g0: fffff8000225f5a0 g1: 0000000000000000 g2: 00000000b6db6db7 g3: 0000000000000000
g4: fffff80013b1d0a0 g5: 0000000000000000 g6: fffff8000225c000 g7: 0000000000000000
o0: fffff80004660000 o1: 0000000000000000 o2: 0000000000000000 o3: fffff80004660000
o4: 0000000000000000 o5: fffff80013f43810 sp: fffff8000225ee41 ret_pc: 0000000000423560
RPC: <pci_alloc_consistent+0x60/0x1a0>
l0: 0000000000000001 l1: fffff80004660000 l2: 0000000000000000 l3: 0000000000000001
l4: 0000000000000000 l5: 0000000000002000 l6: 0000000000000000 l7: 0000000070195298
i0: 0000000000000000 i1: 0000000000004000 i2: fffff80005dd0508 i3: 00000000efa01501
i4: fffff8000225c000 i5: 0000000000000002 i6: fffff8000225ef01 i7: 000000000226e3ac
I7: <cinergyt2_alloc_stream_urbs+0xc/0x120 [cinergyT2]>
Caller[000000000226e3ac]: cinergyt2_alloc_stream_urbs+0xc/0x120 [cinergyT2]
Caller[000000000226f364]: cinergyt2_probe+0x84/0x3c0 [cinergyT2]
Caller[000000000200009c]: usb_probe_interface+0x5c/0x80 [usbcore]
Caller[000000000054b7b0]: driver_probe_device+0x30/0xc0
Caller[000000000054b8e8]: __driver_attach+0x28/0x40
Caller[000000000054ae28]: bus_for_each_dev+0x48/0x80
Caller[000000000054b2ec]: bus_add_driver+0x6c/0xe0
Caller[0000000002000194]: usb_register+0x54/0xc0 [usbcore]
Caller[0000000002276008]: cinergyt2_init+0x8/0x80 [cinergyT2]
Caller[00000000004613ac]: sys_init_module+0x14c/0x220
Caller[0000000000410e54]: linux_sparc_syscall32+0x34/0x40
Caller[0000000000012758]: 0x12758
Instruction DUMP: 2b000008  4003a40f  932d5010 <c25ca030> c4584000  f058af10  a9520000  9190200f  b336700d

This is due to the fact that cinergyt2_alloc_stream_urbs calls
pci_alloc_consistent with a NULL argument for the pci dev (it's a USB
device):

cinergyt2->streambuf = pci_alloc_consistent(NULL,
                                              STREAM_URB_COUNT*STREAM_BUF_SIZE,
                                              &cinergyt2->streambuf_dmahandle);

dma_alloc_coherent doesn't seem to be implemented on sparc64, what would
be the right way to tackle this?
Cheers,
 -- Guido
