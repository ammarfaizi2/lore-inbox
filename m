Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263779AbSJHUrj>; Tue, 8 Oct 2002 16:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJHUrA>; Tue, 8 Oct 2002 16:47:00 -0400
Received: from dclient217-162-64-94.hispeed.ch ([217.162.64.94]:56593 "EHLO
	wanze.haus") by vger.kernel.org with ESMTP id <S263776AbSJHUpP>;
	Tue, 8 Oct 2002 16:45:15 -0400
Date: Tue, 8 Oct 2002 22:50:54 +0200
From: Martin Renold <martinxyz@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: [patch] tcp connection tracking 2.4.19
Message-ID: <20021008205053.GA2621@old.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Virus: Hi! I'm a header virus! Copy me into yours and join the fun!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

There is a bug in the stable 2.4.19 kernel in the ip_conntrack code that
allows the final ACK of a SYN - SYN/ACK - ACK tcp handshake to establish
an ASSURED connection even if it has a wrong sequence number. The current
code only checks the ACK number.

This allows a DoS attack that will make it impossible to establish *real*
connections for some days, once the maximum is reached. Somebody sent me
an exploit:

http://old.homeip.net/martin/cdos.tgz

So I wrote a simple patch against 2.4.19, but I must admit that I do not
really understand the code around it, especially why it does not mark
such a packet as invalid (I'm new to most things here).

diff -urN -X dontdiff kernel-source-2.4.19.origin/include/linux/netfilter_ipv4/ip_conntrack_tcp.h kernel-source-2.4.19.patch/include/linux/netfilter_ipv4/ip_conntrack_tcp.h
--- kernel-source-2.4.19.origin/include/linux/netfilter_ipv4/ip_conntrack_tcp.h	Fri Aug  4 22:07:24 2000
+++ kernel-source-2.4.19.patch/include/linux/netfilter_ipv4/ip_conntrack_tcp.h	Sat Oct  5 19:07:44 2002
@@ -24,8 +24,9 @@
 {
 	enum tcp_conntrack state;
 
-	/* Poor man's window tracking: sequence number of valid ACK
-           handshake completion packet */
+	/* Poor man's window tracking: expected sequence and acknowledge 
+	   number of valid ACK handshake completion packet */
+	u_int32_t handshake_seq;
 	u_int32_t handshake_ack;
 };
 
diff -urN -X dontdiff kernel-source-2.4.19.origin/net/ipv4/netfilter/ip_conntrack_proto_tcp.c kernel-source-2.4.19.patch/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
--- kernel-source-2.4.19.origin/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	Fri Oct  4 08:13:38 2002
+++ kernel-source-2.4.19.patch/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	Sat Oct  5 20:45:49 2002
@@ -180,6 +180,8 @@
 	if (oldtcpstate == TCP_CONNTRACK_SYN_SENT
 	    && CTINFO2DIR(ctinfo) == IP_CT_DIR_REPLY
 	    && tcph->syn && tcph->ack)
+		conntrack->proto.tcp.handshake_seq
+			= tcph->ack_seq;
 		conntrack->proto.tcp.handshake_ack
 			= htonl(ntohl(tcph->seq) + 1);
 	WRITE_UNLOCK(&tcp_lock);
@@ -196,6 +198,7 @@
 		if (oldtcpstate == TCP_CONNTRACK_SYN_RECV
 		    && CTINFO2DIR(ctinfo) == IP_CT_DIR_ORIGINAL
 		    && tcph->ack && !tcph->syn
+		    && tcph->seq == conntrack->proto.tcp.handshake_seq
 		    && tcph->ack_seq == conntrack->proto.tcp.handshake_ack)
 			set_bit(IPS_ASSURED_BIT, &conntrack->status);
 
-- 
Thunder's just a noise, boys, lightnin' does the work
-- (Chad Brock/John Hadley/Kelly Garrett)
