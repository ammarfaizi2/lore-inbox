Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUKKI02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUKKI02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 03:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbUKKI01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 03:26:27 -0500
Received: from mail.asstra.pl ([217.153.152.34]:33931 "EHLO mail.asstra.pl")
	by vger.kernel.org with ESMTP id S262190AbUKKI0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 03:26:01 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IPSec: cleartext packets path for 2.6.9
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF04E350FB.B5E6A355-ONC2256F49.002E41FB-85256F49.00549F7C@asstra.by>
From: ilia.sotnikov@asstra.by
Date: Thu, 11 Nov 2004 10:25:47 +0200
X-MIMETrack: S/MIME Sign by Notes Client on Ilia Sotnikov/ASSTRA/BY(Release 5.0.12  |February
 13, 2003) at 11.11.2004 10:24:18,
	Serialize by Notes Client on Ilia Sotnikov/ASSTRA/BY(Release 5.0.12  |February
 13, 2003) at 11.11.2004 10:24:18,
	Serialize complete at 11.11.2004 10:24:18,
	S/MIME Sign failed at 11.11.2004 10:24:18: The cryptographic key was not
 found,
	Serialize by Router on Warszawa-Passthru/ASSTRA/BY(Release 6.5.1|January 28, 2004) at
 11/11/2004 09:26:00 AM,
	Serialize complete at 11/11/2004 09:26:00 AM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IPSec: 
Let incoming packets after decapsulation in transport mode traverse the 
same 
path as with tunnels. 
Deliver outgoing packets before encapsulation to all attached PF_PACKET 
sockets 
for example, pcap based programs) without sending them to a physical 
interface.

Signed-off-by: Ilia Sotnikov <ilia.sotnikov@asstra.by>

Description:
xfrm{4,6}_input() calls will return 0 even when decapsulating packet in 
the 
transport mode as opposed to the original concept when they return 
-nh->protocol. 
Then packets get reinjected via neitf_rx() call. Although it's overhead, 
it 
allows a packet to be seen in more Netfilter hooks. Below is table which 
shows 
the difference in Netfilter hooks traversal.

mangle table:
Mode            NF Hook Vanilla Patched
transport       PREROUTING      no              yes
tunnel  PREROUTING      yes             yes

transport       INPUT           no              yes
tunnel  INPUT           yes             yes

transport       OUTPUT  yes             yes
tunnel  OUTPUT  yes             yes

transport       POSTROUTING     no              no
tunnel  POSTROUTING     no              no

Additionally, pcap based programs will be able to see all cleartext 
packets
(incoming and outgoing). In vanilla kernel, you will see only incoming
cleartext packets after decapsulation and only in the tunnel mode.

PS: Please, CC me as I'm not on the list

diff -ur linux-2.6.9.orig/include/net/xfrm.h 
linux-2.6.9/include/net/xfrm.h
--- linux-2.6.9.orig/include/net/xfrm.h 2004-10-19 00:54:55.000000000 
+0300
+++ linux-2.6.9/include/net/xfrm.h      2004-11-10 14:41:00.208600784 
+0200
@@ -909,4 +909,77 @@
        }
 }
 
+/* Deliver clear-text packet to network taps.
+ *
+ * Deliver IP packet to all attached network taps using 
dev_queue_xmit_nit.
+ * No output should be produced on a physical interface.
+ * Actually summary of ip_finish_output, ip_finish_output2.
+ */
+
+static inline int ip_xmit_nit (struct sk_buff *skb)
+{
+       struct sk_buff *newskb;
+       struct net_device *dev;
+       int hh_len;
+
+       /* Allocate new buffer with private headers and shared data 
+          because we only need to modify the former */
+       newskb = pskb_copy(skb, GFP_ATOMIC);
+       if (newskb == NULL)
+               return -ENOMEM;
+
+       if (newskb->dst)
+               dev = newskb->dst->dev;
+       else
+               return -EINVAL;
+
+       /* Allocate more space in the head for LL headers if any */
+       hh_len = LL_RESERVED_SPACE(dev);
+       if (unlikely(skb_headroom(newskb) < hh_len && dev->hard_header)) {
+               struct sk_buff *newskb2;
+
+               newskb2 = skb_realloc_headroom(newskb, hh_len);
+               if (newskb2 == NULL) {
+                       kfree_skb (newskb);
+                       return -ENOMEM;
+               }
+               kfree_skb (newskb);
+               newskb = newskb2;
+       }
+
+       newskb->protocol        = htons(ETH_P_IP);
+       newskb->dev             = dev;
+
+       /* Put LL header into the buffer */
+       if (dev->hard_header)
+               if (!dev->hard_header(newskb, dev, 
ntohs(newskb->protocol), NULL, NULL, newskb->len))
+                       return -EINVAL;
+
+       /* Deliver the buffer to all network taps */
+       dev_queue_xmit_nit(newskb, dev);
+ 
+       kfree_skb(newskb);
+
+       return 0;
+}
+
+static inline void xfrm_expand_mac(struct sk_buff *skb)
+{
+       skb->mac.raw = memmove(skb->data - skb->mac_len,
+                                  skb->mac.raw, skb->mac_len);
+       skb->nh.raw = skb->data;
+}
+
+static inline void xfrm_restore_iph(struct sk_buff *skb)
+{
+       int iph_len, tot_len;
+
+       iph_len = skb->h.raw - skb->nh.raw;
+
+       skb_push (skb, iph_len);
+       tot_len = ntohs(skb->nh.iph->tot_len);
+       tot_len += iph_len;
+       skb->nh.iph->tot_len = htons(tot_len);
+}
+
 #endif /* _NET_XFRM_H */
diff -ur linux-2.6.9.orig/net/ipv4/xfrm4_input.c 
linux-2.6.9/net/ipv4/xfrm4_input.c
--- linux-2.6.9.orig/net/ipv4/xfrm4_input.c     2004-10-19 
00:53:21.000000000 +0300
+++ linux-2.6.9/net/ipv4/xfrm4_input.c  2004-11-10 02:16:57.000000000 
+0200
@@ -105,9 +105,7 @@
                                ipv4_copy_dscp(iph, skb->h.ipiph);
                        if (!(x->props.flags & XFRM_STATE_NOECN))
                                ipip_ecn_decapsulate(skb);
-                       skb->mac.raw = memmove(skb->data - skb->mac_len,
-                                              skb->mac.raw, 
skb->mac_len);
-                       skb->nh.raw = skb->data;
+                       xfrm_expand_mac(skb);
                        memset(&(IPCB(skb)->opt), 0, sizeof(struct 
ip_options));
                        decaps = 1;
                        break;
@@ -134,17 +132,28 @@
        memcpy(skb->sp->x+skb->sp->len, xfrm_vec, xfrm_nr*sizeof(struct 
sec_decap_state));
        skb->sp->len += xfrm_nr;
 
-       if (decaps) {
-               if (!(skb->dev->flags&IFF_LOOPBACK)) {
-                       dst_release(skb->dst);
-                       skb->dst = NULL;
-               }
-               netif_rx(skb);
-               return 0;
-       } else {
-               return -skb->nh.iph->protocol;
+       /* Let packets in IPSec transport mode traverse the same path as 
with tunnel
+        * (which are delivered back to IP stack via netif_rx after 
decapsulation)
+        *
+        * skb->data points to just past IP header, skb->len & 
iph->tot_len doesn't 
+        * count IP header, a gap exists between skb->mac and skb->nh, IP 
checksum
+        * needs to be recalculated.
+        */
+
+       if (!(skb->dev->flags&IFF_LOOPBACK)) {
+               dst_release(skb->dst);
+               skb->dst = NULL;
+       }
+
+       if (!decaps) {
+               xfrm_restore_iph(skb);
+               xfrm_expand_mac(skb);
+               ip_send_check (skb->nh.iph);
        }
 
+       netif_rx(skb);
+       return 0;
+
 drop_unlock:
        spin_unlock(&x->lock);
        xfrm_state_put(x);
diff -ur linux-2.6.9.orig/net/ipv4/xfrm4_output.c 
linux-2.6.9/net/ipv4/xfrm4_output.c
--- linux-2.6.9.orig/net/ipv4/xfrm4_output.c    2004-10-19 
00:53:44.000000000 +0300
+++ linux-2.6.9/net/ipv4/xfrm4_output.c 2004-11-10 02:16:57.000000000 
+0200
@@ -116,6 +116,8 @@
                        goto error;
        }
 
+       /* Deliver clear text packet to network taps */
+       ip_xmit_nit(skb);
        xfrm4_encap(skb);
 
        err = x->type->output(skb);
diff -ur linux-2.6.9.orig/net/ipv6/xfrm6_input.c 
linux-2.6.9/net/ipv6/xfrm6_input.c
--- linux-2.6.9.orig/net/ipv6/xfrm6_input.c     2004-10-19 
00:55:36.000000000 +0300
+++ linux-2.6.9/net/ipv6/xfrm6_input.c  2004-11-10 02:16:57.000000000 
+0200
@@ -92,9 +92,7 @@
                                ipv6_copy_dscp(skb->nh.ipv6h, 
skb->h.ipv6h);
                        if (!(x->props.flags & XFRM_STATE_NOECN))
                                ipip6_ecn_decapsulate(skb);
-                       skb->mac.raw = memmove(skb->data - skb->mac_len,
-                                              skb->mac.raw, 
skb->mac_len);
-                       skb->nh.raw = skb->data;
+                       xfrm_expand_mac(skb);
                        decaps = 1;
                        break;
                }
@@ -121,17 +119,28 @@
        skb->sp->len += xfrm_nr;
        skb->ip_summed = CHECKSUM_NONE;
 
-       if (decaps) {
-               if (!(skb->dev->flags&IFF_LOOPBACK)) {
-                       dst_release(skb->dst);
-                       skb->dst = NULL;
-               }
-               netif_rx(skb);
-               return -1;
-       } else {
-               return 1;
+       /* Let packets in IPSec transport mode traverse the same path as 
with tunnel
+        * (which are delivered back to IP stack via netif_rx after 
decapsulation)
+        *
+        * skb->data points to just past IP header, skb->len & 
iph->tot_len doesn't 
+        * count IP header, a gap exists between skb->mac and skb->nh, IP 
checksum
+        * needs to be recalculated.
+        */
+
+       if (!(skb->dev->flags&IFF_LOOPBACK)) {
+               dst_release(skb->dst);
+               skb->dst = NULL;
+       }
+
+       if (!decaps) {
+               xfrm_restore_iph(skb);
+               xfrm_expand_mac (skb);
+               ip_send_check (skb->nh.iph);
        }
 
+       netif_rx(skb);
+       return -1;
+
 drop_unlock:
        spin_unlock(&x->lock);
        xfrm_state_put(x);
diff -ur linux-2.6.9.orig/net/ipv6/xfrm6_output.c 
linux-2.6.9/net/ipv6/xfrm6_output.c
--- linux-2.6.9.orig/net/ipv6/xfrm6_output.c    2004-10-19 
00:55:07.000000000 +0300
+++ linux-2.6.9/net/ipv6/xfrm6_output.c 2004-11-10 02:16:57.000000000 
+0200
@@ -116,6 +116,8 @@
                        goto error;
        }
 
+       /* Deliver clear text packet to network taps */
+       ip_xmit_nit(skb);
        xfrm6_encap(skb);
 
        err = x->type->output(skb);

