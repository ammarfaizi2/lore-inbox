Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUJWKhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUJWKhJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUJWKer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:34:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15239 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266884AbUJWKbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:31:31 -0400
Date: Sat, 23 Oct 2004 12:32:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
Message-ID: <20041023103247.GE30270@elte.hu>
References: <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <41798BD6.6060207@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41798BD6.6060207@cybsft.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Oct 22 14:37:14 swdev14 kernel: BUG: sleeping function called from invalid context ksoftirqd/0(3) at kernel/mutex.c:37
> Oct 22 14:37:14 swdev14 kernel: in_atomic():1 [00000001], irqs_disabled():0
> Oct 22 14:37:14 swdev14 kernel:  [<c011ac3d>] __might_sleep+0xc4/0xd6 (12)
> Oct 22 14:37:14 swdev14 kernel:  [<c0132ae8>] _mutex_lock+0x3e/0x63 (36)
> Oct 22 14:37:14 swdev14 kernel:  [<e0a8b297>] ipxitf_find_using_phys+0x1e/0x4c [ipx] (28)
> Oct 22 14:37:14 swdev14 kernel:  [<e0a8d5a6>] ipx_rcv+0xdc/0x1dd [ipx] (20)
> Oct 22 14:37:14 swdev14 kernel:  [<c024050b>] snap_rcv+0x5f/0xe0 (32)

does the patch below fix these?

	Ingo

--- linux/net/802/psnap.c.orig
+++ linux/net/802/psnap.c
@@ -55,7 +55,7 @@ static int snap_rcv(struct sk_buff *skb,
 		.type = __constant_htons(ETH_P_SNAP),
 	};
 
-	rcu_read_lock();
+	rcu_read_lock_spin(&snap_lock);
 	proto = find_snap_client(skb->h.raw);
 	if (proto) {
 		/* Pass the frame on. */
@@ -68,7 +68,7 @@ static int snap_rcv(struct sk_buff *skb,
 		rc = 1;
 	}
 
-	rcu_read_unlock();
+	rcu_read_unlock_spin(&snap_lock);
 	return rc;
 }
 
