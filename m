Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSFEROv>; Wed, 5 Jun 2002 13:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315599AbSFEROu>; Wed, 5 Jun 2002 13:14:50 -0400
Received: from [212.30.75.51] ([212.30.75.51]:18316 "EHLO
	radovan.kista.gajba.net") by vger.kernel.org with ESMTP
	id <S315593AbSFEROt>; Wed, 5 Jun 2002 13:14:49 -0400
Date: Wed, 5 Jun 2002 19:16:37 +0200
From: Boris Bezlaj <boris@kista.gajba.net>
To: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: mad16.c
Message-Id: <20020605191637.14bcad75.boris@kista.gajba.net>
X-Mailer: Sylpheed version 0.5.1 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__5_Jun_2002_19:16:37_+0200_08173278"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__5_Jun_2002_19:16:37_+0200_08173278
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi.

Please review this patch(part of Kernel Janitor Project) for mad16 soundcards. I removed the first check_region() as  ad1848_detect() already does that.. comments?
note: ad1848_detect() uses check_region

2nd: i added release_region() for game port (initiative for this patch) to free 0x201 address when the driver unloads(if gameport was found)..for that i used existing 'joystick' variable

3rd: what should  be returned at "@@ -672,7 +667,8 @@"  ..i just used return as i saw somewhere..

comments ?
please cc me as i am not on lkml


--- sound/oss/mad16.c.orig	Sun May 12 00:51:31 2002
+++ sound/oss/mad16.c	Fri May 24 19:16:14 2002
@@ -320,11 +320,6 @@
 	 *    Verify the WSS parameters
 	 */
 
-	if (check_region(hw_config->io_base, 8))
-	{
-		printk(KERN_ERR "MSS: I/O port conflict\n");
-		return 0;
-	}
 	if (!ad1848_detect(hw_config->io_base + 4, &ad_flags, mad16_osp))
 		return 0;
 	/*
@@ -658,7 +653,7 @@
 		}
 		else
 		{
-			printk("MAD16: Invalid capture DMA\n");
+			printk(KERN_ERR "mad16: Invalid capture DMA\n");
 			dma2 = dma;
 		}
 	}
@@ -672,7 +667,8 @@
 					  dma2, 0,
 					  hw_config->osp,
 					  THIS_MODULE);
-	request_region(hw_config->io_base, 4, "mad16 WSS config");
+	if (! request_region(hw_config->io_base, 4, "mad16 WSS config")) 
+			return;
 }
 
 static int __init probe_mad16_mpu(struct address_info *hw_config)
@@ -1035,9 +1031,11 @@
 
 	if (joystick == 1) {
 	        /* register gameport */
-                if (!request_region(0x201, 1, "mad16 gameport"))
-                        printk(KERN_ERR "mad16: gameport address 0x201 already in use\n");
-                else {
+		if (!request_region(0x201, 1, "mad16 gameport")) {
+			joystick = 0;
+			printk(KERN_ERR "mad16: gameport address 0x201 already in use\n");
+		} else {
+			joystick = 1;
 			printk(KERN_ERR "mad16: gameport enabled at 0x201\n");
                         gameport.io = 0x201;
 		        gameport_register_port(&gameport);
@@ -1049,6 +1047,11 @@
 
 static void __exit cleanup_mad16(void)
 {
+	if (joystick) {
+		gameport_unregister_port(&gameport);
+		release_region(0x201, 1);
+	}
+
 	if (found_mpu)
 		unload_mad16_mpu(&cfg_mpu);
 	unload_mad16(&cfg);

-- 

	Boris B.
--Multipart_Wed__5_Jun_2002_19:16:37_+0200_08173278--
