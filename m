Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269930AbUJSWFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269930AbUJSWFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbUJSV7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:59:21 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34531 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269930AbUJSVxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:53:09 -0400
Subject: Re: tun.c patch to fix "smp_processor_id() in preemptible code"
From: Lee Revell <rlrevell@joe-job.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Network Development <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E1CK1e6-0004F3-00@gondolin.me.apana.org.au>
References: <E1CK1e6-0004F3-00@gondolin.me.apana.org.au>
Content-Type: text/plain
Message-Id: <1098222676.23367.18.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 17:51:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 17:35, Herbert Xu wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > I looked at Robert Love's book and I am still unclear on the use of
> > do_softirq above.  To reiterate the question:  why does netif_rx_ni have
> > to manually flush any pending softirqs on the current proccessor after
> > doing the rx?  Is this just a performance hack?
> 
> Yes it allows the packet to be processed immediately.

Ok, here is the correct patch.  If this is really just a matter of
performance, and not required for correctness, disabling preemption is
broken, right?

Lee

--- include/linux/netdevice.h~	2004-10-15 20:19:33.000000000 -0400
+++ include/linux/netdevice.h	2004-10-19 17:47:03.000000000 -0400
@@ -697,8 +697,6 @@
 static inline int netif_rx_ni(struct sk_buff *skb)
 {
        int err = netif_rx(skb);
-       if (softirq_pending(smp_processor_id()))
-               do_softirq();
        return err;
 }


