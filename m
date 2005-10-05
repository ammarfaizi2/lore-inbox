Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbVJEVPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbVJEVPo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbVJEVPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:15:44 -0400
Received: from fmr24.intel.com ([143.183.121.16]:47539 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S965063AbVJEVPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:15:43 -0400
Message-Id: <200510052115.j95LFgg07836@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel performance update - 2.6.14-rc3
Date: Wed, 5 Oct 2005 14:15:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXJ8fEeHoTg0aMTQY6796I8IBYABA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel performance data for 2.6.14-rc3 is updated at:
http://kernel-perf.sourceforge.net

We are continuing our investigation with volanomark regression
seen with HZ rate reduced from default 1K to 250.  The workload
is run with loopback interface.  Preliminarily, we think it is
related to how softirq is invoked.  Multiple threads are usually
blocked waiting on incoming socket data (sleep side kernel via
sk_wait_data function).  It needs an external event (i.e., NIC
receiving a packet over the wire and subsequence hw interrupt) to
trigger a thread wakeup.  However, with software loopback device,
the link between the xmit and rcv is done via softirq.  Even though
softirq is invoked at the end of dev_queue_xmit() via local_bh_enable(),
not all execution of softirq will result a __wake_up().  With higher
HZ rate, timer interrupt is more frequent and thus more softirq
invocation and leads to more __wake_up(), which then takes us to higher
throughput because cpu spend less time in idle.  We are continuing
with more experiments to follow up.

dbench is catching some attention.  We just ran it with default
parameter.  I don't think default parameter is the right one to use
on some of our configurations.  For example, it shows +100% improvement
on 4P Xeon between latest kernel and 2.6.9, while showing -45% on 4P ia64.
It just doesn't make much sense to me.  Does any expert out there have
recommendation What are the proper parameter to use for this workload?
Same thing goes to tbench (what is the proper parameter to use here?).

- Ken

