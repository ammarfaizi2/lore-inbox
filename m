Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVEXWVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVEXWVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVEXWVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:21:24 -0400
Received: from webmail.topspin.com ([12.162.17.3]:21691 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261165AbVEXWU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:20:58 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 1/2] IB: fix potential ib_umad leak
In-Reply-To: <20055241520.Hsf2RosQGYxIWuXH@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 24 May 2005 15:20:57 -0700
Message-Id: <20055241520.C8dwwpEn6S7vuoR1@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 May 2005 22:20:58.0057 (UTC) FILETIME=[DBF1F390:01C560AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Free all unclaimed MAD receive buffers when userspace closes our file
so we don't leak memory.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 drivers/infiniband/core/user_mad.c |    4 ++++
 1 files changed, 4 insertions(+)



--- linux-git.orig/drivers/infiniband/core/user_mad.c	2005-05-24 15:11:25.795151912 -0700
+++ linux-git/drivers/infiniband/core/user_mad.c	2005-05-24 15:17:39.800453121 -0700
@@ -499,6 +499,7 @@
 static int ib_umad_close(struct inode *inode, struct file *filp)
 {
 	struct ib_umad_file *file = filp->private_data;
+	struct ib_umad_packet *packet, *tmp;
 	int i;
 
 	for (i = 0; i < IB_UMAD_MAX_AGENTS; ++i)
@@ -507,6 +508,9 @@
 			ib_unregister_mad_agent(file->agent[i]);
 		}
 
+	list_for_each_entry_safe(packet, tmp, &file->recv_list, list)
+		kfree(packet);
+
 	kfree(file);
 
 	return 0;

