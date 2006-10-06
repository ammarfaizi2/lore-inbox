Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWJFOyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWJFOyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWJFOyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:54:38 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:33945 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161047AbWJFOyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:54:37 -0400
Date: Fri, 6 Oct 2006 16:54:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, melissah@us.ibm.com
Subject: [S390] monwriter buffer limit.
Message-ID: <20061006145439.GB26371@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Melissa Howland <melissah@us.ibm.com>

[S390] monwriter buffer limit.

Make max_bufs a global (per linux guest) limit.

Signed-off-by: Melissa Howland <melissah@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/monwriter.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/monwriter.c linux-2.6-patched/drivers/s390/char/monwriter.c
--- linux-2.6/drivers/s390/char/monwriter.c	2006-10-06 16:29:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/monwriter.c	2006-10-06 16:29:55.000000000 +0200
@@ -26,6 +26,7 @@
 #define MONWRITE_MAX_DATALEN	4024
 
 static int mon_max_bufs = 255;
+static int mon_buf_count;
 
 struct mon_buf {
 	struct list_head list;
@@ -40,7 +41,6 @@ struct mon_private {
 	size_t hdr_to_read;
 	size_t data_to_read;
 	struct mon_buf *current_buf;
-	int mon_buf_count;
 };
 
 /*
@@ -99,13 +99,13 @@ static int monwrite_new_hdr(struct mon_p
 			rc = monwrite_diag(monhdr, monbuf->data,
 					   APPLDATA_STOP_REC);
 			list_del(&monbuf->list);
-			monpriv->mon_buf_count--;
+			mon_buf_count--;
 			kfree(monbuf->data);
 			kfree(monbuf);
 			monbuf = NULL;
 		}
 	} else {
-		if (monpriv->mon_buf_count >= mon_max_bufs)
+		if (mon_buf_count >= mon_max_bufs)
 			return -ENOSPC;
 		monbuf = kzalloc(sizeof(struct mon_buf), GFP_KERNEL);
 		if (!monbuf)
@@ -118,7 +118,7 @@ static int monwrite_new_hdr(struct mon_p
 		}
 		monbuf->hdr = *monhdr;
 		list_add_tail(&monbuf->list, &monpriv->list);
-		monpriv->mon_buf_count++;
+		mon_buf_count++;
 	}
 	monpriv->current_buf = monbuf;
 	return 0;
@@ -186,7 +186,7 @@ static int monwrite_close(struct inode *
 		if (entry->hdr.mon_function != MONWRITE_GEN_EVENT)
 			monwrite_diag(&entry->hdr, entry->data,
 				      APPLDATA_STOP_REC);
-		monpriv->mon_buf_count--;
+		mon_buf_count--;
 		list_del(&entry->list);
 		kfree(entry->data);
 		kfree(entry);
