Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTDGEh6 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 00:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263251AbTDGEh6 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 00:37:58 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:36621 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S263250AbTDGEh5 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 00:37:57 -0400
Date: Mon, 7 Apr 2003 14:49:22 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Melkor Ainur <melkorainur@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: failure due to swapper and inet_sock_destruct
In-Reply-To: <20030406065419.91429.qmail@web21203.mail.yahoo.com>
Message-ID: <Mutt.LNX.4.44.0304071446250.28527-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Apr 2003, Melkor Ainur wrote:

> Hello,
> 
> I am using the 2.4.20 kernel in a fairly high stress
> bursty network environment. Every so often, I see the
> following error message from the kernel:
> 
> Attempt to release TCP socket in state 10 cfbfd540
> 

Could you please try the patch from Dave Miller below (which is already in
2.4.21-pre).


- James
-- 
James Morris 
<jmorris@intercode.com.au>

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.930.3.3 -> 1.930.3.4
#	net/ipv4/tcp_minisocks.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/30	davem@nuts.ninka.net	1.930.3.4
# [TCP]: In tcp_check_req, handle ACKless packets properly.
# --------------------------------------------
#
diff -Nru a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
--- a/net/ipv4/tcp_minisocks.c	Sun Apr  6 21:41:32 2003
+++ b/net/ipv4/tcp_minisocks.c	Sun Apr  6 21:41:32 2003
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

