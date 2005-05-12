Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVELJR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVELJR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 05:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVELJR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 05:17:26 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:33196 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261356AbVELJPM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 05:15:12 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 12 May 2005 11:12:55 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jbeulich@novell.com
Subject: [patch] some vesafb fixes
Message-ID: <20050512091255.GA29789@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the size passed to release_mem_region in an error path.

Also adjust the message printed when vesafb cannot load; the comment
there already says this must not be fatal, so the message should also
not mention the word 'abort' otherwise indicating a problem to worry
about in the log.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Gerd Knorr <kraxel@suse.de>

diff -Npru linux-2.6.12-rc4.base/drivers/video/vesafb.c linux-2.6.12-rc4/drivers/video/vesafb.c
--- linux-2.6.12-rc4.base/drivers/video/vesafb.c	2005-05-11 17:28:18.970188552 +0200
+++ linux-2.6.12-rc4/drivers/video/vesafb.c	2005-05-11 17:50:36.285885664 +0200
@@ -271,7 +271,7 @@ static int __init vesafb_probe(struct de
 
 	if (!request_mem_region(vesafb_fix.smem_start, size_total, "vesafb")) {
 		printk(KERN_WARNING
-		       "vesafb: abort, cannot reserve video memory at 0x%lx\n",
+		       "vesafb: cannot reserve video memory at 0x%lx\n",
 			vesafb_fix.smem_start);
 		/* We cannot make this fatal. Sometimes this comes from magic
 		   spaces our resource handlers simply don't know about */
@@ -279,13 +279,13 @@ static int __init vesafb_probe(struct de
 
 	info = framebuffer_alloc(sizeof(u32) * 256, &dev->dev);
 	if (!info) {
-		release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
+		release_mem_region(vesafb_fix.smem_start, size_total);
 		return -ENOMEM;
 	}
 	info->pseudo_palette = info->par;
 	info->par = NULL;
 
-        info->screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
+	info->screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
 	if (!info->screen_base) {
 		printk(KERN_ERR
 		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
@@ -386,7 +386,7 @@ static int __init vesafb_probe(struct de
 	request_region(0x3c0, 32, "vesafb");
 
 	if (mtrr) {
-		int temp_size = size_total;
+		unsigned int temp_size = size_total;
 		/* Find the largest power-of-two */
 		while (temp_size & (temp_size - 1))
                 	temp_size &= (temp_size - 1);

-- 
-mm seems unusually stable at present.
	-- akpm about 2.6.12-rc3-mm3
