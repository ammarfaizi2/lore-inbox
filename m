Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTEEQnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTEEQnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:43:32 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:42458 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S263737AbTEEQmL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:42:11 -0400
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DEB2E@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: =?iso-8859-1?Q?Sebastian_Sj=F6berg?= <sebastian.sjoberg@axis.com>
Subject: [PATCH 2.4.20] alloc_kiovec performance improvement
Date: Mon, 5 May 2003 18:54:39 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_kiovec always allocates 1024 buffer heads which is a waste 
with performance in the cases when the buffers aren't used.

The patch below adds variants that doesn't allocate the buffer heads.

A similar approach would be to introduce a common function with
a flag that indicates if buffer heads should be allocated.

/Mikael

diff -Nurp linux-2.4.20/fs/iobuf.c linux-2.4.20-local/fs/iobuf.c
--- linux-2.4.20/fs/iobuf.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20-local/fs/iobuf.c	Mon May  5 18:35:12 2003
@@ -114,6 +114,29 @@ nomem:
 	return -ENOMEM;
 }
 
+int alloc_kiovec_nobhs(int nr, struct kiobuf **bufp)
+{
+	int i;
+	struct kiobuf *iobuf;
+	
+	for (i = 0; i < nr; i++) {
+		iobuf = kmem_cache_alloc(kiobuf_cachep, GFP_KERNEL);
+		if (unlikely(!iobuf))
+			goto nomem;
+		if (unlikely(kiobuf_init(iobuf)))
+			goto nomem2;
+		bufp[i] = iobuf;
+	}
+	
+	return 0;
+
+nomem2:
+	kmem_cache_free(kiobuf_cachep, iobuf);
+nomem:
+	free_kiovec_nobhs(i, bufp);
+	return -ENOMEM;
+}
+
 void free_kiovec(int nr, struct kiobuf **bufp) 
 {
 	int i;
@@ -128,6 +151,20 @@ void free_kiovec(int nr, struct kiobuf *
 		kmem_cache_free(kiobuf_cachep, bufp[i]);
 	}
 }
+
+void free_kiovec_nobhs(int nr, struct kiobuf **bufp) 
+{
+	int i;
+	struct kiobuf *iobuf;
+	
+	for (i = 0; i < nr; i++) {
+		iobuf = bufp[i];
+		if (iobuf->locked)
+			unlock_kiovec(1, &iobuf);
+		kfree(iobuf->maplist);
+		kmem_cache_free(kiobuf_cachep, bufp[i]);
+	}
+}
 
 int expand_kiobuf(struct kiobuf *iobuf, int wanted)
 {
diff -Nurp linux-2.4.20/include/linux/iobuf.h linux-2.4.20-local/include/linux/iobuf.h
--- linux-2.4.20/include/linux/iobuf.h	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20-local/include/linux/iobuf.h	Mon May  5 18:35:51 2003
@@ -64,7 +64,9 @@ void	mark_dirty_kiobuf(struct kiobuf *io
 void	end_kio_request(struct kiobuf *, int);
 void	simple_wakeup_kiobuf(struct kiobuf *);
 int	alloc_kiovec(int nr, struct kiobuf **);
+int	alloc_kiovec_nobhs(int nr, struct kiobuf **);
 void	free_kiovec(int nr, struct kiobuf **);
+void	free_kiovec_nobhs(int nr, struct kiobuf **);
 int	expand_kiobuf(struct kiobuf *, int);
 void	kiobuf_wait_for_io(struct kiobuf *);
 extern int alloc_kiobuf_bhs(struct kiobuf *);
diff -Nurp linux-2.4.20/kernel/ksyms.c linux-2.4.20-local/kernel/ksyms.c
--- linux-2.4.20/kernel/ksyms.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20-local/kernel/ksyms.c	Mon May  5 18:36:25 2003
@@ -410,7 +410,9 @@ EXPORT_SYMBOL(__br_write_unlock);
 
 /* Kiobufs */
 EXPORT_SYMBOL(alloc_kiovec);
+EXPORT_SYMBOL(alloc_kiovec_nobhs);
 EXPORT_SYMBOL(free_kiovec);
+EXPORT_SYMBOL(free_kiovec_nobhs);
 EXPORT_SYMBOL(expand_kiobuf);
 
 EXPORT_SYMBOL(map_user_kiobuf);

