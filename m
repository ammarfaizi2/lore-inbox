Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWGSF3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWGSF3E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 01:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWGSF3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 01:29:04 -0400
Received: from smtp-out.google.com ([216.239.33.17]:12276 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932504AbWGSF3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 01:29:02 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:message-id:
	mime-version:content-type;
	b=HXL0Qg3pKfM2OKSF2bagKsBYukRwybgX5+8vMy5LdTi8FLAxM7xp2vSkYt0aUrDOQ
	yJVXJy/7piYY1fWNjXssQ==
Date: Tue, 18 Jul 2006 22:28:51 -0700 (PDT)
From: dave rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.corp.google.com
To: linux-kernel@vger.kernel.org
cc: christophe@google.com
Subject: [PATCH] net1080 inherent pad length
Message-ID: <Pine.LNX.4.63.0607182221170.27600@chino.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For your consideration in 2.6.18-rc2.

The size of struct nc_trailer is inherently the newtailroom pad.

 		David

Signed-off-by: David Rientjes <rientjes@google.com>

diff -ru a/drivers/usb/net/net1080.c b/drivers/usb/net/net1080.c
--- a/drivers/usb/net/net1080.c	2006-07-18 22:19:59.396393000 -0700
+++ b/drivers/usb/net/net1080.c	2006-07-18 22:19:47.772577000 -0700
@@ -498,25 +498,24 @@
  static struct sk_buff *
  net1080_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
  {
-	int			padlen;
  	struct sk_buff		*skb2;
  	struct nc_header	*header = NULL;
  	struct nc_trailer	*trailer = NULL;
+	int			padlen = sizeof (struct nc_trailer);
  	int			len = skb->len;

-	padlen = ((len + sizeof (struct nc_header)
-			+ sizeof (struct nc_trailer)) & 0x01) ? 0 : 1;
+	if (!((len + padlen + sizeof (struct nc_header)) & 0x01))
+		padlen++;
  	if (!skb_cloned(skb)) {
  		int	headroom = skb_headroom(skb);
  		int	tailroom = skb_tailroom(skb);

-		if ((padlen + sizeof (struct nc_trailer)) <= tailroom
-			    && sizeof (struct nc_header) <= headroom)
+		if (padlen <= tailroom && sizeof (struct nc_header) <=
+				headroom)
  			/* There's enough head and tail room */
  			goto encapsulate;

-		if ((sizeof (struct nc_header) + padlen
-					+ sizeof (struct nc_trailer)) <
+		if ((sizeof (struct nc_header) + padlen) <
  				(headroom + tailroom)) {
  			/* There's enough total room, so just readjust */
  			skb->data = memmove(skb->head
@@ -530,7 +529,7 @@
  	/* Create a new skb to use with the correct size */
  	skb2 = skb_copy_expand(skb,
  				sizeof (struct nc_header),
-				sizeof (struct nc_trailer) + padlen,
+				padlen,
  				flags);
  	dev_kfree_skb_any(skb);
  	if (!skb2)

