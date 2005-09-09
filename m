Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVIIGVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVIIGVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 02:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVIIGVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 02:21:45 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:5465 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751126AbVIIGVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 02:21:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2Rq+fjO0w36gRRoHCCluySmKQ6fZeNJJkgwTqSmL+CCXVfgO6uYi/BoBIdcjr/QYWr0P8ENPAn57/0Z/nX+ASW6zhLRgQcAdU6igasVxCZPlP+zLCACY+MehW7SNOWeswfUy7o/VAD5cwUpozOOekuCV/QBvUTXOGaCKuypCzg8=  ;
Message-ID: <43212A1F.5040202@yahoo.com.au>
Date: Fri, 09 Sep 2005 16:22:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] lockless pagecache 5/7
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au> <4317F136.4040601@yahoo.com.au> <4317F17F.5050306@yahoo.com.au> <4317F1A2.8030605@yahoo.com.au> <4317F1BD.8060808@yahoo.com.au> <Pine.LNX.4.62.0509082227550.6098@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509082227550.6098@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> I wonder if it may not be better to use a seqlock for the tree_lock? A
> seqlock requires no writes at all if the tree has not been changed. RCU 
> still requires the incrementing of a (local) counter.
> 

Ah, but the seqlock's write side will cause cacheline bouncing in
the readside. Currently the lockless pagecache patches allow IO to
be busily populating one part of the cache while readers can look
up another part without any cacheline transfers.

Presumably you mean rcu_read_lock's preempt_disable(), however this
is a noop on non preempt kernels, and will almost certainly be hot
in cache in preempt kernels. What's more it should not cause bouncing.

> Using seqlocks would require reworking the readers so that they can 
> retry. Seqlocks provide already a verification that no update took place
> while the operation was in process. Thus we would be using an established 
> framework that insures that the speculation was successful.
> 
> The problem is then though to guarantee that the radix trees are always 
> traversable since the seqlock's retry rather than block. This would 
> require sequencing of inserts and pose a big problem for deletes and 
> updates.
> 

Well the lockless radix tree read side patches (which I have actually
updated to fix some bugs and be rebased on top of your nice cleanup)
do provide that the radix trees are always traversable.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
