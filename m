Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288668AbSAQNL1>; Thu, 17 Jan 2002 08:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288671AbSAQNLN>; Thu, 17 Jan 2002 08:11:13 -0500
Received: from 12-237-138-17.client.attbi.com ([12.237.138.17]:36739 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S288668AbSAQNLI>; Thu, 17 Jan 2002 08:11:08 -0500
Message-ID: <3C46CD56.8080101@attbi.com>
Date: Thu, 17 Jan 2002 07:10:46 -0600
From: Jordan Breeding <ledzep37@attbi.com>
Reply-To: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: reddog83@chartermi.net
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radeonfb for kernel-2.4.18-pre1
In-Reply-To: <auto-000047991150@front1.chartermi.net>
Content-Type: multipart/mixed;
 boundary="------------060302010905050901040302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060302010905050901040302
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

reddog83 wrote:

> Hi this patch fix's up the compiling issue with the Radeon Frame Buffer 
> driver. With this patch it should compile. I checked all over the LKML and 
> there has ben acouple of people who have sent the same patch in but have not 
> been acknowledged. Please apply this patch. Or Alan would you please include 
> this patch in your next ac release if you do have one? 
> Thank you Victor

<more content snipped>

>  @@ -2647,7 +2648,7 @@
>               OUTREG(FP_VERT_STRETCH, mode->fp_vert_stretch);
>               OUTREG(FP_GEN_CNTL, mode->fp_gen_cntl);
>               OUTREG(TMDS_CRC, mode->tmds_crc);
> -             OUTREG(TMDS_TRANSMITTER_CNTL, mode->tmds_transmitter_cntl);
> +/*           OUTREG(TMDS_TRANSMITTER_CNTL, mode->tmds_transmitter_cntl); */
>                if (primary_mon == MT_LCD) {
>                       unsigned int tmp = INREG(LVDS_GEN_CNTL);
> 


This should be the correct patch, which instead of disabling code in the 
driver just correctly defines the necessary code in radeon.h.  This 
patch was posted to linux-kernel a while back and when it was originally 
posted it was said to have come straight from Ani Joshi.  This would 
make sense as it brings the mainline radeon.h in sync with the radeon.h 
which is in the linuxppc-devel bitkeeper tree.

Jordan



--------------060302010905050901040302
Content-Type: text/plain;
 name="patch-ani-radeonfb-2.4.18-pre2-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ani-radeonfb-2.4.18-pre2-1"

--- linux/drivers/video/radeon.h.orig	Wed Dec 26 19:18:54 2001
+++ linux/drivers/video/radeon.h	Wed Dec 26 19:20:24 2001
@@ -97,5 +97,7 @@
 #define MEM_VGA_RP_SEL                         0x003C  
 #define HDP_DEBUG                              0x0138    
-#define SW_SEMAPHORE                           0x013C  
+#define SW_SEMAPHORE                           0x013C
+#define CRTC2_GEN_CNTL                         0x03f8  
+#define CRTC2_DISPLAY_BASE_ADDR                0x033c
 #define SURFACE_CNTL                           0x0B00  
 #define SURFACE0_LOWER_BOUND                   0x0B04  
@@ -338,4 +338,5 @@
 #define DST_WIDTH_HEIGHT		       0x1598
 #define DST_HEIGHT_WIDTH		       0x143c
+#define DST_OFFSET                             0x1404
 #define SRC_CLUT_ADDRESS                       0x1780  
 #define SRC_CLUT_DATA                          0x1784  
@@ -381,4 +381,5 @@
 #define LVDS_PLL_CNTL			       0x02d4
 #define TMDS_CRC			       0x02a0
+#define TMDS_TRANSMITTER_CNTL		       0x02a4
 
 #define RADEON_BASE_CODE		       0x0f0b
@@ -407,9 +407,9 @@
 #define SCLK_CNTL                                  0x000d
 #define MPLL_CNTL                                  0x000e
+#define MDLL_CKO                                   0x000f
 #define MCLK_CNTL                                  0x0012
 #define AGP_PLL_CNTL                               0x000b
 #define PLL_TEST_CNTL                              0x0013
-
 
 /* MCLK_CNTL bit constants */
 #define FORCEON_MCLKA				   (1 << 16)
@@ -475,8 +475,15 @@
 #define CRTC_EXT_DISP_EN      			   (1 << 24)
 #define CRTC_EN					   (1 << 25)
+#define CRTC_DISP_REQ_EN_B                         (1 << 26)
 
 /* CRTC_STATUS bit constants */
 #define CRTC_VBLANK                                0x00000001
 
+/* CRTC2_GEN_CNTL bit constants */
+#define CRT2_ON                                    (1 << 7)
+#define CRTC2_DISPLAY_DIS                          (1 << 23)
+#define CRTC2_EN                                   (1 << 25)
+#define CRTC2_DISP_REQ_EN_B                        (1 << 26)
+
 /* CUR_OFFSET, CUR_HORZ_VERT_POSN, CUR_HORZ_VERT_OFF bit constants */
 #define CUR_LOCK                                   0x80000000
@@ -524,12 +524,24 @@
 #define LVDS_PANEL_FORMAT			   (1 << 3)
 #define LVDS_EN					   (1 << 7)
+#define LVDS_BL_MOD_LEVEL_MASK			   0x0000ff00
+#define LVDS_BL_MOD_LEVEL_SHIFT			   8
+#define LVDS_BL_MOD_EN				   (1 << 16)
 #define LVDS_DIGON				   (1 << 18)
 #define LVDS_BLON				   (1 << 19)
 #define LVDS_SEL_CRTC2				   (1 << 23)
+#define LVDS_STATE_MASK	\
+	(LVDS_ON | LVDS_DISPLAY_DIS | LVDS_BL_MOD_LEVEL_MASK | \
+	 LVDS_EN | LVDS_DIGON | LVDS_BLON)
 
 /* LVDS_PLL_CNTL bit constatns */
 #define HSYNC_DELAY_SHIFT			   0x1c
 #define HSYNC_DELAY_MASK			   (0xf << 0x1c)
 
+/* TMDS_TRANSMITTER_CNTL bit constants */
+#define TMDS_PLL_EN				   (1 << 0)
+#define TMDS_PLLRST				   (1 << 1)
+#define TMDS_RAN_PAT_RST			   (1 << 7)
+#define ICHCSEL					   (1 << 28)
+
 /* FP_HORZ_STRETCH bit constants */
 #define HORZ_STRETCH_RATIO_MASK			   0xffff
@@ -562,4 +562,5 @@
 #define DAC_CRC_EN                                 0x00080000
 #define DAC_MASK_ALL				   (0xff << 24)
+#define DAC_EXPAND_MODE				   (1 << 14)
 #define DAC_VGA_ADR_EN				   (1 << 13)
 #define DAC_RANGE_CNTL				   (3 << 0)
@@ -743,4 +743,13 @@
 #define DP_SRC_HOST_BYTEALIGN                      0x00000400
 
+/* MPLL_CNTL bit constants */
+#define MPLL_RESET                                 0x00000001
+
+/* MDLL_CKO bit constants */
+#define MDLL_CKO__MCKOA_RESET                      0x00000002
+
+/* VCLK_ECP_CNTL constants */
+#define PIXCLK_ALWAYS_ONb                          0x00000040
+#define PIXCLK_DAC_ALWAYS_ONb                      0x00000080
 
 /* masks */

--------------060302010905050901040302--

