Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWGKVPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWGKVPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWGKVPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:15:49 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:3482 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S932131AbWGKVPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:15:48 -0400
Date: Wed, 12 Jul 2006 00:16:20 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Zach Brown <zach.brown@oracle.com>, Sean Hefty <sean.hefty@intel.com>,
       Hal Rosenstock <halr@voltaire.com>, Roland Dreier <rolandd@cisco.com>
Cc: openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: ipoib lockdep warning
Message-ID: <20060711211620.GB21546@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <44B405C8.4040706@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B405C8.4040706@oracle.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 11 Jul 2006 21:20:57.0250 (UTC) FILETIME=[E64D2820:01C6A52F]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Zach Brown <zach.brown@oracle.com>:
> BC:
> 
> query_idr.lock is taken with interrupts enabled and so is implicitly
> ordered before dev->_xmit_lock which is taken in interrupt context.
> 
> ipoib_mcast_join_task()
>   ipoib_mcast_join()
>     ib_sa_mcmember_rec_query()
>       send_mad()
>         idr_pre_get(&query_idr)
>           spin_lock(&idp->lock)

Got to check, but if that's true we have a simple deadlock here:
ib_sa_mcmember_rec_query might get called from interrupt
context as well, deadlocking on idp->lock?

Sean?

> I can imagine all sorts of potential fixes (block ints when calling idr?
>  reorder acquiry in ipoib_mcast_restart_task()?) but I'm operating on a
> partial view of the paths here so I wasn't comfortable suggesting a fix.
>  I wouldn't be surprised to hear that there are circumstances that both
> lockdep and I don't know about that stop this from being a problem :).

Awesome, thanks for the analysis! Your help is very much appreciated.

-- 
MST
