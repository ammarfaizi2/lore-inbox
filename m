Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVH1VFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVH1VFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 17:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVH1VFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 17:05:24 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:52173 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750793AbVH1VFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 17:05:23 -0400
Subject: [PATCH 2.6.13-rc6-mm2] v9fs: use standard kernel byteswapping
	routines
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
       V9FS Developers <v9fs-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 28 Aug 2005 16:05:07 -0500
Message-Id: <1125263107.17501.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] v9fs: use standard kernel byteswapping routines

Originally suggested by hch, we have removed our byteswap code
and replaced it with calls to the standard kernel byteswapping code.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit 06e00e56fdf2c3e230ff60f6fdab6db789f16e73
tree 6eff647a71c056d133aa0f0a9e0a0ff95af05683
parent f32fc66e311abe9e7167991e6b2d37e7c56dcc72
author Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005 16:03:40
-0500
committer Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005
16:03:40 -0500

 fs/9p/conv.c |   28 ++++++----------------------
 1 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/fs/9p/conv.c b/fs/9p/conv.c
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -88,8 +88,7 @@ static inline void buf_put_int16(struct 
 {
 	buf_check_size(buf, 2);
 
-	buf->p[0] = val;
-	buf->p[1] = val >> 8;
+	*(u16 *) buf->p = cpu_to_le16(val);
 	buf->p += 2;
 }
 
@@ -97,10 +96,7 @@ static inline void buf_put_int32(struct 
 {
 	buf_check_size(buf, 4);
 
-	buf->p[0] = val;
-	buf->p[1] = val >> 8;
-	buf->p[2] = val >> 16;
-	buf->p[3] = val >> 24;
+	*(u32 *)buf->p = cpu_to_le32(val);
 	buf->p += 4;
 }
 
@@ -108,14 +104,7 @@ static inline void buf_put_int64(struct 
 {
 	buf_check_size(buf, 8);
 
-	buf->p[0] = val;
-	buf->p[1] = val >> 8;
-	buf->p[2] = val >> 16;
-	buf->p[3] = val >> 24;
-	buf->p[4] = val >> 32;
-	buf->p[5] = val >> 40;
-	buf->p[6] = val >> 48;
-	buf->p[7] = val >> 56;
+	*(u64 *)buf->p = cpu_to_le64(val);
 	buf->p += 8;
 }
 
@@ -158,7 +147,7 @@ static inline u16 buf_get_int16(struct c
 	u16 ret = 0;
 
 	buf_check_size(buf, 2);
-	ret = buf->p[0] | (buf->p[1] << 8);
+	ret = le16_to_cpu(*(u16 *)buf->p);
 
 	buf->p += 2;
 
@@ -170,9 +159,7 @@ static inline u32 buf_get_int32(struct c
 	u32 ret = 0;
 
 	buf_check_size(buf, 4);
-	ret =
-	    buf->p[0] | (buf->p[1] << 8) | (buf->p[2] << 16) | (buf->
-								p[3] << 24);
+	ret = le32_to_cpu(*(u32 *)buf->p);
 
 	buf->p += 4;
 
@@ -184,10 +171,7 @@ static inline u64 buf_get_int64(struct c
 	u64 ret = 0;
 
 	buf_check_size(buf, 8);
-	ret = (u64) buf->p[0] | ((u64) buf->p[1] << 8) |
-	    ((u64) buf->p[2] << 16) | ((u64) buf->p[3] << 24) |
-	    ((u64) buf->p[4] << 32) | ((u64) buf->p[5] << 40) |
-	    ((u64) buf->p[6] << 48) | ((u64) buf->p[7] << 56);
+	ret = le64_to_cpu(*(u64 *)buf->p);
 
 	buf->p += 8;
 


