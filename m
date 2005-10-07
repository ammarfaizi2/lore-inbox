Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbVJGXzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVJGXzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVJGXzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:55:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:8918 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964916AbVJGXzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:55:04 -0400
Date: Fri, 7 Oct 2005 16:54:32 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, meder@o0o.nu, proski@gnu.org,
       orinoco-devel@lists.sourceforge.net, netdev@vger.kernel.org
Subject: [patch 2/7] orinoco: Information leakage due to incorrect padding
Message-ID: <20051007235432.GC23111@kroah.com>
References: <20051007234348.631583000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="orinoco-info-leak.patch"
In-Reply-To: <20051007235353.GA23111@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Roskin <proski@gnu.org>

The orinoco driver can send uninitialized data exposing random pieces of
the system memory.  This happens because data is not padded with zeroes
when its length needs to be increased.

Reported by Meder Kydyraliev <meder@o0o.nu>

Signed-off-by: Pavel Roskin <proski@gnu.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/net/wireless/orinoco.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- linux-2.6.13.y.orig/drivers/net/wireless/orinoco.c
+++ linux-2.6.13.y/drivers/net/wireless/orinoco.c
@@ -502,9 +502,14 @@ static int orinoco_xmit(struct sk_buff *
 		return 0;
 	}
 
-	/* Length of the packet body */
-	/* FIXME: what if the skb is smaller than this? */
-	len = max_t(int,skb->len - ETH_HLEN, ETH_ZLEN - ETH_HLEN);
+	/* Check packet length, pad short packets, round up odd length */
+	len = max_t(int, ALIGN(skb->len, 2), ETH_ZLEN);
+	if (skb->len < len) {
+		skb = skb_padto(skb, len);
+		if (skb == NULL)
+			goto fail;
+	}
+	len -= ETH_HLEN;
 
 	eh = (struct ethhdr *)skb->data;
 
@@ -556,8 +561,7 @@ static int orinoco_xmit(struct sk_buff *
 		p = skb->data;
 	}
 
-	/* Round up for odd length packets */
-	err = hermes_bap_pwrite(hw, USER_BAP, p, ALIGN(data_len, 2),
+	err = hermes_bap_pwrite(hw, USER_BAP, p, data_len,
 				txfid, data_off);
 	if (err) {
 		printk(KERN_ERR "%s: Error %d writing packet to BAP\n",

--
