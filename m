Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVCORBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVCORBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVCORBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:01:47 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14830 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261498AbVCORBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:01:35 -0500
Date: Tue, 15 Mar 2005 10:01:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] ppc32: Fix a warning in planb video driver
Message-ID: <20050315170112.GQ8345@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ aside: This has been sitting in the linuxppc-2.5 bk tree for I don't
  know how long.  And the driver is still horribly broken. ]

The following patch moves overlay_is_active to before its first use.  It
was originally written when gcc wouldn't complain, but now does, about
not having the definition before usage.

 drivers/media/video/planb.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)
--- linux-2.6.11/drivers/media/video/planb.c	2005-03-02 00:38:19.000000000 -0700
+++ linuxppc-2.6.11/drivers/media/video/planb.c	2005-03-15 08:04:16.000000000 -0700
@@ -421,6 +421,16 @@
 /* overlay support functions */
 /*****************************/
 
+static inline int overlay_is_active(struct planb *pb)
+{
+	unsigned int size = pb->tab_size * sizeof(struct dbdma_cmd);
+	unsigned int caddr = (unsigned)in_le32(&pb->planb_base->ch1.cmdptr);
+
+	return (in_le32(&pb->overlay_last1->cmd_dep) == pb->ch1_cmd_phys)
+			&& (caddr < (pb->ch1_cmd_phys + size))
+			&& (caddr >= (unsigned)pb->ch1_cmd_phys);
+}
+
 static void overlay_start(struct planb *pb)
 {
 
@@ -852,16 +862,6 @@
 
 #define PLANB_PALETTE_MAX 15
 
-static inline int overlay_is_active(struct planb *pb)
-{
-	unsigned int size = pb->tab_size * sizeof(struct dbdma_cmd);
-	unsigned int caddr = (unsigned)in_le32(&pb->planb_base->ch1.cmdptr);
-
-	return (in_le32(&pb->overlay_last1->cmd_dep) == pb->ch1_cmd_phys)
-			&& (caddr < (pb->ch1_cmd_phys + size))
-			&& (caddr >= (unsigned)pb->ch1_cmd_phys);
-}
-
 static int vgrab(struct planb *pb, struct video_mmap *mp)
 {
 	unsigned int fr = mp->frame;

-- 
Tom Rini
http://gate.crashing.org/~trini/
