Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263029AbVFXDda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbVFXDda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbVFXDdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:33:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19877
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263029AbVFXDcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:32:16 -0400
Date: Thu, 23 Jun 2005 20:32:09 -0700 (PDT)
Message-Id: <20050623.203209.102574546.davem@davemloft.net>
To: christoph@lameter.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, shai@scalex86.org,
       akpm@osdl.org
Subject: Re: [PATCH] dst numa: Avoid dst counter cacheline bouncing
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506232005030.28244@graphe.net>
References: <Pine.LNX.4.62.0506231953260.28244@graphe.net>
	<Pine.LNX.4.62.0506232005030.28244@graphe.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <christoph@lameter.com>
Date: Thu, 23 Jun 2005 20:10:06 -0700 (PDT)

> AIM7 results (tcp_test and udp_test) on i386 (IBM x445 8p 16G):
> 
> No patch	94788.2
> w/patch		97739.2 (+3.11%)
> 
> The numbers will be much higher on larger NUMA machines.

How much higher?  I don't believe it.  And %3 doesn't justify the
complexity (both in time and memory usage) added by this patch.

Performance of our stack's routing cache is _DEEPLY_ tied to the
size of the routing cache entries, of which dst entry is a member.
Every single byte counts.

You've exploded this to be (NR_NODES * sizeof(void *)) larger.  That
is totally unacceptable, even for NUMA.

Secondly, inlining the "for_each_online_node()" loops isn't very nice
either.

Consider making a per-node routing cache instead, just like the flow
cache is per-cpu, or make socket dst entries have a per-node array of
object pointers.  Fill the per-node array in lazily, just as you do
for the dst.  The first time you try to clone a dst on a cpu for a
socket, create the per-cpu entry slot.

We don't need to make them per-node system wide, only per-socket is
this really needed.

This way you do per-node walking when you detach the dst from the
socket at close() time, not at every dst_release() call, and thus for
every packet in the system.

In light of that, I don't see what the advantage is.  Instead of
atomic inc/dec on every packet sent in the system, you walk the whole
array of counters for every packet sent in the system.  If you really
get contention amongst nodes for a DST entry, this walk should result
in ReadToShare transactions, and thus cacheline movement, between the
NUMA nodes, on every __kfree_skb() call.

Essentially you're trading 1 atomic inc (ReadToOwn) and 1 atomic dec
(ReadToOwn) per packet for significant extra memory, much bigger code,
and 1 ReadToShare transaction per packet.

And since you're still using atomic_inc/atomic_dec you'll still hit
ReadToOwn transactions within the node.
