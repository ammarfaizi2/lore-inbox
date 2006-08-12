Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWHLUrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWHLUrQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 16:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbWHLUrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 16:47:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:38245 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422664AbWHLUrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 16:47:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pYjbPqNhYQejinsB6kdenMm7NaYwMzlRzTpMEvG87n7CW+5K1AFbm3VIm1ZP46qUyzTXDIevH2DV46dd/z7wa7ZwsGOXEMEN2OsPYGyjxtXBmm2ZGZftjFfDupAfXyZ7wagUvCnbWNJ9K8qkxMHKCP4T4L+fJ2eqsMbjIHKO2x8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ISDN: fix double free bug in isdn_net
Date: Sat, 12 Aug 2006 22:48:22 +0200
User-Agent: KMail/1.9.4
Cc: Karsten Keil <kkeil@suse.de>, Kai Germaschewski <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608122248.22639.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's double-free bug in 
drivers/isdn/i4l/isdn_net.c::isdn_net_writebuf_skb().

If isdn_writebuf_skb_stub() doesn't handle the entire skb, then it will 
have freed the skb that was passed to it and when the code then jumps 
to the error label it'll result in a double free of the skb.

The easy way to fix this is to insert an assignment of skb = NULL in the
'if' following the call to isdn_writebuf_skb_stub() so that when the code
at the error label calls dev_kfree_skb(skb); the skb will be NULL and 
nothing will happen since dev_kfree_skb() just does a return if passed a
NULL.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/isdn/i4l/isdn_net.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.18-rc4-orig/drivers/isdn/i4l/isdn_net.c	2006-08-11 00:10:55.000000000 +0200
+++ linux-2.6.18-rc4/drivers/isdn/i4l/isdn_net.c	2006-08-12 22:39:56.000000000 +0200
@@ -1023,6 +1023,7 @@ void isdn_net_writebuf_skb(isdn_net_loca
 	if (ret != len) {
 		/* we should never get here */
 		printk(KERN_WARNING "%s: HL driver queue full\n", lp->name);
+		skb = NULL;
 		goto error;
 	}
 	


