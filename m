Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267717AbTAaHVy>; Fri, 31 Jan 2003 02:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267714AbTAaHVy>; Fri, 31 Jan 2003 02:21:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36779 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267713AbTAaHVw>;
	Fri, 31 Jan 2003 02:21:52 -0500
Date: Thu, 30 Jan 2003 23:18:52 -0800 (PST)
Message-Id: <20030130.231852.18464285.davem@redhat.com>
To: cw@f00f.org
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, lists@openunix.de,
       debian-sparc@lists.debian.org, Ralf.Hildebrandt@charite.de,
       byron@markerman.com, john@grabjohn.com
Subject: [PATCH] fix for "assertion (newsk->state != TCP_SYN_RECV) ..."
From: "David S. Miller" <davem@redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris and others, this below should cure the infamous:

KERNEL: assertion (newsk->state != TCP_SYN_RECV) failed at tcp.c(2229)
KERNEL: assertion ((1<<sk2->state)&(TCPF_ESTABLISHED|TCPF_CLOSE_WAIT|TCPF_CLOSE)) failed at af_inet.c(689)

assertion failures people have been seeing starting in 2.4.20

The bug is in 2.5.x too, and the patch below applies pretty cleanly
there.

This has been sent to Marcelo already, and Linus will get it for
2.5.x when he gets back.

Thanks to everyone for reporting.  The fact that multiple reports
existed made it possible for to figure out what was so common
amongst the reports and thus find the bug relatively quickly.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.933   -> 1.934  
#	net/ipv4/tcp_minisocks.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/30	davem@nuts.ninka.net	1.934
# [TCP]: In tcp_check_req, handle ACKless packets properly.
# --------------------------------------------
#
diff -Nru a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
--- a/net/ipv4/tcp_minisocks.c	Thu Jan 30 23:08:40 2003
+++ b/net/ipv4/tcp_minisocks.c	Thu Jan 30 23:08:40 2003
@@ -938,6 +938,12 @@
 	if (flg & (TCP_FLAG_RST|TCP_FLAG_SYN))
 		goto embryonic_reset;
 
+	/* ACK sequence verified above, just make sure ACK is
+	 * set.  If ACK not set, just silently drop the packet.
+	 */
+	if (!(flg & TCP_FLAG_ACK))
+		return NULL;
+
 	/* If TCP_DEFER_ACCEPT is set, drop bare ACK. */
 	if (tp->defer_accept && TCP_SKB_CB(skb)->end_seq == req->rcv_isn+1) {
 		req->acked = 1;
