Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVD0A46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVD0A46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 20:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVD0A46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 20:56:58 -0400
Received: from [62.206.217.67] ([62.206.217.67]:29889 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261871AbVD0A44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 20:56:56 -0400
Message-ID: <426EE350.1070902@trash.net>
Date: Wed, 27 Apr 2005 02:56:48 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Yair@arx.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
References: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au> <426D0CB9.4060500@trash.net> <20050425213400.GB29288@gondor.apana.org.au> <426D8672.1030001@trash.net> <20050426003925.GA13650@gondor.apana.org.au> <426E3F67.8090006@trash.net> <20050426232857.GA18358@gondor.apana.org.au>
In-Reply-To: <20050426232857.GA18358@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Let's look at the bigger picture.  There are three users of
> ip_route_me_harder: nat, mangle and queue.  They're all done
> in LOCAL_OUT.
> 
> For nat/mangle, the source address cannot change so it's
> guaranteed to be a local IP address.  On the face of it,
> queue could be changing the source address.  However, the
> more I think about it the more I reckon that it should
> be disallowed.

The ipt_REJECT target can send TCP RSTs with foreign source which
go through LOCAL_OUT. Restricting it to this case and adding proper
checks to ipt_REJECT would relieve us of having to handle the last
case you pointed out (foreign saddr, broadcast/multicast daddr), but
it shouldn't be hard to also handle this case.

> If the user is changing the source address in LOCAL_OUT/queue
> then he's doing SNAT in LOCAL_OUT.  This violates some fundamental
> assumptions in netfilter.  The user also isn't going to have
> an easy time setting up the reverse DNAT since the corresponding
> location on the reverse side does not have a ip_route_me_harder
> call.

These assumptions are only for stateful NAT, the mangle table seems
to try to deal with stateless NAT by rerouting in LOCAL_OUT when
saddr/daddr changed. But it could also just be some left-over
cut-n-pasted from ip_nat_standalone.c, I don't think anyone is doing
stateless NAT with netfilter.

Regards
Patrick
