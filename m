Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266467AbRGCHui>; Tue, 3 Jul 2001 03:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266463AbRGCHuS>; Tue, 3 Jul 2001 03:50:18 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:24075 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S266457AbRGCHuO>;
	Tue, 3 Jul 2001 03:50:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15169.30616.190474.603946@gargle.gargle.HOWL>
Date: Tue, 3 Jul 2001 17:43:20 +1000
From: Christopher Yeoh <cyeoh@samba.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more penguins
X-Mailer: VM 6.92 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.4.5 so we can display a decent number of
penguins at boot time (wraps the display of the boot penguins when
they can't all fit on one line).

Chris.
-- 
yeohc@au1.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia

diff -urN linux-2.4.5/drivers/video/fbcon.c linux-2.4.5-logo/drivers/video/fbcon.c
--- linux-2.4.5/drivers/video/fbcon.c	Thu Feb 22 14:25:28 2001
+++ linux-2.4.5-logo/drivers/video/fbcon.c	Sun Jul  1 17:10:27 2001
@@ -608,8 +608,16 @@
     	/* Need to make room for the logo */
 	int cnt;
 	int step;
-    
-    	logo_lines = (LOGO_H + fontheight(p) - 1) / fontheight(p);
+        int logo_rows;
+
+        /* Work out how many rows of logos will be displayed.
+           Leave at least two rows worth of logos at bottom to
+           display boot information */
+        logo_rows = (smp_num_cpus - 1) / (p->var.xres/(LOGO_W+8)) + 1;
+        if ((int)p->var.yres - logo_rows * (LOGO_H+8) < LOGO_H*2)
+            logo_rows = (p->var.yres - LOGO_H*2) / (LOGO_H+8);
+
+    	logo_lines = ((LOGO_H+8)*logo_rows + fontheight(p) - 9) / fontheight(p);
     	q = (unsigned short *)(conp->vc_origin + conp->vc_size_row * old_rows);
     	step = logo_lines * old_cols;
     	for (r = q - logo_lines * old_cols; r < q; r++)
@@ -2055,6 +2063,7 @@
     unsigned char *dst, *src;
     int i, j, n, x1, y1, x;
     int logo_depth, done = 0;
+    int yoff = 0, logo_count = 0;
 
     /* Return if the frame buffer is not mapped */
     if (!fb)
@@ -2115,8 +2124,8 @@
     if (p->fb_info->fbops->fb_rasterimg)
     	p->fb_info->fbops->fb_rasterimg(p->fb_info, 1);
 
-    for (x = 0; x < smp_num_cpus * (LOGO_W + 8) &&
-    	 x < p->var.xres - (LOGO_W + 8); x += (LOGO_W + 8)) {
+    x = 0;
+    while (logo_count < smp_num_cpus && yoff < p->var.yres - (LOGO_H*3)) {
     	 
 #if defined(CONFIG_FBCON_CFB16) || defined(CONFIG_FBCON_CFB24) || \
     defined(CONFIG_FBCON_CFB32) || defined(CONFIG_FB_SBUS)
@@ -2134,7 +2143,7 @@
 		/* have at least 8 bits per color */
 		src = logo;
 		bdepth = depth/8;
-		for( y1 = 0; y1 < LOGO_H; y1++ ) {
+		for( y1 = yoff; y1 < yoff + LOGO_H; y1++ ) {
 		    dst = fb + y1*line + x*bdepth;
 		    for( x1 = 0; x1 < LOGO_W; x1++, src++ ) {
 			val = (*src << redshift) |
@@ -2160,7 +2169,7 @@
 		unsigned int pix;
 		src = linux_logo16;
 		bdepth = (depth+7)/8;
-		for( y1 = 0; y1 < LOGO_H; y1++ ) {
+		for( y1 = yoff; y1 < yoff + LOGO_H; y1++ ) {
 		    dst = fb + y1*line + x*bdepth;
 		    for( x1 = 0; x1 < LOGO_W/2; x1++, src++ ) {
 			pix = (*src >> 4) | 0x10; /* upper nibble */
@@ -2208,7 +2217,7 @@
 	    blueshift  = p->var.blue.offset  - (8-p->var.blue.length);
 
 	    src = logo;
-	    for( y1 = 0; y1 < LOGO_H; y1++ ) {
+	    for( y1 = yoff; y1 < yoff + LOGO_H; y1++ ) {
 		dst = fb + y1*line + x*bdepth;
 		for( x1 = 0; x1 < LOGO_W; x1++, src++ ) {
 		    val = safe_shift((linux_logo_red[*src-32]   & redmask), redshift) |
@@ -2234,7 +2243,7 @@
 #if defined(CONFIG_FBCON_CFB4)
 	if (depth == 4 && p->type == FB_TYPE_PACKED_PIXELS) {
 		src = logo;
-		for( y1 = 0; y1 < LOGO_H; y1++) {
+		for( y1 = yoff; y1 < yoff + LOGO_H; y1++) {
 			dst = fb + y1*line + x/2;
 			for( x1 = 0; x1 < LOGO_W/2; x1++) {
 				u8 q = *src++;
@@ -2250,7 +2259,7 @@
 	    /* depth 8 or more, packed, with color registers */
 		
 	    src = logo;
-	    for( y1 = 0; y1 < LOGO_H; y1++ ) {
+	    for( y1 = yoff; y1 < yoff + LOGO_H; y1++ ) {
 		dst = fb + y1*line + x;
 		for( x1 = 0; x1 < LOGO_W; x1++ )
 		    fb_writeb (*src++, dst++);
@@ -2282,7 +2291,7 @@
 			 (1 << ((8-((pix*logo_depth)&7)-logo_depth) + bit)))
 		
 	    src = logo;
-	    for( y1 = 0; y1 < LOGO_H; y1++ ) {
+	    for( y1 = yoff; y1 < yoff + LOGO_H; y1++ ) {
 		for( x1 = 0; x1 < LOGO_LINE; x1++, src += logo_depth ) {
 		    dst = fb + y1*line + MAP_X(x/8+x1);
 		    for( bit = 0; bit < logo_depth; bit++ ) {
@@ -2301,7 +2310,7 @@
 	     * special case for logo_depth == 4: we used color registers 16..31,
 	     * so fill plane 4 with 1 bits instead of 0 */
 	    if (depth > logo_depth) {
-		for( y1 = 0; y1 < LOGO_H; y1++ ) {
+		for( y1 = yoff; y1 < yoff + LOGO_H; y1++ ) {
 		    for( x1 = 0; x1 < LOGO_LINE; x1++ ) {
 			dst = fb + y1*line + MAP_X(x/8+x1) + logo_depth*plane;
 			for( i = logo_depth; i < depth; i++, dst += plane )
@@ -2327,7 +2336,7 @@
 
 	    int is_hga = !strncmp(p->fb_info->modename, "HGA", 3);
 	    /* can't use simply memcpy because need to apply inverse */
-	    for( y1 = 0; y1 < LOGO_H; y1++ ) {
+	    for( y1 = yoff; y1 < yoff + LOGO_H; y1++ ) {
 		src = logo + y1*LOGO_LINE;
 		if (is_hga)
 		    dst = fb + (y1%4)*8192 + (y1>>2)*line + x/8;
@@ -2346,7 +2355,7 @@
 		outb_p(5,0x3ce); outb_p(0,0x3cf);
 
 		src = logo;
-		for (y1 = 0; y1 < LOGO_H; y1++) {
+		for (y1 = yoff; y1 < yoff + LOGO_H; y1++) {
 			for (x1 = 0; x1 < LOGO_W / 2; x1++) {
 				dst = fb + y1*line + x1/4 + x/8;
 
@@ -2370,6 +2379,12 @@
 		done = 1;
 	}
 #endif			
+        logo_count++;
+        x += LOGO_W + 8;
+        if (x >= p->var.xres - (LOGO_W + 8)) {
+            yoff += LOGO_H + 8;
+            x = 0;
+        }
     }
     
     if (p->fb_info->fbops->fb_rasterimg)

