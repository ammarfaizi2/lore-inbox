Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVCXWB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVCXWB1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 17:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVCXWB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 17:01:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:26256 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261636AbVCXWBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 17:01:01 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16963.14487.752842.849000@tut.ibm.com>
Date: Thu, 24 Mar 2005 16:00:55 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc1-mm2] relayfs: properly handle oversized events
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fails writes larger than the sub-buffer size and prints a
warning and stack trace when it happens.  I chose this over BUG_ON()
or silently failing since while it could probably be considered a bug
for an application to let this happen, it's not fatal and the user
would probably want to know (and change buffer sizes).

Andrew, please apply.

Thanks,

Tom

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.12-rc1-mm2/fs/relayfs/relay.c linux-2.6.12-rc1-mm2-cur/fs/relayfs/relay.c
--- linux-2.6.12-rc1-mm2/fs/relayfs/relay.c	2005-03-20 22:26:47.000000000 -0600
+++ linux-2.6.12-rc1-mm2-cur/fs/relayfs/relay.c	2005-03-20 23:32:50.000000000 -0600
@@ -378,7 +378,10 @@ unsigned relay_switch_subbuf(struct rcha
 	int new, old, produced = atomic_read(&buf->subbufs_produced);
 	unsigned padding;
 
-	if (atomic_read(&buf->unfull)) {
+	if (unlikely(length > buf->chan->subbuf_size))
+		goto toobig;
+
+	if (unlikely(atomic_read(&buf->unfull))) {
 		atomic_set(&buf->unfull, 0);
 		new = produced % buf->chan->n_subbufs;
 		old = (produced - 1) % buf->chan->n_subbufs;
@@ -410,7 +413,15 @@ unsigned relay_switch_subbuf(struct rcha
 	new = (produced + 1) % buf->chan->n_subbufs;
 	do_switch(buf, new, old);
 
+	if (unlikely(length + buf->offset > buf->chan->subbuf_size))
+		goto toobig;
+
 	return length;
+
+toobig:
+	printk(KERN_WARNING "relayfs: event too large (%u)\n", length);
+	WARN_ON(1);
+	return 0;
 }
 
 /**


