Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSJPVDI>; Wed, 16 Oct 2002 17:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbSJPVDH>; Wed, 16 Oct 2002 17:03:07 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:699 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261413AbSJPVDD>;
	Wed, 16 Oct 2002 17:03:03 -0400
Message-ID: <3DADD6FD.E898DD61@us.ibm.com>
Date: Wed, 16 Oct 2002 16:15:41 -0500
From: Mala Anand <mkanand@us.ibm.com>
Organization: IBM Linux Technology Center
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@digeo.com, davem@redhat.com
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       hartner@austin.ibm.com, linux-net@vger.kernel.org
Subject: Skb initialization patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew & David-
 Attached is the skbinit patch for 2.5.38 kernel. The results
of SPECWeb99 were posted to lkml using this patch.  It showed
1.2% improvement in conforming connections. The results can be
found at:
http://marc.theaimsgroup.com/?l=lse-tech&m=103014598223558&w=2

I posted this patch as an RFC to lkml and the details can be
found here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102994936831586&w=2

The patch is very simple moving the initialization of skb from 
__kfree_skb to alloc_skb. Slab cache preserves the value of
the objects between uses. Looks like we were trying to take
advantage of this feature by initializing before freeing it
and this is good for UNI but for SMP there is no guarantee that
the freed skbs will be given back to the same CPU.  

The following are the results running Netperf3:
Pentium III 998 MHz 2-way system
Netperf3 tcp_stream test on an 2-way system using 2.5.38 SMP
kernel. One adapter one connection test with 64k socket buffer
and tcp no-delay ON. NAPI and TSO are disabled.

             2.5.38              2.5.40+patch      % Improvment      
Msg size     Throughput          Throughput       
(bytes)       Mbits/sec           Mbits/sec
512            568.7               579.8              2.0
1024           629.9               638.5              1.4
2048           673.4               682.1              1.3
4096           720.9               732.3              1.6
8192           779.6               799.8              2.6
16384          809.8               828.9              2.4
32768          757.6               772.1              1.9 
65536          743.9               764.8              2.8

2.5.38 kernel baseline profile for 512 msg size  - routines 
affected by the patch:

c02b09f0 alloc_skb                                  557 
c02b0c40 skb_release_data                           879 
c02b0cf0 kfree_skbmem                               262
c02b0d60 __kfree_skb                               1302  
      Total ticks spent in these routines:         3000 


2.5.38 kernel+skbinit patch profile for 512 msg size - 
routines affected by the patch:

c02b09f0 alloc_skb                                   987
c02b0ca0 skb_release_data                            671
c02b0d50 kfree_skbmem                                262
c02b0dc0 __kfree_skb                                1008 
     Total ticks spent in these routines:           2928

Let me know if you need more data.I realize the performance gain is
not substantial on the two workloads we tested. However the patch is
simple, safe and improves network performance to some extent.

diff -Naur linux-2538s/net/core/skbuff.c
linux-2538skbinit/net/core/skbuff.c
--- linux-2538s/net/core/skbuff.c	Wed Sep 25 10:58:25 2002
+++ linux-2538skbinit/net/core/skbuff.c	Tue Oct  8 11:38:35 2002
@@ -195,18 +195,38 @@
 		goto nodata;
 
 	/* XXX: does not include slab overhead */
+	skb->next	  = skb->prev = NULL;
+	skb->list	  = NULL;
+	skb->sk		  = NULL;
+	skb->stamp.tv_sec = 0;	/* No idea about time */
+	skb->dev	  = NULL;
+	skb->dst	  = NULL;
+	memset(skb->cb, 0, sizeof(skb->cb));
+        skb->len = 0;
+        skb->data_len = 0;
+	skb->csum = 0;
+	skb->cloned   = 0;
+	skb->pkt_type	  = PACKET_HOST;	/* Default type */
+	skb->ip_summed = 0;
+        skb->priority = 0;
+	atomic_set(&skb->users,1);
+	skb->security	  = 0;	/* By default packets are insecure */
 	skb->truesize = size + sizeof(struct sk_buff);
 
 	/* Load the data pointers. */
 	skb->head = skb->data = skb->tail = data;
 	skb->end  = data + size;
-
-	/* Set up other state */
-	skb->len      = 0;
-	skb->cloned   = 0;
-	skb->data_len = 0;
-
-	atomic_set(&skb->users, 1);
+	skb->destructor	  = NULL;
+#ifdef CONFIG_NETFILTER
+	skb->nfmark	  = skb->nfcache = 0;
+	skb->nfct	  = NULL;
+#ifdef CONFIG_NETFILTER_DEBUG
+	skb->nf_debug	  = 0;
+#endif
+#endif
+#ifdef CONFIG_NET_SCHED
+	skb->tc_index	  = 0;
+#endif
 	atomic_set(&(skb_shinfo(skb)->dataref), 1);
 	skb_shinfo(skb)->nr_frags  = 0;
 	skb_shinfo(skb)->tso_size = 0;
@@ -220,7 +240,6 @@
 	goto out;
 }
 
-
 /*
  *	Slab constructor for a skb head.
  */
@@ -328,7 +347,6 @@
 #ifdef CONFIG_NETFILTER
 	nf_conntrack_put(skb->nfct);
 #endif
-	skb_headerinit(skb, NULL, 0);  /* clean state */
 	kfree_skbmem(skb);
 }
 
@@ -1204,7 +1222,7 @@
 					      sizeof(struct sk_buff),
 					      0,
 					      SLAB_HWCACHE_ALIGN,
-					      skb_headerinit, NULL);
+					      NULL, NULL);
 	if (!skbuff_head_cache)
 		panic("cannot create skbuff cache");

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center 
   E-mail:mkanand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   Phone:512-838-8088
