Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSE0Pq6>; Mon, 27 May 2002 11:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316664AbSE0Pq5>; Mon, 27 May 2002 11:46:57 -0400
Received: from hera.cwi.nl ([192.16.191.8]:24563 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316663AbSE0Pq4>;
	Mon, 27 May 2002 11:46:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 27 May 2002 17:46:53 +0200 (MEST)
Message-Id: <UTC200205271546.g4RFkrT12572.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] fcntl fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People asked me to document that Linux has a non-POSIX-compliant
fcntl system call. Maybe fixing fcntl is better.
No doubt the same patch should be applied to 2.2 and 2.4,
but let's do 2.5 first.

--- /linux/2.5/linux-2.5.18/linux/fs/locks.c	Tue May 21 07:07:37 2002
+++ /linux/2.5/linux-2.5.18a/linux/fs/locks.c	Mon May 27 17:25:33 2002
@@ -274,9 +274,18 @@
 		return -EINVAL;
 	}
 
-	if (((start += l->l_start) < 0) || (l->l_len < 0))
+	/* POSIX-1996 leaves the case l->l_len < 0 undefined;
+	   POSIX-2001 defines it. */
+	start += l->l_start;
+	if (l->l_len < 0) {
+		end = start - 1;
+		start += l->l_len;
+	} else {
+		end = start + l->l_len - 1;
+	}
+
+	if (start < 0)
 		return -EINVAL;
-	end = start + l->l_len - 1;
 	if (l->l_len > 0 && end < 0)
 		return -EOVERFLOW;
 	fl->fl_start = start;	/* we record the absolute position */

Andries
