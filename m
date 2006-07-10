Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWGJLQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWGJLQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWGJLPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:15:55 -0400
Received: from fitch2.uni2.net ([130.227.52.102]:45276 "EHLO fitch2.uni2.net")
	by vger.kernel.org with ESMTP id S1751385AbWGJLPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:15:30 -0400
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 8/9] -Wshadow: vgacon fixes
Date: Mon, 10 Jul 2006 13:13:36 +0200
User-Agent: KMail/1.8.2
Cc: jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101313.36874.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please see the mail titled 
 "[RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow"
 for an explanation of why I'm doing this)


Fix a few -Wshadow warnings in drivers/video/console/vgacon.c

 drivers/video/console/vgacon.c:858: warning: declaration of 'state' shadows a global declaration
 drivers/video/console/vgacon.c:60: warning: shadowed declaration is here
 drivers/video/console/vgacon.c:928: warning: declaration of 'state' shadows a global declaration
 drivers/video/console/vgacon.c:60: warning: shadowed declaration is here
 drivers/video/console/vgacon.c:959: warning: declaration of 'state' shadows a global declaration
 drivers/video/console/vgacon.c:60: warning: shadowed declaration is here
 drivers/video/console/vgacon.c:1030: warning: declaration of 'state' shadows a global declaration
 drivers/video/console/vgacon.c:60: warning: shadowed declaration is here
 drivers/video/console/vgacon.c:1141: warning: declaration of 'i' shadows a previous local
 drivers/video/console/vgacon.c:1033: warning: shadowed declaration is here

Fixing the last one of these by just removing the local 'i'. Just reusing
the 'i' from the enclosing scope should be ok.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/video/console/vgacon.c |   72 +++++++++++++++----------------
 1 files changed, 35 insertions(+), 37 deletions(-)

--- linux-2.6.18-rc1-orig/drivers/video/console/vgacon.c	2006-07-06 19:39:47.000000000 +0200
+++ linux-2.6.18-rc1/drivers/video/console/vgacon.c	2006-07-09 21:40:46.000000000 +0200
@@ -855,14 +855,14 @@ static struct {
 	unsigned char ClockingMode;	/* Seq-Controller:01h */
 } vga_state;
 
-static void vga_vesa_blank(struct vgastate *state, int mode)
+static void vga_vesa_blank(struct vgastate *stat, int mode)
 {
 	/* save original values of VGA controller registers */
 	if (!vga_vesa_blanked) {
 		spin_lock_irq(&vga_lock);
-		vga_state.SeqCtrlIndex = vga_r(state->vgabase, VGA_SEQ_I);
+		vga_state.SeqCtrlIndex = vga_r(stat->vgabase, VGA_SEQ_I);
 		vga_state.CrtCtrlIndex = inb_p(vga_video_port_reg);
-		vga_state.CrtMiscIO = vga_r(state->vgabase, VGA_MIS_R);
+		vga_state.CrtMiscIO = vga_r(stat->vgabase, VGA_MIS_R);
 		spin_unlock_irq(&vga_lock);
 
 		outb_p(0x00, vga_video_port_reg);	/* HorizontalTotal */
@@ -881,17 +881,17 @@ static void vga_vesa_blank(struct vgasta
 		vga_state.EndVertRetrace = inb_p(vga_video_port_val);
 		outb_p(0x17, vga_video_port_reg);	/* ModeControl */
 		vga_state.ModeControl = inb_p(vga_video_port_val);
-		vga_state.ClockingMode = vga_rseq(state->vgabase, VGA_SEQ_CLOCK_MODE);
+		vga_state.ClockingMode = vga_rseq(stat->vgabase, VGA_SEQ_CLOCK_MODE);
 	}
 
 	/* assure that video is enabled */
 	/* "0x20" is VIDEO_ENABLE_bit in register 01 of sequencer */
 	spin_lock_irq(&vga_lock);
-	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, vga_state.ClockingMode | 0x20);
+	vga_wseq(stat->vgabase, VGA_SEQ_CLOCK_MODE, vga_state.ClockingMode | 0x20);
 
 	/* test for vertical retrace in process.... */
 	if ((vga_state.CrtMiscIO & 0x80) == 0x80)
-		vga_w(state->vgabase, VGA_MIS_W, vga_state.CrtMiscIO & 0xEF);
+		vga_w(stat->vgabase, VGA_MIS_W, vga_state.CrtMiscIO & 0xEF);
 
 	/*
 	 * Set <End of vertical retrace> to minimum (0) and
@@ -920,16 +920,16 @@ static void vga_vesa_blank(struct vgasta
 	}
 
 	/* restore both index registers */
-	vga_w(state->vgabase, VGA_SEQ_I, vga_state.SeqCtrlIndex);
+	vga_w(stat->vgabase, VGA_SEQ_I, vga_state.SeqCtrlIndex);
 	outb_p(vga_state.CrtCtrlIndex, vga_video_port_reg);
 	spin_unlock_irq(&vga_lock);
 }
 
-static void vga_vesa_unblank(struct vgastate *state)
+static void vga_vesa_unblank(struct vgastate *stat)
 {
 	/* restore original values of VGA controller registers */
 	spin_lock_irq(&vga_lock);
-	vga_w(state->vgabase, VGA_MIS_W, vga_state.CrtMiscIO);
+	vga_w(stat->vgabase, VGA_MIS_W, vga_state.CrtMiscIO);
 
 	outb_p(0x00, vga_video_port_reg);	/* HorizontalTotal */
 	outb_p(vga_state.HorizontalTotal, vga_video_port_val);
@@ -948,24 +948,24 @@ static void vga_vesa_unblank(struct vgas
 	outb_p(0x17, vga_video_port_reg);	/* ModeControl */
 	outb_p(vga_state.ModeControl, vga_video_port_val);
 	/* ClockingMode */
-	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, vga_state.ClockingMode);
+	vga_wseq(stat->vgabase, VGA_SEQ_CLOCK_MODE, vga_state.ClockingMode);
 
 	/* restore index/control registers */
-	vga_w(state->vgabase, VGA_SEQ_I, vga_state.SeqCtrlIndex);
+	vga_w(stat->vgabase, VGA_SEQ_I, vga_state.SeqCtrlIndex);
 	outb_p(vga_state.CrtCtrlIndex, vga_video_port_reg);
 	spin_unlock_irq(&vga_lock);
 }
 
-static void vga_pal_blank(struct vgastate *state)
+static void vga_pal_blank(struct vgastate *stat)
 {
 	int i;
 
-	vga_w(state->vgabase, VGA_PEL_MSK, 0xff);
+	vga_w(stat->vgabase, VGA_PEL_MSK, 0xff);
 	for (i = 0; i < 16; i++) {
-		vga_w(state->vgabase, VGA_PEL_IW, i);
-		vga_w(state->vgabase, VGA_PEL_D, 0);
-		vga_w(state->vgabase, VGA_PEL_D, 0);
-		vga_w(state->vgabase, VGA_PEL_D, 0);
+		vga_w(stat->vgabase, VGA_PEL_IW, i);
+		vga_w(stat->vgabase, VGA_PEL_D, 0);
+		vga_w(stat->vgabase, VGA_PEL_D, 0);
+		vga_w(stat->vgabase, VGA_PEL_D, 0);
 	}
 }
 
@@ -1027,7 +1027,7 @@ static int vgacon_blank(struct vc_data *
 #define blackwmap 0xa0000
 #define cmapsz 8192
 
-static int vgacon_do_font_op(struct vgastate *state,char *arg,int set,int ch512)
+static int vgacon_do_font_op(struct vgastate *stat,char *arg,int set,int ch512)
 {
 	unsigned short video_port_status = vga_video_port_reg + 6;
 	int font_select = 0x00, beg, i;
@@ -1075,20 +1075,20 @@ static int vgacon_do_font_op(struct vgas
 	unlock_kernel();
 	spin_lock_irq(&vga_lock);
 	/* First, the Sequencer */
-	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
+	vga_wseq(stat->vgabase, VGA_SEQ_RESET, 0x1);
 	/* CPU writes only to map 2 */
-	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x04);	
+	vga_wseq(stat->vgabase, VGA_SEQ_PLANE_WRITE, 0x04);	
 	/* Sequential addressing */
-	vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x07);	
+	vga_wseq(stat->vgabase, VGA_SEQ_MEMORY_MODE, 0x07);	
 	/* Clear synchronous reset */
-	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x03);
+	vga_wseq(stat->vgabase, VGA_SEQ_RESET, 0x03);
 
 	/* Now, the graphics controller, select map 2 */
-	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x02);		
+	vga_wgfx(stat->vgabase, VGA_GFX_PLANE_READ, 0x02);		
 	/* disable odd-even addressing */
-	vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x00);
+	vga_wgfx(stat->vgabase, VGA_GFX_MODE, 0x00);
 	/* map start at A000:0000 */
-	vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x00);
+	vga_wgfx(stat->vgabase, VGA_GFX_MISC, 0x00);
 	spin_unlock_irq(&vga_lock);
 
 	if (arg) {
@@ -1118,28 +1118,26 @@ static int vgacon_do_font_op(struct vgas
 
 	spin_lock_irq(&vga_lock);
 	/* First, the sequencer, Synchronous reset */
-	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x01);	
+	vga_wseq(stat->vgabase, VGA_SEQ_RESET, 0x01);	
 	/* CPU writes to maps 0 and 1 */
-	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x03);
+	vga_wseq(stat->vgabase, VGA_SEQ_PLANE_WRITE, 0x03);
 	/* odd-even addressing */
-	vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x03);
+	vga_wseq(stat->vgabase, VGA_SEQ_MEMORY_MODE, 0x03);
 	/* Character Map Select */
 	if (set)
-		vga_wseq(state->vgabase, VGA_SEQ_CHARACTER_MAP, font_select);
+		vga_wseq(stat->vgabase, VGA_SEQ_CHARACTER_MAP, font_select);
 	/* clear synchronous reset */
-	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x03);
+	vga_wseq(stat->vgabase, VGA_SEQ_RESET, 0x03);
 
 	/* Now, the graphics controller, select map 0 for CPU */
-	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x00);
+	vga_wgfx(stat->vgabase, VGA_GFX_PLANE_READ, 0x00);
 	/* enable even-odd addressing */
-	vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x10);
+	vga_wgfx(stat->vgabase, VGA_GFX_MODE, 0x10);
 	/* map starts at b800:0 or b000:0 */
-	vga_wgfx(state->vgabase, VGA_GFX_MISC, beg);
+	vga_wgfx(stat->vgabase, VGA_GFX_MISC, beg);
 
 	/* if 512 char mode is already enabled don't re-enable it. */
 	if ((set) && (ch512 != vga_512_chars)) {
-		int i;	
-		
 		/* attribute controller */
 		for (i = 0; i < MAX_NR_CONSOLES; i++) {
 			struct vc_data *c = vc_cons[i].d;
@@ -1151,11 +1149,11 @@ static int vgacon_do_font_op(struct vgas
 		   512-char: disable intensity bit */
 		inb_p(video_port_status);	/* clear address flip-flop */
 		/* color plane enable register */
-		vga_wattr(state->vgabase, VGA_ATC_PLANE_ENABLE, ch512 ? 0x07 : 0x0f);
+		vga_wattr(stat->vgabase, VGA_ATC_PLANE_ENABLE, ch512 ? 0x07 : 0x0f);
 		/* Wilton (1987) mentions the following; I don't know what
 		   it means, but it works, and it appears necessary */
 		inb_p(video_port_status);
-		vga_wattr(state->vgabase, VGA_AR_ENABLE_DISPLAY, 0);	
+		vga_wattr(stat->vgabase, VGA_AR_ENABLE_DISPLAY, 0);	
 	}
 	spin_unlock_irq(&vga_lock);
 	lock_kernel();




