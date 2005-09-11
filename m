Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVIKOLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVIKOLK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 10:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVIKOLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 10:11:09 -0400
Received: from smtp.telecable.es ([212.89.0.18]:37509 "EHLO smtp.telecable.es")
	by vger.kernel.org with ESMTP id S932280AbVIKOLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 10:11:08 -0400
Date: Sun, 11 Sep 2005 16:10:58 +0200
From: Miguel <frankpoole@terra.es>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PCI bug in 2.6.13
Message-Id: <20050911161058.481d1a75.frankpoole@terra.es>
In-Reply-To: <Pine.LNX.4.58.0509101817590.3314@g5.osdl.org>
References: <20050909180405.3e356c2a.frankpoole@terra.es>
	<20050909225956.42021440.akpm@osdl.org>
	<20050910113658.178a7711.frankpoole@terra.es>
	<Pine.LNX.4.58.0509100949370.30958@g5.osdl.org>
	<Pine.LNX.4.58.0509101401490.30958@g5.osdl.org>
	<20050911030814.08cbe74c.frankpoole@terra.es>
	<Pine.LNX.4.58.0509101817590.3314@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus:

> Can you double-check this same thing with the git snapshot (or 2.6.13.1) 
> that should have the pci_map_rom() thing fixed?

The diff between the working 2.6.13 and 2.6.13.1 is the same:

00:0b.0 Mass storage controller: Triones Technologies, Inc.
HPT366/368/370/370A/372/372N (rev 04)
...
-30: 01 00 00 40 60 00 00 00 00 00 00 00 0b 01 08 08
+30: 01 00 00 00 60 00 00 00 00 00 00 00 0b 01 08 08

Between 2.6.13 and 2.6.13-git10:

00:0b.0 Mass storage controller: Triones Technologies, Inc.
HPT366/368/370/370A/372/372N (rev 04)
...
-       Expansion ROM at 40000000 [disabled] [size=128K]
+       Expansion ROM at 50000000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME
(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 00: 03 11 04 00 07 00 30 02 04 00 80 01 08 78 00 00
 10: 01 d0 00 00 01 d4 00 00 01 d8 00 00 01 dc 00 00
 20: 01 e0 00 00 00 00 00 00 00 00 00 00 03 11 01 00
-30: 01 00 00 40 60 00 00 00 00 00 00 00 0b 01 08 08
+30: 01 00 00 00 60 00 00 00 00 00 00 00 0b 01 08 08

> Can you try this _truly_ cheezy patch that should generate a stack trace 
> for the offending place? Btw, only do this with the 2.6.13.1 or git 
> kernels that have the fixed pci_map_rom(), otherwise you'll probably get 
> bogus traps for that case..

After applying this patch I don't see anything new so I have added the
same WARN_ON in pci_write_config_byte and pci_write_config_word and now
dmesg shows this:

HPT370A: chipset revision 4
Badness in pci_write_config_byte at include/linux/pci.h:800
 [<c025c519>]
 [<c0269280>]
 [<c02abbb9>]
 [<c02692a7>]
 [<c025ccf2>]
 [<c0188043>]
 [<c025cd48>]
 [<c039e242>]
 [<c039e278>]
 [<c039e1e8>]
 [<c03889c4>]
 [<c0100383>]
 [<c0100310>]
 [<c0101125>]
HPT370A: 100% native mode on irq 11
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:DMA, hdf:pio
HPT37X: using 33MHz PCI clock
    ide3: BM-DMA at 0xe008-0xe00f, BIOS settings: hdg:pio, hdh:pio
