Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319385AbSH2VzQ>; Thu, 29 Aug 2002 17:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319404AbSH2VyE>; Thu, 29 Aug 2002 17:54:04 -0400
Received: from smtpout.mac.com ([204.179.120.86]:42964 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319385AbSH2Vx0>;
	Thu, 29 Aug 2002 17:53:26 -0400
Message-Id: <200208292157.g7TLvoZH004144@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 30/41 sound/oss/waveartist.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/waveartist.c	Sat Apr 20 18:25:22 2002
+++ linux-2.5-cli-oss/sound/oss/waveartist.c	Thu Aug 15 14:29:48 2002
@@ -839,6 +839,7 @@
 	wavnc_info *devc = (wavnc_info *)dev_id;
 	int	   irqstatus, status;
 
+	spin_lock(&waveartist_lock);
 	irqstatus = inb(devc->hw.io_base + IRQSTAT);
 	status    = inb(devc->hw.io_base + STATR);
 
@@ -870,6 +871,7 @@
 	if (irqstatus & 0x2)
 		// We do not use SB mode natively...
 		printk(KERN_WARNING "waveartist: Unexpected SB interrupt...\n");
+	spin_unlock(&waveartist_lock);
 }
 
 /* -------------------------------------------------------------------------
@@ -1523,8 +1525,7 @@
 
 	*CSR_TIMER1_LOAD = 0x00ffffff;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&waveartist_lock, flags);
 
 	outb(0xFF, 0x201);
 	*CSR_TIMER1_CNTL = TIMER_CNTL_ENABLE | TIMER_CNTL_DIV1;
@@ -1534,7 +1535,7 @@
 
 	*CSR_TIMER1_CNTL = 0;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&waveartist_lock,flags);
 	
 	volume = 0x00ffffff - *CSR_TIMER1_VALUE;
 

