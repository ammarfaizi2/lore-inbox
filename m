Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266363AbTAONbd>; Wed, 15 Jan 2003 08:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266384AbTAONbd>; Wed, 15 Jan 2003 08:31:33 -0500
Received: from kilo.rb.xcalibre.co.uk ([217.204.38.22]:52753 "EHLO
	kilo.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id <S266363AbTAONba>; Wed, 15 Jan 2003 08:31:30 -0500
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
Date: Wed, 15 Jan 2003 13:40:39 +0000
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Cc: rui.sousa@laposte.net
Subject: Re: [PATCH] emu10k1 forward port (2.4.20 to 2.5.56)
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XTWJ+dXK6t7qY9O"
Message-Id: <200301151340.39264.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_XTWJ+dXK6t7qY9O
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This diff applies over the top of Rui's diff to provide the 
__copy_{to,from}_user fixes present in -dj. The merging of both these diffs 
would remove all the remaining important emu10k1 changes from -dj.

Cheers,
Alistair Strachan.

--Boundary-00=_XTWJ+dXK6t7qY9O
Content-Type: text/x-diff;
  charset="utf-8";
  name="emu10k1-dj-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="emu10k1-dj-fixes.diff"

diff -Nudr -U3 emu10k1-rui/audio.c emu10k1-mine/audio.c
--- emu10k1-rui/audio.c	2003-01-15 13:28:20.000000000 +0000
+++ emu10k1-mine/audio.c	2002-12-22 01:57:12.000000000 +0000
@@ -793,7 +799,7 @@
 				cinfo.blocks = 0;
 			}
 
-			if(wiinst->mmapped)
+			if (wiinst->mmapped)
 				wiinst->buffer.bytestocopy %= wiinst->buffer.fragment_size;
 
 			spin_unlock_irqrestore(&wiinst->lock, flags);
diff -Nudr -U3 emu10k1-rui/cardwi.c emu10k1-mine/cardwi.c
--- emu10k1-rui/cardwi.c	2003-01-15 13:28:20.000000000 +0000
+++ emu10k1-mine/cardwi.c	2002-12-22 01:57:12.000000000 +0000
@@ -307,9 +307,10 @@
 
 static void copy_block(u8 *dst, u8 * src, u32 str, u32 len, u8 cov)
 {
-	if (cov == 1)
-		__copy_to_user(dst, src + str, len);
-	else {
+	if (cov == 1) {
+		if (__copy_to_user(dst, src + str, len))
+			return;
+	} else {
 		u8 byte;
 		u32 i;
 
@@ -317,7 +318,8 @@
 
 		for (i = 0; i < len; i++) {
 			byte = src[2 * i] ^ 0x80;
-			__copy_to_user(dst + i, &byte, 1);
+			if (__copy_to_user(dst + i, &byte, 1))
+				return;
 		}
 	}
 }
diff -Nudr -U3 emu10k1-rui/cardwo.c emu10k1-mine/cardwo.c
--- emu10k1-rui/cardwo.c	2003-01-15 13:28:20.000000000 +0000
+++ emu10k1-mine/cardwo.c	2002-12-22 02:20:50.000000000 +0000
@@ -408,15 +408,17 @@
 
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
-
+		if (__copy_from_user(dst[++pg], src + k, len))
+			return;
 	} else
 		__copy_from_user((u8 *)dst[pg] + pgoff, src, len);
 }
@@ -440,7 +442,8 @@
 
 	while (len) { 
 		for (voice_num = 0; voice_num < woinst->num_voices; voice_num++) {
-			__copy_from_user((u8 *)(voice[voice_num].mem.addr[pg]) + pgoff, src, woinst->format.bytespervoicesample);
+			if (__copy_from_user((u8 *)(voice[voice_num].mem.addr[pg]) + pgoff, src, woinst->format.bytespervoicesample))
+				return;
 			src += woinst->format.bytespervoicesample;
 		}
 
diff -Nudr -U3 emu10k1-rui/midi.c emu10k1-mine/midi.c
--- emu10k1-rui/midi.c	2003-01-15 13:28:20.000000000 +0000
+++ emu10k1-mine/midi.c	2002-12-22 02:26:58.000000000 +0000
@@ -122,9 +122,8 @@
 		up(&card->open_sem);
 		interruptible_sleep_on(&card->open_wait);
 
-		if (signal_pending(current)) {
+		if (signal_pending(current))
 			return -ERESTARTSYS;
-		}
 
 		down(&card->open_sem);
 	}
diff -Nudr -U3 emu10k1-rui/passthrough.c emu10k1-mine/passthrough.c
--- emu10k1-rui/passthrough.c	2003-01-15 13:28:20.000000000 +0000
+++ emu10k1-mine/passthrough.c	2002-08-31 22:05:03.000000000 +0000
@@ -165,12 +165,15 @@
 
 		DPD(3, "prepend size %d, prepending %d bytes\n", pt->prepend_size, needed);
 		if (count < needed) {
-			copy_from_user(pt->buf + pt->prepend_size, buffer, count);
+			if (copy_from_user(pt->buf + pt->prepend_size, buffer,
+					   count))
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
@@ -181,7 +184,8 @@
 	blocks_copied = 0;
 	while (blocks > 0) {
 		u16 *bufptr = (u16 *) buffer + (bytes_copied/2);
-		copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE);
+		if (copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE))
+			return -EFAULT;
 		bufptr = (u16 *) pt->buf;
 		r = pt_putblock(wave_dev, bufptr, nonblock);
 		if (r) {
@@ -197,7 +201,8 @@
 	i = count - bytes_copied;
 	if (i) {
 		pt->prepend_size = i;
-		copy_from_user(pt->buf, buffer + bytes_copied, i);
+		if (copy_from_user(pt->buf, buffer + bytes_copied, i))
+			return -EFAULT;
 		bytes_copied += i;
 		DPD(3, "filling prepend buffer with %d bytes", i);
 	}

--Boundary-00=_XTWJ+dXK6t7qY9O--

