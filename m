Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267504AbUJOXzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUJOXzj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 19:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUJOXzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 19:55:39 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12249 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267504AbUJOXzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 19:55:37 -0400
Subject: Re: tun.c patch to fix "smp_processor_id() in preemptible code"
From: Lee Revell <rlrevell@joe-job.com>
To: Alain Schroeder <alain@parkautomat.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <1097876587.4170.16.camel@marvin.home.parkautomat.net>
References: <1097876587.4170.16.camel@marvin.home.parkautomat.net>
Content-Type: text/plain
Message-Id: <1097879702.6737.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 18:35:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 17:43, Alain Schroeder wrote:
> I was getting these traces on a SMP host:

Your patch:

+       preempt_disable();
        netif_rx_ni(skb);
+       preempt_enable();

just wraps this code in preempt_disable/enable:

static inline int netif_rx_ni(struct sk_buff *skb)
{
       int err = netif_rx(skb);
       if (softirq_pending(smp_processor_id()))
               do_softirq();
       return err;
}

Isn't this considered an incorrect use of preempt_disable/enable?  My
reasoning is that if this was correct we would see preempt_dis/enable
sprinkled all over the code which it isn't.

Why do you have to call do_softirq like that?  I was under the
impression that you raise a softirq and it gets run later.

Lee

