Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbUDGTwD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264180AbUDGTwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:52:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:8326 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264186AbUDGTvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:51:36 -0400
Date: Thu, 8 Apr 2004 01:18:43 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Andrea Arcangeli <andrea@suse.de>, "David S. Miller" <davem@redhat.com>,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       paulmck@us.ibm.com, akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040407194842.GA4548@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040331171023.GA4543@in.ibm.com> <16491.4593.718724.277551@robur.slu.se> <20040331203750.GB4543@in.ibm.com> <20040331212817.GQ2143@dualathlon.random> <20040331214342.GD4543@in.ibm.com> <16497.37720.607342.193544@robur.slu.se> <20040405212220.GH4003@in.ibm.com> <16498.43191.733850.18276@robur.slu.se> <20040406195249.GA4581@in.ibm.com> <16500.7408.240318.350476@robur.slu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <16500.7408.240318.350476@robur.slu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 07, 2004 at 05:23:28PM +0200, Robert Olsson wrote:
> Dipankar Sarma writes:
> 
>  > Robert, you should try out rs-throttle-rcu.patch. The idea is that
>  > we don't run too many callbacks in a single rcu. In my setup,
>  > at 100kpps, I see as many as 30000 rcu callbacks in a single
>  > tasklet handler. That is likely hurting even the softirq-only
>  > RCU grace periods. Setting rcupdate.maxbatch=4 will do only 4 per
>  > tasklet thus providing more quiescent points to the system.
> 
> Hello!
> 
> No bad things happens, lots of overflows and drop in performance
> and the userland app can stall for 32 sec. We seems to spin in
> softirq to much and still don't get things done. 

Argh!! Andrea, this means that throttling rcu callbacks with
back-to-back rcu tasklets for better scheduling latency is bad
for this kind of DoS situation. I think we will have to address
the softirq limiting question.

That said, Robert, one last experiment - if you are running UP,
can you try the following patchset (should apply on top of vanilla
2.6.x) ? This implements direct invocation of callbacks instead
of waiting for rcu grace periods in UP kernel. This would be a
good data point to understand what happens.

Thanks
Dipankar

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rcu-rt-latency.patch"


A new interface call_rcu_rt() allows the updates to happen immediately
in a UP kernel. This assumes that no RCU protection is needed 
against interrupts.


 include/linux/rcupdate.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

diff -puN include/linux/rcupdate.h~rcu-rt-latency include/linux/rcupdate.h
--- linux-2.6.0-test8-rcu/include/linux/rcupdate.h~rcu-rt-latency	2003-11-30 19:54:09.000000000 +0530
+++ linux-2.6.0-test8-rcu-dipankar/include/linux/rcupdate.h	2003-11-30 21:39:50.000000000 +0530
@@ -131,6 +131,20 @@ extern void rcu_check_callbacks(int cpu,
 extern void FASTCALL(call_rcu(struct rcu_head *head, 
                           void (*func)(void *arg), void *arg));
 extern void synchronize_kernel(void);
+#if !defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+static inline void call_rcu_rt(struct rcu_head *head, 
+                          void (*func)(void *arg), void *arg)
+{
+	func(arg);
+}
+#else
+static inline void call_rcu_rt(struct rcu_head *head, 
+                          void (*func)(void *arg), void *arg)
+{
+	call_rcu(head, func, arg);
+}
+#endif
+
 
 #endif /* __KERNEL__ */
 #endif /* __LINUX_RCUPDATE_H */

_

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dcache-rcu-latency.patch"


Use the new call_rcu_rt() primitive to immediately free dentries
to slab for UP/CONFIG_PREEMPT. This should improve scheduling
latencies by reducing rcu callback processing time.


 fs/dcache.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/dcache.c~dcache-rcu-latency fs/dcache.c
--- linux-2.6.0-test8-rcu/fs/dcache.c~dcache-rcu-latency	2003-11-30 21:22:02.000000000 +0530
+++ linux-2.6.0-test8-rcu-dipankar/fs/dcache.c	2003-11-30 21:22:16.000000000 +0530
@@ -78,7 +78,7 @@ static void d_free(struct dentry *dentry
 {
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
- 	call_rcu(&dentry->d_rcu, d_callback, dentry);
+ 	call_rcu_rt(&dentry->d_rcu, d_callback, dentry);
 }
 
 /*

_

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rtcache-rcu-latency.patch"

 include/linux/rcupdate.h |    2 ++
 net/ipv4/route.c         |   26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff -puN net/ipv4/route.c~rtcache-rcu-latency net/ipv4/route.c
--- linux-2.6.0-test8-rcu/net/ipv4/route.c~rtcache-rcu-latency	2003-12-15 01:42:09.000000000 +0530
+++ linux-2.6.0-test8-rcu-dipankar/net/ipv4/route.c	2003-12-15 02:15:13.000000000 +0530
@@ -223,11 +223,11 @@ static struct rtable *rt_cache_get_first
 	struct rt_cache_iter_state *st = seq->private;
 
 	for (st->bucket = rt_hash_mask; st->bucket >= 0; --st->bucket) {
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		r = rt_hash_table[st->bucket].chain;
 		if (r)
 			break;
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 	}
 	return r;
 }
@@ -239,10 +239,10 @@ static struct rtable *rt_cache_get_next(
 	smp_read_barrier_depends();
 	r = r->u.rt_next;
 	while (!r) {
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 		if (--st->bucket < 0)
 			break;
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		r = rt_hash_table[st->bucket].chain;
 	}
 	return r;
@@ -278,7 +278,7 @@ static void *rt_cache_seq_next(struct se
 static void rt_cache_seq_stop(struct seq_file *seq, void *v)
 {
 	if (v && v != SEQ_START_TOKEN)
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 }
 
 static int rt_cache_seq_show(struct seq_file *seq, void *v)
@@ -436,13 +436,13 @@ static struct file_operations rt_cpu_seq
   
 static __inline__ void rt_free(struct rtable *rt)
 {
-	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
+	call_rcu_rt(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
 }
 
 static __inline__ void rt_drop(struct rtable *rt)
 {
 	ip_rt_put(rt);
-	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
+	call_rcu_rt(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
 }
 
 static __inline__ int rt_fast_clean(struct rtable *rth)
@@ -2216,7 +2216,7 @@ int __ip_route_output_key(struct rtable 
 
 	hash = rt_hash_code(flp->fl4_dst, flp->fl4_src ^ (flp->oif << 5), flp->fl4_tos);
 
-	rcu_read_lock();
+	rcu_read_lock_bh();
 	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
 		smp_read_barrier_depends();
 		if (rth->fl.fl4_dst == flp->fl4_dst &&
@@ -2232,13 +2232,13 @@ int __ip_route_output_key(struct rtable 
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
 			RT_CACHE_STAT_INC(out_hit);
-			rcu_read_unlock();
+			rcu_read_unlock_bh();
 			*rp = rth;
 			return 0;
 		}
 		RT_CACHE_STAT_INC(out_hlist_search);
 	}
-	rcu_read_unlock();
+	rcu_read_unlock_bh();
 
 	return ip_route_output_slow(rp, flp);
 }
@@ -2448,7 +2448,7 @@ int ip_rt_dump(struct sk_buff *skb,  str
 		if (h < s_h) continue;
 		if (h > s_h)
 			s_idx = 0;
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		for (rt = rt_hash_table[h].chain, idx = 0; rt;
 		     rt = rt->u.rt_next, idx++) {
 			smp_read_barrier_depends();
@@ -2459,12 +2459,12 @@ int ip_rt_dump(struct sk_buff *skb,  str
 					 cb->nlh->nlmsg_seq,
 					 RTM_NEWROUTE, 1) <= 0) {
 				dst_release(xchg(&skb->dst, NULL));
-				rcu_read_unlock();
+				rcu_read_unlock_bh();
 				goto done;
 			}
 			dst_release(xchg(&skb->dst, NULL));
 		}
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 	}
 
 done:
diff -puN include/linux/rcupdate.h~rtcache-rcu-latency include/linux/rcupdate.h
--- linux-2.6.0-test8-rcu/include/linux/rcupdate.h~rtcache-rcu-latency	2003-12-15 02:15:22.000000000 +0530
+++ linux-2.6.0-test8-rcu-dipankar/include/linux/rcupdate.h	2003-12-22 23:31:14.588119016 +0530
@@ -123,6 +123,8 @@ static inline int rcu_pending(int cpu) 
 
 #define rcu_read_lock()		preempt_disable()
 #define rcu_read_unlock()	preempt_enable()
+#define rcu_read_lock_bh()	local_bh_disable()
+#define rcu_read_unlock_bh()	local_bh_enable()
 
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);

_

--9amGYk9869ThD9tj--
