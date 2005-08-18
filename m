Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVHRS7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVHRS7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVHRS7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:59:38 -0400
Received: from [62.206.217.67] ([62.206.217.67]:16050 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S932397AbVHRS7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:59:37 -0400
Message-ID: <4304DA99.2080205@trash.net>
Date: Thu, 18 Aug 2005 20:59:37 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050803 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ollie Wild <aaw@rincewind.tv>
CC: linux-kernel@vger.kernel.org, Maillist netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] fix dst_entry leak in icmp_push_reply()
References: <43039C3F.2000207@rincewind.tv> <4303CEC5.3010502@trash.net> <43042D94.4030303@rincewind.tv> <4304D763.4090001@rincewind.tv>
In-Reply-To: <4304D763.4090001@rincewind.tv>
Content-Type: multipart/mixed;
 boundary="------------020505050000070804030301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020505050000070804030301
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ollie Wild wrote:
> That said, I appreciate that the if-else condition doesn't seem quite
> right.  The problem is, the icmp_push_reply() routine is implicitly
> using the queue as a success indicator.  I put the
> ip_flush_pending_frames() call inside the else block because I wanted to
> guarantee that one of ip_push_pending_frames() and
> ip_flush_pending_frames() is always called.  Both will do proper cleanup.
> 
> I'm open to suggestions if you think there's a cleaner way to implement
> this.

Checking the return value of ip_append_data seems cleaner to me.
Patch attached.

Signed-off-by: Patrick McHardy <kaber@trash.net>

--------------020505050000070804030301
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -349,12 +349,12 @@ static void icmp_push_reply(struct icmp_
 {
 	struct sk_buff *skb;
 
-	ip_append_data(icmp_socket->sk, icmp_glue_bits, icmp_param,
-		       icmp_param->data_len+icmp_param->head_len,
-		       icmp_param->head_len,
-		       ipc, rt, MSG_DONTWAIT);
-
-	if ((skb = skb_peek(&icmp_socket->sk->sk_write_queue)) != NULL) {
+	if (ip_append_data(icmp_socket->sk, icmp_glue_bits, icmp_param,
+		           icmp_param->data_len+icmp_param->head_len,
+		           icmp_param->head_len,
+		           ipc, rt, MSG_DONTWAIT) < 0)
+		ip_flush_pending_frames(icmp_socket->sk);
+	else if ((skb = skb_peek(&icmp_socket->sk->sk_write_queue)) != NULL) {
 		struct icmphdr *icmph = skb->h.icmph;
 		unsigned int csum = 0;
 		struct sk_buff *skb1;

--------------020505050000070804030301--
