Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTFOJOz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 05:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTFOJOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 05:14:55 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:49794 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S261182AbTFOJOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 05:14:53 -0400
Date: Sun, 15 Jun 2003 13:26:56 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: [2.4] memleak in implementation of the IEEE 802.2 LLC protocol?
Message-ID: <20030615092656.GA23595@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   I am trying to teach smatch's unfree script of skbuffers as those could
   create memory leaks if not freed, and I come across this code in
   ./net/802/llc_sendpdu.c::llc_sendipdu() in 2.4.21 kernel:
                tmp=skb_clone(skb, GFP_ATOMIC);
                if(tmp!=NULL)
                {
                        tmp->dev = lp->dev;
                        dev_queue_xmit(skb);
                }
   (and tmp is not used anywhere else)

   Naturally looking at llc_sendipdu() function that have similar construction,
   I think that this small change should be done to avoid memleak
   and to make the code correct, what do you think?

===== net/802/llc_sendpdu.c 1.3 vs edited =====
--- 1.3/net/802/llc_sendpdu.c	Tue Feb  5 10:39:14 2002
+++ edited/net/802/llc_sendpdu.c	Sun Jun 15 13:23:39 2003
@@ -283,7 +283,7 @@
 		if(tmp!=NULL)
 		{
 			tmp->dev = lp->dev;
-			dev_queue_xmit(skb);
+			dev_queue_xmit(tmp);
 		}
 		resend_count++;
 		skb = skb->next;

Bye,
    Oleg
