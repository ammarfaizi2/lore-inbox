Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTJJS45 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTJJS45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:56:57 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:61570
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262071AbTJJS4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:56:55 -0400
Date: Fri, 10 Oct 2003 14:56:39 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Adam Flizikowski <adam_fli@poczta.onet.pl>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 8139_tx_interrupt - Tx time
Message-ID: <Pine.LNX.4.53.0310101456140.15705@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003, Adam Flizikowski wrote:

> Hi,
> 
> I am trying to find out how long it takes to push packet off the NIC in
> 8139_tx_interrupt(){} (kernel 2.4.20)
> 
> but i don't know how to identify packet in this loop - i know that "entry"
> stands for the packet but in the loop underneath:
> /* code snippet for 8139_tx_interrupt(){}*/
> 
> 1726         while (tx_left > 0) {
> 1727                 int entry = dirty_tx % NUM_TX_DESC;
> 1728                 int txstatus;
> 
> ...
> 
> 1762
> 1763                 dirty_tx++;
> 1764                 tx_left--;    // <- is single packet sent just
> here??????
> 1765         }
> 
> what "tx_left" and "dirty_tx" variables stand for? Is single iteration
> through the loop (lines 1726-1765) related to SINGLE packet transmission?

No, that simply checks tx status, the transmission is done elsewhere.

> I wanted to put some probes inside tx_interrupt but not sure where it should
> start/stop measuring to show single packet transmission time.

tx_interrupt is normally triggered on transmission completion, you 
probably want to sample from;

rtl8139_start_xmit {
...
	RTL_W32_F (TxStatus0 + (entry * sizeof (u32)),
		   tp->tx_flag | max(len, (unsigned int)ETH_ZLEN));
...
}

That is when the packet hits the hardware, you could keep per tx 
descriptor start/end timestamps with end being in tx_interrupt.

Hope that gets you somewhere.

