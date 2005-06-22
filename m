Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVFVO1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVFVO1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFVO1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:27:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:16014 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261307AbVFVO0y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:26:54 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17081.29993.369456.980612@tut.ibm.com>
Date: Wed, 22 Jun 2005 09:26:49 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-mm1] relayfs: cancel work on close/reset
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cancels and flushes any delayed work when the channel is
closed or reset.

Andrew, please apply.

Thanks,

Tom

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.12-mm1/fs/relayfs/relay.c linux-2.6.12-mm1-cur/fs/relayfs/relay.c
--- linux-2.6.12-mm1/fs/relayfs/relay.c	2005-06-22 11:16:23.000000000 -0500
+++ linux-2.6.12-mm1-cur/fs/relayfs/relay.c	2005-06-22 11:33:51.000000000 -0500
@@ -155,6 +155,10 @@ static inline void __relay_reset(struct 
 	if (init) {
 		init_waitqueue_head(&buf->read_wait);
 		kref_init(&buf->kref);
+		INIT_WORK(&buf->wake_readers, NULL, NULL);
+	} else {
+		cancel_delayed_work(&buf->wake_readers);
+		flush_scheduled_work();
 	}
 
 	atomic_set(&buf->subbufs_produced, 0);
@@ -171,8 +175,6 @@ static inline void __relay_reset(struct 
 
 	buf->offset = buf->chan->cb->subbuf_start(buf, buf->data, 0, NULL);
 	buf->commit[0] = buf->offset;
-
-	INIT_WORK(&buf->wake_readers, NULL, NULL);
 }
 
 /**
@@ -238,6 +240,8 @@ static inline void relay_close_buf(struc
 {
 	buf->finalized = 1;
 	buf->chan->cb = &default_channel_callbacks;
+	cancel_delayed_work(&buf->wake_readers);
+	flush_scheduled_work();
 	kref_put(&buf->kref, relay_remove_buf);
 }
 



