Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVCDDDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVCDDDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 22:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVCDDDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 22:03:12 -0500
Received: from mail.dif.dk ([193.138.115.101]:45022 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261334AbVCDCrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:47:05 -0500
Date: Fri, 4 Mar 2005 03:47:59 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][3/10] verify_area cleanup : sound
Message-ID: <Pine.LNX.4.62.0503040329410.2801@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch converts verify_area to access_ok in sound/


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -urp linux-2.6.11-orig/sound/core/hwdep.c linux-2.6.11/sound/core/hwdep.c
--- linux-2.6.11-orig/sound/core/hwdep.c	2005-03-02 08:38:34.000000000 +0100
+++ linux-2.6.11/sound/core/hwdep.c	2005-03-03 22:24:20.000000000 +0100
@@ -223,7 +223,7 @@ static int snd_hwdep_dsp_load(snd_hwdep_
 	/* check whether the dsp was already loaded */
 	if (hw->dsp_loaded & (1 << info.index))
 		return -EBUSY;
-	if (verify_area(VERIFY_READ, info.image, info.length))
+	if (!access_ok(VERIFY_READ, info.image, info.length))
 		return -EFAULT;
 	err = hw->ops.dsp_load(hw, &info);
 	if (err < 0)
diff -urp linux-2.6.11-orig/sound/core/seq/seq_clientmgr.c linux-2.6.11/sound/core/seq/seq_clientmgr.c
--- linux-2.6.11-orig/sound/core/seq/seq_clientmgr.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6.11/sound/core/seq/seq_clientmgr.c	2005-03-03 22:24:20.000000000 +0100
@@ -375,7 +375,7 @@ static ssize_t snd_seq_read(struct file 
 	if (!(snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_INPUT))
 		return -ENXIO;
 
-	if (verify_area(VERIFY_WRITE, buf, count))
+	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT;
 
 	/* check client structures are in place */
diff -urp linux-2.6.11-orig/sound/isa/sb/emu8000_patch.c linux-2.6.11/sound/isa/sb/emu8000_patch.c
--- linux-2.6.11-orig/sound/isa/sb/emu8000_patch.c	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.11/sound/isa/sb/emu8000_patch.c	2005-03-03 22:24:20.000000000 +0100
@@ -183,10 +183,10 @@ snd_emu8000_sample_new(snd_emux_t *rec, 
 	}
 
 	if (sp->v.mode_flags & SNDRV_SFNT_SAMPLE_8BITS) {
-		if (verify_area(VERIFY_READ, data, sp->v.size))
+		if (!access_ok(VERIFY_READ, data, sp->v.size))
 			return -EFAULT;
 	} else {
-		if (verify_area(VERIFY_READ, data, sp->v.size * 2))
+		if (!access_ok(VERIFY_READ, data, sp->v.size * 2))
 			return -EFAULT;
 	}
 
diff -urp linux-2.6.11-orig/sound/oss/btaudio.c linux-2.6.11/sound/oss/btaudio.c
--- linux-2.6.11-orig/sound/oss/btaudio.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11/sound/oss/btaudio.c	2005-03-03 22:24:20.000000000 +0100
@@ -558,7 +558,7 @@ static ssize_t btaudio_dsp_read(struct f
 			__s16 __user *dst = (__s16 __user *)(buffer + ret);
 			__s16 avg;
 			int n = ndst>>1;
-			if (0 != verify_area(VERIFY_WRITE,dst,ndst)) {
+			if (!access_ok(VERIFY_WRITE, dst, ndst)) {
 				if (0 == ret)
 					ret = -EFAULT;
 				break;
@@ -574,7 +574,7 @@ static ssize_t btaudio_dsp_read(struct f
 			__u8 *src = bta->buf_cpu + bta->read_offset;
 			__u8 __user *dst = buffer + ret;
 			int n = ndst;
-			if (0 != verify_area(VERIFY_WRITE,dst,ndst)) {
+			if (!access_ok(VERIFY_WRITE, dst, ndst)) {
 				if (0 == ret)
 					ret = -EFAULT;
 				break;
@@ -587,7 +587,7 @@ static ssize_t btaudio_dsp_read(struct f
 			__u16 *src = (__u16*)(bta->buf_cpu + bta->read_offset);
 			__u16 __user *dst = (__u16 __user *)(buffer + ret);
 			int n = ndst>>1;
-			if (0 != verify_area(VERIFY_WRITE,dst,ndst)) {
+			if (!access_ok(VERIFY_WRITE,dst,ndst)) {
 				if (0 == ret)
 					ret = -EFAULT;
 				break;
diff -urp linux-2.6.11-orig/sound/oss/soundcard.c linux-2.6.11/sound/oss/soundcard.c
--- linux-2.6.11-orig/sound/oss/soundcard.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.11/sound/oss/soundcard.c	2005-03-03 22:24:20.000000000 +0100
@@ -341,11 +341,11 @@ static int sound_ioctl(struct inode *ino
 		if (len < 1 || len > 65536 || !p)
 			return -EFAULT;
 		if (_SIOC_DIR(cmd) & _SIOC_WRITE)
-			if ((err = verify_area(VERIFY_READ, p, len)) < 0)
-				return err;
+			if (!access_ok(VERIFY_READ, p, len))
+				return -EFAULT;
 		if (_SIOC_DIR(cmd) & _SIOC_READ)
-			if ((err = verify_area(VERIFY_WRITE, p, len)) < 0)
-				return err;
+			if (!access_ok(VERIFY_WRITE, p, len))
+				return -EFAULT;
 	}
 	DEB(printk("sound_ioctl(dev=%d, cmd=0x%x, arg=0x%x)\n", dev, cmd, arg));
 	if (cmd == OSS_GETVERSION)
diff -urp linux-2.6.11-orig/sound/pci/trident/trident_synth.c linux-2.6.11/sound/pci/trident/trident_synth.c
--- linux-2.6.11-orig/sound/pci/trident/trident_synth.c	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6.11/sound/pci/trident/trident_synth.c	2005-03-03 22:24:20.000000000 +0100
@@ -525,7 +525,7 @@ static int snd_trident_simple_put_sample
 	if (trident->synth.current_size + size > trident->synth.max_size)
 		return -ENOMEM;
 
-	if (verify_area(VERIFY_READ, data, size))
+	if (!access_ok(VERIFY_READ, data, size))
 		return -EFAULT;
 
 	if (trident->tlb.entries) {
@@ -570,7 +570,7 @@ static int snd_trident_simple_get_sample
 		shift++;
 	size <<= shift;
 
-	if (verify_area(VERIFY_WRITE, data, size))
+	if (!access_ok(VERIFY_WRITE, data, size))
 		return -EFAULT;
 
 	/* FIXME: not implemented yet */


