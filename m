Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161522AbWJVAyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161522AbWJVAyj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 20:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161524AbWJVAyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 20:54:39 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:52638 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1161522AbWJVAyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 20:54:38 -0400
Message-id: <4663519137208551@wsc.cz>
Subject: [PATCH 2/3] Char: isicom, simplify timer
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 22 Oct 2006 02:54:39 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, simplify timer

Don't init timer in such complicated way. Use DEFINE_TIMER and then only
mod_timer to reset the expiration.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit e545b8cddd984bff6abbc1286baa042290b43032
tree 306ba2423496b6f8553c7f5db214f1b622136241
parent 12be27655354f888150bbb720614dfba48cecdaf
author Jiri Slaby <jirislaby@gmail.com> Sat, 21 Oct 2006 22:50:31 +0200
committer Jiri Slaby <jirislaby@gmail.com> Sat, 21 Oct 2006 22:50:31 +0200

 drivers/char/isicom.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index a8cfdf5..9a61d0c 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -173,12 +173,13 @@ static int prev_card = 3;	/*	start servi
 static struct tty_driver *isicom_normal;
 
 static DECLARE_COMPLETION(isi_timerdone);
-static struct timer_list tx;
 static char re_schedule = 1;
 
 static void isicom_tx(unsigned long _data);
 static void isicom_start(struct tty_struct *tty);
 
+static DEFINE_TIMER(tx, isicom_tx, 0, 0);
+
 /*   baud index mappings from linux defns to isi */
 
 static signed char linuxb_to_isib[] = {
@@ -519,13 +520,7 @@ sched_again:
  		return;
 	}
 
-	init_timer(&tx);
-	tx.expires = jiffies + HZ/100;
-	tx.data = 0;
-	tx.function = isicom_tx;
-	add_timer(&tx);
-
-	return;
+	mod_timer(&tx, jiffies + msecs_to_jiffies(10));
 }
 
 /* 	Interrupt handlers 	*/
@@ -1906,12 +1901,7 @@ static int __init isicom_init(void)
 		goto err_unrtty;
 	}
 
-	init_timer(&tx);
-	tx.expires = jiffies + 1;
-	tx.data = 0;
-	tx.function = isicom_tx;
-	re_schedule = 1;
-	add_timer(&tx);
+	mod_timer(&tx, jiffies + 1);
 
 	return 0;
 err_unrtty:
