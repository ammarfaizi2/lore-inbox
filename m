Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbUDSMwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbUDSMwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:52:53 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:60812 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264392AbUDSMws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:52:48 -0400
Date: Mon, 19 Apr 2004 18:21:48 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org, mpm@selenic.com,
       mingo@elte.hu, suparna@in.ibm.com
Subject: Problem with Netpoll based netdumping and NAPI
Message-ID: <20040419125148.GA4495@in.ibm.com>
Reply-To: hari@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am facing a problem while trying to network dump using LKCD. My 
debugging so far indicates that this is due to both NAPI and NETPOLL 
being enabled.

I am using LKCD on the 2.6.5 kernel and both the client and server are 
i386 boxes. The dumping machine has an e100 card. I have built the kernel
with both CONFIG_E100_NAPI and CONFIG_NET_POLL_CONTROLLER (and the other
netpoll related options) selected.

LKCD uses netpoll for its network dump implementation. The problem we see
is that the network dump driver does not receive any packet from the 
card driver and hence dumping fails. In e100_intr(), we call 
netif_rx_schedule() if we are using the NAPI feature. netif_rx_schedule, 
in turn, ends up adding the processing of this packet to the NET_RX_SOFTIRQ 
softirq.

When we do netdump, all the other cpus are halted and interrupts disabled. 
So, we never get around to scheduling the ksoftirqd thread and these packets 
are never processed. I think any one using netpoll with NAPI logic turned on
will face this problem.

One way I worked around this was to avoid the NAPI logic when we end up
in e100_intr() due to netpoll. But I think a better solution would be to
let the NAPI code handle this.

Request all to comment and suggest an effective way to fix this problem.
Thanks in advance.

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore
