Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263150AbVCEPzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbVCEPzB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbVCEPyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:54:18 -0500
Received: from coderock.org ([193.77.147.115]:49827 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261911AbVCEPgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:36:07 -0500
Subject: [patch 11/12] sound/oss/emu10k1/* - compile warning cleanup
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, yrgrknmxpzlk@gawab.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 16:35:41 +0100
Message-Id: <20050305153542.7A66E1F208@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


compile warning cleanup - handle copy_to/from_user error 
returns

Signed-off-by: Stephen Biggs <yrgrknmxpzlk@gawab.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/sound/oss/emu10k1/cardwi.c      |   13 ++++++++++---
 kj-domen/sound/oss/emu10k1/passthrough.c |   12 ++++++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff -puN sound/oss/emu10k1/cardwi.c~return_code-sound_oss_emu10k1 sound/oss/emu10k1/cardwi.c
--- kj/sound/oss/emu10k1/cardwi.c~return_code-sound_oss_emu10k1	2005-03-05 16:13:11.000000000 +0100
+++ kj-domen/sound/oss/emu10k1/cardwi.c	2005-03-05 16:13:11.000000000 +0100
@@ -306,8 +306,12 @@ void emu10k1_wavein_getxfersize(struct w
 
 static void copy_block(u8 __user *dst, u8 * src, u32 str, u32 len, u8 cov)
 {
-	if (cov == 1)
-		__copy_to_user(dst, src + str, len);
+	if (cov == 1) {
+		if (__copy_to_user(dst, src + str, len)) {
+			printk( KERN_ERR "emu10k1: %s: copy_to_user failed\n",__FUNCTION__);
+			return;
+		}
+	}
 	else {
 		u8 byte;
 		u32 i;
@@ -316,7 +320,10 @@ static void copy_block(u8 __user *dst, u
 
 		for (i = 0; i < len; i++) {
 			byte = src[2 * i] ^ 0x80;
-			__copy_to_user(dst + i, &byte, 1);
+			if (__copy_to_user(dst + i, &byte, 1)) {
+				printk( KERN_ERR "emu10k1: %s: copy_to_user failed\n",__FUNCTION__);
+				return;
+			}
 		}
 	}
 }
diff -puN sound/oss/emu10k1/passthrough.c~return_code-sound_oss_emu10k1 sound/oss/emu10k1/passthrough.c
--- kj/sound/oss/emu10k1/passthrough.c~return_code-sound_oss_emu10k1	2005-03-05 16:13:11.000000000 +0100
+++ kj-domen/sound/oss/emu10k1/passthrough.c	2005-03-05 16:13:11.000000000 +0100
@@ -162,12 +162,14 @@ ssize_t emu10k1_pt_write(struct file *fi
 
 		DPD(3, "prepend size %d, prepending %d bytes\n", pt->prepend_size, needed);
 		if (count < needed) {
-			copy_from_user(pt->buf + pt->prepend_size, buffer, count);
+			if (copy_from_user(pt->buf + pt->prepend_size, buffer, count))
+				return -EFAULT;
 			pt->prepend_size += count;
 			DPD(3, "prepend size now %d\n", pt->prepend_size);
 			return count;
 		}
-		copy_from_user(pt->buf + pt->prepend_size, buffer, needed);
+		if (copy_from_user(pt->buf + pt->prepend_size, buffer, needed))
+			return -EFAULT;
 		r = pt_putblock(wave_dev, (u16 *) pt->buf, nonblock);
 		if (r)
 			return r;
@@ -178,7 +180,8 @@ ssize_t emu10k1_pt_write(struct file *fi
 	blocks_copied = 0;
 	while (blocks > 0) {
 		u16 __user *bufptr = (u16 __user *) buffer + (bytes_copied/2);
-		copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE);
+		if (copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE))
+			return -EFAULT;
 		r = pt_putblock(wave_dev, (u16 *)pt->buf, nonblock);
 		if (r) {
 			if (bytes_copied)
@@ -193,7 +196,8 @@ ssize_t emu10k1_pt_write(struct file *fi
 	i = count - bytes_copied;
 	if (i) {
 		pt->prepend_size = i;
-		copy_from_user(pt->buf, buffer + bytes_copied, i);
+		if (copy_from_user(pt->buf, buffer + bytes_copied, i))
+			return -EFAULT;
 		bytes_copied += i;
 		DPD(3, "filling prepend buffer with %d bytes", i);
 	}
_
