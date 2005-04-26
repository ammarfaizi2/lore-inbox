Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVDZX3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVDZX3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 19:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVDZX3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 19:29:40 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:30726 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261846AbVDZX3Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 19:29:25 -0400
Date: Wed, 27 Apr 2005 09:28:57 +1000
To: Patrick McHardy <kaber@trash.net>
Cc: Yair@arx.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
Message-ID: <20050426232857.GA18358@gondor.apana.org.au>
References: <E1DQ1Ct-00055s-00@gondolin.me.apana.org.au> <426D0CB9.4060500@trash.net> <20050425213400.GB29288@gondor.apana.org.au> <426D8672.1030001@trash.net> <20050426003925.GA13650@gondor.apana.org.au> <426E3F67.8090006@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426E3F67.8090006@trash.net>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 03:17:27PM +0200, Patrick McHardy wrote:
> 
> Looks like we have no choice but to also use saddr=0 and
> ip_route_output() in this case.

Let's look at the bigger picture.  There are three users of
ip_route_me_harder: nat, mangle and queue.  They're all done
in LOCAL_OUT.

For nat/mangle, the source address cannot change so it's
guaranteed to be a local IP address.  On the face of it,
queue could be changing the source address.  However, the
more I think about it the more I reckon that it should
be disallowed.

If the user is changing the source address in LOCAL_OUT/queue
then he's doing SNAT in LOCAL_OUT.  This violates some fundamental
assumptions in netfilter.  The user also isn't going to have
an easy time setting up the reverse DNAT since the corresponding
location on the reverse side does not have a ip_route_me_harder
call.

Even if there is really a demand for SNAT in LOCAL_OUT, we
should probably be implementing it properly rather than having
the user craft their own in user-space.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
