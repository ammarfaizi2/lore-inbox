Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWIRVDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWIRVDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 17:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWIRVDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 17:03:33 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:8617 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1751088AbWIRVDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 17:03:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=Y2alxgB+/WmAcOVrNyMBzCaMtbuk61hZzP+q+U0LA9WWEgSuJ/CxY+zGfJa1GZpFbuG4h3BNUeRPFNEL9wqQiiINVCXVBOezFnoXTCuJ7/OLDojo+8+2kTFTIAn8cytahxtx3QOvIgJkyBLHsI++/cpUGc/M4L1rP+GtEc3pBdc=;
Date: Tue, 19 Sep 2006 01:03:21 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Andi Kleen <ak@suse.de>
Cc: "Vladimir B. Savkin" <master@sectorb.msk.ru>,
       Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060918210321.GA4780@ms2.inr.ac.ru>
References: <4492D5D3.4000303@atmos.washington.edu> <200609181754.37623.ak@suse.de> <20060918162847.GA4863@ms2.inr.ac.ru> <200609181850.22851.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609181850.22851.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> But that never happens right? 

Right.

Well, not right. It happens. Simply because you get packet
with newer timestamp after previous handler saw this packet
and did some actions. I just do not see any bad consequences.


> And do you have some other prefered way to solve this? Even if the timer
> was fast it would be still good to avoid it in the fast path when DHCPD
> is running.

No. The way, which you suggested, seems to be the best.


1. It even does not disable possibility to record timestamp inside
   driver, which Alan was afraid of. The sequence is:

	if (!skb->tstamp.off_sec)
                net_timestamp(skb);

2. Maybe, netif_rx() should continue to get timestamp in netif_rx().

3. NAPI already introduced almost the same inaccuracy. And it is really
   silly to waste time getting timestamp in netif_receive_skb() a few
   moments before the packet is delivered to a socket.

4. ...but clock source, which takes one of top lines in profiles
   must be repaired yet. :-)

Alexey
