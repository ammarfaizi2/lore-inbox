Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVHRGFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVHRGFq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVHRGFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:05:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56468 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750792AbVHRGFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:05:45 -0400
Date: Thu, 18 Aug 2005 14:11:17 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-cluster@redhat.com
Subject: [PATCH 3/3] dlm: use jhash
Message-ID: <20050818061117.GC10133@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use linux/jhash.h instead of our own hash function.

Signed-off-by: David Teigland <teigland@redhat.com>

---

 dir.c          |    2 +-
 dlm_internal.h |    1 +
 lock.c         |    2 +-
 util.c         |   34 ----------------------------------
 util.h         |    2 --
 5 files changed, 3 insertions(+), 38 deletions(-)

diff -urpN a/drivers/dlm/dir.c b/drivers/dlm/dir.c
--- a/drivers/dlm/dir.c	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/dir.c	2005-08-18 13:47:29.112803024 +0800
@@ -120,7 +120,7 @@ static inline uint32_t dir_hash(struct d
 {
 	uint32_t val;
 
-	val = dlm_hash(name, len);
+	val = jhash(name, len, 0);
 	val &= (ls->ls_dirtbl_size - 1);
 
 	return val;
diff -urpN a/drivers/dlm/dlm_internal.h b/drivers/dlm/dlm_internal.h
--- a/drivers/dlm/dlm_internal.h	2005-08-18 13:26:02.651374888 +0800
+++ b/drivers/dlm/dlm_internal.h	2005-08-18 13:47:29.112803024 +0800
@@ -34,6 +34,7 @@
 #include <linux/kobject.h>
 #include <linux/kref.h>
 #include <linux/kernel.h>
+#include <linux/jhash.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
diff -urpN a/drivers/dlm/lock.c b/drivers/dlm/lock.c
--- a/drivers/dlm/lock.c	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/lock.c	2005-08-18 13:47:29.114802720 +0800
@@ -369,7 +369,7 @@ static int find_rsb(struct dlm_ls *ls, c
 	if (dlm_no_directory(ls))
 		flags |= R_CREATE;
 
-	hash = dlm_hash(name, namelen);
+	hash = jhash(name, namelen, 0);
 	bucket = hash & (ls->ls_rsbtbl_size - 1);
 
 	error = search_rsb(ls, name, namelen, bucket, flags, &r);
diff -urpN a/drivers/dlm/util.c b/drivers/dlm/util.c
--- a/drivers/dlm/util.c	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/util.c	2005-08-18 13:47:29.115802568 +0800
@@ -13,40 +13,6 @@
 #include "dlm_internal.h"
 #include "rcom.h"
 
-/**
- * dlm_hash - hash an array of data
- * @data: the data to be hashed
- * @len: the length of data to be hashed
- *
- * Copied from GFS which copied from...
- *
- * Take some data and convert it to a 32-bit hash.
- * This is the 32-bit FNV-1a hash from:
- * http://www.isthe.com/chongo/tech/comp/fnv/
- */
-
-static inline uint32_t hash_more_internal(const void *data, unsigned int len,
-					  uint32_t hash)
-{
-	unsigned char *p = (unsigned char *)data;
-	unsigned char *e = p + len;
-	uint32_t h = hash;
-
-	while (p < e) {
-		h ^= (uint32_t)(*p++);
-		h *= 0x01000193;
-	}
-
-	return h;
-}
-
-uint32_t dlm_hash(const void *data, int len)
-{
-	uint32_t h = 0x811C9DC5;
-	h = hash_more_internal(data, len, h);
-	return h;
-}
-
 static void header_out(struct dlm_header *hd)
 {
 	hd->h_version		= cpu_to_le32(hd->h_version);
diff -urpN a/drivers/dlm/util.h b/drivers/dlm/util.h
--- a/drivers/dlm/util.h	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/util.h	2005-08-18 13:47:29.115802568 +0800
@@ -13,8 +13,6 @@
 #ifndef __UTIL_DOT_H__
 #define __UTIL_DOT_H__
 
-uint32_t dlm_hash(const char *data, int len);
-
 void dlm_message_out(struct dlm_message *ms);
 void dlm_message_in(struct dlm_message *ms);
 void dlm_rcom_out(struct dlm_rcom *rc);
