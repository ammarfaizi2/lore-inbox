Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSIIKFQ>; Mon, 9 Sep 2002 06:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSIIKEB>; Mon, 9 Sep 2002 06:04:01 -0400
Received: from smtpout.mac.com ([204.179.120.88]:36332 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S316857AbSIIKCC>;
	Mon, 9 Sep 2002 06:02:02 -0400
Message-Id: <200209091006.g89A6gOg000891@smtp-relay04-en1.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 5/10 sound/oss/wf_midi.c
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.33/sound/oss/wf_midi.c	Sat Apr 20 18:25:22 2002
+++ linux-2.5-cli-oss/sound/oss/wf_midi.c	Fri Aug 16 12:43:47 2002
@@ -50,6 +50,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #include <linux/wavefront.h>
@@ -79,6 +80,7 @@
 static struct wf_mpu_config *virt_dev = &devs[1];
 
 static void start_uart_mode (void);
+static spinlock_t lock=SPIN_LOCK_UNLOCKED;
 
 #define	OUTPUT_READY	0x40
 #define	INPUT_AVAIL	0x80
@@ -365,8 +367,8 @@
 	}
 
 	if (mi->m_busy) return;
+	spin_lock(&lock);
 	mi->m_busy = 1;
-	sti (); 
 
 	if (!input_dev) {
 		input_dev = physical_dev;
@@ -406,6 +408,7 @@
 	} while (input_avail() && n-- > 0);
 
 	mi->m_busy = 0;
+	spin_unlock(&lock);
 }
 
 static int
@@ -486,18 +489,17 @@
 		for (timeout = 30000; timeout > 0 && !output_ready ();
 		     timeout--);
       
-		save_flags (flags);
-		cli ();
+		spin_lock_irqsave(&lock, flags);
       
 		if (!output_ready ()) {
 			printk (KERN_WARNING "WF-MPU: Send switch "
 				"byte timeout\n");
-			restore_flags (flags);
+			spin_unlock_irqrestore(&lock, flags);
 			return 0;
 		}
       
 		write_data (switchch);
-		restore_flags (flags);
+		spin_unlock_irqrestore(&lock, flags);
 	} 
 
 	lastoutdev = dev;
@@ -511,16 +513,15 @@
 
 	for (timeout = 30000; timeout > 0 && !output_ready (); timeout--);
 
-	save_flags (flags);
-	cli ();
+	spin_lock_irqsave(&lock, flags);
 	if (!output_ready ()) {
+		spin_unlock_irqrestore(&lock, flags);
 		printk (KERN_WARNING "WF-MPU: Send data timeout\n");
-		restore_flags (flags);
 		return 0;
 	}
 
 	write_data (midi_byte);
-	restore_flags (flags);
+	spin_unlock_irqrestore(&lock, flags);
 
 	return 1;
 }
@@ -768,14 +769,13 @@
 {
 	unsigned long flags;
 
-	save_flags (flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 
 	wf_mpu_close (virt_dev->devno);
 	/* no synth on virt_dev, so no need to call wf_mpu_synth_close() */
 	phys_dev->isvirtual = 0;
 
-	restore_flags (flags);
+	spin_unlock_irqrestore(&lock, flags);
 
 	return 0;
 }
@@ -858,8 +858,7 @@
 	int             ok, i;
 	unsigned long   flags;
 
-	save_flags (flags);
-	cli ();
+	spin_lock_irqsave(&lock, flags);
 
 	/* XXX fix me */
 
@@ -875,6 +874,6 @@
 		}
 	}
 
-	restore_flags (flags);
+	spin_unlock_irqrestore(&lock, flags);
 }
 #endif

