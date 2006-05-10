Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWEJDCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWEJDCO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWEJDBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 23:01:54 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:4670 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932441AbWEJC4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:48 -0400
Date: Tue, 9 May 2006 19:55:58 -0700
Message-Id: <200605100255.k4A2twkM031669@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] emu10k gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning,

sound/oss/emu10k1/passthrough.c: In function 'emu10k1_pt_write':
sound/oss/emu10k1/passthrough.c:165: warning: ignoring return value of 'copy_from_user', declared with attribute warn_unused_result
sound/oss/emu10k1/passthrough.c:170: warning: ignoring return value of 'copy_from_user', declared with attribute warn_unused_result
sound/oss/emu10k1/passthrough.c:181: warning: ignoring return value of 'copy_from_user', declared with attribute warn_unused_result
sound/oss/emu10k1/passthrough.c:196: warning: ignoring return value of 'copy_from_user', declared with attribute warn_unused_result

sound/oss/emu10k1/cardwi.c: In function 'copy_block':
sound/oss/emu10k1/cardwi.c:310: warning: ignoring return value of '__copy_to_user', declared with attribute warn_unused_result
sound/oss/emu10k1/cardwi.c:319: warning: ignoring return value of '__copy_to_user', declared with attribute warn_unused_result

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/sound/oss/emu10k1/passthrough.c
===================================================================
--- linux-2.6.16.orig/sound/oss/emu10k1/passthrough.c
+++ linux-2.6.16/sound/oss/emu10k1/passthrough.c
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
Index: linux-2.6.16/sound/oss/emu10k1/cardwi.c
===================================================================
--- linux-2.6.16.orig/sound/oss/emu10k1/cardwi.c
+++ linux-2.6.16/sound/oss/emu10k1/cardwi.c
@@ -307,7 +307,7 @@ void emu10k1_wavein_getxfersize(struct w
 static void copy_block(u8 __user *dst, u8 * src, u32 str, u32 len, u8 cov)
 {
 	if (cov == 1)
-		__copy_to_user(dst, src + str, len);
+		WARN_ON(__copy_to_user(dst, src + str, len));
 	else {
 		u8 byte;
 		u32 i;
@@ -316,7 +316,7 @@ static void copy_block(u8 __user *dst, u
 
 		for (i = 0; i < len; i++) {
 			byte = src[2 * i] ^ 0x80;
-			__copy_to_user(dst + i, &byte, 1);
+			WARN_ON(__copy_to_user(dst + i, &byte, 1));
 		}
 	}
 }
