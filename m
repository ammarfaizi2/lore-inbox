Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319390AbSH2WUO>; Thu, 29 Aug 2002 18:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319396AbSH2VxN>; Thu, 29 Aug 2002 17:53:13 -0400
Received: from smtpout.mac.com ([204.179.120.89]:15045 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319368AbSH2VwW>;
	Thu, 29 Aug 2002 17:52:22 -0400
Message-Id: <200208292156.g7TLujZH003922@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 22/41 sound/oss/nec_vrc5477.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/nec_vrc5477.c	Sat Apr 20 18:25:20 2002
+++ linux-2.5-cli-oss/sound/oss/nec_vrc5477.c	Sat Aug 10 19:52:27 2002
@@ -807,7 +807,7 @@
 
 static int vrc5477_ac97_open_mixdev(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct list_head *list;
 	struct vrc5477_ac97_state *s;
 
@@ -1331,13 +1331,13 @@
 	case SNDCTL_DSP_RESET:
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_dac.count = 0;
 			s->dma_dac.nextIn = s->dma_dac.nextOut = 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_adc.count = 0;
 			s->dma_adc.nextIn = s->dma_adc.nextOut = 0;
 		}
@@ -1523,7 +1523,7 @@
 
 static int vrc5477_ac97_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 	struct list_head *list;
@@ -1993,7 +1993,7 @@
 	if (s->ps)
 		remove_proc_entry(VRC5477_AC97_MODULE_NAME, NULL);
 #endif /* CONFIG_LL_DEBUG */
-	synchronize_irq();
+	synchronize_irq(s->irq);
 	free_irq(s->irq, s);
 	release_region(s->io, pci_resource_len(dev,0));
 	unregister_sound_dsp(s->dev_audio);

