Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314038AbSDLOf7>; Fri, 12 Apr 2002 10:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314052AbSDLOf6>; Fri, 12 Apr 2002 10:35:58 -0400
Received: from ynrfw28501.yr.com ([12.39.241.132]:55163 "EHLO
	nyc285ex01.nyc.corp.yr.com") by vger.kernel.org with ESMTP
	id <S314038AbSDLOfz> convert rfc822-to-8bit; Fri, 12 Apr 2002 10:35:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 12 Apr 2002 10:35:53 -0400
Message-ID: <D4CA6B275AA33241AC771F0C0B43A921011BE85F@nyc285ex01.nyc.corp.yr.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Index: AcHiL1a8dD4ctlKhRGmzQLP34e6C0A==
From: "Milam, Chad" <Chad_Milam@nyc.yr.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been looking into a problem on a couple of linux routers that 
I have.  All of them are used for routing between the private network 
and the Internet. Some run Check Point VPN-1 v4.1 SP5, some do not.  
The problem is that after about 22 hours, they all have "dst cache 
overflow", which is quite easily traced back to net/ipv4/route.c 
rt_garbage_collect().  rt_garbage_collect appears to be called or 
initiated from two places 1) the dst_ops structure 2) rt_intern_hash.

Based on my testing here is what I have come up with.... dst_ops.entries 
is not being set appropriately (or at least not what I would expect it 
to be). I determined this by changing dst_ops->gc to point to a new 
function (rt_display_tot) for debugging, as well as had rt_intern_hash() 
call this function instead of rt_garbage_collect().  

The sole purpose of this function was to loop through all hash chains and 
count up the entries that should be valid, do a printk("%d %d", count, 
dst_ops.entries), then return(rt_garbage_collect()).  The result was, that 
when rt_garbage_collect() returned 1 (dst cache overflow), the number of 
entries reported by dst_ops.entries was far different than the number 
reported by my loop/counter.  

Upon further investigation in to rt_free(), __dst_free(), and dst_destroy(), 
I found that only dst_destroy() decrements dst_ops.entries.

Furthermore, when dst_ops->gc returns 1, dst_alloc() will not create an 
entry, appropriately so, the box is at a stand still.  

So... For the interim, I have create a small patch that purges the dst cache 
table, and resets dst_ops.entries to 0 anytime rt_garbage_collect() returns 1.  
The result... The box stays up, and hums along quite happily.

I would appreciate any comments with regards to this matter.  I have also 
included a copy of the patch that I created to work around the issue.

Thanks,
Chad

diff -urNp linux-2.2.16cwm/net/ipv4/route.c linux-2.2.16cwm/net/ipv4/route.c
-n- linux-2.2.16/net/ipv4/route.c	Tue Jan  4 13:12:26 2000
+++ linux-2.2.16cwm/net/ipv4/route.c	Tue Apr  9 15:14:12 2002
@@ -96,7 +96,7 @@
 
 #define IP_MAX_MTU	0xFFF0
 
-#define RT_GC_TIMEOUT (300*HZ)
+#define RT_GC_TIMEOUT (120*HZ)
 
 int ip_rt_min_delay = 2*HZ;
 int ip_rt_max_delay = 10*HZ;
@@ -134,7 +134,8 @@ static struct dst_entry * ipv4_dst_rerou
 static struct dst_entry * ipv4_negative_advice(struct dst_entry *);
 static void		  ipv4_link_failure(struct sk_buff *skb);
 static int rt_garbage_collect(void);
-
+static int rt_delete_now(void);
+static int rt_garbage_ctl(void);
 
 struct dst_ops ipv4_dst_ops =
 {
@@ -142,7 +143,7 @@ struct dst_ops ipv4_dst_ops =
 	__constant_htons(ETH_P_IP),
 	RT_HASH_DIVISOR,
 
-	rt_garbage_collect,
+	rt_garbage_ctl,
 	ipv4_dst_check,
 	ipv4_dst_reroute,
 	NULL,
@@ -508,8 +509,7 @@ static int rt_garbage_collect(void)
 
 	if (atomic_read(&ipv4_dst_ops.entries) < ip_rt_max_size)
 		return 0;
-	if (net_ratelimit())
-		printk("dst cache overflow\n");
+
 	return 1;
 
 work_done:
@@ -570,7 +570,7 @@ restart:
 				int saved_int = ip_rt_gc_min_interval;
 				ip_rt_gc_elasticity = 1;
 				ip_rt_gc_min_interval = 0;
-				rt_garbage_collect();
+				rt_garbage_ctl();
 				ip_rt_gc_min_interval = saved_int;
 				ip_rt_gc_elasticity = saved_elasticity;
 				goto restart;
@@ -2045,4 +2045,44 @@ __initfunc(void ip_rt_init(void))
 	ent->read_proc = ip_rt_acct_read;
 #endif
 #endif
+}
+
+static int rt_delete_now(void){
+	struct rtable *rth, **rthp;
+	int i,ent1,ent2,c;
+
+	i=0;
+	ent1=0;
+	ent2=0;
+	c=0;
+
+	ent1=atomic_read(&ipv4_dst_ops.entries);
+	start_bh_atomic();
+	while(i<RT_HASH_DIVISOR){
+		rthp=&rt_hash_table[i];
+		while((rth=*rthp)!=NULL){
+			*rthp=rth->u.rt_next;
+			rth->u.rt_next=NULL;
+			c+=1;
+			rt_free(rth);
+		}
+		i++;
+	}
+
+	atomic_set(&ipv4_dst_ops.entries,0);
+	end_bh_atomic();
+	ent2=atomic_read(&ipv4_dst_ops.entries);
+
+	if(net_ratelimit()){
+		printk("dst cache overflow\n");
+		printk("rt_delete_now(); s:%d e:%d t:%d\n",ent1,ent2,c);
+	}
+
+	return 0;
+}
+
+static int rt_garbage_ctl(void){
+	if(rt_garbage_collect())
+		rt_delete_now();
+	return 0;
 }
