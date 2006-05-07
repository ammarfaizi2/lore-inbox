Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWEGSuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWEGSuF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 14:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWEGSuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 14:50:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:52049 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751230AbWEGSuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 14:50:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mdUrVObjRomgjzBjUW4Y4/41g9zgvZ7baGA47mEMC/jahRZ/4Ch9DW4UB3aGg4Qt3fAK/hyYnHJ5X3h9lgDrcBA2zuyusb51otxC2MSdKcoYu3arFSmfgvD5Fs7b/qOCeXVZTG7HvJ00mUgDC8b0uBjbmM2R/RFoEL09RZwAKEw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth: fix potential NULL ptr deref in dtl1_cs.c::dtl1_hci_send_frame()
Date: Sun, 7 May 2006 20:50:57 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605072050.57415.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a problem in drivers/bluetooth/dtl1_cs.c::dtl1_hci_send_frame()

If bt_skb_alloc() returns NULL, then skb_reserve(s, NSHL); will cause a
NULL pointer deref - ouch.
If we can't allocate the resources we require we need to tell the caller
by returning -ENOMEM.

Found by the coverity checker as bug #409

Patch is compile tested, but that's all, due to lack of hardware.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/bluetooth/dtl1_cs.c |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2.6.17-rc3-git12-orig/drivers/bluetooth/dtl1_cs.c	2006-05-07 03:25:16.000000000 +0200
+++ linux-2.6.17-rc3-git12/drivers/bluetooth/dtl1_cs.c	2006-05-07 20:43:01.000000000 +0200
@@ -423,6 +423,9 @@ static int dtl1_hci_send_frame(struct sk
 	nsh.len = skb->len;
 
 	s = bt_skb_alloc(NSHL + skb->len + 1, GFP_ATOMIC);
+	if (!s)
+		return -ENOMEM;
+
 	skb_reserve(s, NSHL);
 	memcpy(skb_put(s, skb->len), skb->data, skb->len);
 	if (skb->len & 0x0001)


