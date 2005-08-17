Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVHQUVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVHQUVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 16:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVHQUVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 16:21:24 -0400
Received: from ixca-out.ixiacom.com ([67.133.120.10]:29296 "EHLO
	ixca-ex1.ixiacom.com") by vger.kernel.org with ESMTP
	id S1751200AbVHQUVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 16:21:24 -0400
Message-ID: <43039C3F.2000207@rincewind.tv>
Date: Wed, 17 Aug 2005 13:21:19 -0700
X-Sybari-Trust: 134488db 453feeff 522dbac3 0000010c
From: Ollie Wild <aaw@rincewind.tv>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix dst_entry leak in icmp_push_reply()
Content-Type: multipart/mixed;
 boundary="------------010208050607040007020102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010208050607040007020102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If the ip_append_data() call in icmp_push_reply() fails, 
ip_flush_pending_frames() needs to be called.  Otherwise, ip_rt_put() is 
never called on inet_sk(icmp_socket->sk)->cork.rt, which prevents the 
route (and net_device) from ever being freed.

I've attached a patch which fixes the problem.

Ollie Wild

--------------010208050607040007020102
Content-Type: text/x-patch;
 name="icmp_push_reply.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="icmp_push_reply.patch"

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -368,6 +368,8 @@ static void icmp_push_reply(struct icmp_
 		icmph->checksum = csum_fold(csum);
 		skb->ip_summed = CHECKSUM_NONE;
 		ip_push_pending_frames(icmp_socket->sk);
+	} else {
+		ip_flush_pending_frames(icmp_socket->sk);
 	}
 }
 

--------------010208050607040007020102--
