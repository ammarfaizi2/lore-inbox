Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbUK1SZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUK1SZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbUK1SZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:25:27 -0500
Received: from mail.dif.dk ([193.138.115.101]:32416 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261554AbUK1SYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:24:18 -0500
Date: Sun, 28 Nov 2004 19:34:02 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>,
       Gareth Hughes <gareth@valinux.com>,
       "Kevin E. Martin" <martin@valinux.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] copy_to_user return value checking in
 radeon_state.c::radeon_cp_dispatch_texture() ...
Message-ID: <Pine.LNX.4.61.0411281926570.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch adding return value checking to 
drivers/char/drm/radeon_state.c::radeon_cp_dispatch_texture()
thus getting rid of the warning 
drivers/char/drm/radeon_state.c: In function `radeon_cp_dispatch_texture':
drivers/char/drm/radeon_state.c:1443: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result
and hopefully behaving more correctly in the case of errors.

<disclaimer>
I have no hardware to test this, so cmpile tested only.
</disclaimer>


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk11-orig/drivers/char/drm/radeon_state.c linux-2.6.10-rc2-bk11/drivers/char/drm/radeon_state.c
--- linux-2.6.10-rc2-bk11-orig/drivers/char/drm/radeon_state.c	2004-10-18 23:54:55.000000000 +0200
+++ linux-2.6.10-rc2-bk11/drivers/char/drm/radeon_state.c	2004-11-28 19:25:16.000000000 +0100
@@ -1440,7 +1440,10 @@ static int radeon_cp_dispatch_texture( D
 		}
 		if ( !buf ) {
 			DRM_DEBUG("radeon_cp_dispatch_texture: EAGAIN\n");
-			DRM_COPY_TO_USER( tex->image, image, sizeof(*image) );
+			if (DRM_COPY_TO_USER( tex->image, image, sizeof(*image) )) {
+                        	DRM_ERROR( "copy_to_user\n" );
+				return DRM_ERR(EFAULT);
+			}
 			return DRM_ERR(EAGAIN);
 		}
 


PS. Please CC me on replies from other lists than linux-kernel.

-- 
Jesper Juhl <juhl-lkml@dif.dk>



