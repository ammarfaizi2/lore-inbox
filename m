Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbTEBWIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 18:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbTEBWIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 18:08:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28622 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263128AbTEBWIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 18:08:43 -0400
Date: Fri, 02 May 2003 14:14:15 -0700 (PDT)
Message-Id: <20030502.141415.59652168.davem@redhat.com>
To: c-d.hailfinger.kernel.2003@gmx.net
Cc: fw@deneb.enyo.de, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
       hadi@cyberus.ca, robert.olsson@data.slu.se
Subject: Re: must-fix list for 2.6.0
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EB29CC8.1030305@gmx.net>
References: <87znm6c3fd.fsf@deneb.enyo.de>
	<1051790736.8772.23.camel@rth.ninka.net>
	<3EB29CC8.1030305@gmx.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
   Date: Fri, 02 May 2003 18:28:56 +0200

   David S. Miller wrote:
   
   >>Shall I post the exploit?
   > 
   > You can't expect us to act on anything based upon vague references
   > to "dst cache DoS" and things like that.
   
   http://marc.theaimsgroup.com/?l=linux-kernel&m=104956079213417

Yes, that thing.  We're working on a fix.

And, please, don't be silly wrt. exploit posting.  One exists
publicly for some time, just google for juno-z.101f.c  All the
script kiddies know where this thing is and what it does.  So if you
have something better, just post it.

Current patch looks something like this (there will be changes):

--- net/ipv4/route.c.~1~	Thu May  1 06:18:00 2003
+++ net/ipv4/route.c	Thu May  1 10:30:13 2003
@@ -194,19 +194,46 @@ struct rt_hash_bucket {
 static struct rt_hash_bucket 	*rt_hash_table;
 static unsigned			rt_hash_mask;
 static int			rt_hash_log;
+static unsigned int		rt_hash_rnd;
 
 struct rt_cache_stat rt_cache_stat[NR_CPUS];
 
 static int rt_intern_hash(unsigned hash, struct rtable *rth,
 				struct rtable **res);
 
-static __inline__ unsigned rt_hash_code(u32 daddr, u32 saddr, u8 tos)
+/* This bit mixing code is by Bob Jenkins.  He has a great set of documents
+ * about hash function analysis at:
+ *
+ * http://burtleburtle.net/bob/hash/
+ */
+
+#define __mix(a, b, c) \
+{ \
+  a -= b; a -= c; a ^= (c>>13); \
+  b -= c; b -= a; b ^= (a<<8); \
+  c -= a; c -= b; c ^= (b>>13); \
+  a -= b; a -= c; a ^= (c>>12);  \
+  b -= c; b -= a; b ^= (a<<16); \
+  c -= a; c -= b; c ^= (b>>5); \
+  a -= b; a -= c; a ^= (c>>3);  \
+  b -= c; b -= a; b ^= (a<<10); \
+  c -= a; c -= b; c ^= (b>>15); \
+}
+
+static unsigned int rt_hash_code(u32 daddr, u32 saddr, u8 tos)
 {
-	unsigned hash = ((daddr & 0xF0F0F0F0) >> 4) |
-			((daddr & 0x0F0F0F0F) << 4);
-	hash ^= saddr ^ tos;
-	hash ^= (hash >> 16);
-	return (hash ^ (hash >> 8)) & rt_hash_mask;
+	u32 a, b, c;
+
+	a = b = 0x9e3779b9;
+	c = rt_hash_rnd;
+
+	a += daddr;
+	b += saddr;
+	c += (u32) tos;
+
+	__mix(a, b, c);
+
+	return (c & rt_hash_mask);
 }
 
 static int rt_cache_get_info(char *buffer, char **start, off_t offset,
@@ -2461,6 +2488,9 @@ static int ip_rt_acct_read(char *buffer,
 void __init ip_rt_init(void)
 {
 	int i, order, goal;
+
+	rt_hash_rnd = (int) ((num_physpages ^ (num_physpages>>8)) ^
+			     (jiffies ^ (jiffies >> 7)));
 
 #ifdef CONFIG_NET_CLS_ROUTE
 	for (order = 0;
--- net/ipv4/netfilter/ip_conntrack_core.c.~1~	Thu May  1 09:24:17 2003
+++ net/ipv4/netfilter/ip_conntrack_core.c	Thu May  1 16:48:57 2003
@@ -104,20 +104,45 @@ ip_conntrack_put(struct ip_conntrack *ct
 	nf_conntrack_put(&ct->infos[0]);
 }
 
-static inline u_int32_t
+/* This bit mixing code is by Bob Jenkins.  He has a great set of documents
+ * about hash function analysis at:
+ *
+ * http://burtleburtle.net/bob/hash/
+ */
+
+#define __mix(a, b, c) \
+{ \
+  a -= b; a -= c; a ^= (c>>13); \
+  b -= c; b -= a; b ^= (a<<8); \
+  c -= a; c -= b; c ^= (b>>13); \
+  a -= b; a -= c; a ^= (c>>12);  \
+  b -= c; b -= a; b ^= (a<<16); \
+  c -= a; c -= b; c ^= (b>>5); \
+  a -= b; a -= c; a ^= (c>>3);  \
+  b -= c; b -= a; b ^= (a<<10); \
+  c -= a; c -= b; c ^= (b>>15); \
+}
+
+static int ip_conntrack_hash_rnd;
+
+static u_int32_t
 hash_conntrack(const struct ip_conntrack_tuple *tuple)
 {
+	unsigned int a, b, c;
+
 #if 0
 	dump_tuple(tuple);
 #endif
-	/* ntohl because more differences in low bits. */
-	/* To ensure that halves of the same connection don't hash
-	   clash, we add the source per-proto again. */
-	return (ntohl(tuple->src.ip + tuple->dst.ip
-		     + tuple->src.u.all + tuple->dst.u.all
-		     + tuple->dst.protonum)
-		+ ntohs(tuple->src.u.all))
-		% ip_conntrack_htable_size;
+	a = b = 0x9e3779b9;
+	c = ip_conntrack_hash_rnd;
+
+	a += tuple->src.ip;
+	b += (tuple->dst.ip ^ tuple->dst.protonum);
+	c += (tuple->src.u.all | (tuple->dst.u.all << 16));
+
+	__mix(a, b, c);
+
+	return (c % ip_conntrack_htable_size);
 }
 
 inline int
@@ -1411,6 +1436,9 @@ int __init ip_conntrack_init(void)
 {
 	unsigned int i;
 	int ret;
+
+	ip_conntrack_hash_rnd = (int) ((num_physpages ^ (num_physpages>>8)) ^
+				       (jiffies ^ (jiffies >> 7)));
 
 	/* Idea from tcp.c: use 1/16384 of memory.  On i386: 32MB
 	 * machine has 256 buckets.  >= 1GB machines have 8192 buckets. */
