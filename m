Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWK0S33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWK0S33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWK0S33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:29:29 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:32920 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932164AbWK0S32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:29:28 -0500
Message-ID: <456B2E87.5000800@s5r6.in-berlin.de>
Date: Mon, 27 Nov 2006 19:29:27 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Robert Crocombe <rcrocomb@gmail.com>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
Subject: MMIO write ordering (was Re: ieee1394: host adapter disappears on
 1394 bus reset)
References: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>	 <4564C4C7.5060403@s5r6.in-berlin.de>	 <e6babb600611221628nd9430c6pe3ab36e9862b3b6d@mail.gmail.com> <e6babb600611270739k27e1ed51va3cd82ccfa0b77ff@mail.gmail.com> <456B1C52.4040305@s5r6.in-berlin.de>
In-Reply-To: <456B1C52.4040305@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Question to others:
> 
> ohci1394.c::ohci_irq_handler() is taking a per-host spinlock around some
> register reads and writes, particularly:
> ...
> 	spin_lock_irqsave(&ohci->event_lock, flags);
> 	event = reg_read(ohci, OHCI1394_IntEventClear);
> 	reg_write(ohci, OHCI1394_IntEventClear, event &
> 						~OHCI1394_busReset);
> 	spin_unlock_irqrestore(&ohci->event_lock, flags);
> ...
> 	spin_lock_irqsave(&ohci->event_lock, flags);
> 	reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
> 	run_an_insane_loop_as_an_alleged_fix_for_dorky_hardware;
> 	spin_unlock_irqrestore(&ohci->event_lock, flags);
> ...
> 	spin_lock_irqsave(&ohci->event_lock, flags);
> 	reg_write(ohci, OHCI1394_IntEventClear, OHCI1394_busReset);
> 	reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
> 	spin_unlock_irqrestore(&ohci->event_lock, flags);
> 
> I think these spinlocks are totally useless 1. because
> ohci_irq_handler() is only called as the hardware interrupt servicing
> routine and 2. because they don't flush the register write operations.
> Right? Wrong? [Ohci1394's reg_write() is a writel().]

Also, what is the status of ordering guarantees --- or lack thereof ---
for writel() under Linux 2.6.16 and 2.6.18? Especially in presence of a
PCI-X to PCI bridge...
-- 
Stefan Richter
-=====-=-==- =-== ==-==
http://arcgraph.de/sr/
