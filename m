Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266898AbSLJWXp>; Tue, 10 Dec 2002 17:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266903AbSLJWXo>; Tue, 10 Dec 2002 17:23:44 -0500
Received: from dp.samba.org ([66.70.73.150]:60839 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266898AbSLJWXi>;
	Tue, 10 Dec 2002 17:23:38 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15862.27438.787187.93003@argo.ozlabs.ibm.com>
Date: Wed, 11 Dec 2002 09:31:10 +1100
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: atyfb in 2.5.51
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 2.5.51 on my G3 powerbook (laptop), which has a Rage LT Pro
video chip (ID 0x4c49 or LI).  With the patch below, atyfb compiles
and seems to mostly work.  However, I didn't see any penguin on boot.
Instead the top inch or so of the screen was just black.

X seems to be running just fine.  I have 'Option "UseFBDev"' in my
/etc/X11/XF86Config-4.  What doesn't work is changing VTs from X to a
text console.  If I press ctrl-alt-F1, for instance, the colormap
changes but I don't see anything get redrawn.  The screen looks just
like what I had in X but with the altered colormap.  If I then press
alt-F7, it switches back to X and X redraws the screen properly and
restores its colormap.

The other worrying thing is that on two occasions now the machine has
oopsed in free_block(), called from reap_timer_fnc(), because it has
dereferenced a bogus pointer value.  When I look at the memory that it
read the pointer from, it looks like a console screen buffer, that is,
the bytes are alternately 0x07 and ascii characters that look like a
login prompt.  This happened when waking the machine up from sleep and
when exiting X.  It sounds to me like you are freeing a console screen
buffer and then continuing to use it.

The patch below also takes out the CONFIG_NVRAM stuff since it doesn't
work and I don't believe anyone has ever used it.

I have also tried aty128fb with some local patches to get it to
compile for my G4 powerbook.  It also doesn't draw the penguin, and it
oopses when X starts, for some reason.

Regards,
Paul.

diff -urN linux-2.5/drivers/video/aty/atyfb_base.c pmac-2.5/drivers/video/aty/atyfb_base.c
--- linux-2.5/drivers/video/aty/atyfb_base.c	2002-12-10 15:29:52.000000000 +1100
+++ pmac-2.5/drivers/video/aty/atyfb_base.c	2002-12-11 09:16:11.000000000 +1100
@@ -70,7 +70,7 @@
 
 #ifdef __powerpc__
 #include <asm/prom.h>
-#include <video/macmodes.h>
+#include "../macmodes.h"	/* XXX relative include, yuck */
 #endif
 #ifdef __sparc__
 #include <asm/pbm.h>
@@ -84,9 +84,6 @@
 #ifdef CONFIG_BOOTX_TEXT
 #include <asm/btext.h>
 #endif
-#ifdef CONFIG_NVRAM
-#include <linux/nvram.h>
-#endif
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
@@ -226,14 +223,9 @@
 #endif
 
 #ifdef CONFIG_PPC
-#ifdef CONFIG_NVRAM_NOT_DEFINED
-static int default_vmode __initdata = VMODE_NVRAM;
-static int default_cmode __initdata = CMODE_NVRAM;
-#else
 static int default_vmode __initdata = VMODE_CHOOSE;
 static int default_cmode __initdata = CMODE_CHOOSE;
 #endif
-#endif
 
 #ifdef CONFIG_ATARI
 static unsigned int mach64_count __initdata = 0;
@@ -1412,16 +1404,16 @@
 static int aty_sleep_notify(struct pmu_sleep_notifier *self, int when)
 {
 	struct fb_info *info;
-	struct atyfb_par *par = (struct atyfb_par *) info->fb.par;
+	struct atyfb_par *par;
 	int result;
 
 	result = PBOOK_SLEEP_OK;
 
 	for (info = first_display; info != NULL; info = par->next) {
-		struct fb_fix_screeninfo fix;
 		int nb;
 
-		nb = fb_display[fg_console].var.yres * info->fix.line_length;
+		par = (struct atyfb_par *) info->par;
+		nb = info->var.yres * info->fix.line_length;
 
 		switch (when) {
 		case PBOOK_SLEEP_REQUEST:
@@ -1439,7 +1431,7 @@
 			if (par->blitter_may_be_busy)
 				wait_for_idle(par);
 			/* Stop accel engine (stop bus mastering) */
-			if (par->accel_flags & FB_ACCELF_TEXT)
+			if (info->var.accel_flags & FB_ACCELF_TEXT)
 				aty_reset_engine(par);
 
 			/* Backup fb content */
@@ -1844,14 +1836,6 @@
 			    (&var, info, mode_option, 8))
 				var = default_var;
 		} else {
-#ifdef CONFIG_NVRAM
-			if (default_vmode == VMODE_NVRAM) {
-				default_vmode = nvram_read_byte(NV_VMODE);
-				if (default_vmode <= 0
-				    || default_vmode > VMODE_MAX)
-					default_vmode = VMODE_CHOOSE;
-			}
-#endif
 			if (default_vmode == VMODE_CHOOSE) {
 				if (M64_HAS(G3_PB_1024x768))
 					/* G3 PowerBook with 1024x768 LCD */
@@ -1873,10 +1857,6 @@
 			if (default_vmode <= 0
 			    || default_vmode > VMODE_MAX)
 				default_vmode = VMODE_640_480_60;
-#ifdef CONFIG_NVRAM
-			if (default_cmode == CMODE_NVRAM)
-				default_cmode = nvram_read_byte(NV_CMODE);
-#endif
 			if (default_cmode < CMODE_8
 			    || default_cmode > CMODE_32)
 				default_cmode = CMODE_8;
