Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVDBTqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVDBTqV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 14:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVDBTqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 14:46:21 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:18884 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261232AbVDBTqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 14:46:18 -0500
Subject: [PATCH] fix boot hang on some architectures
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: acme@conectiva.com.br, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 02 Apr 2005 13:46:03 -0600
Message-Id: <1112471164.5786.23.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, this is a brown paper bag for someone.  The new protocol
registration locking uses a rwlock to limit access to the protocol list.
Unfortunately, the initialisation:

static rwlock_t proto_list_lock;

Only works to initialise the lock as unlocked on platforms whose unlock
signal is all zeros.  On other platforms, they think it's already locked
and hang forever.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>


===== net/core/sock.c 1.67 vs edited =====
--- 1.67/net/core/sock.c	2005-03-26 17:04:35 -06:00
+++ edited/net/core/sock.c	2005-04-02 13:37:20 -06:00
@@ -1352,7 +1352,7 @@
 
 EXPORT_SYMBOL(sk_common_release);
 
-static rwlock_t proto_list_lock;
+static DEFINE_RWLOCK(proto_list_lock);
 static LIST_HEAD(proto_list);
 
 int proto_register(struct proto *prot, int alloc_slab)


