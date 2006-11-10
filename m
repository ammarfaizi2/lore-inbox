Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965984AbWKJDcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965984AbWKJDcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 22:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966073AbWKJDcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 22:32:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965984AbWKJDcI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 22:32:08 -0500
Date: Thu, 9 Nov 2006 19:31:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5-mm1
Message-Id: <20061109193153.a9709912.akpm@osdl.org>
In-Reply-To: <200611092221.49238.edt@aei.ca>
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	<200611092221.49238.edt@aei.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006 22:21:49 -0500
Ed Tomlinson <edt@aei.ca> wrote:

> On Wednesday 08 November 2006 04:54, Andrew Morton wrote:
> > -radeonfb-support-24bpp-32bpp-minus-alpha.patch
> > 
> >  Dropped
> > 
> > +various-fbdev-files-mark-structs-fix.patch
> > 
> >  Fix various-fbdev-files-mark-structs.patch
> > 
> > +fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch
> > 
> >  fbdev fix
> 
> Strongly suspect that something is not right with these patches.  I have a:
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01) (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc Unknown device 2002
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (2000ns min), Cache Line Size 08
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
>         Region 1: I/O ports at 8000 [size=256]
>         Region 2: Memory at e9010000 (32-bit, non-prefetchable) [size=64K]
>         [virtual] Expansion ROM at e8000000 [disabled] [size=128K]
>         Capabilities: [58] AGP version 3.0
>                 Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
>                 Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>  
> booting with: 
> 
> kernel /boot/2.6.19-rc5-mm1 root=/dev/sda3 vga=0x318 video=vesafb:ywrap,mtrr:3 console=tty0 console=ttyS0,38400 nmi_watchdog=1
> 
> gives a strangely corrupted screen.  The characters seem reversed...
> 

Yup, thanks.  You'll need to revert
fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch:'


diff -puN drivers/video/cfbimgblt.c~revert-fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit drivers/video/cfbimgblt.c
--- a/drivers/video/cfbimgblt.c~revert-fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit
+++ a/drivers/video/cfbimgblt.c
@@ -168,7 +168,7 @@ static inline void slow_imageblit(const 
 
 		while (j--) {
 			l--;
-			color = (*s & (1 << FB_BIT_NR(l))) ? fgcolor : bgcolor;
+			color = (*s & (1 << l)) ? fgcolor : bgcolor;
 			val |= FB_SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */
@@ -258,7 +258,7 @@ static inline void fast_imageblit(const 
 		s += spitch;
 	}
 }	
-
+	
 void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
 {
 	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
diff -puN include/linux/fb.h~revert-fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit include/linux/fb.h
--- a/include/linux/fb.h~revert-fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit
+++ a/include/linux/fb.h
@@ -854,12 +854,10 @@ struct fb_info {
 #endif
 
 #if defined (__BIG_ENDIAN)
-#define FB_BIT_NR(b)              (b)
 #define FB_LEFT_POS(bpp)          (32 - bpp)
 #define FB_SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) << (bits))
 #else
-#define FB_BIT_NR(b)              (7 - (b))
 #define FB_LEFT_POS(bpp)          (0)
 #define FB_SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) >> (bits))
_

