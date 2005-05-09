Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVEIUf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVEIUf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 16:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVEIUf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 16:35:26 -0400
Received: from graphe.net ([209.204.138.32]:50961 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261511AbVEIUfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 16:35:18 -0400
Date: Mon, 9 May 2005 13:35:12 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] timers fixes/improvements
In-Reply-To: <424E6441.12A6BC03@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0505091312490.27740@graphe.net>
References: <424D373F.1BCBF2AC@tv-sign.ru> <424E6441.12A6BC03@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have some strange race conditions as a result of the timer
scalability fixes.

ptype_all is set to 0x10:0x10 on faster systems (Xeon 3.6Ghz).
Slower systems do fine(Xeon 3.0Ghz) and do not corrupt ptype_all.

Its not clear to me how ptype_all could relate to timer operations but
if I apply these timer patches I get ptype_all corruption.

timers-fixes-improvements.patch
timers-fixes-improvements-smp_processor_id-fix.patch
timers-fixes-improvements-fix.patch
timer-deadlock-fix
(It does not matter if the last three are applied)

I put some printk's in an get the following output (2.6.12-rc4 + patches):

net_dev_init: ptype_all = c0569e20:c0569e20
Machine check exception polling timer started.
No per-cpu room for modules.
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with large block numbers, no debug enabled
Intel E7520/7320/7525 detected.<6>ACPI: Power Button (FF) [PWRF]
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.7.6-k2
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI Interrupt
register_netdevice eth%d: ptype_all = 00000010:00000010
ptype_all corrupted = 00000010:00000010. ptype_all fixed up
10 9e 56 c0 10 9e 56 c0 18 9e 56 c0 18 9e 56 c0 10 00 00 00 10 00 00 00 00 00 00 00 00 00 00 00
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt
register_netdevice eth%d: ptype_all = c0569e20:c0569e20

