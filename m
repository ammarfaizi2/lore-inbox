Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVIMWMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVIMWMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVIMWMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:12:31 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62187
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932491AbVIMWMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:12:30 -0400
Date: Tue, 13 Sep 2005 15:12:16 -0700 (PDT)
Message-Id: <20050913.151216.48124942.davem@davemloft.net>
To: kiran@scalex86.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       bharata@in.ibm.com, shai@scalex86.org, rusty@rustcorp.com.au,
       netdev@vger.kernel.org
Subject: Re: [patch 9/11] net: dst_entry.refcount, use, lastuse to use
 alloc_percpu
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050913220737.GA6249@localhost.localdomain>
References: <20050913161708.GK3570@localhost.localdomain>
	<20050913.132442.53540386.davem@davemloft.net>
	<20050913220737.GA6249@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravikiran G Thirumalai <kiran@scalex86.org>
Date: Tue, 13 Sep 2005 15:07:37 -0700

> Agreed the dst changes are ugly; that can be worked on.  But the
> cacheline bouncing problem on the atomic_t dst_entry refcounter has
> been around for quite a while -- even on SMPs, not just NUMA.  We
> need a solution for that.  I thought you were against the dst_entry
> bloat caused by the previous version of the dst patch.  alloc_percpu
> takes that away.  You had concerns about workloads with low route
> locality. Unfortunately we don't have access to infrastructure setup
> for such tests :(

You don't have two computers connected on a network?

All you need is that, load a bunch of routes into one system that
point to an IP address which you just force an ARP entry for (so it
just gets lost in the ether) and then generate a rDOS workload through
it from another machine using pktgen.

I'm fine with funny per-cpu memory allocation strategies, perhaps
(would have to see a patch doing _only_ that to be sure).

But using bigrefs, no way.  We have enough trouble making the data
structures small without adding bloat like that.  A busy server can
have hundreds of thousands of dst cache entries active on it, and they
chew up enough memory as is.
