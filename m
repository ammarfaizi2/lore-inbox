Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVDYJHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVDYJHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 05:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVDYJHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 05:07:24 -0400
Received: from [62.206.217.67] ([62.206.217.67]:16780 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262532AbVDYJHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 05:07:15 -0400
Message-ID: <426CB342.2010504@trash.net>
Date: Mon, 25 Apr 2005 11:07:14 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Yair Itzhaki <Yair@arx.com>
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
References: <4151C0F9B9C25C47B3328922A6297A3286CF98@post.arx.com>
In-Reply-To: <4151C0F9B9C25C47B3328922A6297A3286CF98@post.arx.com>
Content-Type: multipart/mixed;
 boundary="------------070005040209090404020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070005040209090404020705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Yair Itzhaki wrote:
> While traversing packets through Netfilter, changing dest address from a foreign to a local address causes the packet to drop (and show up at ip_rt_bug(), along a syslog entry).

Does this patch fix your problem?


--------------070005040209090404020705
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: Don't use ip_route_input() for local addresses

Local input routes have ->output set to ip_rt_bug().

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit bef30866b7440f4c8aff99dc025ea99b8d396390
tree a469360c577fdf6919b9a771521eca120103db45
parent a5c2178d8f07f6180a2daf8df4524cf3b45e62ed
author Patrick McHardy <kaber@trash.net> 1114419959 +0200
committer Patrick McHardy <kaber@trash.net> 1114419959 +0200

Index: net/core/netfilter.c
===================================================================
--- 70652aa8f30bea3ea83594cc4a47a11f7a8db89d/net/core/netfilter.c  (mode:100644 sha1:e51cfa46950cf8f1f4dea42be94e71d76d8c3c5b)
+++ a469360c577fdf6919b9a771521eca120103db45/net/core/netfilter.c  (mode:100644 sha1:85936a0b23d9ea42e2cd9d45e8254c2f780eb786)
@@ -611,7 +611,8 @@
 	/* some non-standard hacks like ipt_REJECT.c:send_reset() can cause
 	 * packets with foreign saddr to appear on the NF_IP_LOCAL_OUT hook.
 	 */
-	if (inet_addr_type(iph->saddr) == RTN_LOCAL) {
+	if (inet_addr_type(iph->saddr) == RTN_LOCAL ||
+	    inet_addr_type(iph->daddr) == RTN_LOCAL) {
 		fl.nl_u.ip4_u.daddr = iph->daddr;
 		fl.nl_u.ip4_u.saddr = iph->saddr;
 		fl.nl_u.ip4_u.tos = RT_TOS(iph->tos);

--------------070005040209090404020705--
