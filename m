Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936133AbWK3CTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936133AbWK3CTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 21:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936128AbWK3CTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 21:19:52 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:31631
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S936133AbWK3CTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 21:19:51 -0500
Date: Wed, 29 Nov 2006 18:19:50 -0800 (PST)
Message-Id: <20061129.181950.31643130.davem@davemloft.net>
To: wenji@fnal.gov
Cc: akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <2f14bf623344.456de60a@fnal.gov>
References: <2f14bf623344.456de60a@fnal.gov>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenji Wu <wenji@fnal.gov>
Date: Wed, 29 Nov 2006 19:56:58 -0600

> >We could also pepper tcp_recvmsg() with some very carefully placed
> >preemption disable/enable calls to deal with this even with
> >CONFIG_PREEMPT enabled.
>
> I also think about this approach. But since the "problem" happens in
> the 2.6 Desktop and Low-latency Desktop (not server), system
> responsiveness is a key feature, simply placing preemption
> disabled/enable call might not work.  If you want to place
> preemption disable/enable calls within tcp_recvmsg, you have to put
> them in the very beginning and end of the call. Disabling preemption
> would degrade system responsiveness.

We can make explicitl preemption checks in the main loop of
tcp_recvmsg(), and release the socket and run the backlog if
need_resched() is TRUE.

This is the simplest and most elegant solution to this problem.

The one suggested in your patch and paper are way overkill, there is
no reason to solve a TCP specific problem inside of the generic
scheduler.
