Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbREVLvE>; Tue, 22 May 2001 07:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbREVLuz>; Tue, 22 May 2001 07:50:55 -0400
Received: from mgw-x1.nokia.com ([131.228.20.21]:48877 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S261386AbREVLuf>;
	Tue, 22 May 2001 07:50:35 -0400
Date: Tue, 22 May 2001 14:34:07 +0300
To: linux-kernel@vger.kernel.org
Subject: Q about ip_local_deliver_finish
Message-ID: <20010522143407.A590@Hews1193nrc>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: alexey.vyskubov@nokia.com (Alexey Vyskubov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have a question (maybe stupid but I spent a lot of time trying to find an
answer)about ip_local_deliver_finish() in 2.4.4. kernel.
I'll be very grateful if someone explains me what's happening.

There is the following piece of code in ip_local_deliver_finish()
(in net/ipv4/ip_input.c):

if(ipprot != NULL) {
	if(raw_sk == NULL &&
	   ipprot->next == NULL &&
	   ipprot->protocol == protocol) {
		int ret;
		/* Fast path... */
		ret = ipprot->handler(skb);
		return ret;
	} else {
		flag = ip_run_ipprot(skb, skb->nh.iph, ipprot, (raw_sk != NULL));
	}

[some comments skipped]

if(raw_sk != NULL) {	/* Shift to last raw user */
	raw_rcv(raw_sk, skb);
	sock_put(raw_sk);
} else if (!flag) {	/* Free and report errors */
	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_PROT_UNREACH, 0);	
out:
	kfree_skb(skb);
}
}

return 0;


But in ip_run_ipprot the return value of ipprot->handler is just ignored,
code below:

if(skb2 != NULL) {
	ret = 1;
	ipprot->handler(skb2);
}

If I understand correctly it means that if we have two different protocols
with the same (modulo MAX_INET_PROTOS) protocol number then
ip_local_deliver will return the return value of ipprot->handler for the
first protocol in the chain
inet_protos[protocol number modulo MAX_INET_PROTOS] and *always zero* for the
second. Why? Is it a bug or I just do not understand something?

-- 
Alexey
