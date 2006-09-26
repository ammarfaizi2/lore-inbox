Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWIZM2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWIZM2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWIZM2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:28:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:39321 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751199AbWIZM2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:28:19 -0400
X-Authenticated: #704063
Subject: [Patch] Off-by-one in /arch/ppc/platforms/mpc8*
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: vbordug@ru.mvista.com
Content-Type: text/plain
Date: Tue, 26 Sep 2006 14:28:15 +0200
Message-Id: <1159273695.6502.5.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

a find -iname \*.[ch] | xargs grep "> ARRAY_SIZE(" revealed
several incorrect usages of ARRAY_SIZE in the mpc drivers.
The last element in the array is always ARRAY_SIZE()-1,
this patch modifies the bounds checks accordingly.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git5/arch/ppc/platforms/mpc8272ads_setup.c.orig	2006-09-26 14:24:56.000000000 +0200
+++ linux-2.6.18-git5/arch/ppc/platforms/mpc8272ads_setup.c	2006-09-26 14:25:12.000000000 +0200
@@ -196,7 +196,7 @@ static void __init mpc8272ads_fixup_enet
 	bd_t* bi = (void*)__res;
 	int fs_no = fsid_fcc1+pdev->id-1;
 
-	if(fs_no > ARRAY_SIZE(mpc82xx_enet_pdata)) {
+	if(fs_no >= ARRAY_SIZE(mpc82xx_enet_pdata)) {
 		return;
 	}
 
@@ -222,7 +222,7 @@ static void mpc8272ads_fixup_uart_pdata(
 	int id = fs_uart_id_scc2fsid(idx);
 
 	/* no need to alter anything if console */
-	if ((id <= num) && (!pdev->dev.platform_data)) {
+	if ((id < num) && (!pdev->dev.platform_data)) {
 		pinfo = &mpc8272_uart_pdata[id];
 		pinfo->uart_clk = bd->bi_intfreq;
 		pdev->dev.platform_data = pinfo;
--- linux-2.6.18-git5/arch/ppc/platforms/mpc866ads_setup.c.orig	2006-09-26 14:23:08.000000000 +0200
+++ linux-2.6.18-git5/arch/ppc/platforms/mpc866ads_setup.c	2006-09-26 14:23:48.000000000 +0200
@@ -259,7 +259,7 @@ static void mpc866ads_fixup_enet_pdata(s
 	/* Get pointer to Communication Processor */
 	cp = cpmp;
 
-	if(fs_no > ARRAY_SIZE(mpc8xx_enet_pdata)) {
+	if(fs_no >= ARRAY_SIZE(mpc8xx_enet_pdata)) {
 		printk(KERN_ERR"No network-suitable #%d device on bus", fs_no);
 		return;
 	}
@@ -305,7 +305,7 @@ static void __init mpc866ads_fixup_uart_
 	int id = fs_uart_id_smc2fsid(idx);
 
 	/* no need to alter anything if console */
-	if ((id <= num) && (!pdev->dev.platform_data)) {
+	if ((id < num) && (!pdev->dev.platform_data)) {
 		pinfo = &mpc866_uart_pdata[id];
 		pinfo->uart_clk = bd->bi_intfreq;
 		pdev->dev.platform_data = pinfo;
--- linux-2.6.18-git5/arch/ppc/platforms/mpc885ads_setup.c.orig	2006-09-26 14:24:03.000000000 +0200
+++ linux-2.6.18-git5/arch/ppc/platforms/mpc885ads_setup.c	2006-09-26 14:24:31.000000000 +0200
@@ -263,7 +263,7 @@ static void mpc885ads_fixup_enet_pdata(s
 	char *e;
 	int i;
 
-	if(fs_no > ARRAY_SIZE(mpc8xx_enet_pdata)) {
+	if(fs_no >= ARRAY_SIZE(mpc8xx_enet_pdata)) {
 		printk(KERN_ERR"No network-suitable #%d device on bus", fs_no);
 		return;
 	}
@@ -371,7 +371,7 @@ static void __init mpc885ads_fixup_uart_
 	int id = fs_uart_id_smc2fsid(idx);
 
 	/* no need to alter anything if console */
-	if ((id <= num) && (!pdev->dev.platform_data)) {
+	if ((id < num) && (!pdev->dev.platform_data)) {
 		pinfo = &mpc885_uart_pdata[id];
 		pinfo->uart_clk = bd->bi_intfreq;
 		pdev->dev.platform_data = pinfo;


