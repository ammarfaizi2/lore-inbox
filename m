Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289306AbSANXro>; Mon, 14 Jan 2002 18:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289301AbSANXrZ>; Mon, 14 Jan 2002 18:47:25 -0500
Received: from cx421112-a.dt1.sdca.home.com ([24.38.4.100]:2052 "HELO
	bulldog.sacerdoti.org") by vger.kernel.org with SMTP
	id <S289305AbSANXrD>; Mon, 14 Jan 2002 18:47:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Federico David Sacerdoti <fds@cs.ucsd.edu>
Organization: UCSD
To: netdev@oss.sgi.com, davem@redhat.com, ak@muc.de, kuznet@ms2.inr.ac.ru
Subject: New network monitoring proc file.
Date: Mon, 14 Jan 2002 15:48:26 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020114234525.4C84B77BB@bulldog.sacerdoti.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to submit a patch that adds a /proc file to the kernel which 
monitors the health of active TCP connections. It does this by counting 
the number of duplicate ACKs sent out, among other things.

I have a website detailing the exact metrics used and why I choose them:  		
http://heron.ucsd.edu/tcphealth/

I have tested this patch on 5 i686 computers, and have had many downloads of it 
by users interested in my tcphealth gkrellm monitoring module. Since I am forced 
to update my patch often due to demand, I would like to formally submit 
it to you for inclusion in the new 2.5 development kernel.

Sincerely,
Federico Sacerdoti

Here is the patch for the 2.5.1 kernel. It also works for kernel 2.5.2pre11.

----------- Start Patch ------------
diff -Naur pristine-linux-2.5.1/include/net/sock.h linux-2.5.1/include/net/sock.h
--- pristine-linux-2.5.1/include/net/sock.h	Mon Jan 14 13:43:41 2002
+++ linux-2.5.1/include/net/sock.h	Mon Jan 14 13:48:49 2002
@@ -24,6 +24,7 @@
  *		Alan Cox	:	Eliminate low level recv/recvfrom
  *		David S. Miller	:	New socket lookup architecture.
  *              Steve Whitehouse:       Default routines for sock_ops
+ *      Federico D. Sacerdoti	:	Added TCP health counters.
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -278,6 +279,7 @@
 		__u32	lrcvtime;	/* timestamp of last received data packet*/
 		__u16	last_seg_size;	/* Size of last incoming segment	*/
 		__u16	rcv_mss;	/* MSS used for delayed ACK decisions	*/ 
+		__u32	last_ack_sent;	/* Sequence number of the last ack we sent. */
 	} ack;

 	/* Data for direct copy to user */
@@ -418,6 +420,14 @@
 	int			linger2;
 
 	unsigned long last_synq_overflow; 
+
+	/*
+	 * TCP health monitoring counters.
+	 */
+	__u32	dup_acks_sent;
+	__u32	dup_pkts_recv;
+	__u32	acks_sent;
+	__u32	pkts_recv;
 };
 

diff -Naur pristine-linux-2.5.1/net/ipv4/af_inet.c linux-2.5.1/net/ipv4/af_inet.c
--- pristine-linux-2.5.1/net/ipv4/af_inet.c	Mon Jan 14 13:43:45 2002
+++ linux-2.5.1/net/ipv4/af_inet.c	Mon Jan 14 13:53:14 2002
@@ -56,6 +56,7 @@
  *					Some other random speedups.
  *		Cyrus Durgin	:	Cleaned up file for kmod hacks.
  *		Andi Kleen	:	Fix inet_stream_connect TCP race.
+ *	Federico D. Sacerdoti	:	Added tcphealth /proc/net file.
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -129,6 +130,7 @@
 extern int afinet_get_info(char *, char **, off_t, int);
 extern int tcp_get_info(char *, char **, off_t, int);
 extern int udp_get_info(char *, char **, off_t, int);
+extern int tcp_health_get_info(char *, char **, off_t, int);
 extern void ip_mc_drop_socket(struct sock *sk);

 #ifdef CONFIG_DLCI
@@ -1196,6 +1198,7 @@
 	proc_net_create ("sockstat", 0, afinet_get_info);
 	proc_net_create ("tcp", 0, tcp_get_info);
 	proc_net_create ("udp", 0, udp_get_info);
+	proc_net_create ("tcphealth", 0, tcp_health_get_info);
 #endif		/* CONFIG_PROC_FS */
 	return 0;
 }
diff -Naur pristine-linux-2.5.1/net/ipv4/proc.c linux-2.5.1/net/ipv4/proc.c
--- pristine-linux-2.5.1/net/ipv4/proc.c	Mon Jan 14 13:43:45 2002
+++ linux-2.5.1/net/ipv4/proc.c	Mon Jan 14 14:02:57 2002
@@ -26,6 +26,7 @@
  *	Andi Kleen		:	Add support for open_requests and
  *					split functions for more readibility.
  *	Andi Kleen		:	Add support for /proc/net/netstat
+ *	Federico D. Sacerdoti	:	Added support for /proc/net/tcphealth
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -212,3 +213,97 @@
 		len = 0;
 	return len;
 }
+
+/*
+ *	Output /proc/net/tcphealth
+ */
+#define LINESZ 128
+
+int tcp_health_get_info(char *buffer, char **start, off_t offset, int length)
+{
+	int len=0, i=0, num=0;
+	off_t pos=0, begin=0;
+       char tmpbuf[LINESZ+1], srcIP[32], destIP[32];
+
+	unsigned long  dest, src, SmoothedRttEstimate,
+		AcksSent, DupAcksSent, PktsRecv, DupPktsRecv;
+	unsigned short destp, srcp;
+
+	len = sprintf(buffer,
+		"TCP Health Monitoring (established connections only)\n"
+		" -Duplicate ACKs indicate lost or reordered packets on the connection.\n"
+		" -Duplicate Packets Received signal a slow and badly inefficient connection.\n"
+		" -RttEst estimates how long future packets will take on a round trip over the connection.\n"
+		"id   Local Address        Remote Address       RttEst(ms) AcksSent "
+		"DupAcksSent PktsRecv DupPktsRecv\n");
+	pos=len;
+
+	/* Loop through established TCP connections */
+	local_bh_disable();
+	for (i=0; i < tcp_ehash_size; i++) {
+		struct tcp_ehash_bucket *head = &tcp_ehash[i];
+		struct sock *sk;
+		struct tcp_opt *tp;
+
+		read_lock(&head->lock);
+		for (sk=head->chain; sk; sk=sk->next) {
+			if (!TCP_INET_FAMILY(sk->family))
+				continue;
+			pos+=LINESZ;
+			if (pos <= offset)
+				continue;
+
+			dest  = ntohl(sk->daddr);
+			src = ntohl(sk->rcv_saddr);
+			destp = ntohs(sk->dport);
+			srcp  = ntohs(sk->sport);
+
+			tp = &(sk->tp_pinfo.af_tcp);
+			SmoothedRttEstimate = (tp->srtt >> 3);
+			AcksSent = tp->acks_sent;
+			DupAcksSent = tp->dup_acks_sent;
+			PktsRecv = tp->pkts_recv;
+			DupPktsRecv = tp->dup_pkts_recv;
+
+			sprintf(srcIP, "%lu.%lu.%lu.%lu:%u",
+				((src >> 24) & 0xFF), ((src >> 16) & 0xFF), ((src >> 8) & 0xFF), (src & 0xFF),
+				srcp);
+			sprintf(destIP, "%lu.%lu.%lu.%lu:%u",
+				((dest >> 24) & 0xFF), ((dest >> 16) & 0xFF), ((dest >> 8) & 0xFF), (dest & 0xFF),
+				destp);
+
+			sprintf(tmpbuf, "%d: %-21s %-21s "
+				"%8lu %8lu %8lu %8lu %8lu",
+				num,
+				srcIP,
+				destIP,
+				SmoothedRttEstimate,
+				AcksSent,
+				DupAcksSent,
+				PktsRecv,
+				DupPktsRecv
+				);
+
+			len += sprintf(buffer+len, "%-*s\n", LINESZ-1, tmpbuf);
+			if(pos >= offset+length) {
+				read_unlock(&head->lock);
+				goto out;
+			}
+			num++;
+		}
+		read_unlock(&head->lock);
+	}
+
+out:
+	local_bh_enable();
+
+	begin = len - (pos - offset);
+	*start = buffer + begin;
+	len -= begin;
+	if(len>length)
+		len = length;
+	if (len<0)
+		len = 0;
+	return len;
+}
+
diff -Naur pristine-linux-2.5.1/net/ipv4/tcp_input.c linux-2.5.1/net/ipv4/tcp_input.c
--- pristine-linux-2.5.1/net/ipv4/tcp_input.c	Mon Jan 14 13:43:45 2002
+++ linux-2.5.1/net/ipv4/tcp_input.c	Mon Jan 14 14:12:57 2002
@@ -60,6 +60,7 @@
  *		Pasi Sarolahti,
  *		Panu Kuhlberg:		Experimental audit of TCP (re)transmission
  *					engine. Lots of bugs are found.
+ *		Federico D. Sacerdoti:	Added TCP health monitoring.
  */

 #include <linux/config.h>
@@ -2496,6 +2497,8 @@
 		}

 		if (!after(TCP_SKB_CB(skb)->end_seq, tp->rcv_nxt)) {
+			/* Course retransmit inefficiency- this packet has been received twice. */
+			tp->dup_pkts_recv++;
 			SOCK_DEBUG(sk, "ofo packet was already received \n");
 			__skb_unlink(skb, skb->list);
 			__kfree_skb(skb);
@@ -2608,6 +2611,10 @@
 		return;
 	}
 
+	/* A packet is a "duplicate" if it contains bytes we have already received. */
+	if (before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt))
+		tp->dup_pkts_recv++;
+
 	if (!after(TCP_SKB_CB(skb)->end_seq, tp->rcv_nxt)) {
 		/* A retransmit, 2nd most common case.  Force an immediate ack. */
 		NET_INC_STATS_BH(DelayedACKLost);
@@ -3241,6 +3248,14 @@
 	 */
 
 	tp->saw_tstamp = 0;
+
+	/*
+	 *	Tcp health monitoring is interested in
+	 *	total per-connection packet arrivals.
+	 *	This is in the fast path, but is quick.
+	 */
+
+	tp->pkts_recv++;
 
 	/*	pred_flags is 0xS?10 << 16 + snd_wnd
 	 *	if header_predition is to be made
diff -Naur pristine-linux-2.5.1/net/ipv4/tcp_output.c linux-2.5.1/net/ipv4/tcp_output.c
--- pristine-linux-2.5.1/net/ipv4/tcp_output.c	Mon Jan 14 13:43:45 2002
+++ linux-2.5.1/net/ipv4/tcp_output.c	Mon Jan 14 14:16:49 2002
@@ -33,6 +33,7 @@
  *		Andrea Arcangeli:	SYNACK carry ts_recent in tsecr.
  *		Cacophonix Gaul :	draft-minshall-nagle-01
  *		J Hadi Salim	:	ECN support
+ *	Federico D. Sacerdoti	:	Added TCP health monitoring.
  *
  */

@@ -1321,9 +1322,16 @@
 		TCP_SKB_CB(buff)->flags = TCPCB_FLAG_ACK;
 		TCP_SKB_CB(buff)->sacked = 0;

+		/* If the rcv_nxt has not advanced since sending our last ACK, this is a duplicate. */
+		if (tp->rcv_nxt == tp->ack.last_ack_sent)
+			tp->dup_acks_sent++;
+		/* Record the total number of acks sent on this connection. */
+		tp->acks_sent++;
+
 		/* Send it off, this clears delayed acks for us. */
 		TCP_SKB_CB(buff)->seq = TCP_SKB_CB(buff)->end_seq = tcp_acceptable_seq(sk, tp);
 		TCP_SKB_CB(buff)->when = tcp_time_stamp;
+		tp->ack.last_ack_sent = tp->rcv_nxt;
 		tcp_transmit_skb(sk, buff);
 	}
 }
-------------- End Patch -------------------
