Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWA0CpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWA0CpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 21:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWA0CpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 21:45:17 -0500
Received: from mail.dvmed.net ([216.237.124.58]:34745 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964843AbWA0CpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 21:45:15 -0500
Message-ID: <43D98915.6040004@pobox.com>
Date: Thu, 26 Jan 2006 21:44:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Francois Romieu <romieu@fr.zoreil.com>, mingo@elte.hu, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, davem@redhat.com
Subject: Re: [lock validator] drivers/net/8139too.c: deadlock?
References: <E1F2JFb-0007MW-00@gondolin.me.apana.org.au>
In-Reply-To: <E1F2JFb-0007MW-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Herbert Xu wrote: > You've got it. > > rx_poll =>
	rtl8139_rx => netif_receive_skb => ... => tcp_v4_rcv > > In fact once
	we're at netif_receive_skb it's easy to see how we'll grab > xmit_lock
	again. > > Prescription: Move TX timeout handling into a work queue.
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> You've got it.
> 
> rx_poll => rtl8139_rx => netif_receive_skb => ... => tcp_v4_rcv
> 
> In fact once we're at netif_receive_skb it's easy to see how we'll grab
> xmit_lock again.
> 
> Prescription: Move TX timeout handling into a work queue.


This was my recommendation as well.

Using a work queue not only solves this locking problem, but it also 
enables the possibility of sleeping, a common operation during the 
hardware resets that often occur during ->tx_timeout()

Anyone who wants to make this change in a driver, don't forget that this 
could race with other operations, notably dev->stop() or suspend.

	Jeff


