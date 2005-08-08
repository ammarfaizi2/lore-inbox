Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVHHWz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVHHWz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVHHWz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:55:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52631 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932337AbVHHWz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:55:57 -0400
Date: Mon, 8 Aug 2005 18:55:46 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: icn driver fails to unload when no hardware present.
Message-ID: <20050808225546.GA4315@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a null dereference in module unload path.

Found by a simple modprobe icn ; rmmod icn

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/drivers/isdn/icn/icn.c~	2005-08-08 18:50:25.000000000 -0400
+++ linux-2.6.12/drivers/isdn/icn/icn.c	2005-08-08 18:54:13.000000000 -0400
@@ -1650,7 +1650,7 @@ static void __exit icn_exit(void)
 {
 	isdn_ctrl cmd;
 	icn_card *card = cards;
-	icn_card *last;
+	icn_card *last, *tmpcard;
 	int i;
 	unsigned long flags;
 
@@ -1670,8 +1670,9 @@ static void __exit icn_exit(void)
 			for (i = 0; i < ICN_BCH; i++)
 				icn_free_queue(card, i);
 		}
-		card = card->next;
+		tmpcard = card->next;
 		spin_unlock_irqrestore(&card->lock, flags);
+		card = tmpcard;
 	}
 	card = cards;
 	cards = NULL;
