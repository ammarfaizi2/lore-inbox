Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319411AbSH2VzP>; Thu, 29 Aug 2002 17:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319405AbSH2VyM>; Thu, 29 Aug 2002 17:54:12 -0400
Received: from smtpout.mac.com ([204.179.120.86]:38868 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319355AbSH2VxT>;
	Thu, 29 Aug 2002 17:53:19 -0400
Message-Id: <200208292157.g7TLvhZH004108@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 29/41 sound/oss/soundcard.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/soundcard.c	Sat Aug 10 00:10:57 2002
+++ linux-2.5-cli-oss/sound/oss/soundcard.c	Wed Aug 14 22:24:33 2002
@@ -658,22 +658,16 @@
 
 int sound_open_dma(int chn, char *deviceID)
 {
-	unsigned long   flags;
-
 	if (!valid_dma(chn)) {
 		printk(KERN_ERR "sound_open_dma: Invalid DMA channel %d\n", chn);
 		return 1;
 	}
-	save_flags(flags);
-	cli();
 
 	if (dma_alloc_map[chn] != DMA_MAP_FREE) {
 		printk("sound_open_dma: DMA channel %d busy or not allocated (%d)\n", chn, dma_alloc_map[chn]);
-		restore_flags(flags);
 		return 1;
 	}
 	dma_alloc_map[chn] = DMA_MAP_BUSY;
-	restore_flags(flags);
 	return 0;
 }
 
@@ -689,18 +683,11 @@
 
 void sound_close_dma(int chn)
 {
-	unsigned long   flags;
-
-	save_flags(flags);
-	cli();
-
 	if (dma_alloc_map[chn] != DMA_MAP_BUSY) {
 		printk(KERN_ERR "sound_close_dma: Bad access to DMA channel %d\n", chn);
-		restore_flags(flags);
 		return;
 	}
 	dma_alloc_map[chn] = DMA_MAP_FREE;
-	restore_flags(flags);
 }
 
 static void do_sequencer_timer(unsigned long dummy)

