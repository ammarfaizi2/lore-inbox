Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbVLTSfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVLTSfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbVLTSfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:35:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:25752 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750886AbVLTSfp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:35:45 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17320.22302.312403.942098@tut.ibm.com>
Date: Tue, 20 Dec 2005 13:10:22 -0600
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, compudj@krystal.dyndns.org
Subject: [PATCH] relayfs: remove warning printk() in relay_switch_subbuf()
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There's currently a diagnostic printk in relay_switch_subbuf() meant
as a warning if you accidentally try to log an event larger than the
sub-buffer size.  The problem is if this happens while logging from
somewhere it's not safe to be doing printks, such as in the scheduler,
you can end up with a deadlock.  This patch removes the warning from
relay_switch_subbuf() and instead prints some diagnostic info when the
channel is closed.

Thanks to Mathieu Desnoyers for pointing out the problem and
suggesting a fix.

Tom

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff --git a/fs/relayfs/relay.c b/fs/relayfs/relay.c
--- a/fs/relayfs/relay.c
+++ b/fs/relayfs/relay.c
@@ -333,8 +333,7 @@ size_t relay_switch_subbuf(struct rchan_
 	return length;
 
 toobig:
-	printk(KERN_WARNING "relayfs: event too large (%Zd)\n", length);
-	WARN_ON(1);
+	buf->chan->last_toobig = length;
 	return 0;
 }
 
@@ -399,6 +398,11 @@ void relay_close(struct rchan *chan)
 		relay_close_buf(chan->buf[i]);
 	}
 
+	if (chan->last_toobig)
+		printk(KERN_WARNING "relayfs: one or more items not logged "
+		       "[item size (%Zd) > sub-buffer size (%Zd)]\n",
+		       chan->last_toobig, chan->subbuf_size);
+
 	kref_put(&chan->kref, relay_destroy_channel);
 }
 
diff --git a/include/linux/relayfs_fs.h b/include/linux/relayfs_fs.h
--- a/include/linux/relayfs_fs.h
+++ b/include/linux/relayfs_fs.h
@@ -20,9 +20,9 @@
 #include <linux/kref.h>
 
 /*
- * Tracks changes to rchan_buf struct
+ * Tracks changes to rchan/rchan_buf structs
  */
-#define RELAYFS_CHANNEL_VERSION		5
+#define RELAYFS_CHANNEL_VERSION		6
 
 /*
  * Per-cpu relay channel buffer
@@ -60,6 +60,7 @@ struct rchan
 	struct rchan_callbacks *cb;	/* client callbacks */
 	struct kref kref;		/* channel refcount */
 	void *private_data;		/* for user-defined data */
+	size_t last_toobig;		/* tried to log event > subbuf size */
 	struct rchan_buf *buf[NR_CPUS]; /* per-cpu channel buffers */
 };
 


