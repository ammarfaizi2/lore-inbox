Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279305AbRKMVVP>; Tue, 13 Nov 2001 16:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279277AbRKMVVG>; Tue, 13 Nov 2001 16:21:06 -0500
Received: from [217.6.75.131] ([217.6.75.131]:5592 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S279242AbRKMVUv>; Tue, 13 Nov 2001 16:20:51 -0500
Message-ID: <3BF190F0.3FB26BD0@internetwork-ag.de>
Date: Tue, 13 Nov 2001 22:30:24 +0100
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        paulus@samba.org
CC: linux-ppp@vger.kernel.org
Subject: [PATCH] ppp_generic causes skput:under: w/ pppoatm and vc-encaps
Content-Type: multipart/mixed;
 boundary="------------16CE7A4DD19160204463BA74"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------16CE7A4DD19160204463BA74
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

using pppoatm from Mitchell Blank jr resulted in a BUG "skput:under: ..." when
used w/ vc-encapsulation.  The problem is (at least w/ the iphase driver) that
the skb's headroom is 0 (since the vc-encaps. is nothing but the PPP frame) and
ppp_receive_nonmp_frame unconditionally calls skb_push -> BUG(skput:under: ...")
in the CONFIG_PPP_FILTER section.

I've attached a patch, checking for headroom first, and - if necessary -
reallocating a larger buffer for the skb_push.

Please check and apply - or find a better fix!

Thanks,

Immanuel

--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de



--------------16CE7A4DD19160204463BA74
Content-Type: text/plain; charset=us-ascii;
 name="qq2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qq2"

diff -Naur linux-2.4.10/drivers/net/ppp_generic.c linux-2.4.10-new/drivers/net/ppp_generic.c
--- linux-2.4.10/drivers/net/ppp_generic.c Sun Sep  9 19:45:43 2001
+++ linux-2.4.10-new/drivers/net/ppp_generic.c Tue Nov 13 21:48:29 2001
@@ -1470,6 +1470,23 @@
   /* check if the packet passes the pass and active filters */
   /* the filter instructions are constructed assuming
      a four-byte PPP header on each packet */
+         /* make sure we have room for the following skb_push... */
+         if (skb_headroom(skb) < PPP_HDRLEN) {
+      struct sk_buff *ns;
+      
+      ns = alloc_skb(skb->len + PPP_HDRLEN*2,GFP_ATOMIC);
+      if (ns == 0) {
+   printk(KERN_DEBUG "PPP: inbound skb not resizeable.\n");
+   kfree_skb(skb);
+   return;
+      }
+      skb_reserve(ns, PPP_HDRLEN*2);
+      memcpy(skb_put(ns, skb->len), skb->data, skb->len);
+      kfree_skb(skb);
+      skb = ns;
+      if (ppp->debug & 1)
+   printk(KERN_DEBUG "PPP: inbound skb resized.\n");
+  }
   *skb_push(skb, 2) = 0;
   if (ppp->pass_filter.filter
       && sk_run_filter(skb, ppp->pass_filter.filter,


--------------16CE7A4DD19160204463BA74--

