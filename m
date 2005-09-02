Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVIBPMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVIBPMJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 11:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVIBPMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 11:12:09 -0400
Received: from yakov.inr.ac.ru ([194.67.69.111]:36534 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S1750704AbVIBPMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 11:12:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=PDXH3BPDnLx4ZDSrZ6Uq1Lx5K0UX18v4OThfsHkrifS9wU7lHcmntZgA2uSvCOQ7PT+a3FaaHeU70hBl/TrcmS0IJg4KqcFuiGGtXaVgdQjYjKkAmkhugoh2334ol5eC6B3lltJ8PtGvSuuF2k89tK+1An99lCmgX60R7EjoJ+Q=;
Date: Fri, 2 Sep 2005 19:11:47 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: John Heffner <jheffner@psc.edu>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Ion Badulescu <lists@limebrokerage.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x kernels
Message-ID: <20050902151147.GA13922@yakov.inr.ac.ru>
References: <Pine.LNX.4.61.0509011713240.6083@guppy.limebrokerage.com> <20050901.154300.118239765.davem@davemloft.net> <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com> <2d02c76a84655d212634a91002b3eccd@psc.edu> <20050902134807.GB12617@yakov.inr.ac.ru> <4629cfbdf1af310d5c6cffd7178cff5b@psc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4629cfbdf1af310d5c6cffd7178cff5b@psc.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I wonder if clamping the window though is too harsh.  Maybe just 
> setting the rcv_ssthresh down is better? 

It is too harsh. This was invented before we learned how to collapse
received data, that time tiny segments were fatal and clamping was
the last weapon against misbehaving connections.

It can be removed.

Actually, right solution would be an attempt to calculate ratio
window/rcvbuf dynamically. It looked quite tricky, so it was not done.
Instead it is controlled with static sysctl sysctl_tcp_adv_win_scale.
It does not work sometimes f.e. when a device has larger link level overhead.
I think, this should be reconsidered.

> Why the distinction between 
> in-order and out-of-order data?  Because you expect in-order data to be 
> a persistent case?

Overflow in in-order data is hard, we cannot drop data. Also, it means
that receiving application cannot hold to receive rate and we can shrink
window.

Out-of-order data are different: we can drop the segments if we are
in serious troubles and overflow there can be cured by expansion of window
to allow fast retransmit.

Alexey
