Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266088AbUF2Vts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266088AbUF2Vts (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUF2Vts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:49:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:56257 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266088AbUF2Vs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:48:58 -0400
Date: Tue, 29 Jun 2004 14:45:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] convert private ABS() to kernel's abs()
Message-Id: <20040629144520.28674a65.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Convert private ABS() defines and callers to use abs() from linux/kernel.h.
Builds successfully.  stv0299, riva, & sstfb modules load.
[ia64 not built]

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 arch/ia64/sn/fakeprom/fw-emu.c        |    4 ++--
 drivers/char/ftape/lowlevel/fdc-io.c  |    5 +++--
 drivers/media/dvb/frontends/stv0299.c |    6 ++----
 drivers/video/riva/riva_hw.c          |   23 ++++++++++++-----------
 drivers/video/sstfb.c                 |    4 ++--
 include/linux/ftape.h                 |    1 -
 include/video/sstfb.h                 |    4 ----
 7 files changed, 21 insertions(+), 26 deletions(-)

diff -Naurp ./arch/ia64/sn/fakeprom/fw-emu.c~rm_ABS ./arch/ia64/sn/fakeprom/fw-emu.c
--- ./arch/ia64/sn/fakeprom/fw-emu.c~rm_ABS	2004-06-15 22:19:44.000000000 -0700
+++ ./arch/ia64/sn/fakeprom/fw-emu.c	2004-06-29 13:11:52.000000000 -0700
@@ -37,6 +37,7 @@
  */
 #include <linux/config.h>
 #include <linux/efi.h>
+#include <linux/kernel.h>
 #include <asm/pal.h>
 #include <asm/sal.h>
 #include <asm/sn/sn_sal.h>
@@ -78,7 +79,6 @@
 #define BOOT_PARAM_ADDR 0x40000
 #define MAX(i,j)		((i) > (j) ? (i) : (j))
 #define MIN(i,j)		((i) < (j) ? (i) : (j))
-#define ABS(i)			((i) > 0   ? (i) : -(i))
 #define ALIGN8(p)		(((long)(p) +7) & ~7)
 
 #define FPROM_BUG()		do {while (1);} while (0)
@@ -670,7 +670,7 @@ sys_fw_init (const char *args, int argle
 	for (i=0; i<=max_nasid; i++)
 		for (j=0; j<=max_nasid; j++)
 			if (nasid_present(i) && nasid_present(j))
-				*(cp+PROXIMITY_DOMAIN(i)*acpi_slit->localities+PROXIMITY_DOMAIN(j)) = 10 + MIN(254, 5*ABS(i-j));
+				*(cp+PROXIMITY_DOMAIN(i)*acpi_slit->localities+PROXIMITY_DOMAIN(j)) = 10 + MIN(254, 5*abs(i-j));
 
 	cp = acpi_slit->entry + acpi_slit->localities*acpi_slit->localities;
 	acpi_checksum(&acpi_slit->header, cp - (char*)acpi_slit);
diff -Naurp ./include/linux/ftape.h~rm_ABS ./include/linux/ftape.h
--- ./include/linux/ftape.h~rm_ABS	2004-06-15 22:19:42.000000000 -0700
+++ ./include/linux/ftape.h	2004-06-29 12:44:01.000000000 -0700
@@ -195,7 +195,6 @@ typedef union {
 
 /*      some useful macro's
  */
-#define ABS(a)          ((a) < 0 ? -(a) : (a))
 #define NR_ITEMS(x)     (int)(sizeof(x)/ sizeof(*x))
 
 #endif  /* __KERNEL__ */
diff -Naurp ./include/video/sstfb.h~rm_ABS ./include/video/sstfb.h
--- ./include/video/sstfb.h~rm_ABS	2004-06-15 22:18:58.000000000 -0700
+++ ./include/video/sstfb.h	2004-06-29 12:43:35.000000000 -0700
@@ -72,10 +72,6 @@
 #define BIT(x)		(1ul<<(x))
 #define POW2(x)		(1ul<<(x))
 
-#ifndef ABS
-# define ABS(x)		(((x)<0)?-(x):(x))
-#endif
-
 /*
  *
  *  Const
diff -Naurp ./drivers/video/riva/riva_hw.c~rm_ABS ./drivers/video/riva/riva_hw.c
--- ./drivers/video/riva/riva_hw.c~rm_ABS	2004-06-15 22:20:27.000000000 -0700
+++ ./drivers/video/riva/riva_hw.c	2004-06-29 13:08:35.000000000 -0700
@@ -46,6 +46,7 @@
 
 /* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/nv/riva_hw.c,v 1.33 2002/08/05 20:47:06 mvojkovi Exp $ */
 
+#include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
 #include "riva_hw.h"
@@ -147,7 +148,7 @@ static int ShowHideCursor
 #define GFIFO_SIZE_128	256
 #define MFIFO_SIZE	120
 #define VFIFO_SIZE	256
-#define	ABS(a)	(a>0?a:-a)
+
 typedef struct {
   int gdrain_rate;
   int vdrain_rate;
@@ -376,44 +377,44 @@ static int nv3_iterate(nv3_fifo_info *re
         }
         ns = 1000000*ainfo->gburst_size/(state->memory_width/8)/state->mclk_khz;
         tmp = ns * ainfo->gdrain_rate/1000000;
-        if (ABS(ainfo->gburst_size) + ((ABS(ainfo->wcglwm) + 16 ) & ~0x7) - tmp > max_gfsize)
+        if (abs(ainfo->gburst_size) + ((abs(ainfo->wcglwm) + 16 ) & ~0x7) - tmp > max_gfsize)
         {
             ainfo->converged = 0;
             return (1);
         }
         ns = 1000000*ainfo->vburst_size/(state->memory_width/8)/state->mclk_khz;
         tmp = ns * ainfo->vdrain_rate/1000000;
-        if (ABS(ainfo->vburst_size) + (ABS(ainfo->wcvlwm + 32) & ~0xf)  - tmp> VFIFO_SIZE)
+        if (abs(ainfo->vburst_size) + (abs(ainfo->wcvlwm + 32) & ~0xf)  - tmp> VFIFO_SIZE)
         {
             ainfo->converged = 0;
             return (1);
         }
-        if (ABS(ainfo->gocc) > max_gfsize)
+        if (abs(ainfo->gocc) > max_gfsize)
         {
             ainfo->converged = 0;
             return (1);
         }
-        if (ABS(ainfo->vocc) > VFIFO_SIZE)
+        if (abs(ainfo->vocc) > VFIFO_SIZE)
         {
             ainfo->converged = 0;
             return (1);
         }
-        if (ABS(ainfo->mocc) > MFIFO_SIZE)
+        if (abs(ainfo->mocc) > MFIFO_SIZE)
         {
             ainfo->converged = 0;
             return (1);
         }
-        if (ABS(vfsize) > VFIFO_SIZE)
+        if (abs(vfsize) > VFIFO_SIZE)
         {
             ainfo->converged = 0;
             return (1);
         }
-        if (ABS(gfsize) > max_gfsize)
+        if (abs(gfsize) > max_gfsize)
         {
             ainfo->converged = 0;
             return (1);
         }
-        if (ABS(mfsize) > MFIFO_SIZE)
+        if (abs(mfsize) > MFIFO_SIZE)
         {
             ainfo->converged = 0;
             return (1);
@@ -493,8 +494,8 @@ static char nv3_arb(nv3_fifo_info * res_
     }
     if (ainfo->converged)
     {
-        res_info->graphics_lwm = (int)ABS(ainfo->wcglwm) + 16;
-        res_info->video_lwm = (int)ABS(ainfo->wcvlwm) + 32;
+        res_info->graphics_lwm = (int)abs(ainfo->wcglwm) + 16;
+        res_info->video_lwm = (int)abs(ainfo->wcvlwm) + 32;
         res_info->graphics_burst_size = ainfo->gburst_size;
         res_info->video_burst_size = ainfo->vburst_size;
         res_info->graphics_hi_priority = (ainfo->priority == GRAPHICS);
diff -Naurp ./drivers/video/sstfb.c~rm_ABS ./drivers/video/sstfb.c
--- ./drivers/video/sstfb.c~rm_ABS	2004-06-29 10:09:26.000000000 -0700
+++ ./drivers/video/sstfb.c	2004-06-29 12:41:24.000000000 -0700
@@ -349,10 +349,10 @@ static int sst_calc_pll(const int freq, 
 		if (m >= 128)
 			break;
 		fout = (DAC_FREF * (m + 2)) / ((1 << p) * (n + 2));
-		if ((ABS(fout - freq) < best_err) && (m > 0)) {
+		if ((abs(fout - freq) < best_err) && (m > 0)) {
 			best_n = n;
 			best_m = m;
-			best_err = ABS(fout - freq);
+			best_err = abs(fout - freq);
 			/* we get the lowest m , allowing 0.5% error in freq*/
 			if (200*best_err < freq) break;
 		}
diff -Naurp ./drivers/char/ftape/lowlevel/fdc-io.c~rm_ABS ./drivers/char/ftape/lowlevel/fdc-io.c
--- ./drivers/char/ftape/lowlevel/fdc-io.c~rm_ABS	2004-06-15 22:20:27.000000000 -0700
+++ ./drivers/char/ftape/lowlevel/fdc-io.c	2004-06-29 12:39:37.000000000 -0700
@@ -31,6 +31,7 @@
 #include <linux/sched.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -786,8 +787,8 @@ int fdc_seek(int track)
 		}
 	}
 #ifdef TESTING
-	time = ftape_timediff(time, ftape_timestamp()) / ABS(track - ftape_current_cylinder);
-	if ((time < 900 || time > 3100) && ABS(track - ftape_current_cylinder) > 5) {
+	time = ftape_timediff(time, ftape_timestamp()) / abs(track - ftape_current_cylinder);
+	if ((time < 900 || time > 3100) && abs(track - ftape_current_cylinder) > 5) {
 		TRACE(ft_t_warn, "Wrong FDC STEP interval: %d usecs (%d)",
                          time, track - ftape_current_cylinder);
 	}
diff -Naurp ./drivers/media/dvb/frontends/stv0299.c~rm_ABS ./drivers/media/dvb/frontends/stv0299.c
--- ./drivers/media/dvb/frontends/stv0299.c~rm_ABS	2004-06-15 22:20:26.000000000 -0700
+++ ./drivers/media/dvb/frontends/stv0299.c	2004-06-29 12:55:03.000000000 -0700
@@ -418,8 +418,6 @@ static int tsa5059_set_tv_freq	(struct d
 }
 
 
-
-#define ABS(x) ((x) < 0 ? -(x) : (x))
 #define MIN2(a,b) ((a) < (b) ? (a) : (b))
 #define MIN3(a,b,c) MIN2(MIN2(a,b),c)
 
@@ -436,8 +434,8 @@ static int tua6100_set_tv_freq	(struct d
 
 	first_ZF = (freq) / 1000;
 
-	if (ABS(MIN2(ABS(first_ZF-1190),ABS(first_ZF-1790))) <
-	    ABS(MIN3(ABS(first_ZF-1202),ABS(first_ZF-1542),ABS(first_ZF-1890))))
+	if (abs(MIN2(abs(first_ZF-1190),abs(first_ZF-1790))) <
+	    abs(MIN3(abs(first_ZF-1202),abs(first_ZF-1542),abs(first_ZF-1890))))
 		_fband = 2;
 	else
 		_fband = 3;


--

