Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbSL0XKl>; Fri, 27 Dec 2002 18:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSL0XKl>; Fri, 27 Dec 2002 18:10:41 -0500
Received: from are.twiddle.net ([64.81.246.98]:33929 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265222AbSL0XKg>;
	Fri, 27 Dec 2002 18:10:36 -0500
Date: Fri, 27 Dec 2002 15:18:43 -0800
From: Richard Henderson <rth@twiddle.net>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [FB PATCH] cfbimgblt isn't 64-bit clean
Message-ID: <20021227151843.A3108@twiddle.net>
Mail-Followup-To: linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The text is written as if it's thinking about handling 64-bit
unsigned long, but it doesn't.  The tables that map bits to
pixels are completely unprepared for this.

I thought about widening the tables, but I thought they'd get
unreasonably large.  There's no reason not to go ahead and 
handle this 32-bits at a time.

I've isolated this choice to two defines at the top of the 
file, WORD and BITS_PER_WORD, so it'll not be _that_ hard to
change if someone disagrees.


r~




You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.958, 2002-12-27 15:12:24-08:00, rth@are.twiddle.net
  [FB] Use u32 instead of unsigned long for cfbimgblt bit ops.
  The code that maps bits to pixels is not prepared to handle
  a 64-bit long.


 cfbimgblt.c |   94 +++++++++++++++++++++++++++++++-----------------------------
 1 files changed, 49 insertions, 45 deletions


diff -Nru a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
--- a/drivers/video/cfbimgblt.c	Fri Dec 27 15:16:03 2002
+++ b/drivers/video/cfbimgblt.c	Fri Dec 27 15:16:03 2002
@@ -21,13 +21,13 @@
  *
  *  FIXME
  *  The code for 24 bit is horrible. It copies byte by byte size instead of
- *  longs like the other sizes. Needs to be optimized.
+ *  words like the other sizes. Needs to be optimized.
  *  
  *  Tony: 
  *  Incorporate mask tables similar to fbcon-cfb*.c in 2.4 API.  This speeds 
  *  up the code significantly.
  *  
- *  Code for depths not multiples of BITS_PER_LONG is still kludgy, which is
+ *  Code for depths not multiples of BITS_PER_WORD is still kludgy, which is
  *  still processed a bit at a time.   
  *
  *  Also need to add code to deal with cards endians that are different than
@@ -48,7 +48,11 @@
 #define DPRINTK(fmt, args...)
 #endif
 
-static u32 cfb_tab8[] = {
+/* The following code can *not* handle a 64-bit long.  */
+#define WORD u32
+#define BITS_PER_WORD 32
+
+static WORD const cfb_tab8[] = {
 #if defined(__BIG_ENDIAN)
     0x00000000,0x000000ff,0x0000ff00,0x0000ffff,
     0x00ff0000,0x00ff00ff,0x00ffff00,0x00ffffff,
@@ -64,7 +68,7 @@
 #endif
 };
 
-static u32 cfb_tab16[] = {
+static WORD const cfb_tab16[] = {
 #if defined(__BIG_ENDIAN)
     0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
 #elif defined(__LITTLE_ENDIAN)
@@ -74,11 +78,11 @@
 #endif
 };
 
-static u32 cfb_tab32[] = {
+static WORD const cfb_tab32[] = {
 	0x00000000, 0xffffffff
 };
 
-#if BITS_PER_LONG == 32
+#if BITS_PER_WORD == 32
 #define FB_WRITEL fb_writel
 #define FB_READL  fb_readl
 #else
@@ -87,7 +91,7 @@
 #endif 
 
 #if defined (__BIG_ENDIAN)
-#define LEFT_POS(bpp)          (BITS_PER_LONG - bpp)
+#define LEFT_POS(bpp)          (BITS_PER_WORD - bpp)
 #define NEXT_POS(pos, bpp)     ((pos) -= (bpp))
 #define SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define SHIFT_LOW(val, bits)   ((val) << (bits))
@@ -99,25 +103,25 @@
 #endif
 
 static inline void color_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1, 
-				   unsigned long start_index, unsigned long pitch_index)
+				   WORD start_index, WORD pitch_index)
 {
 	/* Draw the penguin */
 	int i, n;
-	unsigned long bitmask = SHIFT_LOW(~0UL, BITS_PER_LONG - p->var.bits_per_pixel);
-	unsigned long *palette = (unsigned long *) p->pseudo_palette;
-	unsigned long *dst, *dst2, color = 0, val, shift;
-	unsigned long null_bits = BITS_PER_LONG - p->var.bits_per_pixel; 
+	WORD bitmask = SHIFT_LOW(~0UL, BITS_PER_WORD - p->var.bits_per_pixel);
+	u32 *palette = (u32 *) p->pseudo_palette;
+	WORD *dst, *dst2, color = 0, val, shift;
+	WORD null_bits = BITS_PER_WORD - p->var.bits_per_pixel; 
 	u8 *src = image->data;
 
-	dst2 = (unsigned long *) dst1;
+	dst2 = (WORD *) dst1;
 	for (i = image->height; i--; ) {
 		n = image->width;
-		dst = (unsigned long *) dst1;
+		dst = (WORD *) dst1;
 		shift = 0;
 		val = 0;
 		
 		if (start_index) {
-			unsigned long start_mask = ~(SHIFT_HIGH(~0UL, start_index));
+			WORD start_mask = ~(SHIFT_HIGH(~0UL, start_index));
 
 			val = FB_READL(dst) & start_mask;
 			shift = start_index;
@@ -134,14 +138,14 @@
 				if (shift == null_bits)
 					val = 0;
 				else
-					val = SHIFT_LOW(color, BITS_PER_LONG - shift);
+					val = SHIFT_LOW(color, BITS_PER_WORD - shift);
 			}
 			shift += p->var.bits_per_pixel;
-			shift &= (BITS_PER_LONG - 1);
+			shift &= (BITS_PER_WORD - 1);
 			src++;
 		}
 		if (shift) {
-			unsigned long  end_mask = SHIFT_HIGH(~0UL, shift);
+			WORD end_mask = SHIFT_HIGH(~0UL, shift);
 
 			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
 		}
@@ -149,35 +153,35 @@
 		if (pitch_index) {
 			dst2 += p->fix.line_length;
 			dst1 = (char *) dst2;
-			(unsigned long) dst1 &= ~(sizeof(unsigned long) - 1);
+			(size_t) dst1 &= ~(sizeof(WORD) - 1);
 
 			start_index += pitch_index;
-			start_index &= BITS_PER_LONG - 1;
+			start_index &= BITS_PER_WORD - 1;
 		}
 	}
 }
 
 static inline void slow_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1,
-				  unsigned long fgcolor, unsigned long bgcolor, 
-				  unsigned long start_index, unsigned long pitch_index)
+				  WORD fgcolor, WORD bgcolor, 
+				  WORD start_index, WORD pitch_index)
 {
-	unsigned long i, j, l = 8;
-	unsigned long shift, color, bpp = p->var.bits_per_pixel;
-	unsigned long *dst, *dst2, val, pitch = p->fix.line_length;
-	unsigned long null_bits = BITS_PER_LONG - bpp;
+	WORD i, j, l = 8;
+	WORD shift, color, bpp = p->var.bits_per_pixel;
+	WORD *dst, *dst2, val, pitch = p->fix.line_length;
+	WORD null_bits = BITS_PER_WORD - bpp;
 	u8 *src = image->data;
 	
-	dst2 = (unsigned long *) dst1;
+	dst2 = (WORD *) dst1;
 
 	for (i = image->height; i--; ) {
 		shift = 0;
 		val = 0;
 		j = image->width;
-		dst = (unsigned long *) dst1;
+		dst = (WORD *) dst1;
 
 		/* write leading bits */
 		if (start_index) {
-			unsigned long start_mask = ~(SHIFT_HIGH(~0UL, start_index));
+			WORD start_mask = ~(SHIFT_HIGH(~0UL, start_index));
 
 			val = FB_READL(dst) & start_mask;
 			shift = start_index;
@@ -196,15 +200,15 @@
 				if (shift == null_bits)
 					val = 0;
 				else
-					val = SHIFT_LOW(color, BITS_PER_LONG - shift);
+					val = SHIFT_LOW(color, BITS_PER_WORD - shift);
 			}
 			shift += bpp;
-			shift &= (BITS_PER_LONG - 1);
+			shift &= (BITS_PER_WORD - 1);
 			if (!l) { l = 8; src++; };
 		}
 		/* write trailing bits */
  		if (shift) {
-			unsigned long end_mask = SHIFT_HIGH(~0UL, shift);
+			WORD end_mask = SHIFT_HIGH(~0UL, shift);
 
 			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
 		}
@@ -213,24 +217,24 @@
 		if (pitch_index) {
 			dst2 += pitch;
 			dst1 = (char *) dst2;
-			(unsigned long) dst1 &= ~(sizeof(unsigned long) - 1);
+			(size_t) dst1 &= ~(sizeof(WORD) - 1);
 
 			start_index += pitch_index;
-			start_index &= BITS_PER_LONG - 1;
+			start_index &= BITS_PER_WORD - 1;
 		}
 		
 	}
 }
 
 static inline void fast_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1, 
-				  unsigned long fgcolor, unsigned long bgcolor) 
+				  WORD fgcolor, WORD bgcolor) 
 {
 	int i, j, k, l = 8, n;
-	unsigned long bit_mask, end_mask, eorx; 
-	unsigned long fgx = fgcolor, bgx = bgcolor, pad, bpp = p->var.bits_per_pixel;
-	unsigned long tmp = (1 << bpp) - 1;
-	unsigned long ppw = BITS_PER_LONG/bpp, ppos;
-	unsigned long *dst;
+	WORD bit_mask, end_mask, eorx; 
+	WORD fgx = fgcolor, bgx = bgcolor, pad, bpp = p->var.bits_per_pixel;
+	WORD tmp = (1 << bpp) - 1;
+	WORD ppw = BITS_PER_WORD/bpp, ppos;
+	WORD *dst;
 	u32 *tab = NULL;
 	char *src = image->data;
 		
@@ -263,7 +267,7 @@
 	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
-		dst = (unsigned long *) dst1;
+		dst = (WORD *) dst1;
 		
 		for (j = k; j--; ) {
 			l -= ppw;
@@ -291,8 +295,8 @@
 void cfb_imageblit(struct fb_info *p, struct fb_image *image)
 {
 	int x2, y2, vxres, vyres;
-	unsigned long fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
-	unsigned long bpl = sizeof(unsigned long), bpp = p->var.bits_per_pixel;
+	WORD fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
+	WORD bpl = sizeof(WORD), bpp = p->var.bits_per_pixel;
 	u8 *dst1;
 
 	vxres = p->var.xres_virtual;
@@ -315,7 +319,7 @@
 	image->height = y2 - image->dy;
 
 	bitstart = (image->dy * p->fix.line_length * 8) + (image->dx * bpp);
-	start_index = bitstart & (BITS_PER_LONG - 1);
+	start_index = bitstart & (BITS_PER_WORD - 1);
 	pitch_index = (p->fix.line_length & (bpl - 1)) * 8;
 
 	bitstart /= 8;
@@ -332,7 +336,7 @@
 			bgcolor = image->bg_color;
 		}	
 		
-		if (BITS_PER_LONG % bpp == 0 && !start_index && !pitch_index && 
+		if (BITS_PER_WORD % bpp == 0 && !start_index && !pitch_index && 
 		    bpp >= 8 && bpp <= 32 && (image->width & 7) == 0) 
 			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
 		else 

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch3145
M'XL(`#/?##X``[U76W/:.!1^QK_B[&0V`RP72[Y@2.FT*6V3:6:32=KI0[?#
M"%N`&F-[;!'27::_?8\D<(!<2KL7AY&0=*[?^8Y,#N!#P?->)9=3ZP!.TD+V
M*BSG+;D0413S5L(E[E^F*>ZWI^F,MU&R??RN+2>L25N>A:<73(93N.%YT:N0
MEE/NR*\9[U4N7[_]</;RTK+Z?7@U9<F$7W$)_;XET_R&Q5'Q@LEIG"8MF;.D
MF'')6F$Z6Y:B2VK;%/\\TG%LSU\2WW8[RY!$A#"7\,BF;N"[%H;U8B?P'1N$
MT@YU;-<.EH[C=@-K`*35]0*P:9O0-NT`\7J$]JC;M(.>;<,#)N$W`DW;.H9_
M-_A75@B?WAQ_5L6`N4-!)(7D+()T#/.D$).$1X!N)C!.<PC'(S&;C&()(R$A
MS8H6JK^?<@C3B(.<,@DSEA7JM,!`(1.W/"Y`%)"D$K*<9YA5I$XP3$P,M1GX
M;E-94TY:UCMP*.UVK(N[BEG-'WPLRV:V]1R^%&(V2Y/BQ92+@B<CGD\,6C<B
MEW,6:\"B7"C^M&]$Q--VF6`K-`!ZQ*<.M0E94M(-G"4+6<BCP!EWV-AV,>F'
MJO^T3<,&0HF]]%TWH)J?CZHHOOX?B=PYF;';!8_C%F>86RR2Z[URLCVT;5.Z
MI'[@4<UPXNX2G-A/$=SM0M/U_A.*[\7N-:=AF]*H_D.DOD]I4^9S:.8+_4&*
M7CQ>\9_@^X"Z0*Q3/4(=8)'F40&QN%89<$AQR*$0?W),[G?.(YW'"`\R*6:X
M';6L@6,K$WI4)EZI]!4J$<_DU.0ZF\=29#$O%'['I^^OAA>O+X<?SR\'"HU"
MBCB&ZW@>3;XV8#$5>!&+PAIX1!G&T;/:=0WM.(WC="$0=@URR!*HH_WZPP`"
MU-O60<3'(N&@G6$ERXWM,/#@#ZN03(K0B(;(:*GNK:%DH^#39^C#7];`[ZB0
M]/BH,/'7TATMW7E2VJ%KZ4"GJ\<#L0L3=CJ&..AJK/6XSN/L]9OWPXOSJ^HH
MRVI0/M5M_2:H8VN`G:8LF*F"#XIJ`0PPET.11/RV878R@6]$LZ,5?7"58A>G
MBA9`H&>LN,;HKTY.,8BS\X_5;_:'LP;L^LZ:SV]8WE*-,,QX/M2=4#NR*JJU
MZAF+N90<[53UNJ;DLX+/HW2X.CM:N:Q'A6SHD380QQAIU@>[`=CU#2BF8BS7
MDLD\CH>Z\_K[A7,$F"0QZ.BIHKRHH(SG&N":'"DASPAY&D+<?4B(ZDJ9"6'>
MP'B%V;>J0>WD].W)"K:-&M1JRHBC"60F5:P*YKD%MX;@/MX:"6W!-6&XJS#T
M`1SV[].#&''7B+L;4?,D&F[5>3/BTI%GD/-6O*JJ2V,H#1[*X3>]DXXU4+72
MH6>P]+Q5?'<(**5[02H5GP!%%9_B9!BL3\>3%1B&F^O5ILAW.>Z[FN/8WVN.
MBP9\:8`"/5@S2^>\8E]#M14>/LRHATBKF:K=&K6QN&WANY(/8YY,Y'0?^J)+
MA4/'E%9/CW*UXQLA_RFN!L92\(^XVNUJ(WKZ*:Y2<S71]=7T':Y2NV/$.S_*
M54HT*&;:GZOX\\>H=??F*J7&$_7+V_9QKM9`*73Q;7=*'0>G\I;5*37*Y/!;
MFM_B?559&;O%=$N3([TL^9^Q:"^2RID2J1)X]DR_*DP&YBS+%KLT;*,,&L_2
M8I/E*F7?I.P_Q3C:=54/TZZG>G@;DC+RK6Y50:MU8[-EU=V_=C_*%-LVZ_:=
MM`<."?0/%SUM5;-?NH/#1]CG./KB,E.E@N_K';E?C7>,$`X/X9<MLN!Z,PM<
;W_U/&DYY>%W,9WU&(I^&H6_]#;UYC$7P#@``
`
end
