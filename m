Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319392AbSH2WVT>; Thu, 29 Aug 2002 18:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319435AbSH2WUZ>; Thu, 29 Aug 2002 18:20:25 -0400
Received: from smtpout.mac.com ([204.179.120.97]:64472 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319392AbSH2VxD>;
	Thu, 29 Aug 2002 17:53:03 -0400
Message-Id: <200208292157.g7TLvQ72021684@smtp-relay04-en1.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 27/41 sound/oss/opl3sa2.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/opl3sa2.c	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/opl3sa2.c	Tue Aug 13 15:37:21 2002
@@ -149,6 +149,8 @@
 static struct address_info cfg_mss[OPL3SA2_CARDS_MAX];
 static struct address_info cfg_mpu[OPL3SA2_CARDS_MAX];
 
+static spinlock_t	lock=SPIN_LOCK_UNLOCKED;
+
 /* Our parameters */
 static int __initdata io	= -1;
 static int __initdata mss_io	= -1;
@@ -927,8 +929,7 @@
 	if (!pdev)
 		return -EINVAL;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);
 
 	p = (opl3sa2_mixerdata *) pdev->data;
 	p->in_suspend = 1;
@@ -951,7 +952,7 @@
 	opl3sa2_read(p->cfg_port, OPL3SA2_PM, &p->reg);
 	opl3sa2_write(p->cfg_port, OPL3SA2_PM, p->reg | pm_mode);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 	return 0;
 }
 
@@ -964,15 +965,14 @@
 		return -EINVAL;
 
 	p = (opl3sa2_mixerdata *) pdev->data;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock,flags);	
 
 	/* I don't think this is necessary */
 	opl3sa2_write(p->cfg_port, OPL3SA2_PM, p->reg);
 	opl3sa2_mixer_restore(p, p->card);
 	p->in_suspend = 0;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock,flags);
 	return 0;
 }
 

