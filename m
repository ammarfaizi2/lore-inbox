Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292230AbSBTTVH>; Wed, 20 Feb 2002 14:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSBTTU6>; Wed, 20 Feb 2002 14:20:58 -0500
Received: from zero.tech9.net ([209.61.188.187]:7187 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292228AbSBTTUl>;
	Wed, 20 Feb 2002 14:20:41 -0500
Subject: [PATCH] proper lseek locking in ALSA, take 3
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 14:20:40 -0500
Message-Id: <1014232841.18361.37.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch implements proper locking in ALSA lseek methods. 
Note ALSA has 3 lseek implementations, but only:

	sound/core/info.c :: snd_info_entry_llseek()

requires locking.  I wrapped the function in the BKL.  According to
Jaroslav Kysela the gus_mem_proc method is only called from above.  The
third lseek, in hwdep.c, clearly doesn't need locking.  Without this
patch, the above lseek is not safe.

Patch is against 2.5.5, please apply.

	Robert Love	

diff -urN linux-2.5.5/sound/core/info.c linux/sound/core/info.c
--- linux-2.5.5/sound/core/info.c	Tue Feb 19 21:11:01 2002
+++ linux/sound/core/info.c	Tue Feb 19 21:50:18 2002
@@ -29,6 +29,7 @@
 #include <sound/info.h>
 #include <sound/version.h>
 #include <linux/proc_fs.h>
+#include <linux/smp_lock.h>
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
 #endif
@@ -162,31 +163,40 @@
 {
 	snd_info_private_data_t *data;
 	struct snd_info_entry *entry;
+	int ret = -EINVAL;
 
 	data = snd_magic_cast(snd_info_private_data_t, file->private_data, return -ENXIO);
 	entry = data->entry;
+	lock_kernel();
 	switch (entry->content) {
 	case SNDRV_INFO_CONTENT_TEXT:
 		switch (orig) {
 		case 0:	/* SEEK_SET */
 			file->f_pos = offset;
-			return file->f_pos;
+			ret = file->f_pos;
+			goto out;
 		case 1:	/* SEEK_CUR */
 			file->f_pos += offset;
-			return file->f_pos;
+			ret = file->f_pos;
+			goto out;
 		case 2:	/* SEEK_END */
 		default:
-			return -EINVAL;
+			goto out;
 		}
 		break;
 	case SNDRV_INFO_CONTENT_DATA:
-		if (entry->c.ops->llseek)
-			return entry->c.ops->llseek(entry,
+		if (entry->c.ops->llseek) {
+			ret = entry->c.ops->llseek(entry,
 						    data->file_private_data,
 						    file, offset, orig);
+			goto out;
+		}
 		break;
 	}
-	return -ENXIO;
+	ret = -ENXIO;
+out:
+	unlock_kernel();
+	return ret;
 }
 
 static ssize_t snd_info_entry_read(struct file *file, char *buffer,




