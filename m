Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbREELdV>; Sat, 5 May 2001 07:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132372AbREELdL>; Sat, 5 May 2001 07:33:11 -0400
Received: from fepF.post.tele.dk ([195.41.46.135]:43907 "EHLO
	fepF.post.tele.dk") by vger.kernel.org with ESMTP
	id <S132359AbREELcy>; Sat, 5 May 2001 07:32:54 -0400
From: "Svenning Soerensen" <svenning@post5.tele.dk>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-ipsec@freeswan.org>
Subject: Problem with PMTU discovery on ICMP packets
Date: Sat, 5 May 2001 13:36:32 +0200
Message-ID: <015201c0d557$a1e69c50$1400a8c0@sss.intermate.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I think there is a bug in the 2.4 icmp code regarding PMTU discovery.
It seems to be inconsistent between reboots: at one boot echo replies always
have the DF bit set, while after another boot they don't, indicating that
this is caused by an uninitialized parameter.
Even 'echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc' doesn't change this
behaviour.

I can't think of any legitimate reasons for doing PMTU discovery on ICMP
packets, and since it actually in some situations breaks ping in combination
with FreeS/WAN (I can elaborate, if anyone is interested), I would suggest
to turn it off in a consistent manner.
The patch below (against 2.4.4) should accomplish this.

Svenning

--- linux/net/ipv4/icmp.c	2001/04/28 12:30:34	1.1.1.2
+++ linux/net/ipv4/icmp.c	2001/05/05 11:06:41
@@ -1006,6 +1006,7 @@
 	icmp_socket->sk->allocation=GFP_ATOMIC;
 	icmp_socket->sk->sndbuf = SK_WMEM_MAX*2;
 	icmp_socket->sk->protinfo.af_inet.ttl = MAXTTL;
+	icmp_socket->sk->protinfo.af_inet.pmtudisc = IP_PMTUDISC_DONT;
 
 	/* Unhash it so that IP input processing does not even
 	 * see it, we do not wish this socket to see incoming
