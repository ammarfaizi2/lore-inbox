Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTJFVfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 17:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbTJFVfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 17:35:14 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:15330 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S261797AbTJFVfF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 17:35:05 -0400
Message-ID: <3F81E0CE.2000908@terra.com.br>
Date: Mon, 06 Oct 2003 18:38:22 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] Leak in vesafb
References: <3F81DEE5.9000600@terra.com.br>
In-Reply-To: <3F81DEE5.9000600@terra.com.br>
Content-Type: multipart/mixed;
 boundary="------------030903090806040806020406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030903090806040806020406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Felipe W Damasio wrote:
>     Hi Andrew,
> 
>     Patch against 2.6.0-test6.
> 
>     Releases a previous request'ed_mem_region. Found by smatch.
> 
>     Since it didn't checked the return value of request_region, I'm not 
> sure we should free it here...since (as it says on the driver), "vgacon 
> probably has this region already".
> 
>     Andrew, I'd appreciate you could review this..

	Also, this updated patch also iounmap fb_info.screen_base, since 
we're about to return -EINVAL on vesa_init.

	Cheers,

Felipe

--------------030903090806040806020406
Content-Type: text/plain;
 name="vesafb-leak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vesafb-leak.patch"

--- linux-2.6.0-test6/drivers/video/vesafb.c.orig	2003-10-06 18:22:13.000000000 -0300
+++ linux-2.6.0-test6/drivers/video/vesafb.c	2003-10-06 18:33:39.000000000 -0300
@@ -366,8 +366,11 @@
 
 	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
 
-	if (register_framebuffer(&fb_info)<0)
+	if (register_framebuffer(&fb_info)<0) {
+		release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
+		iounmap(fb_info.screen_base);
 		return -EINVAL;
+	}
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
 	       fb_info.node, fb_info.fix.id);

--------------030903090806040806020406--

