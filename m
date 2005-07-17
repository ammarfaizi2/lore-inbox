Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263072AbVGNSdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263072AbVGNSdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbVGNSdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:33:37 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:8639 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263079AbVGNSb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:31:29 -0400
Message-Id: <200507141830.j6EIUpRZ023698@ms-smtp-03-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Sun, 17 Jul 2005 08:53:54 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc2-mm2 5/7] v9fs: 9P protocol implementation (2.0.2)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [5/7] of the v9fs-2.0.2 patch against Linux 2.6.13-rc2-mm2.

This part of the patch contains the 9P protocol function changes related
to hch's comments.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>


 ----------

 fs/9p/9p.c      |    2 +-
 fs/9p/conv.c    |   54 ++++++++++++++++++------------------------------------
 2 files changed, 19 insertions(+), 37 deletions(-)

 ----------

--- a/fs/9p/9p.c
+++ b/fs/9p/9p.c
@@ -28,9 +28,9 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
 
 #include "debug.h"
-#include "idpool.h"
 #include "v9fs.h"
 #include "9p.h"
 #include "mux.h"
diff --git a/fs/9p/Makefile b/fs/9p/Makefile
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -28,9 +28,9 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
 
 #include "debug.h"
-#include "idpool.h"
 #include "v9fs.h"
 #include "9p.h"
 #include "conv.h"
@@ -55,39 +55,21 @@ static inline int buf_check_overflow(str
 	return buf->p > buf->ep;
 }
 
-#define buf_check_sizep(buf, len) \
-	if (buf->p+len > buf->ep) { \
-		if (buf->p < buf->ep) { \
-			eprintk(KERN_ERR, "buffer overflow\n"); \
-			buf->p = buf->ep + 1; \
-		} \
-		return NULL; \
-	} \
-
-
-#define buf_check_size(buf, len) \
-	if (buf->p+len > buf->ep) { \
-		if (buf->p < buf->ep) { \
-			eprintk(KERN_ERR, "buffer overflow\n"); \
-			buf->p = buf->ep + 1; \
-		} \
-		return 0; \
-	} \
-
-#define buf_check_sizev(buf, len) \
-	if (buf->p+len > buf->ep) { \
-		if (buf->p < buf->ep) { \
-			eprintk(KERN_ERR, "buffer overflow\n"); \
-			buf->p = buf->ep + 1; \
-		} \
-		return; \
-	} \
+static inline void buf_check_size(struct cbuf *buf, int len) 
+{
+	if (buf->p+len > buf->ep) { 
+		if (buf->p < buf->ep) { 
+			eprintk(KERN_ERR, "buffer overflow\n"); 
+			buf->p = buf->ep + 1; 
+		} 
+	} 
+}
 
 static inline void *buf_alloc(struct cbuf *buf, int len)
 {
 	void *ret = NULL;
 
-	buf_check_sizep(buf, len);
+	buf_check_size(buf, len);
 	ret = buf->p;
 	buf->p += len;
 
@@ -96,7 +78,7 @@ static inline void *buf_alloc(struct cbu
 
 static inline void buf_put_int8(struct cbuf *buf, u8 val)
 {
-	buf_check_sizev(buf, 1);
+	buf_check_size(buf, 1);
 
 	buf->p[0] = val;
 	buf->p++;
@@ -104,7 +86,7 @@ static inline void buf_put_int8(struct c
 
 static inline void buf_put_int16(struct cbuf *buf, u16 val)
 {
-	buf_check_sizev(buf, 2);
+	buf_check_size(buf, 2);
 
 	buf->p[0] = val;
 	buf->p[1] = val >> 8;
@@ -113,7 +95,7 @@ static inline void buf_put_int16(struct 
 
 static inline void buf_put_int32(struct cbuf *buf, u32 val)
 {
-	buf_check_sizev(buf, 4);
+	buf_check_size(buf, 4);
 
 	buf->p[0] = val;
 	buf->p[1] = val >> 8;
@@ -124,7 +106,7 @@ static inline void buf_put_int32(struct 
 
 static inline void buf_put_int64(struct cbuf *buf, u64 val)
 {
-	buf_check_sizev(buf, 8);
+	buf_check_size(buf, 8);
 
 	buf->p[0] = val;
 	buf->p[1] = val >> 8;
@@ -139,7 +121,7 @@ static inline void buf_put_int64(struct 
 
 static inline void buf_put_stringn(struct cbuf *buf, const char *s, u16 slen)
 {
-	buf_check_sizev(buf, slen + 2);
+	buf_check_size(buf, slen + 2);
 
 	buf_put_int16(buf, slen);
 	memcpy(buf->p, s, slen);
@@ -153,7 +135,7 @@ static inline void buf_put_string(struct
 
 static inline void buf_put_data(struct cbuf *buf, void *data, u32 datalen)
 {
-	buf_check_sizev(buf, datalen);
+	buf_check_size(buf, datalen);
 
 	memcpy(buf->p, data, datalen);
 	buf->p += datalen;
@@ -257,7 +239,7 @@ static inline void *buf_get_datab(struct
 	char *ret = NULL;
 	int n = 0;
 
-	buf_check_sizep(dbuf, datalen);
+	buf_check_size(dbuf, datalen);
 
 	n = buf_get_data(buf, dbuf->p, datalen);
 
