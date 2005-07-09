Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVGINGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVGINGY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 09:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVGINGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 09:06:24 -0400
Received: from mx1.elte.hu ([157.181.1.137]:63889 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261382AbVGINGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 09:06:18 -0400
Date: Sat, 9 Jul 2005 15:05:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050709130557.GA5763@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu> <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709124105.GB4665@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709124105.GB4665@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (gdb) ####################################
> (gdb) # c02de0f3, stack size:  572 bytes #
> (gdb) ####################################
> (gdb) 0xc02de0f3 is in ip_setsockopt (net/ipv4/ip_sockglue.c:385).

----
this patch reduces ip_setsockopt's stack footprint from 572 bytes to 164 
bytes. (Note: needs review and testing as i could not excercise this 
multicast codepath.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/net/ipv4/ip_sockglue.c
===================================================================
--- linux.orig/net/ipv4/ip_sockglue.c
+++ linux/net/ipv4/ip_sockglue.c
@@ -691,52 +691,65 @@ int ip_setsockopt(struct sock *sk, int l
 		case MCAST_JOIN_GROUP:
 		case MCAST_LEAVE_GROUP: 
 		{
-			struct group_req greq;
+			struct group_req *greq;
 			struct sockaddr_in *psin;
 			struct ip_mreqn mreq;
 
+			err = -ENOMEM;
+			greq = kmalloc(sizeof(*greq), GFP_KERNEL);
+			if (!greq)
+				break;
 			if (optlen < sizeof(struct group_req))
-				goto e_inval;
+				goto free_greq_e_inval;
 			err = -EFAULT;
-			if(copy_from_user(&greq, optval, sizeof(greq)))
-				break;
-			psin = (struct sockaddr_in *)&greq.gr_group;
+			if(copy_from_user(greq, optval, sizeof(*greq)))
+				goto free_greq_break;
+			psin = (struct sockaddr_in *)&greq->gr_group;
 			if (psin->sin_family != AF_INET)
-				goto e_inval;
+				goto free_greq_e_inval;
 			memset(&mreq, 0, sizeof(mreq));
 			mreq.imr_multiaddr = psin->sin_addr;
-			mreq.imr_ifindex = greq.gr_interface;
+			mreq.imr_ifindex = greq->gr_interface;
 
 			if (optname == MCAST_JOIN_GROUP)
 				err = ip_mc_join_group(sk, &mreq);
 			else
 				err = ip_mc_leave_group(sk, &mreq);
+free_greq_break:
+			kfree(greq);
 			break;
+free_greq_e_inval:
+			kfree(greq);
+			goto e_inval;
 		}
 		case MCAST_JOIN_SOURCE_GROUP:
 		case MCAST_LEAVE_SOURCE_GROUP:
 		case MCAST_BLOCK_SOURCE:
 		case MCAST_UNBLOCK_SOURCE:
 		{
-			struct group_source_req greqs;
+			struct group_source_req *greqs;
 			struct ip_mreq_source mreqs;
 			struct sockaddr_in *psin;
 			int omode, add;
 
+			err = -ENOMEM;
+			greqs = kmalloc(sizeof(*greqs), GFP_KERNEL);
+			if (!greqs)
+				break;
 			if (optlen != sizeof(struct group_source_req))
-				goto e_inval;
-			if (copy_from_user(&greqs, optval, sizeof(greqs))) {
+				goto free_greqs_e_inval;
+			if (copy_from_user(&greqs, optval, sizeof(*greqs))) {
 				err = -EFAULT;
-				break;
+				goto free_greqs_break;
 			}
-			if (greqs.gsr_group.ss_family != AF_INET ||
-			    greqs.gsr_source.ss_family != AF_INET) {
+			if (greqs->gsr_group.ss_family != AF_INET ||
+			    greqs->gsr_source.ss_family != AF_INET) {
 				err = -EADDRNOTAVAIL;
-				break;
+				goto free_greqs_break;
 			}
-			psin = (struct sockaddr_in *)&greqs.gsr_group;
+			psin = (struct sockaddr_in *)&greqs->gsr_group;
 			mreqs.imr_multiaddr = psin->sin_addr.s_addr;
-			psin = (struct sockaddr_in *)&greqs.gsr_source;
+			psin = (struct sockaddr_in *)&greqs->gsr_source;
 			mreqs.imr_sourceaddr = psin->sin_addr.s_addr;
 			mreqs.imr_interface = 0; /* use index for mc_source */
 
@@ -749,14 +762,14 @@ int ip_setsockopt(struct sock *sk, int l
 			} else if (optname == MCAST_JOIN_SOURCE_GROUP) {
 				struct ip_mreqn mreq;
 
-				psin = (struct sockaddr_in *)&greqs.gsr_group;
+				psin = (struct sockaddr_in *)&greqs->gsr_group;
 				mreq.imr_multiaddr = psin->sin_addr;
 				mreq.imr_address.s_addr = 0;
-				mreq.imr_ifindex = greqs.gsr_interface;
+				mreq.imr_ifindex = greqs->gsr_interface;
 				err = ip_mc_join_group(sk, &mreq);
 				if (err)
-					break;
-				greqs.gsr_interface = mreq.imr_ifindex;
+					goto free_greqs_break;
+				greqs->gsr_interface = mreq.imr_ifindex;
 				omode = MCAST_INCLUDE;
 				add = 1;
 			} else /* MCAST_LEAVE_SOURCE_GROUP */ {
@@ -764,8 +777,13 @@ int ip_setsockopt(struct sock *sk, int l
 				add = 0;
 			}
 			err = ip_mc_source(add, omode, sk, &mreqs,
-				greqs.gsr_interface);
-			break;
+				greqs->gsr_interface);
+free_greqs_break:
+			kfree(greqs);
+			break;
+free_greqs_e_inval:
+			kfree(greqs);
+			goto e_inval;
 		}
 		case MCAST_MSFILTER:
 		{
