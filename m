Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264723AbSJORJj>; Tue, 15 Oct 2002 13:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSJORJj>; Tue, 15 Oct 2002 13:09:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63909 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264723AbSJORJh>;
	Tue, 15 Oct 2002 13:09:37 -0400
Date: Tue, 15 Oct 2002 10:08:11 -0700 (PDT)
Message-Id: <20021015.100811.118915540.davem@redhat.com>
To: perex@perex.cz
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: ALSA update
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0210150013540.503-100000@pnote.perex-int.cz>
References: <20021014.125829.01014301.davem@redhat.com>
	<Pine.LNX.4.33.0210150013540.503-100000@pnote.perex-int.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jaroslav Kysela <perex@perex.cz>
   Date: Tue, 15 Oct 2002 00:43:53 +0200 (CEST)

   Oops. Missing two backslashes. It should be corrected with this patch 
   (already in linux-sound BK repository):

That's just the tip of the iceberg.

It fails again soon after that, none of the ioctl32.c/pcm32.c
changes were even _compile_ tested.

Try this instead:

--- ./sound/core/ioctl32/pcm32.c.~1~	Mon Oct 14 13:09:55 2002
+++ ./sound/core/ioctl32/pcm32.c	Mon Oct 14 13:12:38 2002
@@ -20,6 +20,7 @@
 
 #include <sound/driver.h>
 #include <linux/time.h>
+#include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include "ioctl32.h"
@@ -230,7 +231,7 @@ static int _snd_ioctl32_xfern(unsigned i
 	snd_pcm_file_t *pcm_file;
 	snd_pcm_substream_t *substream;
 	struct sndrv_xfern32 data32, *srcptr = (struct sndrv_xfern32*)arg;
-	void *bufs = NULL;
+	void **bufs = NULL;
 	int err = 0, ch, i;
 	u32 *bufptr;
 	mm_segment_t oldseg;
@@ -260,7 +261,7 @@ static int _snd_ioctl32_xfern(unsigned i
 		return -EFAULT;
 	__get_user(data32.bufs, &srcptr->bufs);
 	bufptr = (u32*)TO_PTR(data32.bufs);
-	bufs = kmalloc(sizeof(void *) * 128, GFP_KERNEL)
+	bufs = kmalloc(sizeof(void *) * 128, GFP_KERNEL);
 	if (bufs == NULL)
 		return -ENOMEM;
 	for (i = 0; i < ch; i++) {
@@ -352,8 +353,8 @@ static int _snd_ioctl32_pcm_hw_params_ol
 	mm_segment_t oldseg;
 	int err;
 
-	data32 = kcalloc(sizeof(*data32), GFP_KERNEL);
-	data = kcalloc(sizeof(*data), GFP_KERNEL);
+	data32 = snd_kcalloc(sizeof(*data32), GFP_KERNEL);
+	data = snd_kcalloc(sizeof(*data), GFP_KERNEL);
 	if (data32 == NULL || data == NULL) {
 		err = -ENOMEM;
 		goto __end;
--- ./sound/core/ioctl32/ioctl32.h.~1~	Mon Oct 14 13:01:25 2002
+++ ./sound/core/ioctl32/ioctl32.h	Mon Oct 14 13:12:01 2002
@@ -86,16 +86,16 @@ static int _snd_ioctl32_##type(unsigned 
 	struct sndrv_##type *data;\
 	mm_segment_t oldseg;\
 	int err;\
-	data32 = kcalloc(sizeof(*data32), GFP_KERNEL); \
-	data = kcalloc(sizeof(*data), GFP_KERNEL); \
+	data32 = snd_kcalloc(sizeof(*data32), GFP_KERNEL); \
+	data = snd_kcalloc(sizeof(*data), GFP_KERNEL); \
 	if (data32 == NULL || data == NULL) { \
 		err = -ENOMEM; \
 		goto __end; \
-	}
+	} \
 	if (copy_from_user(data32, (void*)arg, sizeof(*data32))) { \
 		err = -EFAULT; \
 		goto __end; \
-	}
+	} \
 	memset(data, 0, sizeof(*data));\
 	convert_from_32(type, data, data32);\
 	oldseg = get_fs();\
--- ./sound/core/ioctl32/ioctl32.c.~1~	Mon Oct 14 13:02:21 2002
+++ ./sound/core/ioctl32/ioctl32.c	Mon Oct 14 13:03:35 2002
@@ -23,6 +23,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/time.h>
+#include <linux/slab.h>
 #include <linux/init.h>
 #include <sound/core.h>
 #include <sound/control.h>
@@ -287,13 +288,13 @@ static int _snd_ioctl32_ctl_elem_value(u
 	data->id = data32->id;
 	data->indirect = data32->indirect;
 	if (data->indirect) /* FIXME: this is not correct for long arrays */
-		data.value.integer.value_ptr = (void*)TO_PTR(data32->value.integer.value_ptr);
+		data->value.integer.value_ptr = (void*)TO_PTR(data32->value.integer.value_ptr);
 	type = get_ctl_type(file, &data->id);
 	if (type < 0) {
 		err = type;
 		goto __end;
 	}
-	if (! data.indirect) {
+	if (! data->indirect) {
 		switch (type) {
 		case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
 		case SNDRV_CTL_ELEM_TYPE_INTEGER:
@@ -328,7 +329,7 @@ static int _snd_ioctl32_ctl_elem_value(u
 	if (err < 0)
 		goto __end;
 	/* restore info to 32bit */
-	if (! data.indirect) {
+	if (! data->indirect) {
 		switch (type) {
 		case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
 		case SNDRV_CTL_ELEM_TYPE_INTEGER:
