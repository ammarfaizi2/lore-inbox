Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTEXLhB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 07:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTEXLhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 07:37:01 -0400
Received: from smtp01.web.de ([217.72.192.180]:5901 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S264054AbTEXLhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 07:37:00 -0400
Date: Sat, 24 May 2003 14:06:05 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: Re: [PATCH] SYSV fs: test in sysv_hash() is backwards
Message-Id: <20030524140605.31fc7360.l.s.r@web.de>
In-Reply-To: <20030524133213.04a53581.l.s.r@web.de>
References: <20030524133213.04a53581.l.s.r@web.de>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003 13:32:13 +0200
René Scharfe <l.s.r@web.de> wrote:

> it seems sysvfs will compute a filename hash only in the case where
> that name is too long.

... and that is just fine. On second glance, that is _exactly_ what
it should do. The common case is handled in fs/namei.c. D'oh!

There's opportunity for cleanup, though. Updated patch below.

René



--- fs/sysv/namei.c.orig	2003-05-24 12:49:57.000000000 +0200
+++ fs/sysv/namei.c	2003-05-24 13:59:09.000000000 +0200
@@ -42,21 +42,12 @@
 
 static int sysv_hash(struct dentry *dentry, struct qstr *qstr)
 {
-	unsigned long hash;
-	int i;
-	const unsigned char *name;
-
-	i = SYSV_NAMELEN;
-	if (i >= qstr->len)
-		return 0;
 	/* Truncate the name in place, avoids having to define a compare
 	   function. */
-	qstr->len = i;
-	name = qstr->name;
-	hash = init_name_hash();
-	while (i--)
-		hash = partial_name_hash(*name++, hash);
-	qstr->hash = end_name_hash(hash);
+	if (qstr->len > SYSV_NAMELEN) {
+		qstr->len = SYSV_NAMELEN;
+		qstr->hash = full_name_hash(qstr->name, qstr->len);
+	}
 	return 0;
 }
 
