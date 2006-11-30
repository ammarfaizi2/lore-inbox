Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030666AbWK3QMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030666AbWK3QMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 11:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030649AbWK3QMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 11:12:46 -0500
Received: from mailgw2.fnal.gov ([131.225.111.12]:2951 "EHLO mailgw2.fnal.gov")
	by vger.kernel.org with ESMTP id S967828AbWK3QMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 11:12:44 -0500
Date: Thu, 30 Nov 2006 10:08:22 -0600
From: Wenji Wu <wenji@fnal.gov>
Subject: RE: [patch 1/4] - Potential performance bottleneck for Linxu TCP
In-reply-to: <20061129.181950.31643130.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-to: wenji@fnal.gov
Message-id: <HNEBLGGMEGLPMPPDOPMGMEAMCGAA.wenji@fnal.gov>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>We can make explicitl preemption checks in the main loop of
>tcp_recvmsg(), and release the socket and run the backlog if
>need_resched() is TRUE.

>This is the simplest and most elegant solution to this problem.


I am not sure whether this approach will work. How can you make the explicit
preemption checks?



For Desktop case, yes, you can make the explicit preemption checks at some
points whether need_resched() is true. But when need_resched() is true, you
can not decide whether it is triggered by higher priority processes becoming
runnable, or the process within tcp_recvmsg being expiring.


If the higher prioirty processes become runnable (e.g., interactive
process), you better yield the CPU, instead of continuing this process. If
it is the case that the process within tcp_recvmsg() is expriring, then, you
can continue the process to go ahead to process backlog.

For Low-latency Desktop case, I believe it is very hard to make the checks.
We do not know when the process is going to expire, or when higher priority
process will become runnable. The process could expire at any moment, or
higher priority process could become runnnable at any moment. If we do not
want to tradeoff system responsiveness, where do you want to make the check?
If you just make the chekc, then need_resched() become TRUE, what are you
going to do in this case?

wenji




