Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTJHNeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTJHNdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:33:40 -0400
Received: from mail.convergence.de ([212.84.236.4]:8673 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261546AbTJHN27 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:28:59 -0400
Subject: [PATCH 9/14] various av7110 dvb-driver updates
In-Reply-To: <10656197373087@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 8 Oct 2003 15:28:57 +0200
Message-Id: <106561973797@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry: have a look at patch 12 for details!
-[DVB] various av7110 updates
diff -uNrwB --new-file xx-linux-2.6.0-test5/drivers/media/dvb/ttpci/av7110.c linux-2.6.0-test5/drivers/media/dvb/ttpci/av7110.c
--- xx-linux-2.6.0-test5/drivers/media/dvb/ttpci/av7110.c	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test5/drivers/media/dvb/ttpci/av7110.c	2003-09-10 10:58:29.000000000 +0200
@@ -40,9 +40,9 @@
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/timer.h>
+#include <linux/poll.h>
 #include <linux/unistd.h>
 #include <linux/byteorder/swabb.h>
-#include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <stdarg.h>
@@ -196,17 +197,22 @@
 	return result;
 }
 
-/* DEBI during interrupt */
 
-/* fixme: val can be a pointer to a memory or an u32 value -- this 
-   won't work on 64bit platforms! */
+/* DEBI during interrupt */
+/* single word writes */
 static inline void iwdebi(struct av7110 *av7110, u32 config, int addr, u32 val, int count)
 {
-        if (count>4 && val)
-                memcpy(av7110->debi_virt, (char *) val, count);
         debiwrite(av7110, config, addr, val, count);
 }
 
+/* buffer writes */
+static inline void mwdebi(struct av7110 *av7110, u32 config, int addr, char *val, int count)
+{
+	memcpy(av7110->debi_virt, val, count);
+        debiwrite(av7110, config, addr, 0, count);
+}
+
+
 static inline u32 irdebi(struct av7110 *av7110, u32 config, int addr, u32 val, int count)
 {
         u32 res;
@@ -1915,8 +1922,8 @@
                 if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0)
                         return -1;
                 DEB_D(("Writing DRAM block %d\n",i));
-                iwdebi(av7110, DEBISWAB, bootblock,
-                       i*(BOOT_MAX_SIZE)+(u32)data,
+                mwdebi(av7110, DEBISWAB, bootblock,
+                       ((char*)data) + i*(BOOT_MAX_SIZE),
                        BOOT_MAX_SIZE);
                 bootblock^=0x1400;
                 iwdebi(av7110, DEBISWAB, BOOT_BASE, swab32(base), 4);
@@ -1929,9 +1936,9 @@
                 if (waitdebi(av7110, BOOT_STATE, BOOTSTATE_BUFFER_EMPTY) < 0)
                         return -1;
                 if (rest>4)
-                        iwdebi(av7110, DEBISWAB, bootblock, i*(BOOT_MAX_SIZE)+(u32)data, rest);
+                        mwdebi(av7110, DEBISWAB, bootblock, ((char*)data) + i*(BOOT_MAX_SIZE), rest);
                 else
-                        iwdebi(av7110, DEBISWAB, bootblock, i*(BOOT_MAX_SIZE)-4+(u32)data, rest+4);
+                        mwdebi(av7110, DEBISWAB, bootblock, ((char*)data) + i*(BOOT_MAX_SIZE) - 4, rest+4);
                 
                 iwdebi(av7110, DEBISWAB, BOOT_BASE, swab32(base), 4);
                 iwdebi(av7110, DEBINOSWAP, BOOT_SIZE, rest, 2);
@@ -2015,7 +2022,7 @@
         //saa7146_setgpio(dev, DEBI_DONE_LINE, SAA7146_GPIO_INPUT);
         //saa7146_setgpio(dev, 3, SAA7146_GPIO_INPUT);
 
-        iwdebi(av7110, DEBISWAB, DPRAM_BASE, (u32) bootcode, sizeof(bootcode));
+	mwdebi(av7110, DEBISWAB, DPRAM_BASE, bootcode, sizeof(bootcode));
         iwdebi(av7110, DEBINOSWAP, BOOT_STATE, BOOTSTATE_BUFFER_FULL, 2);
         
         wait_for_debi_done(av7110);
@@ -2033,7 +2040,7 @@
         
         DEB_D(("bootarm: load dpram code\n"));
 
-	iwdebi(av7110, DEBISWAB, DPRAM_BASE, (u32) Dpram, sizeof(Dpram));
+	mwdebi(av7110, DEBISWAB, DPRAM_BASE, Dpram, sizeof(Dpram));
 
 	wait_for_debi_done(av7110);
 
@@ -2742,7 +2764,7 @@
 
 		DEB_EE(("VIDIOC_G_TUNER: %d\n", t->index));
 
-		if( 0 == av7110->has_analog_tuner || av7110->current_input != 1 ) {
+		if( 0 == av7110->has_analog_tuner || t->index != 0 ) {
 			return -EINVAL;
 		}
 
@@ -3257,7 +3279,7 @@
 	DEB_EE(("av7110: fwstc = %04hx %04hx %04hx %04hx\n",
 			fwstc[0], fwstc[1], fwstc[2], fwstc[3]));
 
-	*stc =  (((uint64_t)(~fwstc[2]) & 1) << 32) |
+	*stc =  (((uint64_t) ((fwstc[3] & 0x8000) >> 15)) << 32) |
 		(((uint64_t)fwstc[1])     << 16) | ((uint64_t)fwstc[0]);
 	*base = 1;
 
@@ -3630,17 +3652,22 @@
 
 	DEB_EE(("av7110: %p\n",av7110));
 
+	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
 	poll_wait(file, &av7110->avout.queue, wait);
+	}
+	
 	poll_wait(file, &av7110->video_events.wait_queue, wait);
 
 	if (av7110->video_events.eventw != av7110->video_events.eventr)
 		mask = POLLPRI;
 
+	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
 	if (av7110->playing) {
                 if (FREE_COND)
                         mask |= (POLLOUT | POLLWRNORM);
         } else /* if not playing: may play if asked for */
                 mask |= (POLLOUT | POLLWRNORM);
+	}
 
         return mask;
 }
@@ -3653,6 +3680,10 @@
 
 	DEB_EE(("av7110: %p\n",av7110));
 
+	if ((file->f_flags & O_ACCMODE) == O_RDONLY) {
+		return -EPERM;
+	}
+
         if (av7110->videostate.stream_source!=VIDEO_SOURCE_MEMORY) 
                 return -EPERM;
 
@@ -3690,6 +3721,10 @@
                 n=MIN_IFRAME/len+1;
         }
 
+	/* setting n always > 1, fixes problems when playing stillframes
+	   consisting of I- and P-Frames */
+	n=MIN_IFRAME/len+1;
+	
 	/* FIXME: nonblock? */
 	dvb_play(av7110, iframe_header, sizeof(iframe_header), 0, 1, 0);
 
@@ -3711,9 +3746,12 @@
         
 	DEB_EE(("av7110: %p\n",av7110));
 
-        if (((file->f_flags&O_ACCMODE)==O_RDONLY) &&
-            (cmd!=VIDEO_GET_STATUS))
+        if ((file->f_flags&O_ACCMODE)==O_RDONLY) {
+		if ( cmd!=VIDEO_GET_STATUS && cmd!=VIDEO_GET_EVENT && 
+		     cmd!=VIDEO_GET_SIZE ) {
                 return -EPERM;
+		}
+	}
         
         switch (cmd) {
         case VIDEO_STOP:
@@ -4027,15 +4065,17 @@
 
         if ((err=dvb_generic_open(inode, file))<0)
                 return err;
+
+	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
         dvb_ringbuffer_flush_spinlock_wakeup(&av7110->aout);
         dvb_ringbuffer_flush_spinlock_wakeup(&av7110->avout);
         av7110->video_blank=1;
         av7110->audiostate.AV_sync_state=1;
         av7110->videostate.stream_source=VIDEO_SOURCE_DEMUX;
 
-	if ((file->f_flags & O_ACCMODE) != O_RDONLY)
 		/*  empty event queue */
 		av7110->video_events.eventr = av7110->video_events.eventw = 0;
+	}
 
         return 0;
 }
@@ -4047,7 +4087,10 @@
 
 	DEB_EE(("av7110: %p\n",av7110));
 
+	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
         AV_Stop(av7110, RP_VIDEO);
+	}
+
         return dvb_generic_release(inode, file);
 }
 
@@ -4094,7 +4137,8 @@
 
 static struct dvb_device dvbdev_video = {
 	.priv		= 0,
-	.users		= 1,
+	.users		= 6,
+	.readers	= 5,	/* arbitrary */
 	.writers	= 1,
 	.fops		= &dvb_video_fops,
 	.kernel_ioctl	= dvb_video_ioctl,
@@ -4660,6 +4730,7 @@
 MAKE_AV7110_INFO(unkwn1, "Technotrend/Hauppauge PCI rev?(unknown1)?");
 MAKE_AV7110_INFO(unkwn2, "Technotrend/Hauppauge PCI rev?(unknown2)?");
 MAKE_AV7110_INFO(nexus,  "Technotrend/Hauppauge Nexus PCI DVB-S");
+MAKE_AV7110_INFO(dvboc11,"Octal/Technotrend DVB-C for iTV");
 
 static struct pci_device_id pci_tbl[] = {
 	MAKE_EXTENSION_PCI(fs_1_5, 0x110a, 0xffff),
@@ -4676,6 +4747,7 @@
 	MAKE_EXTENSION_PCI(unkwn1, 0xffc2, 0x0000),
 	MAKE_EXTENSION_PCI(unkwn2, 0x00a1, 0x00a1),
 	MAKE_EXTENSION_PCI(nexus,  0x00a1, 0xa1a0),
+	MAKE_EXTENSION_PCI(dvboc11,0x13c2, 0x000a),
 	{
 		.vendor    = 0,
 	}

