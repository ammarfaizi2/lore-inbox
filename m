Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbSLBV1U>; Mon, 2 Dec 2002 16:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSLBV1T>; Mon, 2 Dec 2002 16:27:19 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:20630 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S265276AbSLBV0f>;
	Mon, 2 Dec 2002 16:26:35 -0500
Date: Mon, 2 Dec 2002 23:47:54 -0500
From: Christoph Hellwig <hch@sgi.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] keep lru_list_lock around osync_buffers_list
Message-ID: <20021202234754.A30978@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's exactly one caller of osync_buffers_list (and it's static
to buffer.c), so we can keep holding lru_list_lock over the call
to it instead of releasing and reacquiring it.


--- 1.77/fs/buffer.c	Sun Aug 25 21:28:55 2002
+++ edited/fs/buffer.c	Mon Dec  2 21:48:11 2002
@@ -869,8 +869,8 @@
 		spin_lock(&lru_list_lock);
 	}
 	
-	spin_unlock(&lru_list_lock);
 	err2 = osync_buffers_list(list);
+	spin_unlock(&lru_list_lock);
 
 	if (err)
 		return err;
@@ -887,6 +887,8 @@
  * you dirty the buffers, and then use osync_buffers_list to wait for
  * completion.  Any other dirty buffers which are not yet queued for
  * write will not be flushed to disk by the osync.
+ *
+ * Expects lru_list_lock to be held at entry.
  */
 static int osync_buffers_list(struct list_head *list)
 {
@@ -894,8 +896,6 @@
 	struct list_head *p;
 	int err = 0;
 
-	spin_lock(&lru_list_lock);
-	
  repeat:
 	list_for_each_prev(p, list) {
 		bh = BH_ENTRY(p);
@@ -911,7 +911,6 @@
 		}
 	}
 
-	spin_unlock(&lru_list_lock);
 	return err;
 }
 
