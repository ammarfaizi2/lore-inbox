Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161521AbWJVAy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161521AbWJVAy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 20:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161522AbWJVAy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 20:54:29 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:51614 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1161521AbWJVAy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 20:54:28 -0400
Message-id: <935639182341124516@wsc.cz>
Subject: [PATCH 1/3] Char: isicom, use completion
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 22 Oct 2006 02:54:28 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

isicom, use completion

use wait_for_completion+complete instead of variables+msleep hack.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 12be27655354f888150bbb720614dfba48cecdaf
tree a41af90a51a6de23bbae8ee7109a33a7fef23154
parent e6ef63223d0b6c4a72f815b8a42584d346980c82
author Jiri Slaby <jirislaby@gmail.com> Sat, 21 Oct 2006 21:50:40 +0200
committer Jiri Slaby <jirislaby@gmail.com> Sat, 21 Oct 2006 21:50:40 +0200

 drivers/char/isicom.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
index db57da6..a8cfdf5 100644
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -172,6 +172,7 @@ static struct pci_driver isicom_driver =
 static int prev_card = 3;	/*	start servicing isi_card[0]	*/
 static struct tty_driver *isicom_normal;
 
+static DECLARE_COMPLETION(isi_timerdone);
 static struct timer_list tx;
 static char re_schedule = 1;
 
@@ -514,7 +515,7 @@ static void isicom_tx(unsigned long _dat
 	/*	schedule another tx for hopefully in about 10ms	*/
 sched_again:
 	if (!re_schedule) {
-		re_schedule = 2;
+		complete(&isi_timerdone);
  		return;
 	}
 
@@ -1923,12 +1924,9 @@ error:
 
 static void __exit isicom_exit(void)
 {
-	unsigned int index = 0;
-
 	re_schedule = 0;
 
-	while (re_schedule != 2 && index++ < 100)
-		msleep(10);
+	wait_for_completion_timeout(&isi_timerdone, HZ);
 
 	pci_unregister_driver(&isicom_driver);
 	tty_unregister_driver(isicom_normal);
