Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWIXMai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWIXMai (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 08:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWIXMai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 08:30:38 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:16559 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750865AbWIXMah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 08:30:37 -0400
Subject: Re: [PATCH] Advertise PPPoE MTU / avoid memory leak.
From: Michal Ostrowski <mostrows@earthlink.net>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       ppp-bugs@dp.samba.org
In-Reply-To: <20060923.145600.51855973.davem@davemloft.net>
References: <115903262344-git-send-email-mostrows@earthlink.net>
	 <20060923.145600.51855973.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 24 Sep 2006 07:29:25 -0500
Message-Id: <1159100966.23197.293.camel@brick.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-23 at 14:56 -0700, David Miller wrote:
> From: mostrows@earthlink.net
> Date: Sat, 23 Sep 2006 12:30:23 -0500
> 
> > __pppoe_xmit must free any skb it allocates if there is an error
> > submitting the skb downstream.
> 
> This isn't right, dev_queue_xmit() can return -ENETDOWN and still
> free the SKB, so your change will cause the SKB to be freed up
> twice in that case, from dev_queue_xmit():
> 
> 	rc = -ENETDOWN;
> 	rcu_read_unlock_bh();
> 
> out_kfree_skb:
> 	kfree_skb(skb);
> 	return rc;
> 
> dev_queue_xmit() is basically expected to consume the packet,
> error or not.
> 
> What case of calling dev_queue_xmit() did you discover that did not
> kfree the SKB on error?  We should fix that.  On a quick scan on the
> entire dev_queue_xmit() implmentation, I cannot find such a case.
> 

I think the call path via dev->hard_start_xmit, if it fails, may result
in an skb not being freed.  This appears to be the case with the e100.c
driver.  The qdisc_restart path to dev->hard_start_xmit also appears
susceptible to this.  It appears that not all devices agree as to who
should clean-up an skb on error.

-- 
Michal Ostrowski <mostrows@earthlink.net>

