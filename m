Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265569AbTFRWOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265570AbTFRWOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:14:55 -0400
Received: from tomts23.bellnexxia.net ([209.226.175.185]:65419 "EHLO
	tomts23-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S265569AbTFRWOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:14:51 -0400
Subject: [PATCH] 2.[45] eexpress.c skb_padto fixes broke pppoe
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-oKG89FVDviF22Z0b19SG"
Organization: 
Message-Id: <1055975326.28012.13.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Jun 2003 18:28:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oKG89FVDviF22Z0b19SG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I posted this to linux-net and didn't get a reply so I am posting it
here. Please cc any replies.

The attached patch fixes the breakage caused by the recent skb_padto
security fixes. It applies to both 2.4.21 and 2.5.72 (with a little
fuzz). I have tested it on 2.4.21 but not on 2.5.

If it looks ok can it be included in 2.4 and 2.5?

Regards,

Shane

--=-oKG89FVDviF22Z0b19SG
Content-Disposition: attachment; filename=eexpress_skb_padto_fix.diff
Content-Type: text/x-diff; name=eexpress_skb_padto_fix.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.4.21aarc8A/drivers/net/eexpress.c.broken	Fri Jun 13 10:51:34 2003
+++ linux-2.4.21aarc8A/drivers/net/eexpress.c	Mon Jun 16 22:05:55 2003
@@ -640,7 +640,9 @@
 static int eexp_xmit(struct sk_buff *buf, struct net_device *dev)
 {
 	struct net_local *lp = (struct net_local *)dev->priv;
-	short length = buf->len;
+	unsigned short length = (ETH_ZLEN < buf->len) ? buf->len :
+		                         ETH_ZLEN;
+
 #ifdef CONFIG_SMP
 	unsigned long flags;
 #endif
@@ -654,7 +656,6 @@
 		buf = skb_padto(buf, ETH_ZLEN);
 		if(buf == NULL)
 			return 0;
-		length = buf->len;
 	}
 
 	disable_irq(dev->irq);

--=-oKG89FVDviF22Z0b19SG--

