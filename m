Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129126AbRBBPRU>; Fri, 2 Feb 2001 10:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129660AbRBBPRK>; Fri, 2 Feb 2001 10:17:10 -0500
Received: from [213.244.175.130] ([213.244.175.130]:43280 "EHLO base.oxygen.nl")
	by vger.kernel.org with ESMTP id <S129126AbRBBPRC>;
	Fri, 2 Feb 2001 10:17:02 -0500
Message-ID: <019701c08d2b$2fc78950$960aa8c0@infernix>
From: "infernix" <infernix@infernix.nl>
To: <linux-kernel@vger.kernel.org>
Subject: isdn_ppp.c bug (isdn_lzscomp.c aka STAC compression > oops on 2.4.x)
Date: Fri, 2 Feb 2001 16:16:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to run ISDN STAC compression on my 2.4.0 kernel. It compiled fine
but once I dialed in and started to use STAC compression it gave me a big
fat oops. I mailed Andre Beck (beck@ibh-dd.de),  the author of
isdn_lzscomp.c (available at www.isdn4linux.de) if this was a known problem,
and there was a fix yet. After a while, he responded with:

> Yep. I've found a bug that was introduced in the late 2.4.0-test
> releases and caused an skb to be freed twice, forcing the kernel
> into a BUG() Oops. The current maintainer of isdn_ppp.c acked that
> bug and prepared this patch, which cured the problem on all test
> systems so far.

However, the patch hasn't been implemented yet, neither in 2.4.1 or in
2.4.1-ac1, because the obvious "HACK,HACK,HACK" sentence is still present :)
Could someone see to it that this mail reaches the kernel's isdn_ppp.c
maintainer and get this thing moving? Thanks.

Regards,

infernix

--- linux-2.4.1-pre8/drivers/isdn/isdn_ppp.c Wed Jan 17 21:09:00 2001
+++ linux-2.4.1-pre8-make-9.work/drivers/isdn/isdn_ppp.c Sun Jan 21 17:47:27
2001
@@ -2310,8 +2310,7 @@
   rsparm.data = rsdata;
   rsparm.maxdlen = IPPP_RESET_MAXDATABYTES;

- /* !!!HACK,HACK,HACK!!! 2048 is only assumed */
-  skb_out = dev_alloc_skb(2048);
+  skb_out = dev_alloc_skb(is->mru + PPP_HDRLEN);
  len = ipc->decompress(stat, skb, skb_out, &rsparm);
  kfree_skb(skb);
  if (len <= 0) {
@@ -2332,14 +2331,17 @@
  kfree_skb(skb_out);
  return NULL;
  }
-
- if (isdn_ppp_skip_ac(ri, skb) < 0) {
- kfree_skb(skb);
+ /* compressed packet always starts with the protocol field,
+ * no need to skip address/control field */
+#if 0
+ if (isdn_ppp_skip_ac(ri, skb_out) < 0) {
+ kfree_skb(skb_out);
  return NULL;
  }
- *proto = isdn_ppp_strip_proto(skb);
+#endif
+ *proto = isdn_ppp_strip_proto(skb_out);
  if (*proto < 0) {
- kfree_skb(skb);
+ kfree_skb(skb_out);
  return NULL;
  }
  return skb_out;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
