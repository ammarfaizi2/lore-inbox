Return-Path: <linux-kernel-owner+w=401wt.eu-S1751072AbWLLDrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWLLDrF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 22:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWLLDrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 22:47:05 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:53382 "EHLO Smtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751072AbWLLDrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 22:47:03 -0500
Date: Tue, 12 Dec 2006 04:47:14 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] Introduce jiffies_32 and related compare functions
In-reply-to: <20061211.173100.74720551.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <457E2642.2000103@cosmosbay.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_A35qnBxV1uA7CL68MNshTg)"
References: <200612112027.kBBKR4nG006298@shell0.pdx.osdl.net>
 <457DCC60.3050006@cosmosbay.com> <457DE27E.5000100@cosmosbay.com>
 <20061211.173100.74720551.davem@davemloft.net>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_A35qnBxV1uA7CL68MNshTg)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT

David Miller a écrit :
> From: Eric Dumazet <dada1@cosmosbay.com>
> Date: Mon, 11 Dec 2006 23:58:06 +0100
> 
>> Some subsystems dont need more than 32bits timestamps.
>>
>> See for example net/ipv4/inetpeer.c and include/net/tcp.h :
>> #define tcp_time_stamp            ((__u32)(jiffies))
>>
>>
>> Because most timeouts should work with 'normal jiffies' that are 32bits on 
>> 32bits platforms, it makes sense to be able to use only 32bits to store them 
>> and not 64 bits, to save ram.
>>
>> This patch introduces jiffies_32, and related comparison functions 
>> time_after32(), time_before32(), time_after_eq32() and time_before_eq32().
>>
>> I plan to use this infrastructure in network code for example (struct 
>> dst_entry comes to mind).
> 
> The TCP case is because the protocol limits the size of
> the timestamp we can store in the TCP Timestamp option.
> 
> Otherwise we would use the full 64-bit jiffies timestamp,
> in order to have a larger window of values which would not
> overflow.
> 
> Since there is no protocol limitation involved in cases
> such as dst_entry, I think we should keep it at 64-bits
> on 64-bit platforms to make the wrap-around window as
> large as possible.
> 
> I really don't see any reason to make these changes.  Yes,
> you'd save some space, but one of the chief advantages of
> 64-bit is that we get larger jiffies value windows.  If
> that has zero value, as your intended changes imply, then
> we shouldn't need the default 64-bit jiffies either, by
> implication.

Well, just to have similar functions to manipulate jiffies.

We already know that using a 32bits dtime in struct inet_peer permited an 
object size of 64 bytes instead of 128 bytes (on 64bits platforms)

On one machine (running linux-2.6.16) I have :

# grep peer /proc/slabinfo
inet_peer_cache    65972  86220    128   30    1 : tunables  120   60    8 : 
slabdata   2874   2874    262

(So the 128 bytes -> 64 bytes is going to save 1437 pages of memory)

# grep dst /proc/slabinfo
ip_dst_cache      1765818 2077380    320   12    1 : tunables   54   27    8 : 
slabdata 173115 173115     39

(So saving 4*4 bytes per dst might save 32 MB of ram).
I doubt being able to extend the expiration of a dst above 2^32 ticks (49 days 
if HZ=1000, 198 days if HZ=250) is worth the ram wastage.

Dont you prefer to be able to apply this patch for example ?

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary_(ID_A35qnBxV1uA7CL68MNshTg)
Content-type: text/plain; name=inetpeer.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=inetpeer.patch

--- linux/net/ipv4/inetpeer.c.orig	2006-12-12 05:25:42.000000000 +0100
+++ linux-ed/net/ipv4/inetpeer.c	2006-12-12 05:29:22.000000000 +0100
@@ -338,8 +338,7 @@ static int cleanup_once(unsigned long tt
 	spin_lock_bh(&inet_peer_unused_lock);
 	p = inet_peer_unused_head;
 	if (p != NULL) {
-		__u32 delta = (__u32)jiffies - p->dtime;
-		if (delta < ttl) {
+		if (time_after32(p->dtime + ttl, jiffies_32)) {
 			/* Do not prune fresh entries. */
 			spin_unlock_bh(&inet_peer_unused_lock);
 			return -1;
@@ -466,7 +465,7 @@ void inet_putpeer(struct inet_peer *p)
 		p->unused_next = NULL;
 		*inet_peer_unused_tailp = p;
 		inet_peer_unused_tailp = &p->unused_next;
-		p->dtime = (__u32)jiffies;
+		p->dtime = jiffies_32;
 	}
 	spin_unlock_bh(&inet_peer_unused_lock);
 }

--Boundary_(ID_A35qnBxV1uA7CL68MNshTg)--
