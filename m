Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTKNEu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 23:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTKNEu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 23:50:57 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:4802 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262174AbTKNEux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 23:50:53 -0500
Date: Fri, 14 Nov 2003 10:27:14 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net,
       suparna@in.ibm.com, prasanna@in.ibm.com
Subject: Re: LKCD Network dump over netpoll patch (2.6.0-test9)
Message-ID: <20031114045714.GB18584@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20031110140742.GJ1409@in.ibm.com> <20031111005233.GV13246@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111005233.GV13246@waste.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is the patch to netpoll. This patch modifies the netpoll_poll() routine 
to include the zap_completion_queue() routine as suggested by Matt Mackall.

diff -urNp linux.orig/net/core/netpoll.c linux-2.6.0-test9/net/core/netpoll.c
--- linux.orig/net/core/netpoll.c	2003-11-13 05:22:20.000000000 +0530
+++ linux-2.6.0-test9/net/core/netpoll.c	2003-11-13 05:46:46.000000000 +0530
@@ -66,6 +66,7 @@ void netpoll_poll(struct netpoll *np)
 	if(trapped && np->dev->poll &&
 	   test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
 		np->dev->poll(np->dev, &budget);
+	zap_completion_queue();
 }
 
 static void refill_skbs(void)
@@ -115,8 +116,8 @@ static struct sk_buff * find_skb(struct 
 	unsigned long flags;
 	struct sk_buff *skb = NULL;
 
-repeat:
 	zap_completion_queue();
+repeat:
 	if (nr_skbs < MAX_SKBS)
 		refill_skbs();
 
@@ -165,7 +166,6 @@ repeat:
 		spin_unlock(&np->dev->xmit_lock);
 
 		netpoll_poll(np);
-		zap_completion_queue();
 		goto repeat;
 	}
 
-- 
Thanks & Regards
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-5044632
