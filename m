Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWISUaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWISUaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWISUaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:30:46 -0400
Received: from postel.suug.ch ([194.88.212.233]:58037 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S1751127AbWISUap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:30:45 -0400
Date: Tue, 19 Sep 2006 22:31:05 +0200
From: Thomas Graf <tgraf@suug.ch>
To: David Miller <davem@davemloft.net>
Cc: kuznet@ms2.inr.ac.ru, ak@suse.de, master@sectorb.msk.ru, hawk@diku.dk,
       harry@atmos.washington.edu, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060919203105.GF18349@postel.suug.ch>
References: <20060918162847.GA4863@ms2.inr.ac.ru> <200609181850.22851.ak@suse.de> <20060918210321.GA4780@ms2.inr.ac.ru> <20060918.142247.14844785.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060918.142247.14844785.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Miller <davem@davemloft.net> 2006-09-18 14:22
> From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> Date: Tue, 19 Sep 2006 01:03:21 +0400
> 
> > 1. It even does not disable possibility to record timestamp inside
> >    driver, which Alan was afraid of. The sequence is:
> > 
> > 	if (!skb->tstamp.off_sec)
> >                 net_timestamp(skb);
> > 
> > 2. Maybe, netif_rx() should continue to get timestamp in netif_rx().
> > 
> > 3. NAPI already introduced almost the same inaccuracy. And it is really
> >    silly to waste time getting timestamp in netif_receive_skb() a few
> >    moments before the packet is delivered to a socket.
> > 
> > 4. ...but clock source, which takes one of top lines in profiles
> >    must be repaired yet. :-)
> 
> Ok, ok, but don't we have queueing disciplines that need the timestamp
> even on ingress?

Queueing disciplines generally only care about the time delta
between two packets, using the receive stamp would lead to
wrong results as soon as a packet is queued more than once.

However, since we recently introcued ingress queueing we
must update the stamp to make up for the delay caused by the
queue. Updating the stamp at socket enqueue time would solve
this automatically.

It seems only natural to me that the real problem is the slow
clock source which needs to be resolved regardless of the
outcome of this discussion. I believe that updating the stamp
at socket enqueue time is the right thing to do but it shouldn't
be considered as a solution to the performance problem.
