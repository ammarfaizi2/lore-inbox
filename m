Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVHFMxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVHFMxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 08:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVHFMxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 08:53:09 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:26851 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261813AbVHFMxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 08:53:07 -0400
Subject: Re: [PATCH 8/8] ALSA: convert kcalloc to kzalloc
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: dtor_core@ameritech.net
Cc: pmarques@grupopie.com, tiwai@suse.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000508050822f18c9ac@mail.gmail.com>
References: <ikr7kg.6lzzr6.7ocpqo9oanclt926l5vz7gkyx.beaver@cs.helsinki.fi>
	 <ikr7kp.i3e3jm.bv3m5oebr5lt3u19xzl3ct9yu.beaver@cs.helsinki.fi>
	 <d120d5000508050822f18c9ac@mail.gmail.com>
Date: Sat, 06 Aug 2005 15:52:35 +0300
Message-Id: <1123332756.11074.10.camel@haji.ri.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 10:22 -0500, Dmitry Torokhov wrote:
> On 8/5/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.
> > 
> 
> Hi,
> 
> Have you seen the following in include/sound/core?
> 
> ...
> #define kmalloc(size, flags) snd_hidden_kmalloc(size, flags)
> #define kcalloc(n, size, flags) snd_hidden_kcalloc(n, size, flags)
> #define kfree(obj) snd_hidden_kfree(obj)

Thanks for the catch, Dmitry.

			Pekka

[PATCH] ALSA: introduce snd_hidden_kzalloc

This patch introduces a memory-leak tracking version of kzalloc for ALSA.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/sound/core.h |    2 ++
 sound/core/memory.c  |   13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

Index: 2.6/include/sound/core.h
===================================================================
--- 2.6.orig/include/sound/core.h
+++ 2.6/include/sound/core.h
@@ -291,12 +291,14 @@ void snd_memory_done(void);
 int snd_memory_info_init(void);
 int snd_memory_info_done(void);
 void *snd_hidden_kmalloc(size_t size, unsigned int __nocast flags);
+void *snd_hidden_kzalloc(size_t size, unsigned int __nocast flags);
 void *snd_hidden_kcalloc(size_t n, size_t size, unsigned int __nocast flags);
 void snd_hidden_kfree(const void *obj);
 void *snd_hidden_vmalloc(unsigned long size);
 void snd_hidden_vfree(void *obj);
 char *snd_hidden_kstrdup(const char *s, unsigned int __nocast flags);
 #define kmalloc(size, flags) snd_hidden_kmalloc(size, flags)
+#define kzalloc(size, flags) snd_hidden_kzalloc(size, flags)
 #define kcalloc(n, size, flags) snd_hidden_kcalloc(n, size, flags)
 #define kfree(obj) snd_hidden_kfree(obj)
 #define vmalloc(size) snd_hidden_vmalloc(size)
Index: 2.6/sound/core/memory.c
===================================================================
--- 2.6.orig/sound/core/memory.c
+++ 2.6/sound/core/memory.c
@@ -116,15 +116,20 @@ void *snd_hidden_kmalloc(size_t size, un
 	return _snd_kmalloc(size, flags);
 }
 
+void *snd_hidden_kzalloc(size_t size, unsigned int __nocast flags)
+{
+	void *ret = _snd_kmalloc(size, flags);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
+}
+
 void *snd_hidden_kcalloc(size_t n, size_t size, unsigned int __nocast flags)
 {
 	void *ret = NULL;
 	if (n != 0 && size > INT_MAX / n)
 		return ret;
-	ret = _snd_kmalloc(n * size, flags);
-	if (ret)
-		memset(ret, 0, n * size);
-	return ret;
+	return snd_hidden_kzalloc(n * size, flags);
 }
 
 void snd_hidden_kfree(const void *obj)


