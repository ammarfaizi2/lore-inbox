Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261773AbSJDOBl>; Fri, 4 Oct 2002 10:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261774AbSJDOBl>; Fri, 4 Oct 2002 10:01:41 -0400
Received: from gate.perex.cz ([194.212.165.105]:6930 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S261773AbSJDOBj>;
	Fri, 4 Oct 2002 10:01:39 -0400
Date: Fri, 4 Oct 2002 16:06:08 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Anton Blanchard <anton@samba.org>
cc: "akpm@zip.com.au" <akpm@zip.com.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: sleeper
In-Reply-To: <20021004095609.GA8809@krispykreme>
Message-ID: <Pine.LNX.4.33.0210041603430.713-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002, Anton Blanchard wrote:

> sound and devfs caught in action.

This patch should fix the problem:

--- sound_core.c	13 Aug 2002 16:13:33 -0000	1.8
+++ sound_core.c	4 Oct 2002 14:04:22 -0000
@@ -122,7 +122,7 @@
  *	Remove a node from the chain. Called with the lock asserted
  */
  
-static void __sound_remove_unit(struct sound_unit **list, int unit)
+static struct sound_unit *__sound_remove_unit(struct sound_unit **list, int unit)
 {
 	while(*list)
 	{
@@ -130,13 +130,12 @@
 		if(p->unit_minor==unit)
 		{
 			*list=p->next;
-			devfs_unregister (p->de);
-			kfree(p);
-			return;
+			return p;
 		}
 		list=&(p->next);
 	}
 	printk(KERN_ERR "Sound device %d went missing!\n", unit);
+	return NULL;
 }
 
 /*
@@ -189,9 +188,15 @@
  	
 static void sound_remove_unit(struct sound_unit **list, int unit)
 {
+	struct sound_unit *p;
+
 	spin_lock(&sound_loader_lock);
-	__sound_remove_unit(list, unit);
+	p = __sound_remove_unit(list, unit);
 	spin_unlock(&sound_loader_lock);
+	if (p) {
+		devfs_unregister (p->de);
+		kfree(p);
+	}
 }
 
 /*

					Jaroslav

> Anton
> 
> Debug: sleeping function called from illegal context at slab.c:1374
> Call backtrace: 
> C00000000005C3B8 __might_sleep+0xf4
> C000000000091764 __kmem_cache_alloc+0x268
> C0000000001369AC devfsd_notify_de+0xc4
> C000000000136B0C devfsd_notify+0x3c
> C0000000001370E4 _devfs_unregister+0xb0
> C00000000013722C devfs_unregister+0x8c
> C0000000002F8474 __sound_remove_unit+0x78
> C0000000002F86F8 sound_remove_unit+0x60
> C000000000303BD0 snd_unregister_oss_device+0x98
> C0000000003085BC snd_mixer_oss_notify_handler+0x68
> C0000000002FA2F4 snd_card_free+0x2a0
> D0000000001494FC Unknown
> C000000000064D84 free_module+0x1c0
> C000000000062F60 sys_delete_module+0x220
> C00000000001F7BC sys32_delete_module+0x10

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

