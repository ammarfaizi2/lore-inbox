Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031280AbWK3UW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031280AbWK3UW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031363AbWK3UW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:22:58 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:29411
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1031341AbWK3UW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:22:57 -0500
Date: Thu, 30 Nov 2006 12:22:58 -0800 (PST)
Message-Id: <20061130.122258.68041055.davem@davemloft.net>
To: mingo@elte.hu
Cc: johnpol@2ka.mipt.ru, nickpiggin@yahoo.com.au, wenji@fnal.gov,
       akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061130103240.GA25733@elte.hu>
References: <456EAD6E.6040709@yahoo.com.au>
	<20061130102205.GA20654@2ka.mipt.ru>
	<20061130103240.GA25733@elte.hu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Thu, 30 Nov 2006 11:32:40 +0100

> Note that even without the change the TCP receiving task is already 
> getting a disproportionate share of cycles due to softirq processing! 
> Under a load of 10.0 it went from 500 mbits to 74 mbits, while the 
> 'fair' share would be 50 mbits. So the TCP receiver /already/ has an 
> unfair advantage. The patch only deepends that unfairness.

I want to point out something which is slightly misleading about this
kind of analysis.

Your disk I/O speed doesn't go down by a factor of 10 just because 9
other non disk I/O tasks are running, yet for TCP that's seemingly OK
:-)

Not looking at input TCP packets enough to send out the ACKs is the
same as "forgetting" to queue some I/O requests that can go to the
controller right now.

That's the problem, TCP performance is intimately tied to ACK
feedback.  So we should find a way to make sure ACK feedback goes
out, in preference to other tcp_recvmsg() processing.

What really should pace the TCP sender in this kind of situation is
the advertised window, not the lack of ACKs.  Lack of an ACK mean the
packet didn't get there, which is the wrong signal in this kind of
situation, whereas a closing window means "application can't keep
up with the data rate, hold on..." and is the proper flow control
signal in this high load scenerio.

If you don't send ACKs, packets are retransmitted when there is no
reason for it, and that borders on illegal. :-)
