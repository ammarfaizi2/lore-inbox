Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268474AbUIMPZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268474AbUIMPZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268227AbUIMPWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:22:31 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:388 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S268524AbUIMPSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:18:38 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/3] fbdev: fix scrolling corruption
Date: Mon, 13 Sep 2004 23:18:43 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409132210.25202.adaplas@hotpop.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patches fixes the following:

- scrolling corruption if scrolling mode is SCROLL_PAN_MOVE. This bug
  was introduced by the tile blitting patch.

- flashing cursor even when console is blanked

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff -uprN linux-2.6.9-rc1-mm5-orig/drivers/video/console/fbcon.c linux-2.6.9-rc1-mm5/drivers/video/console/fbcon.c
--- linux-2.6.9-rc1-mm5-orig/drivers/video/console/fbcon.c	2004-09-13 21:49:01.000000000 +0800
+++ linux-2.6.9-rc1-mm5/drivers/video/console/fbcon.c	2004-09-13 22:24:33.027181792 +0800
@@ -1160,10 +1160,11 @@ static __inline__ void ypan_up(struct vc
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
-	
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
+
 	p->yscroll += count;
 	if (p->yscroll > p->vrows - vc->vc_rows) {
-		fbcon_bmove(vc, p->vrows - vc->vc_rows,
+		ops->bmove(vc, info, p->vrows - vc->vc_rows,
 			    0, 0, 0, vc->vc_rows, vc->vc_cols);
 		p->yscroll -= p->vrows - vc->vc_rows;
 	}
@@ -1207,10 +1208,11 @@ static __inline__ void ypan_down(struct 
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
 	
 	p->yscroll -= count;
 	if (p->yscroll < 0) {
-		fbcon_bmove(vc, 0, 0, p->vrows - vc->vc_rows,
+		ops->bmove(vc, info, 0, 0, p->vrows - vc->vc_rows,
 			    0, vc->vc_rows, vc->vc_cols);
 		p->yscroll += p->vrows - vc->vc_rows;
 	}
@@ -1461,6 +1463,7 @@ static int fbcon_scroll(struct vc_data *
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
 	int scroll_partial = info->flags & FBINFO_PARTIAL_PAN_OK;
 
 	if (!info->fbops->fb_blank && console_blanked)
@@ -1487,10 +1490,10 @@ static int fbcon_scroll(struct vc_data *
 			goto redraw_up;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
-			fbcon_bmove(vc, t + count, 0, t, 0,
+			ops->bmove(vc, info, t + count, 0, t, 0,
 				    b - t - count, vc->vc_cols);
-			fbcon_clear(vc, b - count, 0, count,
-					 vc->vc_cols);
+			ops->clear(vc, info, b - count, 0, count,
+				  vc->vc_cols);
 			break;
 
 		case SCROLL_WRAP_MOVE:
@@ -1571,9 +1574,9 @@ static int fbcon_scroll(struct vc_data *
 			count = vc->vc_rows;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
-			fbcon_bmove(vc, t, 0, t + count, 0,
+			ops->bmove(vc, info, t, 0, t + count, 0,
 				    b - t - count, vc->vc_cols);
-			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			ops->clear(vc, info, t, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_WRAP_MOVE:
@@ -1948,6 +1951,7 @@ static int fbcon_blank(struct vc_data *v
 	}
 
 	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
+	info->cursor.flash = (!blank);
 
 	if (!info->fbops->fb_blank) {
 		if (blank) {


