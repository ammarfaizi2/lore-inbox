Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUDCMRf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 07:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUDCMRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 07:17:35 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:16878 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261718AbUDCMRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 07:17:33 -0500
Date: Sat, 3 Apr 2004 14:13:29 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: a.nielsen@optushome.com.au, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, degger@tarantel.rz.fh-muenchen.de
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Message-ID: <20040403141329.A20457@electric-eye.fr.zoreil.com>
References: <20040403150229.75ec6b98.a.nielsen@optushome.com.au> <20040403112755.A19308@electric-eye.fr.zoreil.com> <20040403020740.33ef375f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040403020740.33ef375f.akpm@osdl.org>; from akpm@osdl.org on Sat, Apr 03, 2004 at 02:07:40AM -0800
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> :
[...]
> The logic is faulty, or at least very odd.
> 
> 	tx_left = tp->cur_tx - dirty_tx;
> 
> 	while (tx_left > 0) {
> 		int entry = dirty_tx % NUM_TX_DESC;
> 
> 		if (!(le32_to_cpu(tp->TxDescArray[entry].status) & OWNbit)) {
> 			...
> 		}
> 	}
> 
> Why is that `if' test there at all?  If it ever returns false, the box

It checks that the network card has returned the buffer to the host computer.
The code will loop in the irq handler until every buffer submitted
for Tx is processed
- it is gross;
- it is not robust;
- I assume that's why the driver sucks cpu like hell on high Tx traffic;
- ... but it is not faulty. 

> locks up.  A BUG_ON(le32_to_cpu(tp->TxDescArray[entry].status) & OWNbit)
> might make more sense.

In Linus's current tree, I doubt it: assume the host has submitted a few
packets for Tx and the network card issue an interrupt for the first one 
whereas the second descriptor still belongs to the network card -> boom.

--
Ueimor
