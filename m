Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVHDDdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVHDDdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 23:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVHDDdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 23:33:39 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:8358 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S261747AbVHDDdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 23:33:38 -0400
Date: Thu, 4 Aug 2005 13:33:29 +1000
To: Guillaume Pelat <guillaume.pelat@winch-hebergement.net>
Cc: davem@davemloft.net, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 - kernel panic - BUG at net/ipv4/tcp_output.c:918
Message-ID: <20050804033329.GA14501@gondor.apana.org.au>
References: <42EDDE50.6050800@winch-hebergement.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EDDE50.6050800@winch-hebergement.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 08:33:20AM +0000, Guillaume Pelat wrote:
> 
> I just tried the patch attached. :)
> 
> The bug is still here (same symptoms), with a slightly different backtrace :
> ------------[ cut here ]------------
> kernel BUG at net/ipv4/tcp_output.c:918!

OK, let's try again :)

I bet it's the tcp_enter_cwr() call in tcp_transmit_skb().  So
the sequence is:

tcp_write_xmit
	cwnd_quota = tcp_cwnd_test
	tcp_transmit_skb
		tcp_enter_cwr
			tp->snd_cwnd = min(tp->snd_cwnd, in_flight + 1)

At this point cwnd_quota is out-of-sync with tp->snd_cwnd.

	cwnd_quota -= tcp_skb_pcount(skb)
	cwnd_quota > 0
	tcp_tso_should_defer
		BUG since tp->snd_cwnd is smaller than what
		cwnd_quota indicated.

So I suppose we should reset cwnd_quota after tcp_transmit_skb?

Perhaps we should only transmit one MSS in this case?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
