Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318432AbSHUQ5t>; Wed, 21 Aug 2002 12:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSHUQ5t>; Wed, 21 Aug 2002 12:57:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57051 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318432AbSHUQ5r>; Wed, 21 Aug 2002 12:57:47 -0400
Subject: Re: (RFC): SKB Initialization 
To: alan@lxorguk.ukuu.org.uk, davem@redhat.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Cc: "Bill Hartner" <bhartner@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF9AEE9308.79FD144F-ON87256C1C.004716B7@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Wed, 21 Aug 2002 11:59:44 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/21/2002 10:59:44 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a 2.5.25 patch that improves the skb header initialization
on SMP systems [for netperf].  The patch removes the constructor
for the skbuff_head_cache and moves the initialization of the skb
header from __free_skb to alloc_skb.

Since skbs freed on one CPU may end up being allocated on another cpu,
and often are, the initialization on the free side may not be the
right choice for SMP particularily if the free slab is then allocated
on another CPU.

I measured the cycles spent in initializing skb in the stock kernel
versus with the patch. I collected the cycles at the end of running
tcp_stream netperf test using 4KB message size, 64KB socket buffer
size, 2 adapter test on a 2-way system.

Two 996MHz Pentium III systems with 2 gigabit ethernet cards in each
one of them are used. The cycles are collected at the server
end.

The patch reduces the numer of cylces by 25%

Baseline on Linux 2.5.25 kernel:
-------------------------------

                                CPU 0                 CPU 1
                               ------                 ------
Avg cycles in alloc_skb:        64.05                 203.39
Avg cycles in __kfree_skb:     127.54                 228.95
                               ------                 -------
Total Avg Cycles               191.59                 432.34
                               ------                 -------

# of times alloc_skb called:      235,478            2,060,422
# of times __kfree_skb called:  2,063,276              232,359


Linux 2.5.25+Skbinit Patch:
--------------------------
                              CPU 0                   CPU 1
                              -----                   -----
 Avg cycles in alloc skb:     237.21                  230.91

 # of times alloc_skb called: 1,226,594             1,213,327



I also will collect the cycles of this init code in Specweb99 workload
and will post it later.



diff -Naur linux2.5.25/net/core/skbuff.c linux-525skb/net/core/skbuff.c
--- linux2.5.25/net/core/skbuff.c   Tue Aug 20 08:50:58 2002
+++ linux-525skb/net/core/skbuff.c  Wed Aug 21 08:51:52 2002
@@ -195,18 +195,37 @@
            goto nodata;

      /* XXX: does not include slab overhead */
+     skb->next     = skb->prev = NULL;
+     skb->list     = NULL;
+     skb->sk             = NULL;
+     skb->stamp.tv_sec = 0;  /* No idea about time */
+     skb->dev      = NULL;
+     skb->dst      = NULL;
+     memset(skb->cb, 0, sizeof(skb->cb));
+     skb->len      = 0;
+     skb->data_len = 0;
+     skb->csum = 0;
+     skb->cloned   = 0;
+     skb->pkt_type       = PACKET_HOST;  /* Default type */
+     skb->ip_summed      = 0;
+     skb->priority       = 0;
+     skb->security       = 0;      /* By default packets are insecure */
      skb->truesize = size + sizeof(struct sk_buff);
-
      /* Load the data pointers. */
      skb->head = skb->data = skb->tail = data;
      skb->end  = data + size;
-
-     /* Set up other state */
-     skb->len      = 0;
-     skb->cloned   = 0;
-     skb->data_len = 0;
-
      atomic_set(&skb->users, 1);
+     skb->destructor     = NULL;
+#ifdef CONFIG_NETFILTER
+     skb->nfmark   = skb->nfcache = 0;
+     skb->nfct     = NULL;
+#ifdef CONFIG_NETFILTER_DEBUG
+     skb->nf_debug       = 0;
+#endif
+#endif
+#ifdef CONFIG_NET_SCHED
+     skb->tc_index       = 0;
+#endif
      atomic_set(&(skb_shinfo(skb)->dataref), 1);
      skb_shinfo(skb)->nr_frags  = 0;
      skb_shinfo(skb)->frag_list = NULL;
@@ -326,7 +345,7 @@
 #ifdef CONFIG_NETFILTER
      nf_conntrack_put(skb->nfct);
 #endif
-     skb_headerinit(skb, NULL, 0);  /* clean state */
+     /* skb_headerinit(skb, NULL, 0);   clean state */
      kfree_skbmem(skb);
 }

@@ -1191,7 +1210,7 @@
                                    sizeof(struct sk_buff),
                                    0,
                                    SLAB_HWCACHE_ALIGN,
-                                   skb_headerinit, NULL);
+                                   NULL, NULL);
      if (!skbuff_head_cache)
            panic("cannot create skbuff cache");




Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.comdeveloperworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088


