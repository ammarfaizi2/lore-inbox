Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVIAPoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVIAPoz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbVIAPoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:44:55 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:4286 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S1030208AbVIAPoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:44:54 -0400
Message-ID: <431721F0.6090402@cosmosbay.com>
Date: Thu, 01 Sep 2005 17:44:48 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] : struct dentry : place d_hash close to d_parent and d_name
 to speedup lookups
References: <20050901035542.1c621af6.akpm@osdl.org>
In-Reply-To: <20050901035542.1c621af6.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050405060203050402010402"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 01 Sep 2005 17:44:48 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050405060203050402010402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


dentry cache uses sophisticated RCU technology (and prefetching if available) 
but touches 2 cache lines per dentry during hlist lookup.

This patch moves d_hash in the same cache line than d_parent and d_name fields 
so that :

1) One cache line is needed instead of two.
2) the hlist_for_each_rcu() prefetching has a chance to bring all the needed 
data in advance, not only the part that includes d_hash.next.

I also changed one old comment that was wrong for 64bits.

A further optimisation would be to separate dentry in two parts, one that is 
mostly read, and one writen (d_count/d_lock) to avoid false sharing on 
SMP/NUMA but this would need different field placement depending on 32bits or 
64bits platform.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------050405060203050402010402
Content-Type: text/plain;
 name="dentry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dentry.patch"


--------------050405060203050402010402--
