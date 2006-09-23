Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWIWV4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWIWV4E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 17:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWIWV4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 17:56:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57800
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750738AbWIWV4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 17:56:01 -0400
Date: Sat, 23 Sep 2006 14:56:00 -0700 (PDT)
Message-Id: <20060923.145600.51855973.davem@davemloft.net>
To: mostrows@earthlink.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       ppp-bugs@dp.samba.org
Subject: Re: [PATCH] Advertise PPPoE MTU / avoid memory leak.
From: David Miller <davem@davemloft.net>
In-Reply-To: <115903262344-git-send-email-mostrows@earthlink.net>
References: <115903262344-git-send-email-mostrows@earthlink.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: mostrows@earthlink.net
Date: Sat, 23 Sep 2006 12:30:23 -0500

> __pppoe_xmit must free any skb it allocates if there is an error
> submitting the skb downstream.

This isn't right, dev_queue_xmit() can return -ENETDOWN and still
free the SKB, so your change will cause the SKB to be freed up
twice in that case, from dev_queue_xmit():

	rc = -ENETDOWN;
	rcu_read_unlock_bh();

out_kfree_skb:
	kfree_skb(skb);
	return rc;

dev_queue_xmit() is basically expected to consume the packet,
error or not.

What case of calling dev_queue_xmit() did you discover that did not
kfree the SKB on error?  We should fix that.  On a quick scan on the
entire dev_queue_xmit() implmentation, I cannot find such a case.
