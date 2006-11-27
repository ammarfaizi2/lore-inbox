Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934251AbWK0WfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934251AbWK0WfE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 17:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934279AbWK0WfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 17:35:04 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50579 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S934251AbWK0WfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 17:35:01 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <456B680D.2000703@s5r6.in-berlin.de>
Date: Mon, 27 Nov 2006 23:34:53 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061113 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Robert Crocombe <rcrocomb@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: ieee1394: host adapter disappears on 1394 bus reset
References: <e6babb600611220731p67b15e51q95f524683070ae80@mail.gmail.com>	 <4564C4C7.5060403@s5r6.in-berlin.de>	 <e6babb600611221628nd9430c6pe3ab36e9862b3b6d@mail.gmail.com>	 <e6babb600611270739k27e1ed51va3cd82ccfa0b77ff@mail.gmail.com>	 <456B1C52.4040305@s5r6.in-berlin.de>	 <e6babb600611270946o738327feqd7a18f2f1ff8fccd@mail.gmail.com>	 <456B2DD0.4060500@s5r6.in-berlin.de> <e6babb600611271234u5bb09ef1j1e26d68548770e88@mail.gmail.com>
In-Reply-To: <e6babb600611271234u5bb09ef1j1e26d68548770e88@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Crocombe wrote:
...
> Nov 27 13:06:37 spanky kernel: ohci1394: fw-host1: IntEvent: 00020010

busReset + RQPkt (packet sent)

...
> Nov 27 13:06:37 spanky kernel: ohci1394: fw-host1: IntEvent: 00010000

selfIDcomplete

...
> Nov 27 13:06:40 spanky kernel: ohci1394: fw-host1: IntEventClear
> 00000000 IntEventSet   04508000 IntMaskSet    838301f3

IntEventSet = phyRegRcvd + cycleLost + cycleSynch + selfIDcomplete2

> Nov 27 13:06:40 spanky kernel: ohci1394: fw-host1: IntEvent: 00020010
...
> Nov 27 13:06:41 spanky kernel: ohci1394: fw-host1: IntEvent: 00010000
...
> Nov 27 13:06:44 spanky kernel: ohci1394: fw-host1: IntEventClear
> 00000000 IntEventSet   6ffdc33f IntMaskSet    00000000

IntEventSet = vendorSpecific + softInterrupt + ack_tardy + phyRegRcvd +
cycleTooLong + unrecoverableError + cycleInconsistent + cycleLost +
cycle64Seconds + cycleSynch + phy + regAccessFail + selfIDComplete +
selfIDComplete2 + [reserved...?] + lockRespErr + postedWriteErr + RSPkt
+ RQPkt + ARRS + ARRQ + respTxComplete + reqTxComplete

(The bit 00004000 is not standardized and shouldn't be there. Whatever.)

That's a lot of stuff that happened right before this last print macro.
Maybe ages were spent in hpsb_selfid_complete. I will try to work on
getting non-critical parts out of hpsb_selfid_complete issue during the
week, but I don't know how fast I can do this and if this will help in
the first place.

...
> I didn't mention that I have:
> 
> options ieee1394 disable_nodemgr=1
> options ohci1394 phys_dma=0
> 
> in my /etc/modprobe.conf.  The Linux adapters are functioning as
> simulated peripherals to a piece of control hardware that always has a
> dest address of 0x0000 0000 0000 on all packets so I needed to get rid
> of posted writes and any bickering over bus master.

Posted writes are still enabled. phys_dma=0 disables only the physical
response unit. You have to change the source if you want to disable
posted writes. See the top of ohci_initialize. Should this be a module
load parameter too?
-- 
Stefan Richter
-=====-=-==- =-== ==-==
http://arcgraph.de/sr/
