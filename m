Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVA1Ab4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVA1Ab4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVA1A30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:29:26 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:1225 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261360AbVA1AZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:25:13 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050128002508.23839.95066.57216@localhost.localdomain>
In-Reply-To: <20050128002501.23839.78981.57374@localhost.localdomain>
References: <20050128002501.23839.78981.57374@localhost.localdomain>
Subject: [PATCH 2.4] lcd: fix memory leak in lcd_ioctl()
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [70.16.225.90] at Thu, 27 Jan 2005 18:25:08 -0600
Date: Thu, 27 Jan 2005 18:25:09 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a memory leak in the FLASH_Burn ioctl for the Cobalt LCD interface driver.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -purN --exclude='*~' linux-2.4.29-original/drivers/char/lcd.c linux-2.4.29/drivers/char/lcd.c
--- linux-2.4.29-original/drivers/char/lcd.c	2005-01-27 18:46:42.085690494 -0500
+++ linux-2.4.29/drivers/char/lcd.c	2005-01-27 18:49:38.011310971 -0500
@@ -434,8 +434,10 @@ static int lcd_ioctl(struct inode *inode
 		save_flags(flags);
 		for (i=0; i<FLASH_SIZE; i=i+128) {
 
-		        if(copy_from_user(rom, display.RomImage + i, 128))
+		        if(copy_from_user(rom, display.RomImage + i, 128)) {
+			   kfree(rom);
 			   return -EFAULT;
+			}
 			burn_addr = kFlashBase + i;
 			cli();
 			for ( index = 0; index < ( 128 ) ; index++ ) 
