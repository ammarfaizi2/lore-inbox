Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWHIMsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWHIMsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWHIMsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:48:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:39391 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750718AbWHIMsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:48:09 -0400
X-Authenticated: #704063
Subject: [Patch] Remove useless if in mm/filemap
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 09 Aug 2006 14:48:07 +0200
Message-Id: <1155127687.26942.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

since the variable copied is size_t, which means it is unsigned,
the copied >= 0 expression is always true. Therefore we can
remove the if. It does not seem that filemap_copy_from_user()
or filemap_copy_from_user_iovec() can ever return negative values,
or any of the functions they call, so this should be safe.
The patch simply removes the if statement and fixes identation.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-rc4/mm/filemap.c.orig	2006-08-09 14:41:54.000000000 +0200
+++ linux-2.6.18-rc4/mm/filemap.c	2006-08-09 14:43:19.000000000 +0200
@@ -2158,24 +2158,21 @@ generic_file_buffered_write(struct kiocb
 			continue;
 		}
 zero_length_segment:
-		if (likely(copied >= 0)) {
-			if (!status)
-				status = copied;
-
-			if (status >= 0) {
-				written += status;
-				count -= status;
-				pos += status;
-				buf += status;
-				if (unlikely(nr_segs > 1)) {
-					filemap_set_next_iovec(&cur_iov,
-							&iov_base, status);
-					if (count)
-						buf = cur_iov->iov_base +
-							iov_base;
-				} else {
-					iov_base += status;
-				}
+		if (!status)
+			status = copied;
+
+		if (status >= 0) {
+			written += status;
+			count -= status;
+			pos += status;
+			buf += status;
+			if (unlikely(nr_segs > 1)) {
+				filemap_set_next_iovec(&cur_iov,
+					&iov_base, status);
+				if (count)
+					buf = cur_iov->iov_base + iov_base;
+			} else {
+				iov_base += status;
 			}
 		}
 		if (unlikely(copied != bytes))


