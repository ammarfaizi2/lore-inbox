Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269389AbUHZTDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269389AbUHZTDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269368AbUHZSz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:55:29 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:37340 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S269367AbUHZSvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:51:04 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm1 - undefined references - [PATCH]
Date: Thu, 26 Aug 2004 20:53:08 +0200
User-Agent: KMail/1.6.2
References: <20040826014745.225d7a2c.akpm@osdl.org>
In-Reply-To: <20040826014745.225d7a2c.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408262053.08255.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 10:47, you wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/
>

make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CPP     arch/i386/kernel/vsyscall.lds.s
  SYSCALL arch/i386/kernel/vsyscall-int80.so
  SYSCALL arch/i386/kernel/vsyscall-sysenter.so
  AS      arch/i386/kernel/vsyscall.o
  SYSCALL arch/i386/kernel/vsyscall-syms.o
  LD      arch/i386/kernel/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.data+0x40a68): undefined reference to `cfb_fillrect'
drivers/built-in.o(.data+0x40a6c): undefined reference to `cfb_copyarea'
make: *** [.tmp_vmlinux1] Error 1


as shown by the code (drivers/video/tdfxfb.c):

#ifdef CONFIG_FB_3DFX_ACCEL
        .fb_fillrect    = tdfxfb_fillrect,
        .fb_copyarea    = tdfxfb_copyarea,
        .fb_imageblit   = tdfxfb_imageblit,
        .fb_cursor      = tdfxfb_cursor,
#else
        .fb_fillrect    = cfb_fillrect,
        .fb_copyarea    = cfb_copyarea,
        .fb_imageblit   = cfb_imageblit,
        .fb_cursor      = soft_cursor,
#endif

3dfx framebuffer driver depends on "cfb_fillrect.c" and "cfb_copyarea.c"
if it's compiled without CONFIG_FB_3DFX_ACCEL turned on...

Signed-off-by: Paolo Ornati <ornati@fastwebnet.it>

--- linux-2.6.9-rc1-mm1/drivers/video/Makefile.orig	2004-08-26 19:24:10.000000000 +0200
+++ linux-2.6.9-rc1-mm1/drivers/video/Makefile	2004-08-26 20:27:55.097186528 +0200
@@ -34,7 +34,11 @@ obj-$(CONFIG_FB_CYBER)            += cyb
 obj-$(CONFIG_FB_CYBER2000)        += cyber2000fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_GBE)              += gbefb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_3DFX)             += tdfxfb.o cfbimgblt.o
+obj-$(CONFIG_FB_3DFX)             += tdfxfb.o tdfxfb_lib.o
+tdfxfb_lib-y                      := cfbimgblt.o
+ifneq ($(CONFIG_FB_3DFX_ACCEL),y)
+tdfxfb_lib-y                      += cfbfillrect.o cfbcopyarea.o
+endif
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o


-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.8-gentoo-r1)
