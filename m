Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263829AbTIIAvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTIIAvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:51:12 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:7646 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S263829AbTIIAvK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:51:10 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: kernel oops with kernel-smp-2.4.20-20.9 (Unable to handle kernel NULL pointer dereference at virtual address 00000000)
Date: Mon, 8 Sep 2003 17:51:04 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E01022294A8@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel oops with kernel-smp-2.4.20-20.9 (Unable to handle kernel NULL pointer dereference at virtual address 00000000)
Thread-Index: AcN0TTD9MW5IDEF6SpGB1/A21BmVTgCHx+lw
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Frederic Trudeau" <ftrudeau@zesolution.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Sep 2003 00:51:05.0030 (UTC) FILETIME=[72C0F660:01C3766C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>EIP; f8b05260 <[e1000]e1000_clean_rx_ring+30/140>   <=====
> 
> >>ecx; 00031988 Before first symbol
> >>edx; f770b980 <_end+3728d080/3838e760>
> >>esp; f54a1e98 <_end+35023598/3838e760>
> 
> Trace; f8b051dd <[e1000]e1000_free_rx_resources+1d/70>
> Trace; f8b04a26 <[e1000]e1000_open+46/60>

Fix in newer e1000 drivers.  Your failing request_irq().  Need to remove
some code in e1000_up so we don't try to free resources twice:

        if(request_irq(netdev->irq, &e1000_intr, SA_SHIRQ |
SA_SAMPLE_RANDOM,
                       netdev->name, netdev)) {
-               e1000_reset_hw(&adapter->hw);
-               e1000_free_tx_resources(adapter);
-               e1000_free_rx_resources(adapter);
                return -1;
        }

-scott
