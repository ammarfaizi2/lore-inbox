Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267759AbUJOMix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267759AbUJOMix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 08:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUJOMih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 08:38:37 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:36581 "EHLO
	holub.nextsoft.cz") by vger.kernel.org with ESMTP id S267759AbUJOMfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 08:35:01 -0400
From: Michal Rokos <michal@rokos.info>
To: linux-sound@vger.kernel.org
Subject: [Patch 2.6] Sound - Exclude uneeded code when ! CONFIG_PROC_FS
Date: Fri, 15 Oct 2004 14:34:53 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410151434.53766.michal@rokos.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried to compile without procfs support and I got few "unused code" 
warnings.

This patch fixes it.

Tested by compilation only. (With CONFIG_PROC_FS on and off)

Michal

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/15 13:21:56+02:00 michal@nb-rokos.nx.cz 
#   Exclude /proc related code when ! CONFIG_PROC_FS.
# 
# sound/pci/ac97/ac97_local.h
#   2004/10/15 13:21:41+02:00 michal@nb-rokos.nx.cz +7 -0
#   Exclude /proc related code when ! CONFIG_PROC_FS.
# 
# sound/pci/ac97/Makefile
#   2004/10/15 13:21:41+02:00 michal@nb-rokos.nx.cz +6 -1
#   Exclude /proc related code when ! CONFIG_PROC_FS.
# 
# sound/core/pcm.c
#   2004/10/15 13:21:41+02:00 michal@nb-rokos.nx.cz +15 -3
#   Exclude /proc related code when ! CONFIG_PROC_FS.
# 
diff -Nru a/sound/core/pcm.c b/sound/core/pcm.c
--- a/sound/core/pcm.c 2004-10-15 14:25:13 +02:00
+++ b/sound/core/pcm.c 2004-10-15 14:25:13 +02:00
@@ -267,7 +267,7 @@
 }
 #endif
 
-
+#ifdef CONFIG_PROC_FS
 static void snd_pcm_proc_info_read(snd_pcm_substream_t *substream, 
snd_info_buffer_t *buffer)
 {
  snd_pcm_info_t info;
@@ -391,6 +391,7 @@
  snd_iprintf(buffer, "hw_ptr      : %ld\n", runtime->status->hw_ptr);
  snd_iprintf(buffer, "appl_ptr    : %ld\n", 
runtime->control->appl_ptr);
 }
+#endif
 
 #ifdef CONFIG_SND_DEBUG
 static void snd_pcm_xrun_debug_read(snd_info_entry_t *entry, 
snd_info_buffer_t *buffer)
@@ -408,6 +409,7 @@
 }
 #endif
 
+#ifdef CONFIG_PROC_FS
 static int snd_pcm_stream_proc_init(snd_pcm_str_t *pstr)
 {
  snd_pcm_t *pcm = pstr->pcm;
@@ -551,6 +553,16 @@
  }
  return 0;
 }
+#else /* CONFIG_PROC_FS */
+/*
+ * Fix me - signature of *_done is int *_done, not void *_done, but 
it's used
+ * as void *_done (MR)
+ */
+#define snd_pcm_stream_proc_init(snd_pcm_str_t) (0)
+#define snd_pcm_stream_proc_done(snd_pcm_str_t) do { } while (0)
+#define snd_pcm_substream_proc_init(snd_pcm_substream_t) (0)
+#define snd_pcm_substream_proc_done(snd_pcm_substream_t) do { } while 
(0)
+#endif
 
 /**
  * snd_pcm_new_stream - create a new PCM stream
@@ -971,7 +983,7 @@
 /*
  *  Info interface
  */
-
+#ifdef CONFIG_PROC_FS
 static void snd_pcm_proc_read(snd_info_entry_t *entry, 
snd_info_buffer_t * buffer)
 {
  int idx;
@@ -992,11 +1004,11 @@
  }
  up(&register_mutex);
 }
+#endif
 
 /*
  *  ENTRY functions
  */
-
 static snd_info_entry_t *snd_pcm_proc_entry = NULL;
 
 static int __init alsa_pcm_init(void)
diff -Nru a/sound/pci/ac97/Makefile b/sound/pci/ac97/Makefile
--- a/sound/pci/ac97/Makefile 2004-10-15 14:25:13 +02:00
+++ b/sound/pci/ac97/Makefile 2004-10-15 14:25:13 +02:00
@@ -3,7 +3,12 @@
 # Copyright (c) 2001 by Jaroslav Kysela <perex@suse.cz>
 #
 
-snd-ac97-codec-objs := ac97_codec.o ac97_pcm.o ac97_proc.o ac97_patch.o
+snd-ac97-codec-objs := ac97_codec.o ac97_pcm.o ac97_patch.o
+
+ifneq ($(CONFIG_PROC_FS),)
+snd-ac97-codec-objs += ac97_proc.o
+endif
+
 snd-ak4531-codec-objs := ak4531_codec.o
 
 # Toplevel Module Dependency
diff -Nru a/sound/pci/ac97/ac97_local.h b/sound/pci/ac97/ac97_local.h
--- a/sound/pci/ac97/ac97_local.h 2004-10-15 14:25:13 +02:00
+++ b/sound/pci/ac97/ac97_local.h 2004-10-15 14:25:13 +02:00
@@ -51,7 +51,14 @@
 void snd_ac97_rename_vol_ctl(ac97_t *ac97, const char *src, const char 
*dst);
 
 /* ac97_proc.c */
+#ifdef CONFIG_PROC_FS
 void snd_ac97_bus_proc_init(ac97_bus_t * ac97);
 void snd_ac97_bus_proc_done(ac97_bus_t * ac97);
 void snd_ac97_proc_init(ac97_t * ac97);
 void snd_ac97_proc_done(ac97_t * ac97);
+#else
+#define snd_ac97_bus_proc_init(ac97_bus_t) do { } while (0)
+#define snd_ac97_bus_proc_done(ac97_bus_t) do { } while (0)
+#define snd_ac97_proc_init(ac97_t) do { } while (0)
+#define snd_ac97_proc_done(ac97_t) do { } while (0)
+#endif

