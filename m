Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132138AbRADARd>; Wed, 3 Jan 2001 19:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132059AbRADARX>; Wed, 3 Jan 2001 19:17:23 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:17165 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129324AbRADARH>; Wed, 3 Jan 2001 19:17:07 -0500
Message-ID: <A7BD6744D865D211AC3E00A0C95D1A6E0351D93A@orsmsx45.jf.intel.com>
From: "Villalovos, John L" <john.l.villalovos@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'jjciarla@raiz.uncu.edu.ar'" <jjciarla@raiz.uncu.edu.ar>
Subject: Fix for Real Audio IP Masquerade
Date: Wed, 3 Jan 2001 16:16:39 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff against 2.2.19pre6 though the file hasn't changed since Oct 27, 1998.

This fixes a problem in the ip_masq_raudio.c module where it assumes that
all TCP headers are 20 bytes long.  Some implementations of the Real Player
clients use the TCP options section of the TCP header.  Thus these TCP
headers are longer than 20 bytes long and then break the RTSP portion of the
IP masquerading code.  This fix uses the header length field in the TCP
header to calculate the correct offset into the data portion of the TCP
packet.

John



--- ip_masq_raudio.c	Tue Oct 27 09:57:19 1998
+++ /usr/src/linux/net/ipv4/ip_masq_raudio.c	Wed Jan  3 16:03:21 2001
@@ -169,7 +169,10 @@
         skb = *skb_p;
 	iph = skb->nh.iph;
         th = (struct tcphdr *)&(((char *)iph)[iph->ihl*4]);
-        data = (char *)&th[1];
+
+	/* Make sure we take into account the size of the TCP packet.  This
is
+	 * because there may be TCP options in the TCP packet */
+	data = ((char *)&th[0]) + (th->doff * 4);
 
         data_limit = skb->h.raw + skb->len;
 
@@ -315,7 +318,10 @@
         skb = *skb_p;
 	iph = skb->nh.iph;
         th = (struct tcphdr *)&(((char *)iph)[iph->ihl*4]);
-        data = (char *)&th[1];
+
+	/* Make sure we take into account the size of the TCP packet.  This
is
+	 * because there may be TCP options in the TCP packet */
+	data = ((char *)&th[0]) + (th->doff * 4);
 
         data_limit = skb->h.raw + skb->len;
 
John Villalovos
Intel Corporation
2111 NE 25TH AVE STOP JF2-70
HILLSBORO, OR  97124-5961
(503) 264-1320   Fax: (503) 264-6380

GPG 1.+/PGP 5.+/ DSS/Diffie Helman
http://www.sodarock.com/JohnVillalovos-gpgkey.txt
1024D/1A25D86C 2F24 AD89 E5D5 C92B 7FE2  F878 7ED5 2D38 1A25 D86C


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
