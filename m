Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263378AbRFAExO>; Fri, 1 Jun 2001 00:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263379AbRFAExE>; Fri, 1 Jun 2001 00:53:04 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:25582 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S263378AbRFAEwv>;
	Fri, 1 Jun 2001 00:52:51 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200106010452.VAA17405@csl.Stanford.EDU>
Subject: [CHECKER] 2.4.5-ac4 use of freed pointers
To: linux-kernel@vger.kernel.org
Date: Thu, 31 May 2001 21:52:49 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three use-after-free bugs:

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/net/rose/rose_dev.c:127:rose_rebuild_header: ERROR:FREE:122:127: Use-after-free of 'skbn'! set by 'kfree_skb':122
		skb_set_owner_w(skbn, skb->sk);

	kfree_skb(skb);

	if (!rose_route_frame(skbn, NULL)) {
Start --->
		kfree_skb(skbn);
		stats->tx_errors++;
	}

	stats->tx_packets++;
Error --->
	stats->tx_bytes += skbn->len;
#endif
	return 1;
}
---------------------------------------------------------
[BUG] frees then uses the next pointer.
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/wan/lapbether.c:101:lapbeth_check_devices: ERROR:FREE:113:101: Use-after-free of 'lapbeth'! set by 'kfree':113
	save_flags(flags);
	cli();

	lapbeth_prev = NULL;

Error --->
	for (lapbeth = lapbeth_devices; lapbeth != NULL; lapbeth = lapbeth->next) {
		if (!dev_get(lapbeth->ethname)) {
			if (lapbeth_prev)
				lapbeth_prev->next = lapbeth->next;
			else
				lapbeth_devices = lapbeth->next;

			if (&lapbeth->axdev == dev)
				result = 1;

			unregister_netdev(&lapbeth->axdev);
			dev_put(lapbeth->ethdev);
Start --->
			kfree(lapbeth);
		}
		else
			lapbeth_prev = lapbeth;
---------------------------------------------------------
[BUG] frees then uses the next pointer.
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/hamradio/bpqether.c:178:bpq_check_devices: ERROR:FREE:193:178: Use-after-free of 'bpq'! set by 'kfree':193
	save_flags(flags);
	cli();

	bpq_prev = NULL;

Error --->
	for (bpq = bpq_devices; bpq != NULL; bpq = bpq->next) {

	... DELETED 9 lines ...

			/* We should be locked, call 
			 * unregister_netdevice directly 
			 */

			unregister_netdevice(&bpq->axdev);
Start --->
			kfree(bpq);
		}
		else
			bpq_prev = bpq;

