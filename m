Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTIYQNy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbTIYQNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:13:54 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:62986 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261328AbTIYQNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:13:51 -0400
Date: Thu, 25 Sep 2003 20:11:27 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, kevin.vanmaren@unisys.com,
       peter@chubb.wattle.id.au, bcrl@kvack.org, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030925201127.A11889@jurassic.park.msu.ru>
References: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com> <20030923105712.552dbb1e.davem@redhat.com> <16240.36993.148535.613568@napali.hpl.hp.com> <20030923114744.137d5dac.davem@redhat.com> <16240.40001.632466.644215@napali.hpl.hp.com> <20030923121044.483d3a5c.davem@redhat.com> <16240.42563.834328.584444@napali.hpl.hp.com> <20030923200832.1a58a215.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030923200832.1a58a215.davem@redhat.com>; from davem@redhat.com on Tue, Sep 23, 2003 at 08:08:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 08:08:32PM -0700, David S. Miller wrote:
> It's not even decided that the copying version is faster.

On Alpha it is - I did some experimentation yesterday with
the tulip driver and "rx_copybreak=0" vs default "rx_copybreak=1518".
That's true, copying the large packet is very expensive due to constant
cache misses. On UP1500 it costs more than 2500 cycles per 1.5Kb
copy on large ftp transfers.
OTOH, minimal time to handle unaligned load is ~200 cycles (ev6 cpu),
but only when the trap handler itself and its data are in L1 cache
(like doing unaligned load in a tight loop). In the real life average
time is ~400 cycles due to cache misses.
Further, with "rx_copybreak=0" I've got 20 (!) unaligned traps per TCP
packet, i.e. penalty was 8000 vs 2500 cycles...
Note that my network setup is as simple as possible - no routing/filtering
etc., just a networked workstation. I guess one with a more complex
routing/firewalling configuration would have a LOT more unaligned
traps per packet.

Ivan.
