Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUHSCUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUHSCUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 22:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbUHSCUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 22:20:49 -0400
Received: from smtp3.akamai.com ([63.116.109.25]:65511 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S266474AbUHSCUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 22:20:23 -0400
Message-ID: <41240E63.CAD19093@akamai.com>
Date: Wed, 18 Aug 2004 19:20:19 -0700
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: netdev@oss.sgi.com
CC: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: ip_evictor can loop
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Code has changed in  2.6 here, but still
ip_frag_mem is dynamic;  While getting and
releasing locks,  something can be inserted
in the lru list, while one item can be deleted
in overlapping manner.

If the traffic is like  there is more traffic
coming in than can be freed, then  ip_evictor
code may loop as long as ip_frag_mem will be
more than low threshold.

There should be some way of getting out of
this loop.

If I am not missing something, fixes are
1. Calculating the goal ahead, and accounting
the memory freed as return values or arguments
from ipq_destroy etc. would be one fix.
2. After calling ip_evictor,  ip_defrag() code should
make second check on high threshold and should
not queue the packet,  if we are under
attack or pressure.

-----
The code is given below

ip_fragment.c:

/* Memory limiting on fragments.  Evictor trashes the oldest
 * fragment queue until we are back under the low threshold.
 */
static void ip_evictor(void)
{
        struct ipq *qp;
        struct list_head *tmp;

        for(;;) {
                if (atomic_read(&ip_frag_mem) <=
sysctl_ipfrag_low_thresh)
                        return;

                read_lock(&ipfrag_lock);
                if (list_empty(&ipq_lru_list)) {
                        read_unlock(&ipfrag_lock);
                        return;
                }
                tmp = ipq_lru_list.next;
                qp = list_entry(tmp, struct ipq, lru_list);
                atomic_inc(&qp->refcnt);
                read_unlock(&ipfrag_lock);

                spin_lock(&qp->lock);
                if (!(qp->last_in&COMPLETE))
                        ipq_kill(qp);               /*  -----> gets
write lock  ipfrag_lock */
                spin_unlock(&qp->lock);

                ipq_put(qp);
                IP_INC_STATS_BH(ReasmFails);
        }
}


------
Fix from Dave:
I think #1 is the ideal fix.

Do you understand that packet processing is dead on
the cpu executing this code?  That means the worst
possible case is that all cpus in the system enter this
loop, and they will absolutely make forward progress and
eventually bring the value back down under the low
threshold.

So you'd need a multi-processor system, one cpu sits in
the ip_evitor() loop and another gets exactly one fragment
each time the first cpu brings the limit below the low
threshold.  That is the only way to loop because otherwise
other cpus will work to lower the IP fragment memory usage
below the threshold.

I really think systems will get out of this lock-step state
very quickly even under enormous packet load.

Nevertheless I will add an implementation of #1 in the
tree.  Something like this:

===== net/ipv4/ip_fragment.c 1.8 vs edited =====
--- 1.8/net/ipv4/ip_fragment.c  2003-05-28 00:49:28 -07:00
+++ edited/net/ipv4/ip_fragment.c       2004-08-18 14:23:59 -07:00
@@ -168,14 +168,18 @@
 atomic_t ip_frag_mem = ATOMIC_INIT(0); /* Memory used for fragments */

 /* Memory Tracking Functions. */
-static __inline__ void frag_kfree_skb(struct sk_buff *skb)
+static __inline__ void frag_kfree_skb(struct sk_buff *skb, int *work)
 {
+       if (work)
+               *work -= skb->truesize;
        atomic_sub(skb->truesize, &ip_frag_mem);
        kfree_skb(skb);
 }

-static __inline__ void frag_free_queue(struct ipq *qp)
+static __inline__ void frag_free_queue(struct ipq *qp, int *work)
 {
+       if (work)
+               *work -= sizeof(struct ipq);
        atomic_sub(sizeof(struct ipq), &ip_frag_mem);
        kfree(qp);
 }
@@ -194,7 +198,7 @@
 /* Destruction primitives. */

 /* Complete destruction of ipq. */
-static void ip_frag_destroy(struct ipq *qp)
+static void ip_frag_destroy(struct ipq *qp, int *work)
 {
        struct sk_buff *fp;

@@ -206,18 +210,18 @@
        while (fp) {
                struct sk_buff *xp = fp->next;

-               frag_kfree_skb(fp);
+               frag_kfree_skb(fp, work);
                fp = xp;
        }

        /* Finally, release the queue descriptor itself. */
-       frag_free_queue(qp);
+       frag_free_queue(qp, work);
 }

-static __inline__ void ipq_put(struct ipq *ipq)
+static __inline__ void ipq_put(struct ipq *ipq, int *work)
 {
        if (atomic_dec_and_test(&ipq->refcnt))
-               ip_frag_destroy(ipq);
+               ip_frag_destroy(ipq, work);
 }

 /* Kill ipq entry. It is not destroyed immediately,
@@ -242,10 +246,13 @@
 {
        struct ipq *qp;
        struct list_head *tmp;
+       int work;

-       for(;;) {
-               if (atomic_read(&ip_frag_mem) <=
sysctl_ipfrag_low_thresh)
-                       return;
+       work = atomic_read(&ip_frag_mem) - sysctl_ipfrag_low_thresh;
+       if (work <= 0)
+               return;
+
+       while (work > 0) {
                read_lock(&ipfrag_lock);
                if (list_empty(&ipq_lru_list)) {
                        read_unlock(&ipfrag_lock);
@@ -261,7 +268,7 @@
                        ipq_kill(qp);
                spin_unlock(&qp->lock);

-               ipq_put(qp);
+               ipq_put(qp, &work);
                IP_INC_STATS_BH(IpReasmFails);
        }
 }
@@ -293,7 +300,7 @@
        }
 out:
        spin_unlock(&qp->lock);
-       ipq_put(qp);
+       ipq_put(qp, NULL);
 }

 /* Creation primitives. */
@@ -316,7 +323,7 @@
                        atomic_inc(&qp->refcnt);
                        write_unlock(&ipfrag_lock);
                        qp_in->last_in |= COMPLETE;
-                       ipq_put(qp_in);
+                       ipq_put(qp_in, NULL);
                        return qp;
                }
        }
@@ -505,7 +512,7 @@
                                qp->fragments = next;

                        qp->meat -= free_it->len;
-                       frag_kfree_skb(free_it);
+                       frag_kfree_skb(free_it, NULL);
                }
        }

@@ -656,7 +663,7 @@
                        ret = ip_frag_reasm(qp, dev);

                spin_unlock(&qp->lock);
-               ipq_put(qp);
+               ipq_put(qp, NULL);
                return ret;
        }

-----

Thanks,
Prasanna.

