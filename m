Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313947AbSDKBiX>; Wed, 10 Apr 2002 21:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313948AbSDKBiW>; Wed, 10 Apr 2002 21:38:22 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:60154
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313947AbSDKBiU>; Wed, 10 Apr 2002 21:38:20 -0400
Date: Wed, 10 Apr 2002 18:40:35 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@zip.com.au>,
        Lennert Buytenhek <buytenh@gnu.org>
Subject: Re: [BUG] DEADLOCK when removing a bridge on 2.4.19-pre6
Message-ID: <20020411014035.GJ23513@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"David S. Miller" <davem@redhat.com>,
	Andrew Morton <akpm@zip.com.au>,
	Lennert Buytenhek <buytenh@gnu.org>
In-Reply-To: <20020410015311.GA31952@matchmail.com> <20020410181606.GD23513@matchmail.com> <20020411004911.GH23513@matchmail.com> <20020411010515.GI23513@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 06:05:15PM -0700, Mike Fedyk wrote:
> On Wed, Apr 10, 2002 at 05:49:11PM -0700, Mike Fedyk wrote:
> > 2.4.18_fix_port_state_handling.diff
> > 
> > Is causing the problem on 2.4.17-19p6tulip-br0fpsh.  I haven't tested the
> > other patches though.
> > 
> > I'm going to reverse this patch on 2.4.19-pre6 to see if it fixes it there
> > too.  Stay tuned.
> 
> 2.4.18_enslave_bridge_dev_to_bridge_dev.diff
> 
> Is fine I didn't reproduce the trouble in 2.4.17-19p6tulip-br0ebdtbd (it was
> already compiling when I tested the port_state kernel...).
> 
> 2.4.19-pre6-nobr0fpsh building now...

Yep, reversing 2.4.18_fix_port_state_handling.diff fixed it.

Here's a patch to reverse it for you:
--- 2.4.19-pre6/net/bridge/br_input.c	Mon Feb 25 11:38:14 2002
+++ 2.4.19-pre6-nobr0fpsh/net/bridge/br_input.c	Wed Apr 10 18:04:17 2002
@@ -5,7 +5,7 @@
  *	Authors:
  *	Lennert Buytenhek		<buytenh@gnu.org>
  *
- *	$Id: br_input.c,v 1.9.2.1 2001/12/24 04:50:05 davem Exp $
+ *	$Id: br_input.c,v 1.9 2001/08/14 22:05:57 davem Exp $
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -46,7 +46,7 @@
 			br_pass_frame_up_finish);
 }
 
-static int br_handle_frame_finish(struct sk_buff *skb)
+static void __br_handle_frame(struct sk_buff *skb)
 {
 	struct net_bridge *br;
 	unsigned char *dest;
@@ -57,112 +57,103 @@
 	dest = skb->mac.ethernet->h_dest;
 
 	p = skb->dev->br_port;
-	if (p == NULL)
-		goto err_nolock;
-
 	br = p->br;
-	read_lock(&br->lock);
-	if (skb->dev->br_port == NULL)
-		goto err;
-
 	passedup = 0;
+
+	if (!(br->dev.flags & IFF_UP) ||
+	    p->state == BR_STATE_DISABLED)
+		goto freeandout;
+
 	if (br->dev.flags & IFF_PROMISC) {
 		struct sk_buff *skb2;
 
 		skb2 = skb_clone(skb, GFP_ATOMIC);
-		if (skb2 != NULL) {
+		if (skb2) {
 			passedup = 1;
 			br_pass_frame_up(br, skb2);
 		}
 	}
 
+	if (skb->mac.ethernet->h_source[0] & 1)
+		goto freeandout;
+
+	if (!passedup &&
+	    (dest[0] & 1) &&
+	    (br->dev.flags & IFF_ALLMULTI || br->dev.mc_list != NULL)) {
+		struct sk_buff *skb2;
+
+		skb2 = skb_clone(skb, GFP_ATOMIC);
+		if (skb2) {
+			passedup = 1;
+			br_pass_frame_up(br, skb2);
+		}
+	}
+
+	if (br->stp_enabled &&
+	    !memcmp(dest, bridge_ula, 5) &&
+	    !(dest[5] & 0xF0))
+		goto handle_special_frame;
+
+	if (p->state == BR_STATE_LEARNING ||
+	    p->state == BR_STATE_FORWARDING)
+		br_fdb_insert(br, p, skb->mac.ethernet->h_source, 0);
+
+	if (p->state != BR_STATE_FORWARDING)
+		goto freeandout;
+
 	if (dest[0] & 1) {
-		br_flood_forward(br, skb, !passedup);
+		br_flood_forward(br, skb, 1);
 		if (!passedup)
 			br_pass_frame_up(br, skb);
-		goto out;
+		else
+			kfree_skb(skb);
+		return;
 	}
 
 	dst = br_fdb_get(br, dest);
+
 	if (dst != NULL && dst->is_local) {
 		if (!passedup)
 			br_pass_frame_up(br, skb);
 		else
 			kfree_skb(skb);
 		br_fdb_put(dst);
-		goto out;
+		return;
 	}
 
 	if (dst != NULL) {
 		br_forward(dst->dst, skb);
 		br_fdb_put(dst);
-		goto out;
+		return;
 	}
 
 	br_flood_forward(br, skb, 0);
+	return;
 
-out:
-	read_unlock(&br->lock);
-	return 0;
+ handle_special_frame:
+	if (!dest[5]) {
+		br_stp_handle_bpdu(skb);
+		return;
+	}
 
-err:
-	read_unlock(&br->lock);
-err_nolock:
+ freeandout:
 	kfree_skb(skb);
-	return 0;
 }
 
-void br_handle_frame(struct sk_buff *skb)
+static int br_handle_frame_finish(struct sk_buff *skb)
 {
 	struct net_bridge *br;
-	unsigned char *dest;
-	struct net_bridge_port *p;
 
-	dest = skb->mac.ethernet->h_dest;
-
-	p = skb->dev->br_port;
-	if (p == NULL)
-		goto err_nolock;
-
-	br = p->br;
+	br = skb->dev->br_port->br;
 	read_lock(&br->lock);
-	if (skb->dev->br_port == NULL)
-		goto err;
-
-	if (!(br->dev.flags & IFF_UP) ||
-	    p->state == BR_STATE_DISABLED)
-		goto err;
-
-	if (skb->mac.ethernet->h_source[0] & 1)
-		goto err;
-
-	if (p->state == BR_STATE_LEARNING ||
-	    p->state == BR_STATE_FORWARDING)
-		br_fdb_insert(br, p, skb->mac.ethernet->h_source, 0);
-
-	if (br->stp_enabled &&
-	    !memcmp(dest, bridge_ula, 5) &&
-	    !(dest[5] & 0xF0))
-		goto handle_special_frame;
-
-	if (p->state == BR_STATE_FORWARDING) {
-		NF_HOOK(PF_BRIDGE, NF_BR_PRE_ROUTING, skb, skb->dev, NULL,
-			br_handle_frame_finish);
-		read_unlock(&br->lock);
-		return;
-	}
-
-err:
+	__br_handle_frame(skb);
 	read_unlock(&br->lock);
-err_nolock:
-	kfree_skb(skb);
-	return;
 
-handle_special_frame:
-	if (!dest[5]) {
-		br_stp_handle_bpdu(skb);
-		return;
-	}
+	return 0;
+}
 
-	kfree_skb(skb);
+void br_handle_frame(struct sk_buff *skb)
+{
+	NF_HOOK(PF_BRIDGE, NF_BR_PRE_ROUTING, skb, skb->dev, NULL,
+			br_handle_frame_finish);
 }
