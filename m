Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422730AbWJPQ2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbWJPQ2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422739AbWJPQ2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:28:16 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:18633 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1422730AbWJPQ2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:14 -0400
Message-Id: <20061016162731.445990000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:11 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 02/12] document i_size_write locking rules
Content-Disposition: inline; filename=document_i_size_write_locking.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless someone reads the documentation for write_seqcount_{begin,end}
it is not obvious, that i_size_write() needs locking.  Especially,
that lack of such locking can result in a system hang.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2006-10-16 12:53:03.000000000 +0200
+++ linux/include/linux/fs.h	2006-10-16 14:10:22.000000000 +0200
@@ -670,7 +670,11 @@ static inline loff_t i_size_read(struct 
 #endif
 }
 
-
+/*
+ * NOTE: unlike i_size_read(), i_size_write() does need locking around it
+ * (normally i_mutex), otherwise on 32bit/SMP an update of i_size_seqcount
+ * can be lost, resulting in subsequent i_size_read() calls spinning forever.
+ */
 static inline void i_size_write(struct inode *inode, loff_t i_size)
 {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)

--
