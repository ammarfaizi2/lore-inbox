Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTJFV0z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 17:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTJFV0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 17:26:54 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:46279 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S262069AbTJFV0x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 17:26:53 -0400
Message-ID: <3F81DEE5.9000600@terra.com.br>
Date: Mon, 06 Oct 2003 18:30:13 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] Leak in vesafb
Content-Type: multipart/mixed;
 boundary="------------080804060503020707040900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080804060503020707040900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Andrew,

	Patch against 2.6.0-test6.

	Releases a previous request'ed_mem_region. Found by smatch.

	Since it didn't checked the return value of request_region, I'm not 
sure we should free it here...since (as it says on the driver), 
"vgacon probably has this region already".

	Andrew, I'd appreciate you could review this..

	Thanks.

Felipe

--------------080804060503020707040900
Content-Type: text/plain;
 name="vesafb-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vesafb-leak.patch"

--- linux-2.6.0-test6/drivers/video/vesafb.c.orig	2003-10-06 18:22:13.000000000 -0300
+++ linux-2.6.0-test6/drivers/video/vesafb.c	2003-10-06 18:23:35.000000000 -0300
@@ -366,8 +366,10 @@
 
 	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
 
-	if (register_framebuffer(&fb_info)<0)
+	if (register_framebuffer(&fb_info)<0) {
+		release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
 		return -EINVAL;
+	}
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
 	       fb_info.node, fb_info.fix.id);

--------------080804060503020707040900--

