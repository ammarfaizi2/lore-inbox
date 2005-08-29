Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVH2SFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVH2SFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVH2SFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:05:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751211AbVH2SFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:05:50 -0400
Date: Mon, 29 Aug 2005 11:05:42 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.12.6
Message-ID: <20050829180542.GA7762@shell0.pdx.osdl.net>
References: <20050829180418.GZ7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050829180418.GZ7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 12
-EXTRAVERSION = .5
+EXTRAVERSION = .6
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2969,23 +2969,22 @@ static void * dev_seq_start(struct seq_f
 {
 	struct sg_proc_deviter * it = kmalloc(sizeof(*it), GFP_KERNEL);
 
+	s->private = it;
 	if (! it)
 		return NULL;
+
 	if (NULL == sg_dev_arr)
-		goto err1;
+		return NULL;
 	it->index = *pos;
 	it->max = sg_last_dev();
 	if (it->index >= it->max)
-		goto err1;
+		return NULL;
 	return it;
-err1:
-	kfree(it);
-	return NULL;
 }
 
 static void * dev_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct sg_proc_deviter * it = (struct sg_proc_deviter *) v;
+	struct sg_proc_deviter * it = s->private;
 
 	*pos = ++it->index;
 	return (it->index < it->max) ? it : NULL;
@@ -2993,7 +2992,9 @@ static void * dev_seq_next(struct seq_fi
 
 static void dev_seq_stop(struct seq_file *s, void *v)
 {
-	kfree (v);
+	struct sg_proc_deviter * it = s->private;
+
+	kfree (it);
 }
 
 static int sg_proc_open_dev(struct inode *inode, struct file *file)
diff --git a/drivers/usb/net/usbnet.c b/drivers/usb/net/usbnet.c
--- a/drivers/usb/net/usbnet.c
+++ b/drivers/usb/net/usbnet.c
@@ -1922,7 +1922,7 @@ static int genelink_rx_fixup (struct usb
 
 			// copy the packet data to the new skb
 			memcpy(skb_put(gl_skb, size), packet->packet_data, size);
-			skb_return (dev, skb);
+			skb_return (dev, gl_skb);
 		}
 
 		// advance to the next packet
diff --git a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -686,7 +686,7 @@ static void handle_stop_signal(int sig, 
 {
 	struct task_struct *t;
 
-	if (p->flags & SIGNAL_GROUP_EXIT)
+	if (p->signal->flags & SIGNAL_GROUP_EXIT)
 		/*
 		 * The process is in the middle of dying already.
 		 */
diff --git a/lib/zlib_inflate/inftrees.c b/lib/zlib_inflate/inftrees.c
--- a/lib/zlib_inflate/inftrees.c
+++ b/lib/zlib_inflate/inftrees.c
@@ -141,7 +141,7 @@ static int huft_build(
   {
     *t = NULL;
     *m = 0;
-    return Z_DATA_ERROR;
+    return Z_OK;
   }
 
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -349,12 +349,12 @@ static void icmp_push_reply(struct icmp_
 {
 	struct sk_buff *skb;
 
-	ip_append_data(icmp_socket->sk, icmp_glue_bits, icmp_param,
-		       icmp_param->data_len+icmp_param->head_len,
-		       icmp_param->head_len,
-		       ipc, rt, MSG_DONTWAIT);
-
-	if ((skb = skb_peek(&icmp_socket->sk->sk_write_queue)) != NULL) {
+	if (ip_append_data(icmp_socket->sk, icmp_glue_bits, icmp_param,
+		           icmp_param->data_len+icmp_param->head_len,
+		           icmp_param->head_len,
+		           ipc, rt, MSG_DONTWAIT) < 0)
+		ip_flush_pending_frames(icmp_socket->sk);
+	else if ((skb = skb_peek(&icmp_socket->sk->sk_write_queue)) != NULL) {
 		struct icmphdr *icmph = skb->h.icmph;
 		unsigned int csum = 0;
 		struct sk_buff *skb1;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -848,6 +848,9 @@ mc_msf_out:
  
 		case IP_IPSEC_POLICY:
 		case IP_XFRM_POLICY:
+			err = -EPERM;
+			if (!capable(CAP_NET_ADMIN))
+				break;
 			err = xfrm_user_policy(sk, optname, optval, optlen);
 			break;
 
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -198,12 +198,13 @@ resubmit:
 		if (!raw_sk) {
 			if (xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
 				IP6_INC_STATS_BH(IPSTATS_MIB_INUNKNOWNPROTOS);
-				icmpv6_param_prob(skb, ICMPV6_UNK_NEXTHDR, nhoff);
+				icmpv6_send(skb, ICMPV6_PARAMPROB,
+				            ICMPV6_UNK_NEXTHDR, nhoff,
+				            skb->dev);
 			}
-		} else {
+		} else
 			IP6_INC_STATS_BH(IPSTATS_MIB_INDELIVERS);
-			kfree_skb(skb);
-		}
+		kfree_skb(skb);
 	}
 	rcu_read_unlock();
 	return 0;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -503,6 +503,9 @@ done:
 		break;
 	case IPV6_IPSEC_POLICY:
 	case IPV6_XFRM_POLICY:
+		retv = -EPERM;
+		if (!capable(CAP_NET_ADMIN))
+			break;
 		retv = xfrm_user_policy(sk, optname, optval, optlen);
 		break;
 
