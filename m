Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319401AbSH2Vxs>; Thu, 29 Aug 2002 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319365AbSH2Vxa>; Thu, 29 Aug 2002 17:53:30 -0400
Received: from smtpout.mac.com ([204.179.120.86]:45267 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319354AbSH2Vvt>;
	Thu, 29 Aug 2002 17:51:49 -0400
Message-Id: <200208292156.g7TLuCKN026339@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 18/41 sound/oss/ite8172.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/ite8172.c	Sat Aug 10 00:04:14 2002
+++ linux-2.5-cli-oss/sound/oss/ite8172.c	Sat Aug 10 19:52:48 2002
@@ -826,7 +826,7 @@
 
 static int it8172_open_mixdev(struct inode *inode, struct file *file)
 {
-    int minor = MINOR(inode->i_rdev);
+    int minor = minor(inode->i_rdev);
     struct list_head *list;
     struct it8172_state *s;
 
@@ -1196,13 +1196,13 @@
     case SNDCTL_DSP_RESET:
 	if (file->f_mode & FMODE_WRITE) {
 	    stop_dac(s);
-	    synchronize_irq();
+	    synchronize_irq(s->irq);
 	    s->dma_dac.count = s->dma_dac.total_bytes = 0;
 	    s->dma_dac.nextIn = s->dma_dac.nextOut = s->dma_dac.rawbuf;
 	}
 	if (file->f_mode & FMODE_READ) {
 	    stop_adc(s);
-	    synchronize_irq();
+	    synchronize_irq(s->irq);
 	    s->dma_adc.count = s->dma_adc.total_bytes = 0;
 	    s->dma_adc.nextIn = s->dma_adc.nextOut = s->dma_adc.rawbuf;
 	}
@@ -1541,7 +1541,7 @@
 
 static int it8172_open(struct inode *inode, struct file *file)
 {
-    int minor = MINOR(inode->i_rdev);
+    int minor = minor(inode->i_rdev);
     DECLARE_WAITQUEUE(wait, current);
     unsigned long flags;
     struct list_head *list;
@@ -1911,7 +1911,7 @@
     if (s->ps)
 	remove_proc_entry(IT8172_MODULE_NAME, NULL);
 #endif /* IT8172_DEBUG */
-    synchronize_irq();
+    synchronize_irq(s->irq);
     free_irq(s->irq, s);
     release_region(s->io, pci_resource_len(dev,0));
     unregister_sound_dsp(s->dev_audio);

