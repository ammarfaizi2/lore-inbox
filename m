Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261734AbSI2SrT>; Sun, 29 Sep 2002 14:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261735AbSI2SrT>; Sun, 29 Sep 2002 14:47:19 -0400
Received: from gate.perex.cz ([194.212.165.105]:12304 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261734AbSI2Sqp>;
	Sun, 29 Sep 2002 14:46:45 -0400
Date: Sun, 29 Sep 2002 20:51:25 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update [6/10] - 2002/07/20
Message-ID: <Pine.LNX.4.33.0209292050390.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.605.2.17, 2002-09-25 17:57:54+02:00, perex@pnote.perex-int.cz
  ALSA update 2002/07/20 :
    - added vfree_nocheck()
    - PCM midlevel & EMU10K1 - added support for SG buffer
    - CS4236 - added new ISA PnP ID
    - HDSP - fixed rate rules (OSS emulation works)


 include/sound/core.h       |    2 
 include/sound/emu10k1.h    |    3 
 include/sound/pcm.h        |    4 
 include/sound/pcm_sgbuf.h  |   60 +++++++
 include/sound/sndmagic.h   |    1 
 include/sound/version.h    |    2 
 sound/core/Makefile        |    5 
 sound/core/control.c       |    1 
 sound/core/pcm_lib.c       |   21 ++
 sound/core/pcm_native.c    |    9 -
 sound/core/pcm_sgbuf.c     |  321 +++++++++++++++++++++++++++++++++++++++
 sound/core/rtctimer.c      |    1 
 sound/core/sound.c         |    2 
 sound/isa/cs423x/cs4236.c  |    2 
 sound/pci/Config.help      |    4 
 sound/pci/Config.in        |    2 
 sound/pci/emu10k1/emupcm.c |   18 +-
 sound/pci/emu10k1/memory.c |   20 +-
 sound/pci/rme9652/hdsp.c   |   20 --
 sound/pci/via686.c         |  366 +++++++++++++++++++--------------------------
 20 files changed, 621 insertions(+), 243 deletions(-)


diff -Nru a/include/sound/core.h b/include/sound/core.h
--- a/include/sound/core.h	Sun Sep 29 20:21:38 2002
+++ b/include/sound/core.h	Sun Sep 29 20:21:38 2002
@@ -243,8 +243,10 @@
 #define kfree_nocheck(obj) snd_wrapper_kfree(obj)
 #define vmalloc(size) snd_hidden_vmalloc(size)
 #define vfree(obj) snd_hidden_vfree(obj)
+#define vfree_nocheck(obj) snd_wrapper_vfree(obj)
 #else
 #define kfree_nocheck(obj) kfree(obj)
+#define vfree_nocheck(obj) vfree(obj)
 #endif
 void *snd_kcalloc(size_t size, int flags);
 char *snd_kmalloc_strdup(const char *string, int flags);
diff -Nru a/include/sound/emu10k1.h b/include/sound/emu10k1.h
--- a/include/sound/emu10k1.h	Sun Sep 29 20:21:38 2002
+++ b/include/sound/emu10k1.h	Sun Sep 29 20:21:38 2002
@@ -26,6 +26,7 @@
 #ifdef __KERNEL__
 
 #include "pcm.h"
+#include "pcm_sgbuf.h"
 #include "rawmidi.h"
 #include "hwdep.h"
 #include "ac97_codec.h"
@@ -1043,7 +1044,7 @@
 unsigned char snd_emu10k1_sum_vol_attn(unsigned int value);
 
 /* memory allocation */
-snd_util_memblk_t *snd_emu10k1_alloc_pages(emu10k1_t *emu, dma_addr_t addr, unsigned long size);
+snd_util_memblk_t *snd_emu10k1_alloc_pages(emu10k1_t *emu, struct snd_sg_buf *sgbuf);
 int snd_emu10k1_free_pages(emu10k1_t *emu, snd_util_memblk_t *blk);
 snd_util_memblk_t *snd_emu10k1_synth_alloc(emu10k1_t *emu, unsigned int size);
 int snd_emu10k1_synth_free(emu10k1_t *emu, snd_util_memblk_t *blk);
diff -Nru a/include/sound/pcm.h b/include/sound/pcm.h
--- a/include/sound/pcm.h	Sun Sep 29 20:21:38 2002
+++ b/include/sound/pcm.h	Sun Sep 29 20:21:38 2002
@@ -96,6 +96,7 @@
 		    void *buf, snd_pcm_uframes_t count);
 	int (*silence)(snd_pcm_substream_t *substream, int channel, 
 		       snd_pcm_uframes_t pos, snd_pcm_uframes_t count);
+	void *(*page)(snd_pcm_substream_t *substream, unsigned long offset);
 } snd_pcm_ops_t;
 
 /*
@@ -771,6 +772,9 @@
 			       unsigned int cond,
 			       snd_pcm_hw_param_t var,
 			       unsigned long step);
+int snd_pcm_hw_constraint_pow2(snd_pcm_runtime_t *runtime,
+			       unsigned int cond,
+			       snd_pcm_hw_param_t var);
 int snd_pcm_hw_rule_add(snd_pcm_runtime_t *runtime,
 			unsigned int cond,
 			int var,
diff -Nru a/include/sound/pcm_sgbuf.h b/include/sound/pcm_sgbuf.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/sound/pcm_sgbuf.h	Sun Sep 29 20:21:38 2002
@@ -0,0 +1,60 @@
+#ifndef __SOUND_PCM_SGBUF_H
+#define __SOUND_PCM_SGBUF_H
+
+/*
+ * Scatter-Gather PCM access
+ *
+ *  Copyright (c) by Takashi Iwai <tiwai@suse.de>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+struct snd_sg_page {
+	void *buf;
+	dma_addr_t addr;
+};
+
+struct snd_sg_buf {
+	int size;	/* allocated byte size (= runtime->dma_bytes) */
+	int pages;	/* allocated pages */
+	int tblsize;	/* allocated table size */
+	struct snd_sg_page *table;
+	struct pci_dev *pci;
+};
+
+typedef struct snd_sg_buf snd_pcm_sgbuf_t; /* for magic cast */
+
+/*
+ * return the pages matching with the given byte size
+ */
+static inline unsigned int snd_pcm_sgbuf_pages(size_t size)
+{
+	return (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+}
+
+
+int snd_pcm_sgbuf_init(snd_pcm_substream_t *substream, struct pci_dev *pci, int tblsize);
+int snd_pcm_sgbuf_delete(snd_pcm_substream_t *substream);
+int snd_pcm_sgbuf_alloc(snd_pcm_substream_t *substream, size_t size);
+int snd_pcm_sgbuf_free(snd_pcm_substream_t *substream);
+
+int snd_pcm_sgbuf_ops_copy_playback(snd_pcm_substream_t *substream, int channel, snd_pcm_uframes_t hwoff, void *buf, snd_pcm_uframes_t count);
+int snd_pcm_sgbuf_ops_copy_capture(snd_pcm_substream_t *substream, int channel, snd_pcm_uframes_t hwoff, void *buf, snd_pcm_uframes_t count);
+int snd_pcm_sgbuf_ops_silence(snd_pcm_substream_t *substream, int channel, snd_pcm_uframes_t hwoff, snd_pcm_uframes_t count);
+void *snd_pcm_sgbuf_ops_page(snd_pcm_substream_t *substream, unsigned long offset);
+
+
+#endif /* __SOUND_PCM_SGBUF_H */
diff -Nru a/include/sound/sndmagic.h b/include/sound/sndmagic.h
--- a/include/sound/sndmagic.h	Sun Sep 29 20:21:38 2002
+++ b/include/sound/sndmagic.h	Sun Sep 29 20:21:38 2002
@@ -61,6 +61,7 @@
 #define snd_pcm_proc_private_t_magic		0xa15a0104
 #define snd_pcm_oss_file_t_magic		0xa15a0105
 #define snd_mixer_oss_t_magic			0xa15a0106
+#define snd_pcm_sgbuf_t_magic			0xa15a0107
 
 #define snd_info_private_data_t_magic		0xa15a0201
 #define snd_ctl_file_t_magic			0xa15a0301
diff -Nru a/include/sound/version.h b/include/sound/version.h
--- a/include/sound/version.h	Sun Sep 29 20:21:38 2002
+++ b/include/sound/version.h	Sun Sep 29 20:21:38 2002
@@ -1,3 +1,3 @@
 /* include/version.h.  Generated automatically by configure.  */
 #define CONFIG_SND_VERSION "0.9.0rc2"
-#define CONFIG_SND_DATE " (Wed Jul 17 10:56:41 2002 UTC)"
+#define CONFIG_SND_DATE " (Sat Jul 20 07:16:41 2002 UTC)"
diff -Nru a/sound/core/Makefile b/sound/core/Makefile
--- a/sound/core/Makefile	Sun Sep 29 20:21:38 2002
+++ b/sound/core/Makefile	Sun Sep 29 20:21:38 2002
@@ -3,7 +3,8 @@
 # Copyright (c) 1999,2001 by Jaroslav Kysela <perex@suse.cz>
 #
 
-export-objs  := sound.o pcm.o pcm_lib.o rawmidi.o timer.o hwdep.o
+export-objs  := sound.o pcm.o pcm_lib.o rawmidi.o timer.o hwdep.o \
+                pcm_sgbuf.o
 
 snd-objs     := sound.o init.o isadma.o memory.o info.o control.o misc.o \
                 device.o wrappers.o
@@ -12,7 +13,7 @@
 endif
 
 snd-pcm-objs := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
-		pcm_memory.o
+		pcm_memory.o pcm_sgbuf.o
 
 snd-rawmidi-objs  := rawmidi.o
 snd-timer-objs    := timer.o
diff -Nru a/sound/core/control.c b/sound/core/control.c
--- a/sound/core/control.c	Sun Sep 29 20:21:38 2002
+++ b/sound/core/control.c	Sun Sep 29 20:21:38 2002
@@ -21,6 +21,7 @@
 
 #define __NO_VERSION__
 #include <sound/driver.h>
+#include <linux/threads.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
diff -Nru a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
--- a/sound/core/pcm_lib.c	Sun Sep 29 20:21:38 2002
+++ b/sound/core/pcm_lib.c	Sun Sep 29 20:21:38 2002
@@ -960,6 +960,26 @@
 				   var, -1);
 }
 
+static int snd_pcm_hw_rule_pow2(snd_pcm_hw_params_t *params, snd_pcm_hw_rule_t *rule)
+{
+	static int pow2_sizes[] = {
+		1<<0, 1<<1, 1<<2, 1<<3, 1<<4, 1<<5, 1<<6, 1<<7,
+		1<<8, 1<<9, 1<<10, 1<<11, 1<<12, 1<<13, 1<<14, 1<<15,
+		1<<16, 1<<17, 1<<18, 1<<19, 1<<20, 1<<21, 1<<22, 1<<23,
+		1<<24, 1<<25, 1<<26, 1<<27, 1<<28, 1<<29, 1<<30
+	};
+	return snd_interval_list(hw_param_interval(params, rule->var),
+				 sizeof(pow2_sizes)/sizeof(int), pow2_sizes, 0);
+}		
+
+int snd_pcm_hw_constraint_pow2(snd_pcm_runtime_t *runtime,
+			       unsigned int cond,
+			       snd_pcm_hw_param_t var)
+{
+	return snd_pcm_hw_rule_add(runtime, cond, var, 
+				   snd_pcm_hw_rule_pow2, NULL,
+				   var, -1);
+}
 
 /* To use the same code we have in alsa-lib */
 #define snd_pcm_t snd_pcm_substream_t
@@ -2364,6 +2384,7 @@
 EXPORT_SYMBOL(snd_pcm_hw_constraint_msbits);
 EXPORT_SYMBOL(snd_pcm_hw_constraint_minmax);
 EXPORT_SYMBOL(snd_pcm_hw_constraint_integer);
+EXPORT_SYMBOL(snd_pcm_hw_constraint_pow2);
 EXPORT_SYMBOL(snd_pcm_hw_rule_add);
 EXPORT_SYMBOL(snd_pcm_set_ops);
 EXPORT_SYMBOL(snd_pcm_set_sync);
diff -Nru a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c	Sun Sep 29 20:21:38 2002
+++ b/sound/core/pcm_native.c	Sun Sep 29 20:21:38 2002
@@ -2631,6 +2631,7 @@
 	snd_pcm_runtime_t *runtime;
 	unsigned long offset;
 	struct page * page;
+	void *vaddr;
 	size_t dma_bytes;
 	
 	if (substream == NULL)
@@ -2646,7 +2647,13 @@
 	dma_bytes = PAGE_ALIGN(runtime->dma_bytes);
 	if (offset > dma_bytes - PAGE_SIZE)
 		return NOPAGE_SIGBUS;
-	page = virt_to_page(runtime->dma_area + offset);
+	if (substream->ops->page) {
+		vaddr = substream->ops->page(substream, offset);
+		if (! vaddr)
+			return NOPAGE_OOM;
+	} else
+		vaddr = runtime->dma_area + offset;
+	page = virt_to_page(vaddr);
 	get_page(page);
 #ifndef LINUX_2_2
 	return page;
diff -Nru a/sound/core/pcm_sgbuf.c b/sound/core/pcm_sgbuf.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/sound/core/pcm_sgbuf.c	Sun Sep 29 20:21:38 2002
@@ -0,0 +1,321 @@
+/*
+ * Scatter-Gather PCM access
+ *
+ *  Copyright (c) by Takashi Iwai <tiwai@suse.de>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#define __NO_VERSION__
+#include <sound/driver.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_sgbuf.h>
+
+
+/* table entries are align to 32 */
+#define SGBUF_TBL_ALIGN		32
+#define sgbuf_align_table(tbl)	((((tbl) + SGBUF_TBL_ALIGN - 1) / SGBUF_TBL_ALIGN) * SGBUF_TBL_ALIGN)
+
+/*
+ * shrink to the given pages.
+ * free the unused pages
+ */
+static void sgbuf_shrink(struct snd_sg_buf *sgbuf, int pages)
+{
+	snd_assert(sgbuf, return);
+	if (! sgbuf->table)
+		return;
+	while (sgbuf->pages > pages) {
+		sgbuf->pages--;
+		snd_free_pci_pages(sgbuf->pci, PAGE_SIZE,
+				   sgbuf->table[sgbuf->pages].buf,
+				   sgbuf->table[sgbuf->pages].addr);
+	}
+}
+
+/*
+ * initialize the sg buffer
+ * assigned to substream->dma_private.
+ * initialize the table with the given size.
+ */
+int snd_pcm_sgbuf_init(snd_pcm_substream_t *substream, struct pci_dev *pci, int tblsize)
+{
+	struct snd_sg_buf *sgbuf;
+
+	tblsize = sgbuf_align_table(tblsize);
+	sgbuf = snd_magic_kcalloc(snd_pcm_sgbuf_t, 0, GFP_KERNEL);
+	if (! sgbuf)
+		return -ENOMEM;
+	substream->dma_private = sgbuf;
+	sgbuf->pci = pci;
+	sgbuf->pages = 0;
+	sgbuf->tblsize = tblsize;
+	sgbuf->table = kmalloc(sizeof(struct snd_sg_page) * tblsize, GFP_KERNEL);
+	if (! sgbuf->table) {
+		snd_pcm_sgbuf_free(substream);
+		return -ENOMEM;
+	}
+	memset(sgbuf->table, 0, sizeof(struct snd_sg_page) * tblsize);
+	return 0;
+}
+
+/*
+ * release all pages and free the sgbuf instance
+ */
+int snd_pcm_sgbuf_delete(snd_pcm_substream_t *substream)
+{
+	struct snd_sg_buf *sgbuf;
+
+	sgbuf = snd_magic_cast(snd_pcm_sgbuf_t, substream->dma_private, return -EINVAL);
+	sgbuf_shrink(sgbuf, 0);
+	if (sgbuf->table)
+		kfree(sgbuf->table);
+	snd_magic_kfree(sgbuf);
+	substream->dma_private = NULL;
+	return 0;
+}
+
+/*
+ * allocate sg buffer table with the given byte size.
+ * if the buffer table already exists, try to resize it.
+ * call this from hw_params callback.
+ */
+int snd_pcm_sgbuf_alloc(snd_pcm_substream_t *substream, size_t size)
+{
+	struct snd_sg_buf *sgbuf;
+	unsigned int pages;
+	unsigned int tblsize;
+	int changed = 0;
+
+	sgbuf = snd_magic_cast(snd_pcm_sgbuf_t, substream->dma_private, return -EINVAL);
+	pages = snd_pcm_sgbuf_pages(size);
+	tblsize = sgbuf_align_table(pages);
+	if (pages < sgbuf->pages) {
+		/* release unsed pages */
+		sgbuf_shrink(sgbuf, pages);
+		substream->runtime->dma_bytes = size;
+		return 1; /* changed */
+	} else if (pages > sgbuf->tblsize) {
+		/* bigger than existing one.  reallocate the table. */
+		struct snd_sg_page *table;
+		table = kmalloc(sizeof(*table) * tblsize, GFP_KERNEL);
+		if (! table)
+			return -ENOMEM;
+		memcpy(table, sgbuf->table, sizeof(*table) * sgbuf->tblsize);
+		kfree(sgbuf->table);
+		sgbuf->table = table;
+		sgbuf->tblsize = tblsize;
+	}
+	/* allocate each page */
+	while (sgbuf->pages < pages) {
+		void *ptr;
+		dma_addr_t addr;
+		ptr = snd_malloc_pci_pages(sgbuf->pci, PAGE_SIZE, &addr);
+		if (! ptr)
+			return -ENOMEM;
+		sgbuf->table[sgbuf->pages].buf = ptr;
+		sgbuf->table[sgbuf->pages].addr = addr;
+		sgbuf->pages++;
+		changed = 1;
+	}
+	sgbuf->size = size;
+	substream->runtime->dma_bytes = size;
+	return changed;
+}
+
+/*
+ * free the sg buffer
+ * the table is kept.
+ * call this from hw_free callback.
+ */
+int snd_pcm_sgbuf_free(snd_pcm_substream_t *substream)
+{
+	struct snd_sg_buf *sgbuf;
+
+	sgbuf = snd_magic_cast(snd_pcm_sgbuf_t, substream->dma_private, return -EINVAL);
+	sgbuf_shrink(sgbuf, 0);
+	return 0;
+}
+
+/*
+ * get the page pointer on the given offset
+ * used as the page callback of pcm ops
+ */
+void *snd_pcm_sgbuf_ops_page(snd_pcm_substream_t *substream, unsigned long offset)
+{
+	struct snd_sg_buf *sgbuf;
+	unsigned int idx;
+
+	sgbuf = snd_magic_cast(snd_pcm_sgbuf_t, substream->dma_private, return NULL);
+	idx = offset >> PAGE_SHIFT;
+	if (idx >= sgbuf->pages)
+		return 0;
+	return sgbuf->table[idx].buf;
+}
+
+/*
+ * do copy_from_user to the sg buffer
+ */
+static int copy_from_user_sg_buf(snd_pcm_substream_t *substream,
+				 char *buf, size_t hwoff, ssize_t bytes)
+{
+	int len;
+	char *addr;
+	size_t p = (hwoff >> PAGE_SHIFT) << PAGE_SHIFT;
+	hwoff -= p;
+	len = PAGE_SIZE - hwoff;
+	for (;;) {
+		addr = snd_pcm_sgbuf_ops_page(substream, p);
+		if (! addr)
+			return -EFAULT;
+		if (len > bytes)
+			len = bytes;
+		if (copy_from_user(addr + hwoff, buf, len))
+			return -EFAULT;
+		bytes -= len;
+		if (bytes <= 0)
+			break;
+		buf += len;
+		p += PAGE_SIZE;
+		len = PAGE_SIZE;
+		hwoff = 0;
+	}
+	return 0;
+}
+
+/*
+ * do copy_to_user from the sg buffer
+ */
+static int copy_to_user_sg_buf(snd_pcm_substream_t *substream,
+			       char *buf, size_t hwoff, ssize_t bytes)
+{
+	int len;
+	char *addr;
+	size_t p = (hwoff >> PAGE_SHIFT) << PAGE_SHIFT;
+	hwoff -= p;
+	len = PAGE_SIZE - hwoff;
+	for (;;) {
+		addr = snd_pcm_sgbuf_ops_page(substream, p);
+		if (! addr)
+			return -EFAULT;
+		if (len > bytes)
+			len = bytes;
+		if (copy_to_user(buf, addr + hwoff, len))
+			return -EFAULT;
+		bytes -= len;
+		if (bytes <= 0)
+			break;
+		buf += len;
+		p += PAGE_SIZE;
+		len = PAGE_SIZE;
+		hwoff = 0;
+	}
+	return 0;
+}
+
+/*
+ * set silence on the sg buffer
+ */
+static int set_silence_sg_buf(snd_pcm_substream_t *substream,
+			      size_t hwoff, ssize_t samples)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	int len, page_len;
+	char *addr;
+	size_t p = (hwoff >> PAGE_SHIFT) << PAGE_SHIFT;
+	hwoff -= p;
+	len = bytes_to_samples(substream->runtime, PAGE_SIZE - hwoff);
+	page_len = bytes_to_samples(substream->runtime, PAGE_SIZE);
+	for (;;) {
+		addr = snd_pcm_sgbuf_ops_page(substream, p);
+		if (! addr)
+			return -EFAULT;
+		if (len > samples)
+			len = samples;
+		snd_pcm_format_set_silence(runtime->format, addr + hwoff, len);
+		samples -= len;
+		if (samples <= 0)
+			break;
+		p += PAGE_SIZE;
+		len = page_len;
+		hwoff = 0;
+	}
+	return 0;
+}
+
+/*
+ * copy callback for playback pcm ops
+ */
+int snd_pcm_sgbuf_ops_copy_playback(snd_pcm_substream_t *substream, int channel,
+				    snd_pcm_uframes_t hwoff, void *buf, snd_pcm_uframes_t count)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	if (channel < 0) {
+		return copy_from_user_sg_buf(substream, buf, frames_to_bytes(runtime, hwoff), frames_to_bytes(runtime, count));
+	} else {
+		size_t dma_csize = runtime->dma_bytes / runtime->channels;
+		size_t c_ofs = (channel * dma_csize) + samples_to_bytes(runtime, hwoff);
+		return copy_from_user_sg_buf(substream, buf, c_ofs, samples_to_bytes(runtime, count));
+	}
+}
+
+/*
+ * copy callback for capture pcm ops
+ */
+int snd_pcm_sgbuf_ops_copy_capture(snd_pcm_substream_t *substream, int channel,
+				   snd_pcm_uframes_t hwoff, void *buf, snd_pcm_uframes_t count)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	if (channel < 0) {
+		return copy_to_user_sg_buf(substream, buf, frames_to_bytes(runtime, hwoff), frames_to_bytes(runtime, count));
+	} else {
+		size_t dma_csize = runtime->dma_bytes / runtime->channels;
+		size_t c_ofs = (channel * dma_csize) + samples_to_bytes(runtime, hwoff);
+		return copy_to_user_sg_buf(substream, buf, c_ofs, samples_to_bytes(runtime, count));
+	}
+}
+
+/*
+ * silence callback for pcm ops
+ */
+int snd_pcm_sgbuf_ops_silence(snd_pcm_substream_t *substream, int channel,
+			      snd_pcm_uframes_t hwoff, snd_pcm_uframes_t count)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	if (channel < 0) {
+		return set_silence_sg_buf(substream, frames_to_bytes(runtime, hwoff),
+					  frames_to_bytes(runtime, count));
+	} else {
+		size_t dma_csize = runtime->dma_bytes / runtime->channels;
+		size_t c_ofs = (channel * dma_csize) + samples_to_bytes(runtime, hwoff);
+		return set_silence_sg_buf(substream, c_ofs, samples_to_bytes(runtime, count));
+	}
+}
+
+
+/*
+ *  Exported symbols
+ */
+EXPORT_SYMBOL(snd_pcm_sgbuf_init);
+EXPORT_SYMBOL(snd_pcm_sgbuf_delete);
+EXPORT_SYMBOL(snd_pcm_sgbuf_alloc);
+EXPORT_SYMBOL(snd_pcm_sgbuf_free);
+EXPORT_SYMBOL(snd_pcm_sgbuf_ops_copy_playback);
+EXPORT_SYMBOL(snd_pcm_sgbuf_ops_copy_capture);
+EXPORT_SYMBOL(snd_pcm_sgbuf_ops_silence);
+EXPORT_SYMBOL(snd_pcm_sgbuf_ops_page);
diff -Nru a/sound/core/rtctimer.c b/sound/core/rtctimer.c
--- a/sound/core/rtctimer.c	Sun Sep 29 20:21:38 2002
+++ b/sound/core/rtctimer.c	Sun Sep 29 20:21:38 2002
@@ -23,6 +23,7 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/time.h>
+#include <linux/threads.h>
 #include <linux/interrupt.h>
 #include <sound/core.h>
 #include <sound/timer.h>
diff -Nru a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c	Sun Sep 29 20:21:38 2002
+++ b/sound/core/sound.c	Sun Sep 29 20:21:38 2002
@@ -501,6 +501,8 @@
 #ifdef CONFIG_SND_DEBUG_MEMORY
 EXPORT_SYMBOL(snd_wrapper_kmalloc);
 EXPORT_SYMBOL(snd_wrapper_kfree);
+EXPORT_SYMBOL(snd_wrapper_vmalloc);
+EXPORT_SYMBOL(snd_wrapper_vfree);
 #endif
 #ifdef HACK_PCI_ALLOC_CONSISTENT
 EXPORT_SYMBOL(snd_pci_hack_alloc_consistent);
diff -Nru a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
--- a/sound/isa/cs423x/cs4236.c	Sun Sep 29 20:21:38 2002
+++ b/sound/isa/cs423x/cs4236.c	Sun Sep 29 20:21:38 2002
@@ -227,6 +227,8 @@
 	ISAPNP_CS4232('C','S','C',0x4336,0x0000,0x0010,0x0003),
 	/* Typhoon Soundsystem PnP - CS4236B */
 	ISAPNP_CS4232('C','S','C',0x4536,0x0000,0x0010,0x0003),
+	/* Crystal CX4235-XQ3 EP - CS4235 */
+	ISAPNP_CS4232('C','S','C',0x4625,0x0100,0x0110,0x0103),
 	/* TerraTec AudioSystem EWS64XL - CS4236B */
 	ISAPNP_CS4232('C','S','C',0xa836,0xa800,0xa810,0xa803),
 	/* TerraTec AudioSystem EWS64XL - CS4236B */
diff -Nru a/sound/pci/Config.help b/sound/pci/Config.help
--- a/sound/pci/Config.help	Sun Sep 29 20:21:38 2002
+++ b/sound/pci/Config.help	Sun Sep 29 20:21:38 2002
@@ -7,6 +7,10 @@
 
 CONFIG_SND_CS46XX_ACCEPT_VALID
   Say 'Y' to allow sample resolution for mmap() transfers.
+  Note: This can be also specified via module option snd_mmap_valid.
+
+CONFIG_SND_CS4281
+  Say 'Y' or 'M' to include support for Cirrus Logic CS4281.
 
 CONFIG_SND_EMU10K1
   Say 'Y' or 'M' to include support for Sound Blaster PCI 512, Live!,
diff -Nru a/sound/pci/Config.in b/sound/pci/Config.in
--- a/sound/pci/Config.in	Sun Sep 29 20:21:38 2002
+++ b/sound/pci/Config.in	Sun Sep 29 20:21:38 2002
@@ -8,7 +8,7 @@
 if [ "$CONFIG_SND_CS46XX" != "n" ]; then
   bool       '  Cirrus Logic (Sound Fusion) MMAP support for OSS' CONFIG_SND_CS46XX_ACCEPT_VALID
 fi
-dep_tristate 'Cirrus Logic (Sound Fusion) CS4281' CONFIG_SND_CS4281 $CONFIG_SND
+dep_tristate 'Cirrus Logic CS4281' CONFIG_SND_CS4281 $CONFIG_SND
 dep_tristate 'EMU10K1 (SB Live!, E-mu APS)' CONFIG_SND_EMU10K1 $CONFIG_SND
 dep_tristate 'Korg 1212 IO' CONFIG_SND_KORG1212 $CONFIG_SND
 dep_tristate 'NeoMagic NM256AV/ZX' CONFIG_SND_NM256 $CONFIG_SND
diff -Nru a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
--- a/sound/pci/emu10k1/emupcm.c	Sun Sep 29 20:21:38 2002
+++ b/sound/pci/emu10k1/emupcm.c	Sun Sep 29 20:21:38 2002
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <sound/core.h>
 #include <sound/emu10k1.h>
+#include <sound/pcm_sgbuf.h>
 
 #define chip_t emu10k1_t
 
@@ -358,13 +359,13 @@
 
 	if ((err = snd_emu10k1_pcm_channel_alloc(epcm, params_channels(hw_params))) < 0)
 		return err;
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
+	if ((err = snd_pcm_sgbuf_alloc(substream, params_buffer_bytes(hw_params))) < 0)
 		return err;
 	if (err > 0) {	/* change */
 		snd_util_memblk_t *memblk;
 		if (epcm->memblk != NULL)
 			snd_emu10k1_free_pages(emu, epcm->memblk);
-		memblk = snd_emu10k1_alloc_pages(emu, runtime->dma_addr, runtime->dma_bytes);
+		memblk = snd_emu10k1_alloc_pages(emu, (struct snd_sg_buf *)substream->dma_private);
 		if ((epcm->memblk = memblk) == NULL || ((emu10k1_memblk_t *)memblk)->mapped_page < 0) {
 			epcm->start_addr = 0;
 			return -ENOMEM;
@@ -400,7 +401,7 @@
 		epcm->memblk = NULL;
 		epcm->start_addr = 0;
 	}
-	snd_pcm_lib_free_pages(substream);
+	snd_pcm_sgbuf_free(substream);
 	return 0;
 }
 
@@ -778,6 +779,10 @@
 	runtime->private_data = epcm;
 	runtime->private_free = snd_emu10k1_pcm_free_substream;
 	runtime->hw = snd_emu10k1_playback;
+	if ((err = snd_pcm_sgbuf_init(substream, emu->pci, 32)) < 0) {
+		snd_magic_kfree(epcm);
+		return err;
+	}
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0) {
 		snd_magic_kfree(epcm);
 		return err;
@@ -804,6 +809,7 @@
 	emu10k1_pcm_mixer_t *mix = &emu->pcm_mixer[substream->number];
 
 	mix->epcm = NULL;
+	snd_pcm_sgbuf_delete(substream);
 	snd_emu10k1_pcm_mixer_notify(emu->card, mix, 0);
 	return 0;
 }
@@ -942,6 +948,9 @@
 	prepare:		snd_emu10k1_playback_prepare,
 	trigger:		snd_emu10k1_playback_trigger,
 	pointer:		snd_emu10k1_playback_pointer,
+	copy:			snd_pcm_sgbuf_ops_copy_playback,
+	silence:		snd_pcm_sgbuf_ops_silence,
+	page:			snd_pcm_sgbuf_ops_page,
 };
 
 static snd_pcm_ops_t snd_emu10k1_capture_ops = {
@@ -959,7 +968,6 @@
 {
 	emu10k1_t *emu = snd_magic_cast(emu10k1_t, pcm->private_data, return);
 	emu->pcm = NULL;
-	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
 int __devinit snd_emu10k1_pcm(emu10k1_t * emu, int device, snd_pcm_t ** rpcm)
@@ -983,8 +991,6 @@
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
 	strcpy(pcm->name, "EMU10K1");
 	emu->pcm = pcm;
-
-	snd_pcm_lib_preallocate_pci_pages_for_all(emu->pci, pcm, 64*1024, 128*1024);
 
 	if (rpcm)
 		*rpcm = pcm;
diff -Nru a/sound/pci/emu10k1/memory.c b/sound/pci/emu10k1/memory.c
--- a/sound/pci/emu10k1/memory.c	Sun Sep 29 20:21:38 2002
+++ b/sound/pci/emu10k1/memory.c	Sun Sep 29 20:21:38 2002
@@ -289,22 +289,19 @@
  * page allocation for DMA
  */
 snd_util_memblk_t *
-snd_emu10k1_alloc_pages(emu10k1_t *emu, dma_addr_t addr, unsigned long size)
+snd_emu10k1_alloc_pages(emu10k1_t *emu, struct snd_sg_buf *sgbuf)
 {
 	snd_util_memhdr_t *hdr;
 	emu10k1_memblk_t *blk;
-	int page, err;
+	int page, err, idx;
 
 	snd_assert(emu, return NULL);
-	snd_assert(size > 0 && size < MAXPAGES * EMUPAGESIZE, return NULL);
+	snd_assert(sgbuf->size > 0 && sgbuf->size < MAXPAGES * EMUPAGESIZE, return NULL);
 	hdr = emu->memhdr;
 	snd_assert(hdr, return NULL);
 
-	if (!is_valid_page(addr))
-		return NULL;
-
 	down(&hdr->block_mutex);
-	blk = search_empty(emu, size);
+	blk = search_empty(emu, sgbuf->size);
 	if (blk == NULL) {
 		up(&hdr->block_mutex);
 		return NULL;
@@ -312,10 +309,15 @@
 	/* fill buffer addresses but pointers are not stored so that
 	 * snd_free_pci_pages() is not called in in synth_free()
 	 */
-	for (page = blk->first_page; page <= blk->last_page; page++) {
+	idx = 0;
+	for (page = blk->first_page; page <= blk->last_page; page++, idx++) {
+		dma_addr_t addr = sgbuf->table[idx].addr;
+		if (! is_valid_page(addr)) {
+			up(&hdr->block_mutex);
+			return NULL;
+		}
 		emu->page_addr_table[page] = addr;
 		emu->page_ptr_table[page] = NULL;
-		addr += PAGE_SIZE;
 	}
 
 	/* set PTB entries */
diff -Nru a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
--- a/sound/pci/rme9652/hdsp.c	Sun Sep 29 20:21:38 2002
+++ b/sound/pci/rme9652/hdsp.c	Sun Sep 29 20:21:38 2002
@@ -482,7 +482,6 @@
 	if (hdsp_fifo_wait(hdsp, 127, HDSP_LONG_WAIT)) {
 		return -1;
 	}
-	
 	hdsp_write (hdsp, HDSP_fifoData, ad);
 	hdsp->mixer_matrix[addr] = data;
 
@@ -854,10 +853,7 @@
 		}
 
 		if (clear_timer && hmidi->istimer && --hmidi->istimer <= 0) {
-			printk ("removing timer because there is nothing to do\n");
-			if (del_timer(&hmidi->timer)) {
-				printk ("not removed\n");
-			}
+			del_timer(&hmidi->timer);
 		} 
 	}
 
@@ -956,16 +952,12 @@
 			hmidi->timer.function = snd_hdsp_midi_output_timer;
 			hmidi->timer.data = (unsigned long) hmidi;
 			hmidi->timer.expires = 1 + jiffies;
-			printk ("add timer from output trigger\n");
 			add_timer(&hmidi->timer);
 			hmidi->istimer++;
 		}
 	} else {
 		if (hmidi->istimer && --hmidi->istimer <= 0) {
-			printk ("remove timer in trigger off\n");
-			if (del_timer (&hmidi->timer)) {
-				printk ("not removed\n");
-			}
+			del_timer (&hmidi->timer);
 		}
 	}
 	spin_unlock_irqrestore (&hmidi->lock, flags);
@@ -2560,7 +2552,7 @@
 				 SNDRV_PCM_INFO_SYNC_START |
 				 SNDRV_PCM_INFO_DOUBLE),
 	formats:		SNDRV_PCM_FMTBIT_S32_LE,
-	rates:			(SNDRV_PCM_RATE_32000 | 
+	rates:			(SNDRV_PCM_RATE_32000 |
 				 SNDRV_PCM_RATE_44100 | 
 				 SNDRV_PCM_RATE_48000 | 
 				 SNDRV_PCM_RATE_64000 | 
@@ -2635,7 +2627,7 @@
 			integer: 1,
 		};
 		return snd_interval_refine(c, &t);
-	} else if (r->max < 88200) {
+	} else if (r->max < 64000) {
 		snd_interval_t t = {
 			min: hdsp->ss_channels,
 			max: hdsp->ss_channels,
@@ -2654,14 +2646,14 @@
 	snd_interval_t *r = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	if (c->min >= hdsp->ss_channels) {
 		snd_interval_t t = {
-			min: 44100,
+			min: 32000,
 			max: 48000,
 			integer: 1,
 		};
 		return snd_interval_refine(r, &t);
 	} else if (c->max <= hdsp->ds_channels) {
 		snd_interval_t t = {
-			min: 88200,
+			min: 64000,
 			max: 96000,
 			integer: 1,
 		};
diff -Nru a/sound/pci/via686.c b/sound/pci/via686.c
--- a/sound/pci/via686.c	Sun Sep 29 20:21:38 2002
+++ b/sound/pci/via686.c	Sun Sep 29 20:21:38 2002
@@ -28,6 +28,8 @@
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <sound/pcm_sgbuf.h>
+#include <sound/pcm_params.h>
 #include <sound/info.h>
 #include <sound/ac97_codec.h>
 #include <sound/mpu401.h>
@@ -135,29 +137,92 @@
 #define   VIA_REG_AC97_DATA_MASK	0xffff
 #define VIA_REG_SGD_SHADOW		0x84	/* dword */
 
-/*
- *
- */
-
-#define VIA_MAX_FRAGS			32
+#define VIA_TBL_BIT_FLAG	0x40000000
+#define VIA_TBL_BIT_EOL		0x80000000
 
 /*
- *  
+ * pcm stream
  */
 
 typedef struct {
 	unsigned long reg_offset;
-	unsigned int *table;
-	dma_addr_t table_addr;
         snd_pcm_substream_t *substream;
-	dma_addr_t physbuf;
+	int running;
         unsigned int size;
         unsigned int fragsize;
 	unsigned int frags;
 	unsigned int lastptr;
 	unsigned int lastcount;
+	unsigned int page_per_frag;
+	unsigned int curidx;
+	unsigned int tbl_entries;	/* number of descriptor table entries */
+	unsigned int tbl_size;		/* size of a table entry */
+	u32 *table; /* physical address + flag */
+	dma_addr_t table_addr;
 } viadev_t;
 
+
+static int build_via_table(viadev_t *dev, snd_pcm_substream_t *substream,
+			   struct pci_dev *pci)
+{
+	int i, pages, size;
+	struct snd_sg_buf *sgbuf = snd_magic_cast(snd_pcm_sgbuf_t, substream->dma_private, return -EINVAL);
+
+	if (dev->table) {
+		pages = snd_pcm_sgbuf_pages(dev->tbl_entries * 8);
+		snd_free_pci_pages(pci, pages << PAGE_SHIFT, dev->table, dev->table_addr);
+		dev->table = NULL;
+	}
+
+	/* allocate buffer descriptor lists */
+	if (dev->fragsize < PAGE_SIZE) {
+		dev->tbl_size = dev->fragsize;
+		dev->tbl_entries = dev->frags;
+		dev->page_per_frag = 1;
+	} else {
+		dev->tbl_size = PAGE_SIZE;
+		dev->tbl_entries = sgbuf->pages;
+		dev->page_per_frag = dev->fragsize >> PAGE_SHIFT;
+	}
+	/* the start of each lists must be aligned to 8 bytes,
+	 * but the kernel pages are much bigger, so we don't care
+	 */
+	pages = snd_pcm_sgbuf_pages(dev->tbl_entries * 8);
+	dev->table = (u32*)snd_malloc_pci_pages(pci, pages << PAGE_SHIFT, &dev->table_addr);
+	if (! dev->table)
+		return -ENOMEM;
+
+	if (dev->tbl_size < PAGE_SIZE) {
+		for (i = 0; i < dev->tbl_entries; i++)
+			dev->table[i << 1] = cpu_to_le32((u32)sgbuf->table[0].addr + dev->fragsize * i);
+	} else {
+		for (i = 0; i < dev->tbl_entries; i++)
+			dev->table[i << 1] = cpu_to_le32((u32)sgbuf->table[i].addr);
+	}
+	size = dev->size;
+	for (i = 0; i < dev->tbl_entries - 1; i++) {
+		dev->table[(i << 1) + 1] = cpu_to_le32(VIA_TBL_BIT_FLAG | dev->tbl_size);
+		size -= dev->tbl_size;
+	}
+	dev->table[(dev->tbl_entries << 1) - 1] = cpu_to_le32(VIA_TBL_BIT_EOL | size);
+
+	return 0;
+}
+
+
+static void clean_via_table(viadev_t *dev, snd_pcm_substream_t *substream,
+			    struct pci_dev *pci)
+{
+	if (dev->table) {
+		snd_free_pci_pages(pci, snd_pcm_sgbuf_pages(dev->tbl_entries * 8) << PAGE_SHIFT, dev->table, dev->table_addr);
+		dev->table = NULL;
+	}
+}
+
+
+/*
+ */
+
 typedef struct _snd_via686a via686a_t;
 #define chip_t via686a_t
 
@@ -178,7 +243,7 @@
 	snd_pcm_t *pcm_fm;
 	viadev_t playback;
 	viadev_t capture;
-	viadev_t playback_fm;
+	/*viadev_t playback_fm;*/
 
 	snd_rawmidi_t *rmidi;
 
@@ -188,9 +253,6 @@
 
 	spinlock_t reg_lock;
 	snd_info_entry_t *proc_entry;
-
-	void *tables;
-	dma_addr_t tables_addr;
 };
 
 static struct pci_device_id snd_via686a_ids[] __devinitdata = {
@@ -336,15 +398,19 @@
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		val = VIA_REG_CTRL_START;
+		viadev->running = 1;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		val = VIA_REG_CTRL_TERMINATE | VIA_REG_CTRL_RESET;
+		viadev->running = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		val = VIA_REG_CTRL_PAUSE;
+		viadev->running = 1;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		val = 0;
+		viadev->running = 0;
 		break;
 	default:
 		return -EINVAL;
@@ -355,44 +421,43 @@
 	return 0;
 }
 
-static void snd_via686a_setup_periods(via686a_t *chip, viadev_t *viadev,
+
+static int snd_via686a_setup_periods(via686a_t *chip, viadev_t *viadev,
 				      snd_pcm_substream_t *substream)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	int idx, frags;
-	unsigned int *table = viadev->table;
 	unsigned long port = chip->port + viadev->reg_offset;
+	int v, err;
 
-	viadev->physbuf = runtime->dma_addr;
 	viadev->size = snd_pcm_lib_buffer_bytes(substream);
 	viadev->fragsize = snd_pcm_lib_period_bytes(substream);
 	viadev->frags = runtime->periods;
 	viadev->lastptr = ~0;
 	viadev->lastcount = ~0;
+	viadev->curidx = 0;
+
+	/* the period size must be in power of 2 */
+	v = ld2(viadev->fragsize);
+	if (viadev->fragsize != (1 << v)) {
+		snd_printd(KERN_ERR "invalid fragment size %d\n", viadev->fragsize);
+		return -EINVAL;
+	}
 
 	snd_via686a_channel_reset(chip, viadev);
-	outl(viadev->table_addr, port + VIA_REG_OFFSET_TABLE_PTR);
+
+	err = build_via_table(viadev, substream, chip->pci);
+	if (err < 0)
+		return err;
+
+	runtime->dma_bytes = viadev->size;
+	outl((u32)viadev->table_addr, port + VIA_REG_OFFSET_TABLE_PTR);
 	outb(VIA_REG_TYPE_AUTOSTART |
 	     (runtime->format == SNDRV_PCM_FORMAT_S16_LE ? VIA_REG_TYPE_16BIT : 0) |
 	     (runtime->channels > 1 ? VIA_REG_TYPE_STEREO : 0) |
 	     ((viadev->reg_offset & 0x10) == 0 ? VIA_REG_TYPE_INT_LSAMPLE : 0) |
 	     VIA_REG_TYPE_INT_EOL |
 	     VIA_REG_TYPE_INT_FLAG, port + VIA_REG_OFFSET_TYPE);
-	if (viadev->size == viadev->fragsize) {
-		table[0] = cpu_to_le32(viadev->physbuf);
-		table[1] = cpu_to_le32(0xc0000000 | /* EOL + flag */
-				       viadev->fragsize);
-	} else {
-		frags = viadev->size / viadev->fragsize;
-		for (idx = 0; idx < frags - 1; idx++) {
-			table[(idx << 1) + 0] = cpu_to_le32(viadev->physbuf + (idx * viadev->fragsize));
-			table[(idx << 1) + 1] = cpu_to_le32(0x40000000 |	/* flag */
-							    viadev->fragsize);
-		}
-		table[((frags-1) << 1) + 0] = cpu_to_le32(viadev->physbuf + ((frags-1) * viadev->fragsize));
-		table[((frags-1) << 1) + 1] = cpu_to_le32(0x80000000 |	/* EOL */
-							  viadev->fragsize);
-	}
+	return 0;
 }
 
 /*
@@ -401,8 +466,16 @@
 
 static inline void snd_via686a_update(via686a_t *chip, viadev_t *viadev)
 {
-	snd_pcm_period_elapsed(viadev->substream);
 	outb(VIA_REG_STAT_FLAG | VIA_REG_STAT_EOL, VIAREG(chip, OFFSET_STATUS) + viadev->reg_offset);
+	if (viadev->substream && viadev->running) {
+		viadev->curidx++;
+		if (viadev->curidx >= viadev->page_per_frag) {
+			viadev->curidx = 0;
+			spin_unlock(&chip->reg_lock);
+			snd_pcm_period_elapsed(viadev->substream);
+			spin_lock(&chip->reg_lock);
+		}
+	}
 }
 
 static void snd_via686a_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -410,8 +483,10 @@
 	via686a_t *chip = snd_magic_cast(via686a_t, dev_id, return);
 	unsigned int status;
 
+	spin_lock(&chip->reg_lock);
 	status = inl(VIAREG(chip, SGD_SHADOW));
 	if ((status & 0x00000077) == 0) {
+		spin_unlock(&chip->reg_lock);
 		if (chip->rmidi != NULL) {
 			snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data, regs);
 		}
@@ -419,10 +494,11 @@
 	}
 	if (inb(VIAREG(chip, PLAYBACK_STATUS)) & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG))
 		snd_via686a_update(chip, &chip->playback);
-	if (inb(VIAREG(chip, FM_STATUS)) & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG))
-		snd_via686a_update(chip, &chip->playback_fm);
 	if (inb(VIAREG(chip, CAPTURE_STATUS)) & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG))
 		snd_via686a_update(chip, &chip->capture);
+	/*if (inb(VIAREG(chip, FM_STATUS)) & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG))
+	  snd_via686a_update(chip, &chip->playback_fm);*/
+	spin_unlock(&chip->reg_lock);
 }
 
 /*
@@ -448,12 +524,12 @@
 static int snd_via686a_hw_params(snd_pcm_substream_t * substream,
 				 snd_pcm_hw_params_t * hw_params)
 {
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+	return snd_pcm_sgbuf_alloc(substream, params_buffer_bytes(hw_params));
 }
 
 static int snd_via686a_hw_free(snd_pcm_substream_t * substream)
 {
-	return snd_pcm_lib_free_pages(substream);
+	return 0;
 }
 
 static int snd_via686a_playback_prepare(snd_pcm_substream_t * substream)
@@ -462,8 +538,7 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
 	snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE, runtime->rate);
-	snd_via686a_setup_periods(chip, &chip->playback, substream);
-	return 0;
+	return snd_via686a_setup_periods(chip, &chip->playback, substream);
 }
 
 static int snd_via686a_capture_prepare(snd_pcm_substream_t * substream)
@@ -472,8 +547,7 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 
 	snd_ac97_set_rate(chip->ac97, AC97_PCM_LR_ADC_RATE, runtime->rate);
-	snd_via686a_setup_periods(chip, &chip->capture, substream);
-	return 0;
+	return snd_via686a_setup_periods(chip, &chip->capture, substream);
 }
 
 static inline unsigned int snd_via686a_cur_ptr(via686a_t *chip, viadev_t *viadev)
@@ -486,9 +560,14 @@
 		ptr += 8;
 	if (!(inb(VIAREG(chip, OFFSET_STATUS) + viadev->reg_offset) & VIA_REG_STAT_ACTIVE))
 		return 0;
-	val = (((unsigned int)(ptr - viadev->table_addr) / 8) - 1) % viadev->frags;
-	val *= viadev->fragsize;
-	val += viadev->fragsize - count;
+	snd_assert(viadev->tbl_entries, return 0);
+	/* get index */
+	if (ptr <= (unsigned int)viadev->table_addr)
+		val = 0;
+	else
+		val = ((ptr - (unsigned int)viadev->table_addr) / 8 - 1) % viadev->tbl_entries;
+	val *= viadev->tbl_size;
+	val += viadev->tbl_size - count;
 	viadev->lastptr = ptr;
 	viadev->lastcount = count;
 	// printk("pointer: ptr = 0x%x (%i), count = 0x%x, val = 0x%x\n", ptr, count, val);
@@ -522,8 +601,8 @@
 	buffer_bytes_max:	128 * 1024,
 	period_bytes_min:	32,
 	period_bytes_max:	128 * 1024,
-	periods_min:		1,
-	periods_max:		VIA_MAX_FRAGS,
+	periods_min:		2,
+	periods_max:		1024,
 	fifo_size:		0,
 };
 
@@ -541,8 +620,8 @@
 	buffer_bytes_max:	128 * 1024,
 	period_bytes_min:	32,
 	period_bytes_max:	128 * 1024,
-	periods_min:		1,
-	periods_max:		VIA_MAX_FRAGS,
+	periods_min:		2,
+	periods_max:		1024,
 	fifo_size:		0,
 };
 
@@ -555,10 +634,20 @@
 	chip->playback.substream = substream;
 	runtime->hw = snd_via686a_playback;
 	runtime->hw.rates = chip->ac97->rates_front_dac;
+	if ((err = snd_pcm_sgbuf_init(substream, chip->pci, 32)) < 0)
+		return err;
 	if (!(runtime->hw.rates & SNDRV_PCM_RATE_8000))
 		runtime->hw.rate_min = 48000;
+	if ((err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES)) < 0)
+		return err;
+#if 0
+	/* applying the following constraint together with the power-of-2 rule
+	 * above may result in too narrow space.
+	 * this one is not strictly necessary, so let's disable it.
+	 */
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
 		return err;
+#endif
 	return 0;
 }
 
@@ -571,10 +660,16 @@
 	chip->capture.substream = substream;
 	runtime->hw = snd_via686a_capture;
 	runtime->hw.rates = chip->ac97->rates_adc;
+	if ((err = snd_pcm_sgbuf_init(substream, chip->pci, 32)) < 0)
+		return err;
 	if (!(runtime->hw.rates & SNDRV_PCM_RATE_8000))
 		runtime->hw.rate_min = 48000;
+	if ((err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES)) < 0)
+		return err;
+#if 0
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
 		return err;
+#endif
 	return 0;
 }
 
@@ -582,6 +677,8 @@
 {
 	via686a_t *chip = snd_pcm_substream_chip(substream);
 
+	clean_via_table(&chip->playback, substream, chip->pci);
+	snd_pcm_sgbuf_delete(substream);
 	chip->playback.substream = NULL;
 	/* disable DAC power */
 	snd_ac97_update_bits(chip->ac97, AC97_POWERDOWN, 0x0200, 0x0200);
@@ -592,6 +689,8 @@
 {
 	via686a_t *chip = snd_pcm_substream_chip(substream);
 
+	clean_via_table(&chip->capture, substream, chip->pci);
+	snd_pcm_sgbuf_delete(substream);
 	chip->capture.substream = NULL;
 	/* disable ADC power */
 	snd_ac97_update_bits(chip->ac97, AC97_POWERDOWN, 0x0100, 0x0100);
@@ -607,6 +706,9 @@
 	prepare:	snd_via686a_playback_prepare,
 	trigger:	snd_via686a_playback_trigger,
 	pointer:	snd_via686a_playback_pointer,
+	copy:           snd_pcm_sgbuf_ops_copy_playback,
+	silence:        snd_pcm_sgbuf_ops_silence,
+	page:           snd_pcm_sgbuf_ops_page,
 };
 
 static snd_pcm_ops_t snd_via686a_capture_ops = {
@@ -618,13 +720,15 @@
 	prepare:	snd_via686a_capture_prepare,
 	trigger:	snd_via686a_capture_trigger,
 	pointer:	snd_via686a_capture_pointer,
+	copy:           snd_pcm_sgbuf_ops_copy_capture,
+	silence:        snd_pcm_sgbuf_ops_silence,
+	page:           snd_pcm_sgbuf_ops_page,
 };
 
 static void snd_via686a_pcm_free(snd_pcm_t *pcm)
 {
 	via686a_t *chip = snd_magic_cast(via686a_t, pcm->private_data, return);
 	chip->pcm = NULL;
-	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
 
 static int __devinit snd_via686a_pcm(via686a_t *chip, int device, snd_pcm_t ** rpcm)
@@ -647,146 +751,11 @@
 	strcpy(pcm->name, "VIA 82C686A");
 	chip->pcm = pcm;
 
-	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 128*1024);
-
 	if (rpcm)
 		*rpcm = NULL;
 	return 0;
 }
 
-#if 0
-
-/*
- *  PCM code - FM channel
- */
-
-static int snd_via686a_playback_fm_ioctl(snd_pcm_substream_t * substream,
-					 unsigned int cmd,
-					 void *arg)
-{
-	return snd_pcm_lib_ioctl(substream, cmd, arg);
-}
-
-static int snd_via686a_playback_fm_trigger(snd_pcm_substream_t * substream,
-					   int cmd)
-{
-	via686a_t *chip = snd_pcm_substream_chip(substream);
-
-	return snd_via686a_trigger(chip, &chip->playback_fm, cmd);
-}
-
-static int snd_via686a_playback_fm_prepare(snd_pcm_substream_t * substream)
-{
-	via686a_t *chip = snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-
-	snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE, runtime->rate);
-	snd_via686a_setup_periods(chip, &chip->playback_fm, substream);
-	return 0;
-}
-
-static snd_pcm_uframes_t snd_via686a_playback_fm_pointer(snd_pcm_substream_t * substream)
-{
-	via686a_t *chip = snd_pcm_substream_chip(substream);
-	return bytes_to_frames(substream->runtime, snd_via686a_cur_ptr(chip, &chip->playback_fm));
-}
-
-static snd_pcm_hardware_t snd_via686a_playback_fm =
-{
-	info:			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
-				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-				 SNDRV_PCM_INFO_MMAP_VALID |
-				 SNDRV_PCM_INFO_PAUSE),
-	formats:		SNDRV_PCM_FMTBIT_S16_LE,
-	rates:			SNDRV_PCM_RATE_KNOT,
-	rate_min:		24000,
-	rate_max:		24000,
-	channels_min:		2,
-	channels_max:		2,
-	buffer_bytes_max:	128 * 1024,
-	period_bytes_min:	32,
-	period_bytes_max:	128 * 1024,
-	periods_min:		1,
-	periods_max:		VIA_MAX_FRAGS,
-	fifo_size:		0,
-};
-
-static int snd_via686a_playback_fm_open(snd_pcm_substream_t * substream)
-{
-	via686a_t *chip = snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	int err;
-
-	if ((runtime->dma_area = snd_malloc_pci_pages_fallback(chip->pci, chip->dma_fm_size, &runtime->dma_addr, &runtime->dma_bytes)) == NULL)
-		return -ENOMEM;
-	chip->playback_fm.substream = substream;
-	runtime->hw = snd_via686a_playback_fm;
-#if 0
-	runtime->hw.rates = chip->ac97->rates_front_dac;
-	if (!(runtime->hw.rates & SNDRV_PCM_RATE_8000))
-		runtime->hw.min_rate = 48000;
-#endif
-	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
-		return err;
-	return 0;
-}
-
-static int snd_via686a_playback_fm_close(snd_pcm_substream_t * substream)
-{
-	via686a_t *chip = snd_pcm_substream_chip(substream);
-	snd_pcm_runtime_t *runtime = substream->runtime;
-
-	chip->playback_fm.substream = NULL;
-	snd_free_pci_pages(chip->pci, runtime->dma_bytes, runtime->dma_area, runtime->dma_addr);
-	/* disable DAC power */
-	snd_ac97_update_bits(chip->ac97, AC97_POWERDOWN, 0x0200, 0x0200);
-	return 0;
-}
-
-static snd_pcm_ops_t snd_via686a_playback_fm_ops = {
-	open:		snd_via686a_playback_fm_open,
-	close:		snd_via686a_playback_fm_close,
-	ioctl:		snd_pcm_lib_ioctl,
-	prepare:	snd_via686a_playback_fm_prepare,
-	trigger:	snd_via686a_playback_fm_trigger,
-	pointer:	snd_via686a_playback_fm_pointer,
-};
-
-static void snd_via686a_pcm_fm_free(void *private_data)
-{
-	via686a_t *chip = snd_magic_cast(via686a_t, private_data, return);
-	chip->pcm_fm = NULL;
-	snd_pcm_lib_preallocate_pci_free_for_all(ensoniq->pci, pcm);
-}
-
-static int __devinit snd_via686a_pcm_fm(via686a_t *chip, int device, snd_pcm_t ** rpcm)
-{
-	snd_pcm_t *pcm;
-	int err;
-
-	if (rpcm)
-		*rpcm = NULL;
-	err = snd_pcm_new(chip->card, "VIA 82C686A - FM DAC", device, 1, 0, &pcm);
-	if (err < 0)
-		return err;
-
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_via686a_playback_fm_ops);
-
-	pcm->private_data = chip;
-	pcm->private_free = snd_via686a_pcm_fm_free;
-	pcm->info_flags = 0;
-	strcpy(pcm->name, "VIA 82C686A - FM DAC");
-
-	snd_pcm_add_buffer_bytes_controls(pcm);
-	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024);
-
-	chip->pcm_fm = pcm;
-	if (rpcm)
-		*rpcm = NULL;
-	return 0;
-}
-
-#endif
 
 /*
  *  Mixer part
@@ -979,7 +948,7 @@
 	/* disable interrupts */
 	snd_via686a_channel_reset(chip, &chip->playback);
 	snd_via686a_channel_reset(chip, &chip->capture);
-	snd_via686a_channel_reset(chip, &chip->playback_fm);
+	/*snd_via686a_channel_reset(chip, &chip->playback_fm);*/
 	return 0;
 }
 
@@ -990,13 +959,10 @@
 	/* disable interrupts */
 	snd_via686a_channel_reset(chip, &chip->playback);
 	snd_via686a_channel_reset(chip, &chip->capture);
-	snd_via686a_channel_reset(chip, &chip->playback_fm);
+	/*snd_via686a_channel_reset(chip, &chip->playback_fm);*/
 	/* --- */
+	synchronize_irq(chip->irq);
       __end_hw:
-	if(chip->irq >= 0)
-		synchronize_irq(chip->irq);
-	if (chip->tables)
-		snd_free_pci_pages(chip->pci, 3 * sizeof(unsigned int) * VIA_MAX_FRAGS * 2, chip->tables, chip->tables_addr);
 	if (chip->res_port) {
 		release_resource(chip->res_port);
 		kfree_nocheck(chip->res_port);
@@ -1061,23 +1027,7 @@
 	/* initialize offsets */
 	chip->playback.reg_offset = VIA_REG_PLAYBACK_STATUS;
 	chip->capture.reg_offset = VIA_REG_CAPTURE_STATUS;
-	chip->playback_fm.reg_offset = VIA_REG_FM_STATUS;
-
-	/* allocate buffer descriptor lists */
-	/* the start of each lists must be aligned to 8 bytes */
-	chip->tables = (unsigned int *)snd_malloc_pci_pages(pci, 3 * sizeof(unsigned int) * VIA_MAX_FRAGS * 2, &chip->tables_addr);
-	if (chip->tables == NULL) {
-		snd_via686a_free(chip);
-		return -ENOMEM;
-	}
-	/* tables must be aligned to 8 bytes, but the kernel pages
-	   are much bigger, so we don't care */
-	chip->playback.table = chip->tables;
-	chip->playback.table_addr = chip->tables_addr;
-	chip->capture.table = chip->playback.table + VIA_MAX_FRAGS * 2;
-	chip->capture.table_addr = chip->playback.table_addr + sizeof(unsigned int) * VIA_MAX_FRAGS * 2;
-	chip->playback_fm.table = chip->capture.table + VIA_MAX_FRAGS * 2;
-	chip->playback_fm.table_addr = chip->capture.table_addr + sizeof(unsigned int) * VIA_MAX_FRAGS * 2;
+	/*chip->playback_fm.reg_offset = VIA_REG_FM_STATUS;*/
 
 	if ((err = snd_via686a_chip_init(chip)) < 0) {
 		snd_via686a_free(chip);

===================================================================


This BitKeeper patch contains the following changesets:
1.605.2.17
## Wrapped with gzip_uu ##


begin 664 bkpatch2473
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
C%5/[RMK:#^(,@?&"OC0;S,>_6%!Q:.W7U_X&5>+/!N:&````
`
end

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

