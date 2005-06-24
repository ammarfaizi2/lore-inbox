Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263118AbVFXE06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbVFXE06 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbVFXEYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:24:02 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58057
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263112AbVFXELu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:11:50 -0400
Date: Thu, 23 Jun 2005 21:11:40 -0700 (PDT)
Message-Id: <20050623.211140.131918815.davem@davemloft.net>
To: christoph@lameter.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, shai@scalex86.org,
       akpm@osdl.org, netdev@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] dst_entry structure use,lastuse and refcnt abstraction
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506232057340.29222@graphe.net>
References: <Pine.LNX.4.62.0506232047450.29103@graphe.net>
	<20050623.205447.66178303.davem@davemloft.net>
	<Pine.LNX.4.62.0506232057340.29222@graphe.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <christoph@lameter.com>
Date: Thu, 23 Jun 2005 21:06:30 -0700 (PDT)

> I am sure one can do better than that. The x445 is the smallest NUMA box 
> that I know of and the only one available in the context of that project. 
> But I am also not sure that this will reach proportions  that will 
> outweigh the complexity added by these patches. What would be 
> the performance benefit that we would need to see to feel that is 
> is right to get such a change in?

Something on the order of %10.  If I recall correctly, that's
basically what we got on SMP from the RCU changes to the routing
cache.

> Hmm. I like the idea of a separate routing cache per node. May actually 
> reach higher performance than splitting the counters. Lets think a bit 
> about that.

One thing that may happen down the line is that the flow cache
becomes a more unified thing.  Ie. local sockets get found there,
netfilter rules can match, as well as normal "routes".

The idea is that on a miss, you go down into the "slow" lookup path
where the data structure is less distributed (SMP and NUMA wise) and
slower to search.  And this populates the flow tables.

But that seems to work best on a per-cpu basis.

Unfortunately, it really doesn't address your problem in and of
itself.  This is because flow entries, especially when used on
sockets, would still get accessed by other cpus and thus nodes.
We would need to build something on top of the per-cpu flowcache,
such as the socket node array idea, to get something that helps
this NUMA issue as well.

Just tossing out some forward looking ideas :)

To be honest, the unified flow cache idea has been tossed around
a lot, and it's still intellectual masterbation.  But then again,
so was the design for the IPSEC stuff we have now for several years.
