Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbTDPBL1 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 21:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbTDPBL1 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 21:11:27 -0400
Received: from taka.swcp.com ([198.59.115.12]:27661 "EHLO taka.swcp.com")
	by vger.kernel.org with ESMTP id S264181AbTDPBL0 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 21:11:26 -0400
Date: Tue, 15 Apr 2003 19:21:19 -0600
From: Trammell Hudson <hudson@osresearch.net>
To: linux-kernel@vger.kernel.org
Subject: drivers/net/isa-skeleton.c queue management bug?
Message-ID: <20030416012119.GC8482@osbox.osresearch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realize that the code is going on ten years old and isn't supposed
to be run, but is there a bug in the interface queue handling for
packet transmissions in isa-skeleton.c?

If TX_RING is defined, net_interrupt() will check to see if it was
called due to a completed packet, and if so, then it executes:

        if (status & TX_INTR) {
                /* Transmit complete. */                  
                net_tx(dev);
                np->stats.tx_packets++;                  
                netif_wake_queue(dev);
        }

However, the net_tx() function processes any completed entries and
then executes:

        if (netif_queue_stopped(dev) && ! tx_full(dev))
                netif_wake_queue(dev);     


It seems that the queue is going to be awoken in net_interrupt,
regardless of the state of the ring buffer.  I'm not exactly sure
under what circumstances this might occur, but I'm trying to track
down random hangs in a driver that is based on isa-skeleton.

Trammell      
--           
  -----|----- hudson@osresearch.net                   W 240-283-1700
*>=====[]L\   hudson@rotomotion.com                   M 505-463-1896
'     -'-`-   http://www.swcp.com/~hudson/                    KC5RNF
