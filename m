Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVJKC33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVJKC33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 22:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVJKC33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 22:29:29 -0400
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:52305 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751353AbVJKC33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 22:29:29 -0400
Message-ID: <434B23CB.7000609@gmail.com>
Date: Mon, 10 Oct 2005 21:30:35 -0500
From: Hareesh Nagarajan <hnagar2@gmail.com>
Reply-To: hnagar2@gmail.com
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: davem@redhat.com
Subject: [PATCH] Trivial patch to remove list member from struct tcx_par in
 drivers/video/tcx.c
Content-Type: multipart/mixed;
 boundary="------------050907040705050509000805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050907040705050509000805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes the list_head member 'list' from struct tcx_par in 
the file drivers/video/tcx.c among other trivial cleanups. The member 
'list' is never used. It turns out that other frame buffer code like 
cg14.c, leo.c, bw2.c, etc. (in drivers/video) seem to have the same 
extra list_head member in their respective *_par structures.

The patch applies to the 2.6.13.4 kernel sources.

(AFAICT, I am not missing anything; If I am, I'm sorry for wasting your 
time.)

Thanks,

Hareesh Nagarajan

--------------050907040705050509000805
Content-Type: text/x-patch;
 name="tcx.c-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tcx.c-cleanup.patch"

--- linux-2.6.13.4/drivers/video/tcx.c	2005-10-10 13:54:29.000000000 -0500
+++ linux-2.6.13.4-edit/drivers/video/tcx.c	2005-10-10 21:05:22.110156000 -0500
@@ -123,7 +123,6 @@
 	int			lowdepth;
 
 	struct sbus_dev		*sdev;
-	struct list_head	list;
 };
 
 /* Reset control plane so that WID is 8-bit plane. */
@@ -174,13 +173,13 @@
 			 unsigned red, unsigned green, unsigned blue,
 			 unsigned transp, struct fb_info *info)
 {
+	if (regno >= 256)
+		return 1;
+
 	struct tcx_par *par = (struct tcx_par *) info->par;
 	struct bt_regs __iomem *bt = par->bt;
 	unsigned long flags;
 
-	if (regno >= 256)
-		return 1;
-
 	red >>= 8;
 	green >>= 8;
 	blue >>= 8;
@@ -442,7 +441,7 @@
 
 	tcx_reset(&all->info);
 
-	tcx_blank(0, &all->info);
+	tcx_blank(FB_BLANK_UNBLANK, &all->info);
 
 	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
 		printk(KERN_ERR "tcx: Could not allocate color map.\n");
@@ -490,8 +489,7 @@
 	struct list_head *pos, *tmp;
 
 	list_for_each_safe(pos, tmp, &tcx_list) {
-		struct all_info *all = list_entry(pos, typeof(*all), list);
-
+		struct all_info *all = list_entry(pos, struct all_info, list);
 		unregister_framebuffer(&all->info);
 		fb_dealloc_cmap(&all->info.cmap);
 		kfree(all);

--------------050907040705050509000805--
