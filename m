Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSK0K3W>; Wed, 27 Nov 2002 05:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSK0K3W>; Wed, 27 Nov 2002 05:29:22 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:49315 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262040AbSK0K3U> convert rfc822-to-8bit; Wed, 27 Nov 2002 05:29:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
Subject: Fwd: Re: [OOPS] 2.4.20-rc4-ac1 (also occurs 2.4.20-rc2-ac3) in radeon DRI for XFree86
Date: Wed, 27 Nov 2002 10:45:08 +0100
User-Agent: KMail/1.4.3
To: linux-kernel@vger.kernel.org
Cc: Joshua Kwan <joshk@mspencer.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211271045.08381.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan, Hi Joshua,

Arjan: many thnx! It fixes the problem :-)
Joshua: here the fix :)

----------  Forwarded Message  ----------

Subject: Re: [OOPS] 2.4.20-rc4-ac1 (also occurs 2.4.20-rc2-ac3) in radeon DRI 
for XFree86
Date: Wed, 27 Nov 2002 04:08:25 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>

On Wed, Nov 27, 2002 at 09:39:38AM +0100, Marc-Christian Petersen wrote:
> Hi Joshua,
>
> > Ksymoops output follows.
> > I compiled Radeon DRM stuff into the kernel -- i845 agp support from
> > agapgart. I am using gcc-3.2 to compile. 100% reproducible (okay, i've
> > been spending too much time on bugzillas...) Feel the power of the oops.
>
> I've posted a similar oops with latest rc2 -AC kernel. I have an ATI
> Rage128 card and also got those oops if using DRI.
>
> I hope Arjan may find the bug :)

I did:


diff -u linux-2.4.19/drivers/char/drm.org/r128_drv.h
 linux-2.4.19/drivers/char/drm/r128_drv.h ---
 linux-2.4.19/drivers/char/drm.org/r128_drv.h	2002-11-26 22:13:52.000000000
 +0100 +++ linux-2.4.19/drivers/char/drm/r128_drv.h	2002-11-26
 22:15:23.000000000 +0100 @@ -36,7 +36,7 @@
 #include <asm/delay.h>

 #define GET_RING_HEAD(ring)		readl(  (volatile u32 *) (ring)->head )
-#define SET_RING_HEAD(ring,val)		writel( (volatile u32 *) (ring)->head,
 (val) ) +#define SET_RING_HEAD(ring,val)		writel( (val), (volatile u32 *)
 (ring)->head )

 typedef struct drm_r128_freelist {
    	unsigned int age;
@@ -386,10 +386,10 @@
 #define R128_ADDR(reg)		(R128_BASE( reg ) + reg)

 #define R128_READ(reg)		readl(  (volatile u32 *) R128_ADDR(reg) )
-#define R128_WRITE(reg,val)	writel( (volatile u32 *) R128_ADDR(reg), (val) )
+#define R128_WRITE(reg,val)	writel( (val) , (volatile u32 *) R128_ADDR(reg))

 #define R128_READ8(reg)		readb(  (volatile u8 *) R128_ADDR(reg) )
-#define R128_WRITE8(reg,val)	writeb( (volatile u8 *) R128_ADDR(reg), (val) )
+#define R128_WRITE8(reg,val)	writeb( (val), (volatile u8 *) R128_ADDR(reg) )

 #define R128_WRITE_PLL(addr,val)					\
 do {									\
diff -u linux-2.4.19/drivers/char/drm.org/radeon_cp.c
 linux-2.4.19/drivers/char/drm/radeon_cp.c ---
 linux-2.4.19/drivers/char/drm.org/radeon_cp.c	2002-11-26 22:13:52.000000000
 +0100 +++ linux-2.4.19/drivers/char/drm/radeon_cp.c	2002-11-26
 22:16:22.000000000 +0100 @@ -929,7 +929,7 @@
 	RADEON_WRITE( RADEON_SCRATCH_UMSK, 0x7 );

 	/* Writeback doesn't seem to work everywhere, test it first */
-	writel( &dev_priv->scratch[1], 0 );
+	writel(0, &dev_priv->scratch[1]);
 	RADEON_WRITE( RADEON_SCRATCH_REG1, 0xdeadbeef );

 	for ( tmp = 0 ; tmp < dev_priv->usec_timeout ; tmp++ ) {
diff -u linux-2.4.19/drivers/char/drm.org/radeon_drv.h
 linux-2.4.19/drivers/char/drm/radeon_drv.h ---
 linux-2.4.19/drivers/char/drm.org/radeon_drv.h	2002-11-26 22:13:53.000000000
 +0100 +++ linux-2.4.19/drivers/char/drm/radeon_drv.h	2002-11-26
 22:15:40.000000000 +0100 @@ -32,7 +32,7 @@
 #define __RADEON_DRV_H__

 #define GET_RING_HEAD(ring)		readl(  (volatile u32 *) (ring)->head )
-#define SET_RING_HEAD(ring,val)		writel( (volatile u32 *) (ring)->head ,
 (val)) +#define SET_RING_HEAD(ring,val)		writel( (val), (volatile u32 *)
 (ring)->head )

 typedef struct drm_radeon_freelist {
    	unsigned int age;
@@ -706,10 +706,10 @@
 #define RADEON_ADDR(reg)	(RADEON_BASE( reg ) + reg)

 #define RADEON_READ(reg)	readl(  (volatile u32 *) RADEON_ADDR(reg) )
-#define RADEON_WRITE(reg,val)	writel( (volatile u32 *) RADEON_ADDR(reg),
 (val) ) +#define RADEON_WRITE(reg,val)	writel( (val), (volatile u32 *)
 RADEON_ADDR(reg))

 #define RADEON_READ8(reg)	readb(  (volatile u8 *) RADEON_ADDR(reg) )
-#define RADEON_WRITE8(reg,val)	writeb( (volatile u8 *) RADEON_ADDR(reg),
 (val) ) +#define RADEON_WRITE8(reg,val)	writeb( (val), (volatile u8 *)
 RADEON_ADDR(reg))

 #define RADEON_WRITE_PLL( addr, val )					\
 do {									\

-------------------------------------------------------


