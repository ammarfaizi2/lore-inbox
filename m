Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265952AbRGAVzz>; Sun, 1 Jul 2001 17:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265953AbRGAVzq>; Sun, 1 Jul 2001 17:55:46 -0400
Received: from gateway.sequent.com ([192.148.1.10]:44079 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S265952AbRGAVzh>; Sun, 1 Jul 2001 17:55:37 -0400
From: Nivedita Singhvi <nivedita@sequent.com>
Message-Id: <200107012155.OAA14218@eng4.sequent.com>
Subject: Re: Client..[ Patch: New TCP counters ]
To: robert@kleemann.org (Robert Kleemann)
Date: Sun, 1 Jul 2001 14:55:15 -0700 (PDT)
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, ak@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106131031090.1153-100000@localhost.localdomain> from "Robert Kleemann" at Jun 13, 2001 09:41:27 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch against Linux kernel 2.4.5 - introduces 2 new Linux-MIB 
TCP counters: TCPChecksumFail and TCPBadHdrLen. This is essentially
a breakdown of the existing SNMP stat TcpInErrs into the above two 
counters and (existing) TCPAbortOnSyn. Makes it easy to identify
dropped packets due to individual issues, particularly checksum
failures. 

Would this be of interest to anyone?

Apologies in advance if this isnt kosher in some way, I'm fairly
new ;). 

thanks,
Nivedita

---
diff -urN linux-2.4.5/include/net/snmp.h linux-2.4.5p1/include/net/snmp.h
--- linux-2.4.5/include/net/snmp.h	Fri May 25 18:01:27 2001
+++ linux-2.4.5p1/include/net/snmp.h	Sat Jun 30 22:26:46 2001
@@ -255,6 +255,8 @@
 	unsigned long	TCPAbortOnLinger;
 	unsigned long	TCPAbortFailed;
 	unsigned long	TCPMemoryPressures;
+	unsigned long	TCPChecksumFail;
+	unsigned long	TCPBadHdrLen;	
 	unsigned long   __pad[0];
 } ____cacheline_aligned;
 
diff -urN linux-2.4.5/net/ipv4/proc.c linux-2.4.5p1/net/ipv4/proc.c
--- linux-2.4.5/net/ipv4/proc.c	Wed May 16 10:21:45 2001
+++ linux-2.4.5p1/net/ipv4/proc.c	Sat Jun 30 22:27:22 2001
@@ -192,7 +192,8 @@
 		      " TCPDSACKOldSent TCPDSACKOfoSent TCPDSACKRecv TCPDSACKOfoRecv"
 		      " TCPAbortOnSyn TCPAbortOnData TCPAbortOnClose"
 		      " TCPAbortOnMemory TCPAbortOnTimeout TCPAbortOnLinger"
-		      " TCPAbortFailed TCPMemoryPressures\n"
+		      " TCPAbortFailed TCPMemoryPressures"
+		      " TCPChecksumFail TCPBadHdrLen\n"
 		      "TcpExt:");
 	for (i=0; i<offsetof(struct linux_mib, __pad)/sizeof(unsigned long); i++)
 		len += sprintf(buffer+len, " %lu", fold_field((unsigned long*)net_statistics, sizeof(struct linux_mib), i));
diff -urN linux-2.4.5/net/ipv4/tcp_input.c linux-2.4.5p1/net/ipv4/tcp_input.c
--- linux-2.4.5/net/ipv4/tcp_input.c	Thu May 24 15:00:59 2001
+++ linux-2.4.5p1/net/ipv4/tcp_input.c	Sat Jun 30 21:08:02 2001
@@ -3298,8 +3298,8 @@
 				tcp_data_snd_check(sk);
 				return 0;
 			} else { /* Header too small */
-				TCP_INC_STATS_BH(TcpInErrs);
-				goto discard;
+				NET_INC_STATS_BH(TCPBadHdrLen);
+				goto input_error;
 			}
 		} else {
 			int eaten = 0;
@@ -3314,15 +3314,19 @@
 
 				__set_current_state(TASK_RUNNING);
 
-				if (tcp_copy_to_iovec(sk, skb, tcp_header_len))
-					goto csum_error;
+				if (tcp_copy_to_iovec(sk, skb, tcp_header_len)) {
+					NET_INC_STATS_BH(TCPChecksumFail);
+					goto input_error;
+				}
 
 				__skb_pull(skb,tcp_header_len);
 
 				tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 			} else {
-				if (tcp_checksum_complete_user(sk, skb))
-					goto csum_error;
+				if (tcp_checksum_complete_user(sk, skb)) {
+					NET_INC_STATS_BH(TCPChecksumFail);
+					goto input_error;
+				}
 
 				if ((int)skb->truesize > sk->forward_alloc)
 					goto step5;
@@ -3366,8 +3370,15 @@
 	}
 
 slow_path:
-	if (len < (th->doff<<2) || tcp_checksum_complete_user(sk, skb))
-		goto csum_error;
+	if (len < (th->doff<<2)) {
+		NET_INC_STATS_BH(TCPBadHdrLen);
+		goto input_error;
+	}
+
+	if (tcp_checksum_complete_user(sk, skb)) {
+		NET_INC_STATS_BH(TCPChecksumFail);
+		goto input_error;
+	}
 
 	/*
 	 * RFC1323: H1. Apply PAWS check first.
@@ -3430,8 +3441,9 @@
 	tcp_ack_snd_check(sk);
 	return 0;
 
-csum_error:
+input_error:
 	TCP_INC_STATS_BH(TcpInErrs);
+	/* FALLTHROUGH */
 
 discard:
 	__kfree_skb(skb);
diff -urN linux-2.4.5/net/ipv4/tcp_ipv4.c linux-2.4.5p1/net/ipv4/tcp_ipv4.c
--- linux-2.4.5/net/ipv4/tcp_ipv4.c	Wed Apr 25 14:57:39 2001
+++ linux-2.4.5p1/net/ipv4/tcp_ipv4.c	Sun Jul  1 00:37:15 2001
@@ -1548,8 +1548,15 @@
 		return 0; 
 	}
 
-	if (skb->len < (skb->h.th->doff<<2) || tcp_checksum_complete(skb))
-		goto csum_err;
+	if (skb->len < (skb->h.th->doff<<2)) {
+		NET_INC_STATS_BH(TCPBadHdrLen);
+		goto input_error;
+	}
+
+	if (tcp_checksum_complete(skb)) {
+		NET_INC_STATS_BH(TCPChecksumFail);
+		goto input_error;
+	}
 
 	if (sk->state == TCP_LISTEN) { 
 		struct sock *nsk = tcp_v4_hnd_req(sk, skb);
@@ -1580,7 +1587,7 @@
 	 */
 	return 0;
 
-csum_err:
+input_error:
 	TCP_INC_STATS_BH(TcpInErrs);
 	goto discard;
 }
@@ -1606,8 +1613,10 @@
 
 	th = skb->h.th;
 
-	if (th->doff < sizeof(struct tcphdr)/4)
-		goto bad_packet;
+	if (th->doff < sizeof(struct tcphdr)/4) {
+		NET_INC_STATS_BH(TCPBadHdrLen);
+		goto input_error;
+	}
 	if (!pskb_may_pull(skb, th->doff*4))
 		goto discard_it;
 
@@ -1616,8 +1625,10 @@
 	 * provided case of th->doff==0 is elimineted.
 	 * So, we defer the checks. */
 	if ((skb->ip_summed != CHECKSUM_UNNECESSARY &&
-	     tcp_v4_checksum_init(skb) < 0))
-		goto bad_packet;
+	     tcp_v4_checksum_init(skb) < 0)) {
+		NET_INC_STATS_BH(TCPChecksumFail);
+		goto input_error;
+	}
 
 	th = skb->h.th;
 	TCP_SKB_CB(skb)->seq = ntohl(th->seq);
@@ -1635,8 +1646,10 @@
 		goto no_tcp_socket;
 
 process:
-	if(!ipsec_sk_policy(sk,skb))
-		goto discard_and_relse;
+	if(!ipsec_sk_policy(sk,skb)) {
+		sock_put(sk);
+		goto discard_it;
+	}
 
 	if (sk->state == TCP_TIME_WAIT)
 		goto do_time_wait;
@@ -1657,26 +1670,37 @@
 	return ret;
 
 no_tcp_socket:
-	if (skb->len < (th->doff<<2) || tcp_checksum_complete(skb)) {
-bad_packet:
-		TCP_INC_STATS_BH(TcpInErrs);
-	} else {
-		tcp_v4_send_reset(skb);
+	if (skb->len < (th->doff<<2)) {
+		NET_INC_STATS_BH(TCPBadHdrLen);
+		goto input_error;
 	}
+	if (tcp_checksum_complete(skb)) {
+		NET_INC_STATS_BH(TCPChecksumFail);
+		goto input_error;
+	}
+	tcp_v4_send_reset(skb);
+	goto discard_it;
+
+input_error:
+	TCP_INC_STATS_BH(TcpInErrs);
+	/* FALLTHROUGH */
 
 discard_it:
 	/* Discard frame. */
 	kfree_skb(skb);
   	return 0;
 
-discard_and_relse:
-	sock_put(sk);
-	goto discard_it;
-
 do_time_wait:
-	if (skb->len < (th->doff<<2) || tcp_checksum_complete(skb)) {
-		TCP_INC_STATS_BH(TcpInErrs);
-		goto discard_and_relse;
+	/* unlike no_tcp_socket, we have a socket reference to put back */
+	if (skb->len < (th->doff<<2)) {
+		NET_INC_STATS_BH(TCPBadHdrLen);
+		sock_put(sk);
+		goto input_error;
+	}
+	if (tcp_checksum_complete(skb)) {
+		NET_INC_STATS_BH(TCPChecksumFail);
+		sock_put(sk);
+		goto input_error;
 	}
 	switch(tcp_timewait_state_process((struct tcp_tw_bucket *)sk,
 					  skb, th, skb->len)) {
@@ -1698,7 +1722,8 @@
 		tcp_v4_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		goto no_tcp_socket;
+		tcp_v4_send_reset(skb);
+		goto discard_it;
 	case TCP_TW_SUCCESS:;
 	}
 	goto discard_it;
diff -urN linux-2.4.5/net/ipv6/tcp_ipv6.c linux-2.4.5p1/net/ipv6/tcp_ipv6.c
--- linux-2.4.5/net/ipv6/tcp_ipv6.c	Wed Apr 25 14:57:39 2001
+++ linux-2.4.5p1/net/ipv6/tcp_ipv6.c	Sun Jul  1 12:07:15 2001
@@ -1459,8 +1459,15 @@
 		return 0;
 	}
 
-	if (skb->len < (skb->h.th->doff<<2) || tcp_checksum_complete(skb))
-		goto csum_err;
+	if (skb->len < (skb->h.th->doff<<2)) {
+                NET_INC_STATS_BH(TCPBadHdrLen);
+                goto input_error;
+        }
+
+        if (tcp_checksum_complete(skb)) {
+                NET_INC_STATS_BH(TCPChecksumFail);
+                goto input_error;
+        }
 
 	if (sk->state == TCP_LISTEN) { 
 		struct sock *nsk = tcp_v6_hnd_req(sk, skb);
@@ -1496,7 +1503,7 @@
 		__kfree_skb(opt_skb);
 	kfree_skb(skb);
 	return 0;
-csum_err:
+input_error:
 	TCP_INC_STATS_BH(TcpInErrs);
 	goto discard;
 
@@ -1548,14 +1555,19 @@
 
 	th = skb->h.th;
 
-	if (th->doff < sizeof(struct tcphdr)/4)
-		goto bad_packet;
+	if (th->doff < sizeof(struct tcphdr)/4) {
+                NET_INC_STATS_BH(TCPBadHdrLen);
+                goto input_error;
+        }
+
 	if (!pskb_may_pull(skb, th->doff*4))
 		goto discard_it;
 
 	if ((skb->ip_summed != CHECKSUM_UNNECESSARY &&
-	     tcp_v6_checksum_init(skb) < 0))
-		goto bad_packet;
+	     tcp_v6_checksum_init(skb) < 0)) {
+                NET_INC_STATS_BH(TCPChecksumFail);
+                goto input_error;
+        }
 
 	th = skb->h.th;
 	TCP_SKB_CB(skb)->seq = ntohl(th->seq);
@@ -1573,8 +1585,11 @@
 		goto no_tcp_socket;
 
 process:
-	if(!ipsec_sk_policy(sk,skb))
-		goto discard_and_relse;
+	if(!ipsec_sk_policy(sk,skb)) {
+                sock_put(sk);
+                goto discard_it;
+        }
+
 	if(sk->state == TCP_TIME_WAIT)
 		goto do_time_wait;
 
@@ -1593,12 +1608,20 @@
 	return ret;
 
 no_tcp_socket:
-	if (skb->len < (th->doff<<2) || tcp_checksum_complete(skb)) {
-bad_packet:
-		TCP_INC_STATS_BH(TcpInErrs);
-	} else {
-		tcp_v6_send_reset(skb);
-	}
+        if (skb->len < (th->doff<<2)) {
+                NET_INC_STATS_BH(TCPBadHdrLen);
+                goto input_error;
+        }
+        if (tcp_checksum_complete(skb)) {
+                NET_INC_STATS_BH(TCPChecksumFail);
+                goto input_error;
+        }
+        tcp_v6_send_reset(skb);
+        goto discard_it;
+
+input_error:
+        TCP_INC_STATS_BH(TcpInErrs);
+        /* FALLTHROUGH */
 
 discard_it:
 
@@ -1609,16 +1632,18 @@
 	kfree_skb(skb);
 	return 0;
 
-discard_and_relse:
-	sock_put(sk);
-	goto discard_it;
-
 do_time_wait:
-	if (skb->len < (th->doff<<2) || tcp_checksum_complete(skb)) {
-		TCP_INC_STATS_BH(TcpInErrs);
-		sock_put(sk);
-		goto discard_it;
-	}
+	/* unlike no_tcp_socket, we have a socket reference to put back */
+	if (skb->len < (th->doff<<2)) {
+                NET_INC_STATS_BH(TCPBadHdrLen);
+                sock_put(sk);
+                goto input_error;
+        }
+        if (tcp_checksum_complete(skb)) {
+                NET_INC_STATS_BH(TCPChecksumFail);
+                sock_put(sk);
+                goto input_error;
+        }
 
 	switch(tcp_timewait_state_process((struct tcp_tw_bucket *)sk,
 					  skb, th, skb->len)) {
@@ -1640,7 +1665,8 @@
 		tcp_v6_timewait_ack(sk, skb);
 		break;
 	case TCP_TW_RST:
-		goto no_tcp_socket;
+		tcp_v6_send_reset(skb);
+		goto discard_it; 
 	case TCP_TW_SUCCESS:;
 	}
 	goto discard_it;
