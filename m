Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWJRQ0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWJRQ0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422643AbWJRQ0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:26:37 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:26714 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422644AbWJRQ0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:26:21 -0400
Date: Wed, 18 Oct 2006 18:26:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, melissah@us.ibm.com
Subject: [S390] monwriter find header logic.
Message-ID: <20061018162628.GD7158@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Melissa Howland <melissah@us.ibm.com>

[S390] monwriter find header logic.

Fix logic for finding matching buffers.

Signed-off-by: Melissa Howland <melissah@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/monwriter.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/monwriter.c linux-2.6-patched/drivers/s390/char/monwriter.c
--- linux-2.6/drivers/s390/char/monwriter.c	2006-10-18 17:12:37.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/monwriter.c	2006-10-18 17:12:54.000000000 +0200
@@ -73,12 +73,15 @@ static inline struct mon_buf *monwrite_f
 	struct mon_buf *entry, *next;
 
 	list_for_each_entry_safe(entry, next, &monpriv->list, list)
-		if (entry->hdr.applid == monhdr->applid &&
+		if ((entry->hdr.mon_function == monhdr->mon_function ||
+		     monhdr->mon_function == MONWRITE_STOP_INTERVAL) &&
+		    entry->hdr.applid == monhdr->applid &&
 		    entry->hdr.record_num == monhdr->record_num &&
 		    entry->hdr.version == monhdr->version &&
 		    entry->hdr.release == monhdr->release &&
 		    entry->hdr.mod_level == monhdr->mod_level)
 			return entry;
+
 	return NULL;
 }
 
@@ -92,7 +95,9 @@ static int monwrite_new_hdr(struct mon_p
 	    monhdr->mon_function > MONWRITE_START_CONFIG ||
 	    monhdr->hdrlen != sizeof(struct monwrite_hdr))
 		return -EINVAL;
-	monbuf = monwrite_find_hdr(monpriv, monhdr);
+	monbuf = NULL;
+	if (monhdr->mon_function != MONWRITE_GEN_EVENT)
+		monbuf = monwrite_find_hdr(monpriv, monhdr);
 	if (monbuf) {
 		if (monhdr->mon_function == MONWRITE_STOP_INTERVAL) {
 			monhdr->datalen = monbuf->hdr.datalen;
@@ -104,7 +109,7 @@ static int monwrite_new_hdr(struct mon_p
 			kfree(monbuf);
 			monbuf = NULL;
 		}
-	} else {
+	} else if (monhdr->mon_function != MONWRITE_STOP_INTERVAL) {
 		if (mon_buf_count >= mon_max_bufs)
 			return -ENOSPC;
 		monbuf = kzalloc(sizeof(struct mon_buf), GFP_KERNEL);
@@ -118,7 +123,8 @@ static int monwrite_new_hdr(struct mon_p
 		}
 		monbuf->hdr = *monhdr;
 		list_add_tail(&monbuf->list, &monpriv->list);
-		mon_buf_count++;
+		if (monhdr->mon_function != MONWRITE_GEN_EVENT)
+			mon_buf_count++;
 	}
 	monpriv->current_buf = monbuf;
 	return 0;
