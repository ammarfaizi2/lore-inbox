Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266515AbUA3FVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266537AbUA3FTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:19:03 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:56452 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266524AbUA3FRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:17:07 -0500
Date: Fri, 30 Jan 2004 00:01:55 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.2-rc2
Message-ID: <20040130000155.GI12308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040129235304.GA12308@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129235304.GA12308@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some aditional information to sysfs for pnp cards.  It should be
useful for userland tools.

--- a/drivers/pnp/card.c	2004-01-29 23:08:49.000000000 +0000
+++ b/drivers/pnp/card.c	2004-01-29 23:03:23.000000000 +0000
@@ -139,6 +139,39 @@
 	kfree(card);
 }
 
+
+static ssize_t pnp_show_card_name(struct device *dmdev, char *buf)
+{
+	char *str = buf;
+	struct pnp_card *card = to_pnp_card(dmdev);
+	str += sprintf(str,"%s\n", card->name);
+	return (str - buf);
+}
+
+static DEVICE_ATTR(name,S_IRUGO,pnp_show_card_name,NULL);
+
+static ssize_t pnp_show_card_ids(struct device *dmdev, char *buf)
+{
+	char *str = buf;
+	struct pnp_card *card = to_pnp_card(dmdev);
+	struct pnp_id * pos = card->id;
+
+	while (pos) {
+		str += sprintf(str,"%s\n", pos->id);
+		pos = pos->next;
+	}
+	return (str - buf);
+}
+
+static DEVICE_ATTR(card_id,S_IRUGO,pnp_show_card_ids,NULL);
+
+static int pnp_interface_attach_card(struct pnp_card *card)
+{
+	device_create_file(&card->dev,&dev_attr_name);
+	device_create_file(&card->dev,&dev_attr_card_id);
+	return 0;
+}
+
 /**
  * pnp_add_card - adds a PnP card to the PnP Layer
  * @card: pointer to the card to add
@@ -158,6 +191,7 @@
 	error = device_register(&card->dev);
 
 	if (error == 0) {
+		pnp_interface_attach_card(card);
 		spin_lock(&pnp_lock);
 		list_add_tail(&card->global_list, &pnp_cards);
 		list_add_tail(&card->protocol_list, &card->protocol->cards);
