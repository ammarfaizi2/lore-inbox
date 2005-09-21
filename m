Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVIUBRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVIUBRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVIUBRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:17:48 -0400
Received: from sccrmhc13.comcast.net ([63.240.76.28]:28338 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750740AbVIUBRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:17:47 -0400
Date: Tue, 20 Sep 2005 21:17:35 -0400
From: Latchesar Ionkov <lucho@ionkov.net>
To: linux-kernel@vger.kernel.org
Cc: v9fs-developer@lists.sourceforge.net
Subject: [PATCH] v9fs-fix-check-conv-buf.patch
Message-ID: <20050921011735.GB2008@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

Check if the conv buffer has enough space for the operation performed.
The checking was lost when buf_check_overflow was converted from macro to
inline function.

---
commit 4e674e810f621d61c8cdf35ed3306e0a6c62acb6
tree ce9872242ab95a59050e2125e42617de4a98e741
parent c90eef84b8f5c7416cb99ab6907896f2dd392b4d
author Latchesar Ionkov <lucho@ionkov.net> Tue, 20 Sep 2005 19:25:18 -0400
committer Latchesar Ionkov <lucho@ionkov.net> Tue, 20 Sep 2005 19:25:18 -0400

 fs/9p/conv.c |  153 ++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 84 insertions(+), 69 deletions(-)

diff --git a/fs/9p/conv.c b/fs/9p/conv.c
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -3,6 +3,7 @@
  *
  * 9P protocol conversion functions
  *
+ *  Copyright (C) 2004, 2005 by Latchesar Ionkov <lucho@ionkov.net>
  *  Copyright (C) 2004 by Eric Van Hensbergen <ericvh@gmail.com>
  *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
  *
@@ -55,66 +56,70 @@ static inline int buf_check_overflow(str
 	return buf->p > buf->ep;
 }
 
-static inline void buf_check_size(struct cbuf *buf, int len)
+static inline int buf_check_size(struct cbuf *buf, int len)
 {
 	if (buf->p+len > buf->ep) {
 		if (buf->p < buf->ep) {
 			eprintk(KERN_ERR, "buffer overflow\n");
 			buf->p = buf->ep + 1;
+			return 0;
 		}
 	}
+
+	return 1;
 }
 
 static inline void *buf_alloc(struct cbuf *buf, int len)
 {
 	void *ret = NULL;
 
-	buf_check_size(buf, len);
-	ret = buf->p;
-	buf->p += len;
+	if (buf_check_size(buf, len)) {
+		ret = buf->p;
+		buf->p += len;
+	}
 
 	return ret;
 }
 
 static inline void buf_put_int8(struct cbuf *buf, u8 val)
 {
-	buf_check_size(buf, 1);
-
-	buf->p[0] = val;
-	buf->p++;
+	if (buf_check_size(buf, 1)) {
+		buf->p[0] = val;
+		buf->p++;
+	}
 }
 
 static inline void buf_put_int16(struct cbuf *buf, u16 val)
 {
-	buf_check_size(buf, 2);
-
-	*(__le16 *) buf->p = cpu_to_le16(val);
-	buf->p += 2;
+	if (buf_check_size(buf, 2)) {
+		*(__le16 *) buf->p = cpu_to_le16(val);
+		buf->p += 2;
+	}
 }
 
 static inline void buf_put_int32(struct cbuf *buf, u32 val)
 {
-	buf_check_size(buf, 4);
-
-	*(__le32 *)buf->p = cpu_to_le32(val);
-	buf->p += 4;
+	if (buf_check_size(buf, 4)) {
+		*(__le32 *)buf->p = cpu_to_le32(val);
+		buf->p += 4;
+	}
 }
 
 static inline void buf_put_int64(struct cbuf *buf, u64 val)
 {
-	buf_check_size(buf, 8);
-
-	*(__le64 *)buf->p = cpu_to_le64(val);
-	buf->p += 8;
+	if (buf_check_size(buf, 8)) {
+		*(__le64 *)buf->p = cpu_to_le64(val);
+		buf->p += 8;
+	}
 }
 
 static inline void buf_put_stringn(struct cbuf *buf, const char *s, u16 slen)
 {
-	buf_check_size(buf, slen + 2);
-
-	buf_put_int16(buf, slen);
-	memcpy(buf->p, s, slen);
-	buf->p += slen;
+	if (buf_check_size(buf, slen + 2)) {
+		buf_put_int16(buf, slen);
+		memcpy(buf->p, s, slen);
+		buf->p += slen;
+	}
 }
 
 static inline void buf_put_string(struct cbuf *buf, const char *s)
@@ -124,20 +129,20 @@ static inline void buf_put_string(struct
 
 static inline void buf_put_data(struct cbuf *buf, void *data, u32 datalen)
 {
-	buf_check_size(buf, datalen);
-
-	memcpy(buf->p, data, datalen);
-	buf->p += datalen;
+	if (buf_check_size(buf, datalen)) {
+		memcpy(buf->p, data, datalen);
+		buf->p += datalen;
+	}
 }
 
 static inline u8 buf_get_int8(struct cbuf *buf)
 {
 	u8 ret = 0;
 
-	buf_check_size(buf, 1);
-	ret = buf->p[0];
-
-	buf->p++;
+	if (buf_check_size(buf, 1)) {
+		ret = buf->p[0];
+		buf->p++;
+	}
 
 	return ret;
 }
@@ -146,10 +151,10 @@ static inline u16 buf_get_int16(struct c
 {
 	u16 ret = 0;
 
-	buf_check_size(buf, 2);
-	ret = le16_to_cpu(*(__le16 *)buf->p);
-
-	buf->p += 2;
+	if (buf_check_size(buf, 2)) {
+		ret = le16_to_cpu(*(__le16 *)buf->p);
+		buf->p += 2;
+	}
 
 	return ret;
 }
@@ -158,10 +163,10 @@ static inline u32 buf_get_int32(struct c
 {
 	u32 ret = 0;
 
-	buf_check_size(buf, 4);
-	ret = le32_to_cpu(*(__le32 *)buf->p);
-
-	buf->p += 4;
+	if (buf_check_size(buf, 4)) {
+		ret = le32_to_cpu(*(__le32 *)buf->p);
+		buf->p += 4;
+	}
 
 	return ret;
 }
@@ -170,10 +175,10 @@ static inline u64 buf_get_int64(struct c
 {
 	u64 ret = 0;
 
-	buf_check_size(buf, 8);
-	ret = le64_to_cpu(*(__le64 *)buf->p);
-
-	buf->p += 8;
+	if (buf_check_size(buf, 8)) {
+		ret = le64_to_cpu(*(__le64 *)buf->p);
+		buf->p += 8;
+	}
 
 	return ret;
 }
@@ -181,27 +186,35 @@ static inline u64 buf_get_int64(struct c
 static inline int
 buf_get_string(struct cbuf *buf, char *data, unsigned int datalen)
 {
+	u16 len = 0;
 
-	u16 len = buf_get_int16(buf);
-	buf_check_size(buf, len);
-	if (len + 1 > datalen)
-		return 0;
-
-	memcpy(data, buf->p, len);
-	data[len] = 0;
-	buf->p += len;
+	len = buf_get_int16(buf);
+	if (!buf_check_overflow(buf) && buf_check_size(buf, len) && len+1>datalen) {
+		memcpy(data, buf->p, len);
+		data[len] = 0;
+		buf->p += len;
+		len++;
+	}
 
-	return len + 1;
+	return len;
 }
 
 static inline char *buf_get_stringb(struct cbuf *buf, struct cbuf *sbuf)
 {
-	char *ret = NULL;
-	int n = buf_get_string(buf, sbuf->p, sbuf->ep - sbuf->p);
+	char *ret;
+	u16 len;
+
+	ret = NULL;
+	len = buf_get_int16(buf);
 
-	if (n > 0) {
+	if (!buf_check_overflow(buf) && buf_check_size(buf, len) && 
+		buf_check_size(sbuf, len+1)) {
+
+		memcpy(sbuf->p, buf->p, len);
+		sbuf->p[len] = 0;
 		ret = sbuf->p;
-		sbuf->p += n;
+		buf->p += len;
+		sbuf->p += len + 1;
 	}
 
 	return ret;
@@ -209,12 +222,15 @@ static inline char *buf_get_stringb(stru
 
 static inline int buf_get_data(struct cbuf *buf, void *data, int datalen)
 {
-	buf_check_size(buf, datalen);
+	int ret = 0;
 
-	memcpy(data, buf->p, datalen);
-	buf->p += datalen;
+	if (buf_check_size(buf, datalen)) {
+		memcpy(data, buf->p, datalen);
+		buf->p += datalen;
+		ret = datalen;
+	}
 
-	return datalen;
+	return ret;
 }
 
 static inline void *buf_get_datab(struct cbuf *buf, struct cbuf *dbuf,
@@ -223,13 +239,12 @@ static inline void *buf_get_datab(struct
 	char *ret = NULL;
 	int n = 0;
 
-	buf_check_size(dbuf, datalen);
-
-	n = buf_get_data(buf, dbuf->p, datalen);
-
-	if (n > 0) {
-		ret = dbuf->p;
-		dbuf->p += n;
+	if (buf_check_size(dbuf, datalen)) {
+		n = buf_get_data(buf, dbuf->p, datalen);
+		if (n > 0) {
+			ret = dbuf->p;
+			dbuf->p += n;
+		}
 	}
 
 	return ret;
