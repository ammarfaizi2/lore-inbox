Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUKDV4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUKDV4s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbUKDV4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:56:09 -0500
Received: from [62.206.217.67] ([62.206.217.67]:55681 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262448AbUKDVx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:53:57 -0500
Message-ID: <418AA4C7.2030909@trash.net>
Date: Thu, 04 Nov 2004 22:53:11 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>, linux-net@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks
 amanda dumps
References: <418A7B0B.7040803@trash.net>	<E1CPoUT-0000sk-00@gondolin.me.apana.org.au> <20041104130028.099fc130.davem@davemloft.net>
In-Reply-To: <20041104130028.099fc130.davem@davemloft.net>
Content-Type: multipart/mixed;
 boundary="------------040605020504000201090706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040605020504000201090706
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:

>You're right... the bug was introduced by my skb_header_pointer() changes.
>Look at this:
>
>	amp = skb_header_pointer(skb, dataoff,
>				 skb->len - dataoff, amanda_buffer);
>	BUG_ON(amp == NULL);
>	data = amp;
>	data_limit = amp + skb->len - dataoff;
>	*data_limit = '\0';
>
>It should just use the amanda_buffer always.
>
Thanks Dave and Herbert, here is the patch in case you haven't fixed it
already.

Regards
Patrick


--------------040605020504000201090706
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/04 22:50:11+01:00 kaber@coreworks.de 
#   [NETFILTER]: Don't use skb_header_pointer in amanda conntrack helper
#   
#   Fixes broken packets, noticed by Matthias Andree <matthias.andree@gmx.de>
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# net/ipv4/netfilter/ip_conntrack_amanda.c
#   2004/11/04 22:50:04+01:00 kaber@coreworks.de +5 -7
#   [NETFILTER]: Don't use skb_header_pointer in amanda conntrack helper
#   
#   Fixes broken packets, noticed by Matthias Andree <matthias.andree@gmx.de>
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
diff -Nru a/net/ipv4/netfilter/ip_conntrack_amanda.c b/net/ipv4/netfilter/ip_conntrack_amanda.c
--- a/net/ipv4/netfilter/ip_conntrack_amanda.c	2004-11-04 22:50:37 +01:00
+++ b/net/ipv4/netfilter/ip_conntrack_amanda.c	2004-11-04 22:50:37 +01:00
@@ -49,7 +49,7 @@
 {
 	struct ip_conntrack_expect *exp;
 	struct ip_ct_amanda_expect *exp_amanda_info;
-	char *amp, *data, *data_limit, *tmp;
+	char *data, *data_limit, *tmp;
 	unsigned int dataoff, i;
 	u_int16_t port, len;
 
@@ -70,11 +70,9 @@
 	}
 
 	LOCK_BH(&amanda_buffer_lock);
-	amp = skb_header_pointer(skb, dataoff,
-				 skb->len - dataoff, amanda_buffer);
-	BUG_ON(amp == NULL);
-	data = amp;
-	data_limit = amp + skb->len - dataoff;
+	skb_copy_bits(skb, dataoff, amanda_buffer, skb->len - dataoff);
+	data = amanda_buffer;
+	data_limit = amanda_buffer + skb->len - dataoff;
 	*data_limit = '\0';
 
 	/* Search for the CONNECT string */
@@ -110,7 +108,7 @@
 		exp->mask.dst.u.tcp.port = 0xFFFF;
 
 		exp_amanda_info = &exp->help.exp_amanda_info;
-		exp_amanda_info->offset = tmp - amp;
+		exp_amanda_info->offset = tmp - amanda_buffer;
 		exp_amanda_info->port   = port;
 		exp_amanda_info->len    = len;
 

--------------040605020504000201090706--
