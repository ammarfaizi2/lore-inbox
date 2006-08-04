Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWHDLPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWHDLPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 07:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWHDLPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 07:15:04 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:24368 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751138AbWHDLPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 07:15:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=sHFdjvnhbss/OvjXFikp+vo2PDL4/QAC9837Qzbmq/vpWkGqFRwYOYaIiCA7/bnNWfyhh+G9KcDtue8c85R77am2+RjNKBvb942dQZlLJBQLa8SKKIqqkMekpRkXQjSPxLnZcOUICfUSOmQkZ8KiUQJtzyN+IKXflxGMCaM7T8Q=
Date: Fri, 4 Aug 2006 13:14:51 +0200
From: Diego Calleja <diegocg@gmail.com>
To: akpm@osdl.org
Cc: rathamahata@php4.ru, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix BeFS slab corruption
Message-Id: <20060804131451.0e50aa07.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In bugzilla #6941, Jens Kilian reported:

"The function befs_utf2nls (in fs/befs/linuxvfs.c) writes a 0 byte past the
end of a block of memory allocated via kmalloc(), leading to memory corruption.
This happens only for filenames which are pure ASCII and a multiple of
4 bytes in length.
[...]

Without DEBUG_SLAB, this leads to further corruption and hard lockups;
I believe this is the bug which has made kernels later than 2.6.8 unusable
for me.  (This must be due to changes in memory management, the bug has
been in the BeFS driver since the time it was introduced (AFAICT).)

Steps to reproduce:
Create a directory (in BeOS, naturally :-) with files named, e.g.,
"1", "22", "333", "4444", ...  Mount it in Linux and do an "ls" or "find""

This patch implements the suggested fix. Credits to Jens Kilian for
debugging the problem and finding the right fix. 


Signed-off-by: Diego Calleja <diegocg@gmail.com>

Index: 2.6/fs/befs/linuxvfs.c
===================================================================
--- 2.6.orig/fs/befs/linuxvfs.c	2006-08-03 18:38:01.000000000 +0200
+++ 2.6/fs/befs/linuxvfs.c	2006-08-03 19:02:11.000000000 +0200
@@ -512,7 +512,11 @@
 	wchar_t uni;
 	int unilen, utflen;
 	char *result;
-	int maxlen = in_len; /* The utf8->nls conversion can't make more chars */
+	/* The utf8->nls conversion won't make the final nls string bigger
+	 * than the utf one, but if the string is pure ascii they'll have the
+	 * same width and an extra char is needed to save the additional \0
+	 */
+	int maxlen = in_len + 1;
 
 	befs_debug(sb, "---> utf2nls()");
 
@@ -588,7 +592,10 @@
 	wchar_t uni;
 	int unilen, utflen;
 	char *result;
-	int maxlen = 3 * in_len;
+	/* There're nls characters that will translate to 3-chars-wide UTF-8
+	 * characters, a additional byte is needed to save the final \0
+	 * in special cases */
+	int maxlen = (3 * in_len) + 1;
 
 	befs_debug(sb, "---> nls2utf()\n");
 

