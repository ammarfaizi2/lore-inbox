Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWG3Qjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWG3Qjn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWG3Qjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:39:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:17454 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932362AbWG3Qjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:39:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sSKLBEgSV3l2QUb0ZHnFD9u/H7AUBr9IbWSgsbsSh372xkodpN13D11Q16OIbDocvZnsWRKZjIJVI8vAHOPDTuOkx82Y16xvsJX03iRsIkDzan5skvK63a6ZcImnQq2NhHyaL8zJq15j13IDXiEYqIaS1+sSJhwOJtH5BOLc7eo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] making the kernel -Wshadow clean - fix vgacon
Date: Sun, 30 Jul 2006 18:40:46 +0200
User-Agent: KMail/1.9.3
References: <200607301830.01659.jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301840.46221.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few -Wshadow warnings in drivers/video/console/vgacon.c


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/video/console/vgacon.c |   72 +++++++++++++++----------------
 1 files changed, 35 insertions(+), 37 deletions(-)

--- linux-2.6.18-rc2-orig/drivers/video/console/vgacon.c	2006-07-18 18:46:50.000000000 +0200
+++ linux-2.6.18-rc2/drivers/video/console/vgacon.c	2006-07-19 00:32:19.000000000 +0200
@@ -855,14 +855,14 @@ static struct {
 	unsigned char ClockingMode;	/* Seq-Controller:01h */
 } vga_state;
 
-static void vga_vesa_blank(struct vgastate *state, int mode)
+static void vga_vesa_blank(struct vgastate *condition, int mode)
 {
 	/* save original values of VGA controller registers */
 	if (!vga_vesa_blanked) {
 		spin_lock_irq(&vga_lock);
-		vga_state.SeqCtrlIndex = vga_r(state->vgabase, VGA_SEQ_I);
+		vga_state.SeqCtrlIndex = vga_r(condition->vgabase, VGA_SEQ_I);
 		vga_state.CrtCtrlIndex = inb_p(vga_video_port_reg);
-		vga_state.CrtMiscIO = vga_r(state->vgabase, VGA_MIS_R);
+		vga_state.CrtMiscIO = vga_r(condition->vgabase, VGA_MIS_R);
 		spin_unlock_irq(&vga_lock);
 
 		outb_p(0x00, vga_video_port_reg);	/* HorizontalTotal */
@@ -881,17 +881,17 @@ static void vga_vesa_blank(struct vgasta
 		vga_state.EndVertRetrace = inb_p(vga_video_port_val);
 		outb_p(0x17, vga_video_port_reg);	/* ModeControl */
 		vga_state.ModeControl = inb_p(vga_video_port_val);
-		vga_state.ClockingMode = vga_rseq(state->vgabase, VGA_SEQ_CLOCK_MODE);
+		vga_state.ClockingMode = vga_rseq(condition->vgabase, VGA_SEQ_CLOCK_MODE);
 	}
 
 	/* assure that video is enabled */
 	/* "0x20" is VIDEO_ENABLE_bit in register 01 of sequencer */
 	spin_lock_irq(&vga_lock);
-	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, vga_state.ClockingMode | 0x20);
+	vga_wseq(condition->vgabase, VGA_SEQ_CLOCK_MODE, vga_state.ClockingMode | 0x20);
 
 	/* test for vertical retrace in process.... */
 	if ((vga_state.CrtMiscIO & 0x80) == 0x80)
-		vga_w(state->vgabase, VGA_MIS_W, vga_state.CrtMiscIO & 0xEF);
+		vga_w(condition->vgabase, VGA_MIS_W, vga_state.CrtMiscIO & 0xEF);
 
 	/*
 	 * Set <End of vertical retrace> to minimum (0) and
@@ -920,16 +920,16 @@ static void vga_vesa_blank(struct vgasta
 	}
 
 	/* restore both index registers */
-	vga_w(state->vgabase, VGA_SEQ_I, vga_state.SeqCtrlIndex);
+	vga_w(condition->vgabase, VGA_SEQ_I, vga_state.SeqCtrlIndex);
 	outb_p(vga_state.CrtCtrlIndex, vga_video_port_reg);
 	spin_unlock_irq(&vga_lock);
 }
 
-static void vga_vesa_unblank(struct vgastate *state)
+static void vga_vesa_unblank(struct vgastate *condition)
 {
 	/* restore original values of VGA controller registers */
 	spin_lock_irq(&vga_lock);
-	vga_w(state->vgabase, VGA_MIS_W, vga_state.CrtMiscIO);
+	vga_w(condition->vgabase, VGA_MIS_W, vga_state.CrtMiscIO);
 
 	outb_p(0x00, vga_video_port_reg);	/* HorizontalTotal */
 	outb_p(vga_state.HorizontalTotal, vga_video_port_val);
@@ -948,24 +948,24 @@ static void vga_vesa_unblank(struct vgas
 	outb_p(0x17, vga_video_port_reg);	/* ModeControl */
 	outb_p(vga_state.ModeControl, vga_video_port_val);
 	/* ClockingMode */
-	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, vga_state.ClockingMode);
+	vga_wseq(condition->vgabase, VGA_SEQ_CLOCK_MODE, vga_state.ClockingMode);
 
 	/* restore index/control registers */
-	vga_w(state->vgabase, VGA_SEQ_I, vga_state.SeqCtrlIndex);
+	vga_w(condition->vgabase, VGA_SEQ_I, vga_state.SeqCtrlIndex);
 	outb_p(vga_state.CrtCtrlIndex, vga_video_port_reg);
 	spin_unlock_irq(&vga_lock);
 }
 
-static void vga_pal_blank(struct vgastate *state)
+static void vga_pal_blank(struct vgastate *condition)
 {
 	int i;
 
-	vga_w(state->vgabase, VGA_PEL_MSK, 0xff);
+	vga_w(condition->vgabase, VGA_PEL_MSK, 0xff);
 	for (i = 0; i < 16; i++) {
-		vga_w(state->vgabase, VGA_PEL_IW, i);
-		vga_w(state->vgabase, VGA_PEL_D, 0);
-		vga_w(state->vgabase, VGA_PEL_D, 0);
-		vga_w(state->vgabase, VGA_PEL_D, 0);
+		vga_w(condition->vgabase, VGA_PEL_IW, i);
+		vga_w(condition->vgabase, VGA_PEL_D, 0);
+		vga_w(condition->vgabase, VGA_PEL_D, 0);
+		vga_w(condition->vgabase, VGA_PEL_D, 0);
 	}
 }
 
@@ -1027,7 +1027,7 @@ static int vgacon_blank(struct vc_data *
 #define blackwmap 0xa0000
 #define cmapsz 8192
 
-static int vgacon_do_font_op(struct vgastate *state,char *arg,int set,int ch512)
+static int vgacon_do_font_op(struct vgastate *condition,char *arg,int set,int ch512)
 {
 	unsigned short video_port_status = vga_video_port_reg + 6;
 	int font_select = 0x00, beg, i;
@@ -1075,20 +1075,20 @@ static int vgacon_do_font_op(struct vgas
 	unlock_kernel();
 	spin_lock_irq(&vga_lock);
 	/* First, the Sequencer */
-	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
+	vga_wseq(condition->vgabase, VGA_SEQ_RESET, 0x1);
 	/* CPU writes only to map 2 */
-	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x04);	
+	vga_wseq(condition->vgabase, VGA_SEQ_PLANE_WRITE, 0x04);	
 	/* Sequential addressing */
-	vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x07);	
+	vga_wseq(condition->vgabase, VGA_SEQ_MEMORY_MODE, 0x07);	
 	/* Clear synchronous reset */
-	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x03);
+	vga_wseq(condition->vgabase, VGA_SEQ_RESET, 0x03);
 
 	/* Now, the graphics controller, select map 2 */
-	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x02);		
+	vga_wgfx(condition->vgabase, VGA_GFX_PLANE_READ, 0x02);		
 	/* disable odd-even addressing */
-	vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x00);
+	vga_wgfx(condition->vgabase, VGA_GFX_MODE, 0x00);
 	/* map start at A000:0000 */
-	vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x00);
+	vga_wgfx(condition->vgabase, VGA_GFX_MISC, 0x00);
 	spin_unlock_irq(&vga_lock);
 
 	if (arg) {
@@ -1118,28 +1118,26 @@ static int vgacon_do_font_op(struct vgas
 
 	spin_lock_irq(&vga_lock);
 	/* First, the sequencer, Synchronous reset */
-	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x01);	
+	vga_wseq(condition->vgabase, VGA_SEQ_RESET, 0x01);	
 	/* CPU writes to maps 0 and 1 */
-	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x03);
+	vga_wseq(condition->vgabase, VGA_SEQ_PLANE_WRITE, 0x03);
 	/* odd-even addressing */
-	vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x03);
+	vga_wseq(condition->vgabase, VGA_SEQ_MEMORY_MODE, 0x03);
 	/* Character Map Select */
 	if (set)
-		vga_wseq(state->vgabase, VGA_SEQ_CHARACTER_MAP, font_select);
+		vga_wseq(condition->vgabase, VGA_SEQ_CHARACTER_MAP, font_select);
 	/* clear synchronous reset */
-	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x03);
+	vga_wseq(condition->vgabase, VGA_SEQ_RESET, 0x03);
 
 	/* Now, the graphics controller, select map 0 for CPU */
-	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x00);
+	vga_wgfx(condition->vgabase, VGA_GFX_PLANE_READ, 0x00);
 	/* enable even-odd addressing */
-	vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x10);
+	vga_wgfx(condition->vgabase, VGA_GFX_MODE, 0x10);
 	/* map starts at b800:0 or b000:0 */
-	vga_wgfx(state->vgabase, VGA_GFX_MISC, beg);
+	vga_wgfx(condition->vgabase, VGA_GFX_MISC, beg);
 
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
+		vga_wattr(condition->vgabase, VGA_ATC_PLANE_ENABLE, ch512 ? 0x07 : 0x0f);
 		/* Wilton (1987) mentions the following; I don't know what
 		   it means, but it works, and it appears necessary */
 		inb_p(video_port_status);
-		vga_wattr(state->vgabase, VGA_AR_ENABLE_DISPLAY, 0);	
+		vga_wattr(condition->vgabase, VGA_AR_ENABLE_DISPLAY, 0);	
 	}
 	spin_unlock_irq(&vga_lock);
 	lock_kernel();


