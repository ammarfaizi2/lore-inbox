Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUG2CRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUG2CRD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 22:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267419AbUG2CQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 22:16:39 -0400
Received: from babyruth.hotpop.com ([38.113.3.61]:54175 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S267416AbUG2COl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 22:14:41 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/5] [RIVAFB]: Do not tap VGA ports if not X86
Date: Thu, 29 Jul 2004 10:04:26 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407291004.26089.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not tap VGA ports if arch is not X86.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

 fbdev.c  |    5 ++++-
 rivafb.h |    2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/riva/fbdev.c linux-2.6.8-rc2-mm1/drivers/video/riva/fbdev.c
--- linux-2.6.8-rc2-mm1-orig/drivers/video/riva/fbdev.c	2004-07-28 20:07:59.018089680 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/riva/fbdev.c	2004-07-28 20:08:30.286336184 +0000
@@ -1090,13 +1090,14 @@ static int rivafb_open(struct fb_info *i
 
 	NVTRACE_ENTER();
 	if (!cnt) {
+#ifdef CONFIG_X86
 		memset(&par->state, 0, sizeof(struct vgastate));
 		par->state.flags = VGA_SAVE_MODE  | VGA_SAVE_FONTS;
 		/* save the DAC for Riva128 */
 		if (par->riva.Architecture == NV_ARCH_03)
 			par->state.flags |= VGA_SAVE_CMAP;
 		save_vga(&par->state);
-
+#endif
 		RivaGetConfig(&par->riva, par->Chipset);
 		/* vgaHWunlock() + riva unlock (0x7F) */
 		CRTCout(par, 0x11, 0xFF);
@@ -1121,7 +1122,9 @@ static int rivafb_release(struct fb_info
 		par->riva.LockUnlock(&par->riva, 0);
 		par->riva.LoadStateExt(&par->riva, &par->initial_state.ext);
 		riva_load_state(par, &par->initial_state);
+#ifdef CONFIG_X86
 		restore_vga(&par->state);
+#endif
 		par->riva.LockUnlock(&par->riva, 1);
 	}
 	atomic_dec(&par->ref_count);
diff -uprN linux-2.6.8-rc2-mm1-orig/drivers/video/riva/rivafb.h linux-2.6.8-rc2-mm1/drivers/video/riva/rivafb.h
--- linux-2.6.8-rc2-mm1-orig/drivers/video/riva/rivafb.h	2004-07-28 20:08:03.560399144 +0000
+++ linux-2.6.8-rc2-mm1/drivers/video/riva/rivafb.h	2004-07-28 20:08:34.671669512 +0000
@@ -50,7 +50,9 @@ struct riva_par {
 
 	struct riva_regs initial_state;	/* initial startup video mode */
 	struct riva_regs current_state;
+#ifdef CONFIG_X86
 	struct vgastate state;
+#endif
 	atomic_t ref_count;
 	u32 cursor_data[32 * 32/4];
 	int cursor_reset;


