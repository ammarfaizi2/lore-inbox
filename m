Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262887AbVCPX7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbVCPX7B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVCPX5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:57:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:7058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262888AbVCPXzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:55:43 -0500
Date: Wed, 16 Mar 2005 15:55:02 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: shemminger@osdl.org, kaber@trash.net, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       cliffw@osdl.org, tytso@mit.edu, rddunlap@osdl.org
Subject: [5/9] [TUN] Fix check for underflow
Message-ID: <20050316235502.GD5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316235336.GY5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

----

From: Stephen Hemminger <shemminger@osdl.org>

http://bugme.osdl.org/show_bug.cgi?id=4279
Summary: When I try to start vpnc the net/core/skbuff.c:91 crash

This check is wrong, gcc optimizes it away:

                if ((len -= sizeof(pi)) > len)
			return -EINVAL;

This could be responsible for the BUG. If len is 2 or 3 and TUN_NO_PI
isn't set it underflows. alloc_skb() allocates len + 2, which is 0 or
1 byte. skb_reserve tries to reserve 2 bytes and things explode in
skb_put.

[TUN]: Fix check for underflow

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -Nru a/drivers/net/tun.c b/drivers/net/tun.c
--- a/drivers/net/tun.c	2005-03-04 19:41:56 +01:00
+++ b/drivers/net/tun.c	2005-03-04 19:41:56 +01:00
@@ -229,7 +229,7 @@
 	size_t len = count;
 
 	if (!(tun->flags & TUN_NO_PI)) {
-		if ((len -= sizeof(pi)) > len)
+		if ((len -= sizeof(pi)) > count)
 			return -EINVAL;
 
 		if(memcpy_fromiovec((void *)&pi, iv, sizeof(pi)))
