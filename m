Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbRCLMlD>; Mon, 12 Mar 2001 07:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130037AbRCLMkn>; Mon, 12 Mar 2001 07:40:43 -0500
Received: from roma.axis.se ([193.13.178.2]:62219 "EHLO roma.axis.se")
	by vger.kernel.org with ESMTP id <S129855AbRCLMkf>;
	Mon, 12 Mar 2001 07:40:35 -0500
Message-ID: <050a01c0aaf1$1984aea0$0a070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: <linux-kernel@vger.kernel.org>
Subject: Missing use of TcpPassiveOpens counter?
Date: Mon, 12 Mar 2001 13:36:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to track down a possible select()/accept()
problem in 2.0.38 I noticed that theTcpPassiveOpens counter
is never increased (not in 2.0, 2.2 nor 2.4)

When checking more of the Tcp: fields in
/proc/net/snmp
it looks like some more fields are not set correctly
(tcpRto*, tcpMaxConn )

Just overlooked and forgotten or does nobody care?
(or both:)

The following patch for 2.0 increases the TcpPassiveOpen counter,
the case where you have crossed SYN's is not handled,
but I don't think it should anyway?
At first I was tempted to put it in the tcp_accept() function,
but it should really be when we change state from 
LISTEN to SYN_RECVD.

diff -u -p -r1.7 tcp_input.c
--- tcp_input.c 2000/03/30 15:53:22     1.7
+++ tcp_input.c 2001/03/12 12:11:18
@@ -747,7 +747,9 @@ static void tcp_conn_request(struct sock
        newsk->dummy_th.source = skb->h.th->dest;
        newsk->dummy_th.dest = skb->h.th->source;
        newsk->users=0;
-
+
+      tcp_statistics.TcpPassiveOpens++; /* LISTEN to SYN_RECV */
+
 #ifdef CONFIG_IP_TRANSPARENT_PROXY
        /* 
         *      Deal with possibly redirected traffic by setting num to


In 2.4 I'm not sure where to put the
TCP_INC_STATS(TcpPassiveOpens); or
TCP_INC_STATS_BH(TcpPassiveOpens);

tcp_minisocks.c:tcp_create_openreq_child() ?


/Johan




