Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292738AbSBZTjx>; Tue, 26 Feb 2002 14:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292739AbSBZTjn>; Tue, 26 Feb 2002 14:39:43 -0500
Received: from gurney.bluecom.no ([217.118.32.13]:15883 "EHLO smtp.bluecom.no")
	by vger.kernel.org with ESMTP id <S292738AbSBZTji>;
	Tue, 26 Feb 2002 14:39:38 -0500
Subject: [PATCH] 2.4.18 Eicon ISDN driver fix.
From: petter wahlman <petter@bluezone.no>
To: linux-kernel@vger.kernel.org
Cc: info@melware.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1014679267.27236.6.camel@BadEip>
Mime-Version: 1.0
X-Mailer: Evolution/1.0 (Preview Release)
Date: 26 Feb 2002 20:26:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following code is calling a possibly blocking operation while
holding a spinlock.


Petter Wahlman


--- linux-2.4.18/drivers/isdn/eicon/eicon_mod.c Fri Dec 21 18:41:54 2001
+++ linux-2.4.18-pw/drivers/isdn/eicon/eicon_mod.c      Mon Feb 25
23:45:05 2002
@@ -665,8 +665,11 @@
                        else
                                cnt = skb->len;

-                       if (user)
+                       if (user) {
+                               spin_unlock_irqrestore(&eicon_lock,
flags);
                                copy_to_user(p, skb->data, cnt);
+                               spin_lock_irqsave(&eicon_lock, flags);
+                       }
                        else
                                memcpy(p, skb->data, cnt);




