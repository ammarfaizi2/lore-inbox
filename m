Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVDEQvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVDEQvx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVDEQve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:51:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:65177 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261821AbVDEQso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:48:44 -0400
Date: Tue, 5 Apr 2005 09:47:27 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: kaber@trash.net, davem@davemloft.net, netdev@oss.sgi.com
Subject: [05/08] [IPSEC]: Do not hold state lock while checking size
Message-ID: <20050405164726.GF17299@kroah.com>
References: <20050405164539.GA17299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405164539.GA17299@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

This patch from Herbert Xu fixes a deadlock with IPsec.
When an ICMP frag. required is sent and the ICMP message
needs the same SA as the packet that caused it the state
will be locked twice.

[IPSEC]: Do not hold state lock while checking size.

This can elicit ICMP message output and thus result in a
deadlock.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
--- a/net/ipv4/xfrm4_output.c	2005-03-20 16:53:05 +01:00
+++ b/net/ipv4/xfrm4_output.c	2005-03-20 16:53:05 +01:00
@@ -103,16 +103,16 @@
 			goto error_nolock;
 	}
 
-	spin_lock_bh(&x->lock);
-	err = xfrm_state_check(x, skb);
-	if (err)
-		goto error;
-
 	if (x->props.mode) {
 		err = xfrm4_tunnel_check_size(skb);
 		if (err)
-			goto error;
+			goto error_nolock;
 	}
+
+	spin_lock_bh(&x->lock);
+	err = xfrm_state_check(x, skb);
+	if (err)
+		goto error;
 
 	xfrm4_encap(skb);
 
diff -Nru a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
--- a/net/ipv6/xfrm6_output.c	2005-03-20 16:53:05 +01:00
+++ b/net/ipv6/xfrm6_output.c	2005-03-20 16:53:05 +01:00
@@ -103,16 +103,16 @@
 			goto error_nolock;
 	}
 
-	spin_lock_bh(&x->lock);
-	err = xfrm_state_check(x, skb);
-	if (err)
-		goto error;
-
 	if (x->props.mode) {
 		err = xfrm6_tunnel_check_size(skb);
 		if (err)
-			goto error;
+			goto error_nolock;
 	}
+
+	spin_lock_bh(&x->lock);
+	err = xfrm_state_check(x, skb);
+	if (err)
+		goto error;
 
 	xfrm6_encap(skb);
 
