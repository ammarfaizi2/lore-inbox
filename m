Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWAGIad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWAGIad (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 03:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWAGIad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 03:30:33 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:19608 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1030355AbWAGIac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 03:30:32 -0500
Message-ID: <43BF7C23.5070805@cosmosbay.com>
Date: Sat, 07 Jan 2006 09:30:27 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
Cc: ak@suse.de, paulmck@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       manfred@colorfullife.com, netdev@vger.kernel.org
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
References: <43BEA693.5010509@cosmosbay.com>	<20060106202626.GA5677@us.ibm.com>	<200601062157.42470.ak@suse.de> <20060106.161721.124249301.davem@davemloft.net>
In-Reply-To: <20060106.161721.124249301.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller a écrit :
> 
> Eric, how important do you honestly think the per-hashchain spinlocks
> are?  That's the big barrier from making rt_secret_rebuild() a simple
> rehash instead of flushing the whole table as it does now.
> 

No problem for me in going to a single spinlock.
I did the hashed spinlock patch in order to reduce the size of the route hash 
table and not hurting big NUMA machines. If you think a single spinlock is OK, 
that's even better !

> The lock is only grabbed for updates, and the access to these locks is
> random and as such probably non-local when taken anyways.  Back before
> we used RCU for reads, this array-of-spinlock thing made a lot more
> sense.
> 
> I mean something like this patch:
> 

> +static DEFINE_SPINLOCK(rt_hash_lock);


Just one point : This should be cache_line aligned, and use one full cache 
line to avoid false sharing at least. (If a cpu takes the lock, no need to 
invalidate *rt_hash_table for all other cpus)

Eric
