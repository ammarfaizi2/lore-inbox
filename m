Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264294AbTCXQgo>; Mon, 24 Mar 2003 11:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264296AbTCXQfM>; Mon, 24 Mar 2003 11:35:12 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:58090 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264294AbTCXQbD>; Mon, 24 Mar 2003 11:31:03 -0500
Message-Id: <200303241642.h2OGgE35008361@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:42:01 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Add __copy_from_user checks to emu10k1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/sound/oss/emu10k1/cardwo.c linux-2.5/sound/oss/emu10k1/cardwo.c
--- bk-linus/sound/oss/emu10k1/cardwo.c	2003-03-22 12:36:23.000000000 +0000
+++ linux-2.5/sound/oss/emu10k1/cardwo.c	2003-03-22 12:41:48.000000000 +0000
@@ -408,14 +408,17 @@ static void copy_block(void **dst, u32 s
 
 	if (len > PAGE_SIZE - pgoff) {
 		k = PAGE_SIZE - pgoff;
-		__copy_from_user((u8 *)dst[pg] + pgoff, src, k);
+		if (__copy_from_user((u8 *)dst[pg] + pgoff, src, k))
+			return;
 		len -= k;
 		while (len > PAGE_SIZE) {
-			__copy_from_user(dst[++pg], src + k, PAGE_SIZE);
+			if (__copy_from_user(dst[++pg], src + k, PAGE_SIZE))
+				return;
 			k += PAGE_SIZE;
 			len -= PAGE_SIZE;
 		}
-		__copy_from_user(dst[++pg], src + k, len);
+		if (__copy_from_user(dst[++pg], src + k, len))
+			return;
 
 	} else
 		__copy_from_user((u8 *)dst[pg] + pgoff, src, len);
@@ -440,7 +443,8 @@ static void copy_ilv_block(struct woinst
 
 	while (len) { 
 		for (voice_num = 0; voice_num < woinst->num_voices; voice_num++) {
-			__copy_from_user((u8 *)(voice[voice_num].mem.addr[pg]) + pgoff, src, woinst->format.bytespervoicesample);
+			if (__copy_from_user((u8 *)(voice[voice_num].mem.addr[pg]) + pgoff, src, woinst->format.bytespervoicesample))
+				return -EFAULT;
 			src += woinst->format.bytespervoicesample;
 		}
 
