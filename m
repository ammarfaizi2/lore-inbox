Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318270AbSG3OA4>; Tue, 30 Jul 2002 10:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318272AbSG3OA4>; Tue, 30 Jul 2002 10:00:56 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:3596 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S318270AbSG3OAz>;
	Tue, 30 Jul 2002 10:00:55 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: martin@dalecki.de
Date: Tue, 30 Jul 2002 16:03:41 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: IDE from current bk tree, UDMA and two channels...
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <963E6E41A8@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
  here at work I have i845 chipset, with one UDMA100 disk connected
to the primary channel, and one UDMA100 disk and one CD-DVD on the
secondary one. CD-DVD driver is not loaded at all, all three devices
are configured for UDMA by kernel. 

  Today 2.5.29-cset511 died when rebooting to 2.5.29-cset536 (rmap.c:212 
BUG(), but I believe that it is fixed by Paulus's page->index patch 
(cset520)) and after reboot I'm not able to fsck /dev/hdc1. It dies with

hdc: ide_dma_intr: status=0x58 [ drive ready,seek complete,data request]
hdc: request error, nr. 1

and fsck is D, and channel is stopped :-( First something easy: I think 
that we should use ", " as a separator in dump_bits, and if there is
space after opening "[", there should be also space before closing "]".

Second problem is that read operation which ends with
"drive ready, seek complete, data request" (why it happened in first
place?) will just read one sector from drive (it was DMA transfer,
so drive->mult_count == 0), and then it returns from ata_error
with ATA_OP_CONTINUES. But what continues? Drive told us that
current operation is done, and no new operation was started, so
there is very low chance that some IRQ will ever come, and timer was
just removed by ata_irq_request(), so channel will never awake.

And third, why this happens at all? When I instrumented ide_dma_intr 
with printk, udma_stop() returns zero: it means that everything went 
fine, UDMA engine asked for interrupt, no error, UDMA engine stopped. 
Only reason I can invent is that drive did not clear DRQ bit yet, or 
that we programmed UDMA engine with too few bytes to transfer. Either 
of these explanations looks strange to me, as this does not explain
why it happens only when both channels are in use simultaneously.

And last thing: problem does not happen when only one of channels is
active, it is triggered only when both channels are active, and
channel #1 is always one which dies. Channel #0 uses IRQ14, channel #1
IRQ15, so there should be no sharing involved.
                                Thanks,
                                    Petr Vandrovec
                                    vandrove@vc.cvut.cz
                                    
