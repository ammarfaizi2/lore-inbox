Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbSJEUsl>; Sat, 5 Oct 2002 16:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262665AbSJEUsl>; Sat, 5 Oct 2002 16:48:41 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:37049 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S262664AbSJEUsk>;
	Sat, 5 Oct 2002 16:48:40 -0400
Date: Sat, 5 Oct 2002 22:54:10 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [patch] 2.4.20-pre9 - drivers/atm/iphase.c : GFP_KERNEL with spinlock held
Message-ID: <20021005225410.A22417@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/atm/iphase.c:tx_intr()
[...]
   1684            spin_lock_irqsave(&iadev->tx_lock, flags);
   1685            ia_tx_poll(iadev);

ia_tx_poll ->
 ia_hack_tcq ->
  ia_enque_rtn_q ->
   IARTN_Q *entry = kmalloc(sizeof(*entry), GFP_KERNEL);

Driver does not seem maintained. Please apply.

--- linux-2.4.20-pre9.orig/drivers/atm/iphase.c	Sat Oct  5 15:51:28 2002
+++ linux-2.4.20-pre9/drivers/atm/iphase.c	Sat Oct  5 22:44:18 2002
@@ -124,7 +124,7 @@ static void ia_enque_head_rtn_q (IARTN_Q
 }
 
 static int ia_enque_rtn_q (IARTN_Q *que, struct desc_tbl_t data) {
-   IARTN_Q *entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+   IARTN_Q *entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
    if (!entry) return -1;
    entry->data = data;
    entry->next = NULL;

