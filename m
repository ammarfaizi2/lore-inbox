Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWGaD4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWGaD4N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 23:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWGaD4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 23:56:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48524
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751069AbWGaD4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 23:56:12 -0400
Date: Sun, 30 Jul 2006 20:56:23 -0700 (PDT)
Message-Id: <20060730.205623.91207946.davem@davemloft.net>
To: Matt_Domsch@dell.com
Cc: herbert@gondor.apana.org.au, yoshfuji@linux-ipv6.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [IPV6]: Audit all ip6_dst_lookup/ip6_dst_store calls
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060731033210.GD31083@humbolt.us.dell.com>
References: <20060729043325.GA7035@gondor.apana.org.au>
	<20060730.154416.121293840.davem@davemloft.net>
	<20060731033210.GD31083@humbolt.us.dell.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Domsch <Matt_Domsch@dell.com>
Date: Sun, 30 Jul 2006 22:32:10 -0500

> swapper/0 is trying to acquire lock:
>  (slock-AF_INET6){-+..}, at: [<ffffffff80414fda>] sk_clone+0xd2/0x3a8
> 
> but task is already holding lock:
>  (slock-AF_INET6){-+..}, at: [<ffffffff883d71a8>] tcp_v6_rcv+0x30e/0x76e [ipv6]

The tcp_v6_rcv() code path is holding the slock on the parent
listening socket, whereas in sk_clone() we have grabbed the
socket slock on the newly allocated "newsk" socket.  These
are thus two seperate locks, although they are in the same
locking class "slock-AF_INET6".

I don't know why the lock validator is complaining about this.
