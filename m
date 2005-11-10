Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVKJMso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVKJMso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVKJMso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:48:44 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:42460 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750797AbVKJMsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:48:42 -0500
Date: Thu, 10 Nov 2005 13:50:58 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 4/7] s390: some more qeth fixes
Message-ID: <20051110125058.GD7936@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 4/7] s390: some more qeth fixes  

From: Frank Pavlic <fpavlic@de.ibm.com>
From: Peter Tiedemann <ptiedem@de.ibm.com>
	- possible race on list fixed by reset 
	  list processing after every operation
	- traffic hang fixed 

Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 qeth_main.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff -Naupr orig/drivers/s390/net/qeth_main.c patched-linux/drivers/s390/net/qeth_main.c
--- orig/drivers/s390/net/qeth_main.c	2005-11-09 20:37:03.000000000 +0100
+++ patched-linux/drivers/s390/net/qeth_main.c	2005-11-09 20:38:23.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.236 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.238 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.236 $	 $Date: 2005/05/04 20:19:18 $
+ *    $Revision: 1.238 $	 $Date: 2005/05/04 20:19:18 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -72,7 +72,7 @@
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.236 $"
+#define VERSION_QETH_C "$Revision: 1.238 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -799,7 +799,7 @@ __qeth_delete_all_mc(struct qeth_card *c
 {
 	struct qeth_ipaddr *addr, *tmp;
 	int rc;
-
+again:
 	list_for_each_entry_safe(addr, tmp, &card->ip_list, entry) {
 		if (addr->is_multicast) {
 			spin_unlock_irqrestore(&card->ip_lock, *flags);
@@ -808,6 +808,7 @@ __qeth_delete_all_mc(struct qeth_card *c
 			if (!rc) {
 				list_del(&addr->entry);
 				kfree(addr);
+				goto again;
 			}
 		}
 	}
@@ -4336,6 +4337,8 @@ qeth_do_send_packet(struct qeth_card *ca
 out:
 	if (flush_count)
 		qeth_flush_buffers(queue, 0, start_index, flush_count);
+	else if (!atomic_read(&queue->set_pci_flags_count))
+		atomic_swap(&queue->state, QETH_OUT_Q_LOCKED_FLUSH);
 	/*
 	 * queue->state will go from LOCKED -> UNLOCKED or from
 	 * LOCKED_FLUSH -> LOCKED if output_handler wanted to 'notify' us
