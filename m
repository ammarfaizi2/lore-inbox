Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269027AbUHXAmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269027AbUHXAmU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUHXAkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:40:37 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:32511 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267516AbUHWTpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:45:09 -0400
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: "cramerj" <cramerj@intel.com>, "Ronciak, John" <john.ronciak@intel.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>,
       <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [broken?] Add MSI support to e1000
X-Message-Flag: Warning: May contain useful information
References: <C7AB9DA4D0B1F344BF2489FA165E50240619D9DA@orsmsx404.amr.corp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 23 Aug 2004 12:39:01 -0700
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E50240619D9DA@orsmsx404.amr.corp.intel.com> (Tom
 L. Nguyen's message of "Mon, 23 Aug 2004 12:09:36 -0700")
Message-ID: <521xhxve3u.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Aug 2004 19:39:01.0670 (UTC) FILETIME=[D7577460:01C48948]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Tom> MSI is an edge trigger, which requires the synchronization
    Tom> handshake between the hardware device and its software device
    Tom> driver. For the MSI-X capability structure, the kernel
    Tom> handles the synchronization by masking and unmasking the MSI
    Tom> maskbits. For the MSI capability structure, the MSI maskbits
    Tom> is optional. If the e1000 hardware does not support the MSI
    Tom> maskbits in its MSI capability structure, I guess it could be
    Tom> a race condition in e1000 hardware, which results an
    Tom> unpredictable behavior.

It seems e1000 does not support the per-vector masking feature of MSI
(see full PCI header dump below).

However if I understand the x86 APIC properly, even without masking,
edge-triggered MSI interrupts should work OK.  As I understand it,
when the interrupt is dispatched, its bit is moved from the IRR to the
ISR.  If the same interrupt is received while the interrupt handler is
running, its bit will be set again in the IRR and it will be
dispatched again as soon as the handler exits.

It seems this should work OK for e1000 -- the chip should not generate
another MSI until the driver reads the ICR in the interrupt handler,
although it might generate an interrupt immediately afterward (while
the interrupt handler is still running).

Am I misunderstanding something?  Or is there something in the
chipset's interrupt handling, outside of the CPU, that will break in
this case?

Thanks,
  Roland

0000:02:0c.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)        Subsystem: Dell: Unknown device 0151
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 185
        Memory at fcfe0000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at df40 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
00: 86 80 0e 10 17 01 30 02 02 00 00 02 10 40 00 00
10: 00 00 fe fc 00 00 00 00 41 df 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 51 01
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 ff 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 e4 22 c8
e0: 00 20 00 1b 07 f0 02 00 00 00 40 04 00 00 00 00
f0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00
