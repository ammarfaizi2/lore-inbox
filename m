Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270486AbUJTUCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270486AbUJTUCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270502AbUJTT6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:58:10 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:21938 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269214AbUJTTxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:53:25 -0400
Subject: Re: [PATCH] Make netif_rx_ni preempt-safe
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       linux-kernel@gondor.apana.org.au, maxk@qualcomm.com,
       irda-users@lists.sourceforge.net,
       Linux Network Development <netdev@oss.sgi.com>,
       Alain Schroeder <alain@parkautomat.net>
In-Reply-To: <200410202214.31791.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1098230132.23628.28.camel@krustophenia.net>
	 <200410201811.44419.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1098290858.1429.70.camel@krustophenia.net>
	 <200410202214.31791.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1098302001.2268.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 15:53:21 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 15:14, Denis Vlasenko wrote:
> On Wednesday 20 October 2004 19:47, Lee Revell wrote:
> > On Wed, 2004-10-20 at 11:11, Denis Vlasenko wrote:
> > > 0x57 == 87 bytes is too big for inline.
> > 
> > Ugh.  So the only fix is not to inline it?
> 
> Yes.
> 
> You can make it conditionally inline/non-inline
> depending on SMP/preempt if you feel masochistic today :),
> but last time I asked davem thought that it is over the top.

I agree, not worth the trouble.  This would actually depend only on
PREEMPT and not SMP.

OK, third try.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- include/linux/netdevice.h~	2004-10-20 15:51:00.000000000 -0400
+++ include/linux/netdevice.h	2004-10-20 15:51:54.000000000 -0400
@@ -694,11 +694,14 @@
 /* Post buffer to the network code from _non interrupt_ context.
  * see net/core/dev.c for netif_rx description.
  */
-static inline int netif_rx_ni(struct sk_buff *skb)
+static int netif_rx_ni(struct sk_buff *skb)
 {
-       int err = netif_rx(skb);
+       int err;
+       preempt_disable();
+       err = netif_rx(skb);
        if (softirq_pending(smp_processor_id()))
                do_softirq();
+       preempt_enable();
        return err;
 }
 


