Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268381AbTBNM5d>; Fri, 14 Feb 2003 07:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268422AbTBNMz6>; Fri, 14 Feb 2003 07:55:58 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:26894 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268410AbTBNMxY>;
	Fri, 14 Feb 2003 07:53:24 -0500
Date: Fri, 14 Feb 2003 15:58:38 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: sound update (11/13)
Message-ID: <20030214125838.GK8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bFUYW7mPOLJ+Jd2A"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bFUYW7mPOLJ+Jd2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

This patch contains SGI visws OSS sound driver update.

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--bFUYW7mPOLJ+Jd2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-sound

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/sound/oss/Kconfig linux-2.5.60/sound/oss/Kconfig
--- linux-2.5.60.vanilla/sound/oss/Kconfig	Thu Feb 13 20:32:37 2003
+++ linux-2.5.60/sound/oss/Kconfig	Thu Feb 13 20:42:02 2003
@@ -225,7 +225,7 @@
 
 config SOUND_VWSND
 	tristate "SGI Visual Workstation Sound"
-	depends on SOUND_PRIME!=n && VISWS && SOUND
+	depends on SOUND_PRIME!=n && X86_VISWS && SOUND
 	help
 	  Say Y or M if you have an SGI Visual Workstation and you want to be
 	  able to use its on-board audio.  Read
diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/sound/oss/vwsnd.c linux-2.5.60/sound/oss/vwsnd.c
--- linux-2.5.60.vanilla/sound/oss/vwsnd.c	Thu Feb 13 20:32:36 2003
+++ linux-2.5.60/sound/oss/vwsnd.c	Thu Feb 13 20:42:02 2003
@@ -144,14 +144,12 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-#include <linux/sched.h>
-#include <linux/semaphore.h>
-#include <linux/stddef.h>
 #include <linux/spinlock.h>
 #include <linux/smp_lock.h>
-#include <asm/fixmap.h>
-#include <asm/cobalt.h>
+#include <linux/wait.h>
+#include <linux/interrupt.h>
 #include <asm/semaphore.h>
+#include <asm/mach-visws/cobalt.h>
 
 #include "sound_config.h"
 
@@ -256,7 +254,7 @@
  * Returns 0 on success, -errno on failure.
  */
 
-static int li_create(lithium_t *lith, unsigned long baseaddr)
+static int __init li_create(lithium_t *lith, unsigned long baseaddr)
 {
 	static void li_destroy(lithium_t *);
 
@@ -3040,15 +3038,15 @@
 }
 
 static struct file_operations vwsnd_audio_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		vwsnd_audio_read,
-	write:		vwsnd_audio_write,
-	poll:		vwsnd_audio_poll,
-	ioctl:		vwsnd_audio_ioctl,
-	mmap:		vwsnd_audio_mmap,
-	open:		vwsnd_audio_open,
-	release:	vwsnd_audio_release,
+	.owner =	THIS_MODULE,
+	.llseek =	no_llseek,
+	.read =		vwsnd_audio_read,
+	.write =	vwsnd_audio_write,
+	.poll =		vwsnd_audio_poll,
+	.ioctl =	vwsnd_audio_ioctl,
+	.mmap =		vwsnd_audio_mmap,
+	.open =		vwsnd_audio_open,
+	.release =	vwsnd_audio_release,
 };
 
 /*****************************************************************************/
@@ -3230,11 +3228,11 @@
 }
 
 static struct file_operations vwsnd_mixer_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	ioctl:		vwsnd_mixer_ioctl,
-	open:		vwsnd_mixer_open,
-	release:	vwsnd_mixer_release,
+	.owner =	THIS_MODULE,
+	.llseek =	no_llseek,
+	.ioctl =	vwsnd_mixer_ioctl,
+	.open =		vwsnd_mixer_open,
+	.release =	vwsnd_mixer_release,
 };
 
 /*****************************************************************************/
@@ -3281,7 +3279,8 @@
 		return 0;
 	}
 
-	printk(KERN_INFO "probe_vwsnd: lithium audio found\n");
+	printk(KERN_INFO "vwsnd: lithium audio at mmio %#x irq %d\n",
+		hw_config->io_base, hw_config->irq);
 
 	return 1;
 }
@@ -3309,7 +3308,7 @@
 	if (err)
 		goto fail1;
 
-	init_waitqueue(&devc->open_wait);
+	init_waitqueue_head(&devc->open_wait);
 
 	devc->rport.hwbuf_size = HWBUF_SIZE;
 	devc->rport.hwbuf_vaddr = __get_free_pages(GFP_KERNEL, HWBUF_ORDER);
@@ -3378,18 +3377,18 @@
 
 	/* Initialize as much of *devc as possible */
 
-	devc->open_sema = MUTEX;
-	devc->io_sema = MUTEX;
-	devc->mix_sema = MUTEX;
+	init_MUTEX(&devc->open_sema);
+	init_MUTEX(&devc->io_sema);
+	init_MUTEX(&devc->mix_sema);
 	devc->open_mode = 0;
 	devc->rport.lock = SPIN_LOCK_UNLOCKED;
-	init_waitqueue(&devc->rport.queue);
+	init_waitqueue_head(&devc->rport.queue);
 	devc->rport.swstate = SW_OFF;
 	devc->rport.hwstate = HW_STOPPED;
 	devc->rport.flags = 0;
 	devc->rport.swbuf = NULL;
 	devc->wport.lock = SPIN_LOCK_UNLOCKED;
-	init_waitqueue(&devc->wport.queue);
+	init_waitqueue_head(&devc->wport.queue);
 	devc->wport.swstate = SW_OFF;
 	devc->wport.hwstate = HW_STOPPED;
 	devc->wport.flags = 0;
@@ -3468,8 +3467,9 @@
 	DBGXV("\n");
 	DBGXV("sound::vwsnd::init_module()\n");
 
-	if(!probe_vwsnd(&the_hw_config))
+	if (!probe_vwsnd(&the_hw_config))
 		return -ENODEV;
+
 	err = attach_vwsnd(&the_hw_config);
 	if (err < 0)
 		return err;

--bFUYW7mPOLJ+Jd2A--
