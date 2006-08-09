Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWHIWbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWHIWbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWHIWbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:31:50 -0400
Received: from smtp-out.google.com ([216.239.45.12]:63808 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751356AbWHIWbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:31:49 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type;
	b=C5IjukKp2etEKXp5F+KYOPrz5d1lWEb186YHYARQOC3LPmTlvcs1zPw2HB3Tzqvwo
	F9clSvMUF5ochGY40KU0g==
Message-ID: <44DA6243.3040803@google.com>
Date: Wed, 09 Aug 2006 15:31:31 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Add the UdpSndbufErrors and UdpRcvbufErrors MIBs
Content-Type: multipart/mixed;
 boundary="------------090907040302000306040501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090907040302000306040501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add the UdpSndbufErrors and UdpRcvbufErrors MIBs

Signed-off-by: Martin Bligh <mbligh@google.com>



--------------090907040302000306040501
Content-Type: text/plain;
 name="linux-2.6.18-rc3-udp_mibs"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.18-rc3-udp_mibs"

Add the UdpSndbufErrors and UdpRcvbufErrors MIBs

Signed-off-by: Martin Bligh <mbligh@google.com>

diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18-rc3/include/linux/snmp.h linux-2.6.18-rc3-udp_mibs/include/linux/snmp.h
--- linux-2.6.18-rc3/include/linux/snmp.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.18-rc3-udp_mibs/include/linux/snmp.h	2006-08-09 15:23:31.000000000 -0700
@@ -155,6 +155,8 @@ enum
 	UDP_MIB_NOPORTS,			/* NoPorts */
 	UDP_MIB_INERRORS,			/* InErrors */
 	UDP_MIB_OUTDATAGRAMS,			/* OutDatagrams */
+	UDP_MIB_RCVBUFERRORS,			/* RcvbufErrors */
+	UDP_MIB_SNDBUFERRORS,			/* SndbufErrors */
 	__UDP_MIB_MAX
 };
 
diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18-rc3/net/ipv4/proc.c linux-2.6.18-rc3-udp_mibs/net/ipv4/proc.c
--- linux-2.6.18-rc3/net/ipv4/proc.c	2006-06-20 14:07:21.000000000 -0700
+++ linux-2.6.18-rc3-udp_mibs/net/ipv4/proc.c	2006-08-09 15:23:31.000000000 -0700
@@ -173,6 +173,8 @@ static const struct snmp_mib snmp4_udp_l
 	SNMP_MIB_ITEM("NoPorts", UDP_MIB_NOPORTS),
 	SNMP_MIB_ITEM("InErrors", UDP_MIB_INERRORS),
 	SNMP_MIB_ITEM("OutDatagrams", UDP_MIB_OUTDATAGRAMS),
+	SNMP_MIB_ITEM("RcvbufErrors", UDP_MIB_RCVBUFERRORS),
+	SNMP_MIB_ITEM("SndbufErrors", UDP_MIB_SNDBUFERRORS),
 	SNMP_MIB_SENTINEL
 };
 
diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.18-rc3/net/ipv4/udp.c linux-2.6.18-rc3-udp_mibs/net/ipv4/udp.c
--- linux-2.6.18-rc3/net/ipv4/udp.c	2006-07-31 10:19:01.000000000 -0700
+++ linux-2.6.18-rc3-udp_mibs/net/ipv4/udp.c	2006-08-09 15:23:31.000000000 -0700
@@ -661,6 +661,16 @@ out:
 		UDP_INC_STATS_USER(UDP_MIB_OUTDATAGRAMS);
 		return len;
 	}
+	/*
+	 * ENOBUFS = no kernel mem, SOCK_NOSPACE = no sndbuf space.  Reporting
+	 * ENOBUFS might not be good (it's not tunable per se), but otherwise
+	 * we don't have a good statistic (IpOutDiscards but it can be too many
+	 * things).  We could add another new stat but at least for now that
+	 * seems like overkill.
+	 */
+	if (err == -ENOBUFS || test_bit(SOCK_NOSPACE, &sk->sk_socket->flags)) {
+		UDP_INC_STATS_USER(UDP_MIB_SNDBUFERRORS);
+	}
 	return err;
 
 do_confirm:
@@ -980,6 +990,7 @@ static int udp_encap_rcv(struct sock * s
 static int udp_queue_rcv_skb(struct sock * sk, struct sk_buff *skb)
 {
 	struct udp_sock *up = udp_sk(sk);
+	int rc;
 
 	/*
 	 *	Charge it to the socket, dropping if the queue is full.
@@ -1026,7 +1037,10 @@ static int udp_queue_rcv_skb(struct sock
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
 
-	if (sock_queue_rcv_skb(sk,skb)<0) {
+	if ((rc = sock_queue_rcv_skb(sk,skb)) < 0) {
+		/* Note that an ENOMEM error is charged twice */
+		if (rc == -ENOMEM)
+			UDP_INC_STATS_BH(UDP_MIB_RCVBUFERRORS);
 		UDP_INC_STATS_BH(UDP_MIB_INERRORS);
 		kfree_skb(skb);
 		return -1;

--------------090907040302000306040501--
