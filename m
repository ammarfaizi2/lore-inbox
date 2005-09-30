Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbVI3JJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVI3JJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 05:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbVI3JJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 05:09:26 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:18623 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932548AbVI3JJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 05:09:25 -0400
Message-ID: <433D00BC.2070001@cosmosbay.com>
Date: Fri, 30 Sep 2005 11:09:16 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [NUMA , x86_64] Why memnode_shift is chosen with the lowest possible
 value ?
References: <1127939141.26401.32.camel@localhost.localdomain> <1127939593.26401.38.camel@localhost.localdomain> <20050928232027.28e1bb93.akpm@osdl.org> <p73k6h0jjh3.fsf@verdi.suse.de> <433BEED6.6000008@cosmosbay.com> <20050929134337.GF2720@wotan.suse.de> <433C1D6F.1030605@cosmosbay.com>
In-Reply-To: <433C1D6F.1030605@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------090308050008010906000909"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 30 Sep 2005 11:09:19 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090308050008010906000909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Eric Dumazet a écrit :
> Andi Kleen a écrit :
> 
>>> Using memnode_shift=33 would access only 2 bytes from this 
>>> memnodemap[], touching fewer cache lines (well , one cache line). 
>>> kfree() and friends would be slightly faster, at least cache friendly.
>>
>>
>>
>> Agreed. Please send a patch.
> 

My previous patch was not correct. Couly you please review this second version.

[PATCH] NUMA,x86_64 :
     Compute the highest possible value for memnode_shift,
     in order to reduce footprint of memnodemap[] to the minimum, thus
     making all users (phys_to_nid(), kfree()), more cache friendly.

Before the patch :

Node 0 MemBase 0000000000000000 Limit 00000001ffffffff
Node 1 MemBase 0000000200000000 Limit 00000003ffffffff
Using 23 for the hash shift. Max adder is 3ffffffff

After the patch :

Node 0 MemBase 0000000000000000 Limit 00000001ffffffff
Node 1 MemBase 0000000200000000 Limit 00000003ffffffff
Using 33 for the hash shift.

In this case, only 2 bytes of memnodemap[] are used, instead of 2048

Thank you

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------090308050008010906000909
Content-Type: text/plain;
 name="compute_hash_shift"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="compute_hash_shift"

--- linux-2.6.14-rc2/arch/x86_64/mm/numa.c	2005-09-20 05:00:41.000000000 +0200
+++ linux-2.6.14-rc2-ed/arch/x86_64/mm/numa.c	2005-09-30 11:04:18.000000000 +0200
@@ -38,38 +38,57 @@
 
 int numa_off __initdata;
 
-int __init compute_hash_shift(struct node *nodes, int numnodes)
+
+/*
+ * Given a shift value, try to populate memnodemap[]
+ * Returns :
+ * 1 if OK
+ * 0 if memnodmap[] too small (of shift too small)
+ * -1 if node overlap or lost ram (shift too big)
+ */
+static int __init populate_memnodemap(
+	const struct node *nodes, int numnodes, int shift)
 {
 	int i; 
-	int shift = 20;
-	unsigned long addr,maxend=0;
-	
-	for (i = 0; i < numnodes; i++)
-		if ((nodes[i].start != nodes[i].end) && (nodes[i].end > maxend))
-				maxend = nodes[i].end;
+	int res = -1;
+	unsigned long addr, end;
 
-	while ((1UL << shift) <  (maxend / NODEMAPSIZE))
-		shift++;
-
-	printk (KERN_DEBUG"Using %d for the hash shift. Max adder is %lx \n",
-			shift,maxend);
-	memset(memnodemap,0xff,sizeof(*memnodemap) * NODEMAPSIZE);
+	memset(memnodemap, 0xff, sizeof(memnodemap));
 	for (i = 0; i < numnodes; i++) {
-		if (nodes[i].start == nodes[i].end)
+		addr = nodes[i].start;
+		end = nodes[i].end;
+		if (addr >= end)
 			continue;
-		for (addr = nodes[i].start;
-		     addr < nodes[i].end;
-		     addr += (1UL << shift)) {
-			if (memnodemap[addr >> shift] != 0xff) {
-				printk(KERN_INFO
-	"Your memory is not aligned you need to rebuild your kernel "
-	"with a bigger NODEMAPSIZE shift=%d adder=%lu\n",
-					shift,addr);
+		if ((end >> shift) >= NODEMAPSIZE)
+			return 0;
+		do {
+			if (memnodemap[addr >> shift] != 0xff)
 				return -1;
-			} 
 			memnodemap[addr >> shift] = i;
-		} 
+			addr += (1 << shift);
+		} while (addr < end);
+		res = 1;
 	} 
+	return res;
+}
+
+int __init compute_hash_shift(struct node *nodes, int numnodes)
+{
+	int shift = 20;
+
+	while (populate_memnodemap(nodes, numnodes, shift + 1) >= 0)
+		shift++;
+
+	printk(KERN_DEBUG "Using %d for the hash shift.\n",
+		shift);
+
+	if (populate_memnodemap(nodes, numnodes, shift) != 1) {
+		printk(KERN_INFO
+	"Your memory is not aligned you need to rebuild your kernel "
+	"with a bigger NODEMAPSIZE shift=%d\n",
+			shift);
+		return -1;
+	}
 	return shift;
 }
 

--------------090308050008010906000909--
