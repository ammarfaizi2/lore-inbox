Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVBARQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVBARQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVBARQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:16:54 -0500
Received: from [195.23.16.24] ([195.23.16.24]:36023 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262074AbVBARQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:16:10 -0500
Message-ID: <41FFB94C.3050807@grupopie.com>
Date: Tue, 01 Feb 2005 17:15:56 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Subject: Re: [PATCH 2.6] 7/7 replace snd_kmalloc_strdup by kstrdup
References: <1107228526.41fef76e4c9be@webmail.grupopie.com>	<s5h651ch6lc.wl@alsa2.suse.de>	<41FF75C0.6040602@grupopie.com>	<s5hy8e8fol6.wl@alsa2.suse.de>	<41FF7F0D.5080800@grupopie.com>	<s5hvf9cfmj9.wl@alsa2.suse.de>	<41FFA2AD.9020006@grupopie.com> <s5hpszkfd4a.wl@alsa2.suse.de>
In-Reply-To: <s5hpszkfd4a.wl@alsa2.suse.de>
Content-Type: multipart/mixed;
 boundary="------------060508090903040809060303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060508090903040809060303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> [...]
> 
> Thanks, that looks almost fine except:
> 
> 
>>diff -uprN -X dontdiff vanilla-2.6.11-rc2-bk9/sound/core/sound.c linux-2.6.11-rc2-bk9/sound/core/sound.c
>>--- vanilla-2.6.11-rc2-bk9/sound/core/sound.c	2005-01-31 20:05:34.000000000 +0000
>>+++ linux-2.6.11-rc2-bk9/sound/core/sound.c	2005-02-01 15:02:04.000000000 +0000
>>@@ -401,7 +401,6 @@ EXPORT_SYMBOL(snd_hidden_kfree);
>> EXPORT_SYMBOL(snd_hidden_vmalloc);
>> EXPORT_SYMBOL(snd_hidden_vfree);
>> #endif
>>-EXPORT_SYMBOL(snd_kmalloc_strdup);
>> EXPORT_SYMBOL(copy_to_user_fromio);
>> EXPORT_SYMBOL(copy_from_user_toio);
>>   /* init.c */
> 
> 
> I guess here missing EXPORT(snd_hidden_kstrdup)?

Good catch.

Here is the revised patch... I hope this time everything is ok

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

--------------060508090903040809060303
Content-Type: text/plain;
 name="patch7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch7"

diff -uprN -X dontdiff vanilla-2.6.11-rc2-bk9/include/sound/core.h linux-2.6.11-rc2-bk9/include/sound/core.h
--- vanilla-2.6.11-rc2-bk9/include/sound/core.h	2005-01-31 20:05:33.000000000 +0000
+++ linux-2.6.11-rc2-bk9/include/sound/core.h	2005-02-01 15:02:04.000000000 +0000
@@ -291,6 +291,7 @@ void *snd_hidden_kcalloc(size_t n, size_
 void snd_hidden_kfree(const void *obj);
 void *snd_hidden_vmalloc(unsigned long size);
 void snd_hidden_vfree(void *obj);
+char *snd_hidden_kstrdup(const char *s, int flags);
 #define kmalloc(size, flags) snd_hidden_kmalloc(size, flags)
 #define kcalloc(n, size, flags) snd_hidden_kcalloc(n, size, flags)
 #define kfree(obj) snd_hidden_kfree(obj)
@@ -300,6 +301,7 @@ void snd_hidden_vfree(void *obj);
 #define vmalloc_nocheck(size) snd_wrapper_vmalloc(size)
 #define kfree_nocheck(obj) snd_wrapper_kfree(obj)
 #define vfree_nocheck(obj) snd_wrapper_vfree(obj)
+#define kstrdup(s, flags)  snd_hidden_kstrdup(s, flags)
 #else
 #define snd_memory_init() /*NOP*/
 #define snd_memory_done() /*NOP*/
@@ -310,7 +312,6 @@ void snd_hidden_vfree(void *obj);
 #define kfree_nocheck(obj) kfree(obj)
 #define vfree_nocheck(obj) vfree(obj)
 #endif
-char *snd_kmalloc_strdup(const char *string, int flags);
 int copy_to_user_fromio(void __user *dst, const volatile void __iomem *src, size_t count);
 int copy_from_user_toio(volatile void __iomem *dst, const void __user *src, size_t count);
 
diff -uprN -X dontdiff vanilla-2.6.11-rc2-bk9/sound/core/info.c linux-2.6.11-rc2-bk9/sound/core/info.c
--- vanilla-2.6.11-rc2-bk9/sound/core/info.c	2005-01-31 20:05:34.000000000 +0000
+++ linux-2.6.11-rc2-bk9/sound/core/info.c	2005-02-01 15:02:04.000000000 +0000
@@ -24,6 +24,7 @@
 #include <linux/vmalloc.h>
 #include <linux/time.h>
 #include <linux/smp_lock.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/info.h>
@@ -755,7 +756,7 @@ static snd_info_entry_t *snd_info_create
 	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
 	if (entry == NULL)
 		return NULL;
-	entry->name = snd_kmalloc_strdup(name, GFP_KERNEL);
+	entry->name = kstrdup(name, GFP_KERNEL);
 	if (entry->name == NULL) {
 		kfree(entry);
 		return NULL;
diff -uprN -X dontdiff vanilla-2.6.11-rc2-bk9/sound/core/info_oss.c linux-2.6.11-rc2-bk9/sound/core/info_oss.c
--- vanilla-2.6.11-rc2-bk9/sound/core/info_oss.c	2004-12-24 21:34:01.000000000 +0000
+++ linux-2.6.11-rc2-bk9/sound/core/info_oss.c	2005-02-01 15:27:43.000000000 +0000
@@ -22,6 +22,7 @@
 #include <sound/driver.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/info.h>
@@ -51,7 +52,7 @@ int snd_oss_info_register(int dev, int n
 			x = NULL;
 		}
 	} else {
-		x = snd_kmalloc_strdup(string, GFP_KERNEL);
+		x = kstrdup(string, GFP_KERNEL);
 		if (x == NULL) {
 			up(&strings);
 			return -ENOMEM;
diff -uprN -X dontdiff vanilla-2.6.11-rc2-bk9/sound/core/memory.c linux-2.6.11-rc2-bk9/sound/core/memory.c
--- vanilla-2.6.11-rc2-bk9/sound/core/memory.c	2005-01-31 20:05:34.000000000 +0000
+++ linux-2.6.11-rc2-bk9/sound/core/memory.c	2005-02-01 15:02:04.000000000 +0000
@@ -184,6 +184,20 @@ void snd_hidden_vfree(void *obj)
 	snd_wrapper_vfree(obj);
 }
 
+char *snd_hidden_kstrdup(const char *s, int flags)
+{
+	int len;
+	char *buf;
+	
+	if (!s) return NULL;
+	
+	len = strlen(s) + 1;
+	buf = _snd_kmalloc(len, flags);
+	if (buf)
+		memcpy(buf, s, len);
+	return buf;
+}
+
 static void snd_memory_info_read(snd_info_entry_t *entry, snd_info_buffer_t * buffer)
 {
 	snd_iprintf(buffer, "kmalloc: %li bytes\n", snd_alloc_kmalloc);
@@ -214,36 +228,9 @@ int __exit snd_memory_info_done(void)
 	return 0;
 }
 
-#else
-
-#define _snd_kmalloc kmalloc
-
 #endif /* CONFIG_SND_DEBUG_MEMORY */
 
 /**
- * snd_kmalloc_strdup - copy the string
- * @string: the original string
- * @flags: allocation conditions, GFP_XXX
- *
- * Allocates a memory chunk via kmalloc() and copies the string to it.
- *
- * Returns the pointer, or NULL if no enoguh memory.
- */
-char *snd_kmalloc_strdup(const char *string, int flags)
-{
-	size_t len;
-	char *ptr;
-
-	if (!string)
-		return NULL;
-	len = strlen(string) + 1;
-	ptr = _snd_kmalloc(len, flags);
-	if (ptr)
-		memcpy(ptr, string, len);
-	return ptr;
-}
-
-/**
  * copy_to_user_fromio - copy data from mmio-space to user-space
  * @dst: the destination pointer on user-space
  * @src: the source pointer on mmio
diff -uprN -X dontdiff vanilla-2.6.11-rc2-bk9/sound/core/oss/mixer_oss.c linux-2.6.11-rc2-bk9/sound/core/oss/mixer_oss.c
--- vanilla-2.6.11-rc2-bk9/sound/core/oss/mixer_oss.c	2005-01-31 20:05:34.000000000 +0000
+++ linux-2.6.11-rc2-bk9/sound/core/oss/mixer_oss.c	2005-02-01 15:02:04.000000000 +0000
@@ -24,6 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/control.h>
@@ -1122,7 +1123,7 @@ static void snd_mixer_oss_proc_write(snd
 			goto __unlock;
 		}
 		tbl->oss_id = ch;
-		tbl->name = snd_kmalloc_strdup(str, GFP_KERNEL);
+		tbl->name = kstrdup(str, GFP_KERNEL);
 		if (! tbl->name) {
 			kfree(tbl);
 			goto __unlock;
diff -uprN -X dontdiff vanilla-2.6.11-rc2-bk9/sound/core/oss/pcm_oss.c linux-2.6.11-rc2-bk9/sound/core/oss/pcm_oss.c
--- vanilla-2.6.11-rc2-bk9/sound/core/oss/pcm_oss.c	2005-01-31 20:05:34.000000000 +0000
+++ linux-2.6.11-rc2-bk9/sound/core/oss/pcm_oss.c	2005-02-01 15:02:04.000000000 +0000
@@ -33,6 +33,7 @@
 #include <linux/time.h>
 #include <linux/vmalloc.h>
 #include <linux/moduleparam.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/pcm.h>
@@ -2349,7 +2350,7 @@ static void snd_pcm_oss_proc_write(snd_i
 					for (setup1 = pstr->oss.setup_list; setup1->next; setup1 = setup1->next);
 					setup1->next = setup;
 				}
-				template.task_name = snd_kmalloc_strdup(task_name, GFP_KERNEL);
+				template.task_name = kstrdup(task_name, GFP_KERNEL);
 			} else {
 				buffer->error = -ENOMEM;
 			}
diff -uprN -X dontdiff vanilla-2.6.11-rc2-bk9/sound/core/sound.c linux-2.6.11-rc2-bk9/sound/core/sound.c
--- vanilla-2.6.11-rc2-bk9/sound/core/sound.c	2005-01-31 20:05:34.000000000 +0000
+++ linux-2.6.11-rc2-bk9/sound/core/sound.c	2005-02-01 17:01:35.000000000 +0000
@@ -400,8 +400,8 @@ EXPORT_SYMBOL(snd_hidden_kcalloc);
 EXPORT_SYMBOL(snd_hidden_kfree);
 EXPORT_SYMBOL(snd_hidden_vmalloc);
 EXPORT_SYMBOL(snd_hidden_vfree);
+EXPORT_SYMBOL(snd_hidden_kstrdup);
 #endif
-EXPORT_SYMBOL(snd_kmalloc_strdup);
 EXPORT_SYMBOL(copy_to_user_fromio);
 EXPORT_SYMBOL(copy_from_user_toio);
   /* init.c */
diff -uprN -X dontdiff vanilla-2.6.11-rc2-bk9/sound/core/timer.c linux-2.6.11-rc2-bk9/sound/core/timer.c
--- vanilla-2.6.11-rc2-bk9/sound/core/timer.c	2005-01-31 20:05:34.000000000 +0000
+++ linux-2.6.11-rc2-bk9/sound/core/timer.c	2005-02-01 15:02:04.000000000 +0000
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/moduleparam.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/timer.h>
 #include <sound/control.h>
@@ -97,7 +98,7 @@ static snd_timer_instance_t *snd_timer_i
 	timeri = kcalloc(1, sizeof(*timeri), GFP_KERNEL);
 	if (timeri == NULL)
 		return NULL;
-	timeri->owner = snd_kmalloc_strdup(owner, GFP_KERNEL);
+	timeri->owner = kstrdup(owner, GFP_KERNEL);
 	if (! timeri->owner) {
 		kfree(timeri);
 		return NULL;
diff -uprN -X dontdiff vanilla-2.6.11-rc2-bk9/sound/isa/gus/gus_mem.c linux-2.6.11-rc2-bk9/sound/isa/gus/gus_mem.c
--- vanilla-2.6.11-rc2-bk9/sound/isa/gus/gus_mem.c	2005-01-31 20:05:34.000000000 +0000
+++ linux-2.6.11-rc2-bk9/sound/isa/gus/gus_mem.c	2005-02-01 15:02:04.000000000 +0000
@@ -21,6 +21,7 @@
 
 #include <sound/driver.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/gus.h>
 #include <sound/info.h>
@@ -213,7 +214,7 @@ snd_gf1_mem_block_t *snd_gf1_mem_alloc(s
 	if (share_id != NULL)
 		memcpy(&block.share_id, share_id, sizeof(block.share_id));
 	block.owner = owner;
-	block.name = snd_kmalloc_strdup(name, GFP_KERNEL);
+	block.name = kstrdup(name, GFP_KERNEL);
 	nblock = snd_gf1_mem_xalloc(alloc, &block);
 	snd_gf1_mem_lock(alloc, 1);
 	return nblock;
@@ -253,13 +254,13 @@ int snd_gf1_mem_init(snd_gus_card_t * gu
 	if (gus->gf1.enh_mode) {
 		block.ptr = 0;
 		block.size = 1024;
-		block.name = snd_kmalloc_strdup("InterWave LFOs", GFP_KERNEL);
+		block.name = kstrdup("InterWave LFOs", GFP_KERNEL);
 		if (snd_gf1_mem_xalloc(alloc, &block) == NULL)
 			return -ENOMEM;
 	}
 	block.ptr = gus->gf1.default_voice_address;
 	block.size = 4;
-	block.name = snd_kmalloc_strdup("Voice default (NULL's)", GFP_KERNEL);
+	block.name = kstrdup("Voice default (NULL's)", GFP_KERNEL);
 	if (snd_gf1_mem_xalloc(alloc, &block) == NULL)
 		return -ENOMEM;
 #ifdef CONFIG_SND_DEBUG
diff -uprN -X dontdiff vanilla-2.6.11-rc2-bk9/sound/synth/emux/emux.c linux-2.6.11-rc2-bk9/sound/synth/emux/emux.c
--- vanilla-2.6.11-rc2-bk9/sound/synth/emux/emux.c	2005-01-31 20:05:35.000000000 +0000
+++ linux-2.6.11-rc2-bk9/sound/synth/emux/emux.c	2005-02-01 15:28:15.000000000 +0000
@@ -22,6 +22,7 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/emux_synth.h>
 #include <linux/init.h>
@@ -76,7 +77,7 @@ int snd_emux_register(snd_emux_t *emu, s
 	snd_assert(name != NULL, return -EINVAL);
 
 	emu->card = card;
-	emu->name = snd_kmalloc_strdup(name, GFP_KERNEL);
+	emu->name = kstrdup(name, GFP_KERNEL);
 	emu->voices = kcalloc(emu->max_voices, sizeof(snd_emux_voice_t), GFP_KERNEL);
 	if (emu->voices == NULL)
 		return -ENOMEM;

--------------060508090903040809060303--
