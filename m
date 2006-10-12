Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWJLBmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWJLBmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWJLBmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:42:44 -0400
Received: from havoc.gtf.org ([69.61.125.42]:61919 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932488AbWJLBmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:42:43 -0400
Date: Wed, 11 Oct 2006 21:42:42 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] sound/oss/emu10k1: handle userspace copy errors
Message-ID: <20061012014242.GA12679@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Propagate copy_to/from_user() errors back through callers.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 sound/oss/emu10k1/audio.c       |    8 +++++-
 sound/oss/emu10k1/cardwi.c      |   31 ++++++++++++++++-------
 sound/oss/emu10k1/cardwi.h      |    2 -
 sound/oss/emu10k1/passthrough.c |   13 ++++++----

diff --git a/sound/oss/emu10k1/audio.c b/sound/oss/emu10k1/audio.c
index cde4d59..d13fe2a 100644
--- a/sound/oss/emu10k1/audio.c
+++ b/sound/oss/emu10k1/audio.c
@@ -110,9 +110,15 @@ static ssize_t emu10k1_audio_read(struct
 
 		if ((bytestocopy >= wiinst->buffer.fragment_size)
 		    || (bytestocopy >= count)) {
+			int rc;
+
 			bytestocopy = min_t(u32, bytestocopy, count);
 
-			emu10k1_wavein_xferdata(wiinst, (u8 __user *)buffer, &bytestocopy);
+			rc = emu10k1_wavein_xferdata(wiinst,
+						     (u8 __user *)buffer,
+						     &bytestocopy);
+			if (rc)
+				return rc;
 
 			count -= bytestocopy;
 			buffer += bytestocopy;
diff --git a/sound/oss/emu10k1/cardwi.c b/sound/oss/emu10k1/cardwi.c
index 8bbf44b..060d1be 100644
--- a/sound/oss/emu10k1/cardwi.c
+++ b/sound/oss/emu10k1/cardwi.c
@@ -304,11 +304,12 @@ void emu10k1_wavein_getxfersize(struct w
 	}
 }
 
-static void copy_block(u8 __user *dst, u8 * src, u32 str, u32 len, u8 cov)
+static int copy_block(u8 __user *dst, u8 * src, u32 str, u32 len, u8 cov)
 {
-	if (cov == 1)
-		__copy_to_user(dst, src + str, len);
-	else {
+	if (cov == 1) {
+		if (__copy_to_user(dst, src + str, len))
+			return -EFAULT;
+	} else {
 		u8 byte;
 		u32 i;
 
@@ -316,22 +317,26 @@ static void copy_block(u8 __user *dst, u
 
 		for (i = 0; i < len; i++) {
 			byte = src[2 * i] ^ 0x80;
-			__copy_to_user(dst + i, &byte, 1);
+			if (__copy_to_user(dst + i, &byte, 1))
+				return -EFAULT;
 		}
 	}
+
+	return 0;
 }
 
-void emu10k1_wavein_xferdata(struct wiinst *wiinst, u8 __user *data, u32 * size)
+int emu10k1_wavein_xferdata(struct wiinst *wiinst, u8 __user *data, u32 * size)
 {
 	struct wavein_buffer *buffer = &wiinst->buffer;
 	u32 sizetocopy, sizetocopy_now, start;
 	unsigned long flags;
+	int ret;
 
 	sizetocopy = min_t(u32, buffer->size, *size);
 	*size = sizetocopy;
 
 	if (!sizetocopy)
-		return;
+		return 0;
 
 	spin_lock_irqsave(&wiinst->lock, flags);
 	start = buffer->pos;
@@ -345,11 +350,17 @@ void emu10k1_wavein_xferdata(struct wiin
 	if (sizetocopy > sizetocopy_now) {
 		sizetocopy -= sizetocopy_now;
 
-		copy_block(data, buffer->addr, start, sizetocopy_now, buffer->cov);
-		copy_block(data + sizetocopy_now, buffer->addr, 0, sizetocopy, buffer->cov);
+		ret = copy_block(data, buffer->addr, start, sizetocopy_now,
+				 buffer->cov);
+		if (ret == 0)
+			ret = copy_block(data + sizetocopy_now, buffer->addr, 0,
+					 sizetocopy, buffer->cov);
 	} else {
-		copy_block(data, buffer->addr, start, sizetocopy, buffer->cov);
+		ret = copy_block(data, buffer->addr, start, sizetocopy,
+				 buffer->cov);
 	}
+
+	return ret;
 }
 
 void emu10k1_wavein_update(struct emu10k1_card *card, struct wiinst *wiinst)
diff --git a/sound/oss/emu10k1/cardwi.h b/sound/oss/emu10k1/cardwi.h
index 15cfb9b..e82029b 100644
--- a/sound/oss/emu10k1/cardwi.h
+++ b/sound/oss/emu10k1/cardwi.h
@@ -83,7 +83,7 @@ void emu10k1_wavein_close(struct emu10k1
 void emu10k1_wavein_start(struct emu10k1_wavedevice *);
 void emu10k1_wavein_stop(struct emu10k1_wavedevice *);
 void emu10k1_wavein_getxfersize(struct wiinst *, u32 *);
-void emu10k1_wavein_xferdata(struct wiinst *, u8 __user *, u32 *);
+int emu10k1_wavein_xferdata(struct wiinst *, u8 __user *, u32 *);
 int emu10k1_wavein_setformat(struct emu10k1_wavedevice *, struct wave_format *);
 void emu10k1_wavein_update(struct emu10k1_card *, struct wiinst *);
 
diff --git a/sound/oss/emu10k1/passthrough.c b/sound/oss/emu10k1/passthrough.c
index 4e3baca..6d21d43 100644
--- a/sound/oss/emu10k1/passthrough.c
+++ b/sound/oss/emu10k1/passthrough.c
@@ -162,12 +162,15 @@ ssize_t emu10k1_pt_write(struct file *fi
 
 		DPD(3, "prepend size %d, prepending %d bytes\n", pt->prepend_size, needed);
 		if (count < needed) {
-			copy_from_user(pt->buf + pt->prepend_size, buffer, count);
+			if (copy_from_user(pt->buf + pt->prepend_size,
+					   buffer, count))
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
@@ -178,7 +181,8 @@ ssize_t emu10k1_pt_write(struct file *fi
 	blocks_copied = 0;
 	while (blocks > 0) {
 		u16 __user *bufptr = (u16 __user *) buffer + (bytes_copied/2);
-		copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE);
+		if (copy_from_user(pt->buf, bufptr, PT_BLOCKSIZE))
+			return -EFAULT;
 		r = pt_putblock(wave_dev, (u16 *)pt->buf, nonblock);
 		if (r) {
 			if (bytes_copied)
@@ -193,7 +197,8 @@ ssize_t emu10k1_pt_write(struct file *fi
 	i = count - bytes_copied;
 	if (i) {
 		pt->prepend_size = i;
-		copy_from_user(pt->buf, buffer + bytes_copied, i);
+		if (copy_from_user(pt->buf, buffer + bytes_copied, i))
+			return -EFAULT;
 		bytes_copied += i;
 		DPD(3, "filling prepend buffer with %d bytes", i);
 	}
