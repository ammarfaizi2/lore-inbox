Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262675AbVAEXll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVAEXll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVAEXll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:41:41 -0500
Received: from mail.dif.dk ([193.138.115.101]:13765 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262670AbVAEXjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:39:14 -0500
Date: Thu, 6 Jan 2005 00:50:38 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] kill problematic variable from drivers/video/fbmem.c
Message-ID: <Pine.LNX.4.61.0501060032150.3492@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My standard config generated a new warning for me with 2.6.10-bk8 : 

  CC      drivers/video/fbmem.o
drivers/video/fbmem.c: In function `fb_set_var':
drivers/video/fbmem.c:719: warning: ISO C90 forbids mixed declarations and code

Upon investigating I saw that it was the variable 'int err' that caused it 
and I also noticed that we might as well just kill that variable.

I can see 4 reasons to get rid of this variable :

1) it causes a warning.
2) it shadows a variable of the same name in the enclosing scope.
3) it is declared after code in the block, thus causing trouble for C89 
compilers like gcc 2.95.3 that we claim to still support.
4) it is completely unnessesary since we can reuse the 'err' variable 
declared at the start of the function without any trouble.

Patch that kills off the variable below.
Patch has been compile tested and boot tested.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk8-orig/drivers/video/fbmem.c linux-2.6.10-bk8/drivers/video/fbmem.c
--- linux-2.6.10-bk8-orig/drivers/video/fbmem.c	2005-01-06 00:04:45.000000000 +0100
+++ linux-2.6.10-bk8/drivers/video/fbmem.c	2005-01-06 00:26:15.000000000 +0100
@@ -716,7 +716,6 @@ fb_set_var(struct fb_info *info, struct 
 		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
 			struct fb_videomode mode;
 			info->var = *var;
-			int err = 0;
 
 			if (info->fbops->fb_set_par)
 				info->fbops->fb_set_par(info);




PS. Please keep me on CC.



