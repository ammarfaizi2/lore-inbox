Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWDWFuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWDWFuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 01:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWDWFub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 01:50:31 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16091
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751287AbWDWFub convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 01:50:31 -0400
Date: Sat, 22 Apr 2006 22:50:11 -0700 (PDT)
Message-Id: <20060422.225011.122273760.davem@davemloft.net>
To: ioe-lkml@rameria.de
Cc: joern@wohnheim.fh-wedel.de, netdev@axxeo.de, simlo@phys.au.dk,
       linux-kernel@vger.kernel.org, mingo@elte.hu, netdev@vger.kernel.org
Subject: Re: Van Jacobson's net channels and real-time
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200604230205.33668.ioe-lkml@rameria.de>
References: <200604221529.59899.ioe-lkml@rameria.de>
	<20060422134956.GC6629@wohnheim.fh-wedel.de>
	<200604230205.33668.ioe-lkml@rameria.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <ioe-lkml@rameria.de>
Date: Sun, 23 Apr 2006 02:05:32 +0200

> On Saturday, 22. April 2006 15:49, Jörn Engel wrote:
> > That was another main point, yes.  And the endpoints should be as
> > little burden on the bottlenecks as possible.  One bottleneck is the
> > receive interrupt, which shouldn't wait for cachelines from other cpus
> > too much.
> 
> Thats right. This will be made a non issue with early demuxing
> on the NIC and MSI (or was it MSI-X?) which will select
> the right CPU based on hardware channels.

It is not clear that MSI'ing the RX interrupt to multiple cpus is the
answer.

Consider the fact that by doing so you're reducing the amount of batch
work each interrupt does by a factor N.  One of the biggest gains of
NAPI btw is that it batches patcket receive, if you don't believe the
benefits of this put a simply cycle counter sample around
netif_receive_skb() calls, and note the difference between the first
packet processed and subsequent ones, it's several orders of magnitude
faster to process subsequent packets within a batch.  I've done this
before on tg3 with sparc64 and posted the numbers on netdev about a
year or so ago.

If you are doing something like netchannels, it helps to batch so that
the demuxing table stays hot in the cpu cache.

There is even talk of dedicating a thread on enormously multi-
threaded cpus just to the NIC hardware interrupt, so it could net
channel to the socket processes running on the other strands.
