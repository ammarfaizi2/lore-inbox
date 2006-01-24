Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWAXCAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWAXCAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 21:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWAXCAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 21:00:23 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:7666 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030294AbWAXCAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 21:00:23 -0500
Date: Mon, 23 Jan 2006 21:02:17 -0500
From: Latchesar Ionkov <lucho@ionkov.net>
To: Andrew Morton <akpm@osdl.org>
Cc: v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] v9fs: v9fs_put_str fix
Message-ID: <20060124020217.GA26367@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v9fs_put_str used to store pointer to the source string, instead of the
cbuf copy. This patch corrects it.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit aa0bbbe2e9c8a9ed97c76345359bcc1935b849f3
tree d0016e07087ee4f1dabbda70b3708f4d39e2e341
parent 80543589e5ab35e0fda3e97f93108f136eb4e623
author Latchesar Ionkov <lucho@ionkov.net> Mon, 23 Jan 2006 08:01:34 -0500
committer Latchesar Ionkov <lucho@ionkov.net> Mon, 23 Jan 2006 08:01:34 -0500

 fs/9p/conv.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/9p/conv.c b/fs/9p/conv.c
index 32a9f99..70bcd27 100644
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -116,13 +116,19 @@ static void buf_put_int64(struct cbuf *b
 	}
 }
 
-static void buf_put_stringn(struct cbuf *buf, const char *s, u16 slen)
+static char *buf_put_stringn(struct cbuf *buf, const char *s, u16 slen)
 {
+	char *ret;
+
+	ret = NULL;
 	if (buf_check_size(buf, slen + 2)) {
 		buf_put_int16(buf, slen);
+		ret = buf->p;
 		memcpy(buf->p, s, slen);
 		buf->p += slen;
 	}
+
+	return ret;
 }
 
 static inline void buf_put_string(struct cbuf *buf, const char *s)
@@ -430,15 +436,19 @@ static inline void v9fs_put_int64(struct
 static void
 v9fs_put_str(struct cbuf *bufp, char *data, struct v9fs_str *str)
 {
-	if (data) {
-		str->len = strlen(data);
-		str->str = bufp->p;
-	} else {
-		str->len = 0;
-		str->str = NULL;
-	}
+	int len;
+	char *s;
+
+	if (data) 
+		len = strlen(data);
+	else
+		len = 0;
 
-	buf_put_stringn(bufp, data, str->len);
+	s = buf_put_stringn(bufp, data, len);
+	if (str) {
+		str->len = len;
+		str->str = s;
+	}
 }
 
 static int
