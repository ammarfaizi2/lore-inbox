Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266580AbUH1IyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266580AbUH1IyO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 04:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUH1IyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 04:54:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6638 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266580AbUH1IyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 04:54:08 -0400
Date: Sat, 28 Aug 2004 10:54:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1 - undefined references - [PATCH]
Message-ID: <20040828085404.GW12772@fs.tum.de>
References: <20040826014745.225d7a2c.akpm@osdl.org> <200408262053.08255.ornati@fastwebnet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408262053.08255.ornati@fastwebnet.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 08:53:08PM +0200, Paolo Ornati wrote:
> On Thursday 26 August 2004 10:47, you wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/
> >
> 
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CPP     arch/i386/kernel/vsyscall.lds.s
>   SYSCALL arch/i386/kernel/vsyscall-int80.so
>   SYSCALL arch/i386/kernel/vsyscall-sysenter.so
>   AS      arch/i386/kernel/vsyscall.o
>   SYSCALL arch/i386/kernel/vsyscall-syms.o
>   LD      arch/i386/kernel/built-in.o
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.data+0x40a68): undefined reference to `cfb_fillrect'
> drivers/built-in.o(.data+0x40a6c): undefined reference to `cfb_copyarea'
> make: *** [.tmp_vmlinux1] Error 1
> 
> 
> as shown by the code (drivers/video/tdfxfb.c):
> 
> #ifdef CONFIG_FB_3DFX_ACCEL
>         .fb_fillrect    = tdfxfb_fillrect,
>         .fb_copyarea    = tdfxfb_copyarea,
>         .fb_imageblit   = tdfxfb_imageblit,
>         .fb_cursor      = tdfxfb_cursor,
> #else
>         .fb_fillrect    = cfb_fillrect,
>         .fb_copyarea    = cfb_copyarea,
>         .fb_imageblit   = cfb_imageblit,
>         .fb_cursor      = soft_cursor,
> #endif
> 
> 3dfx framebuffer driver depends on "cfb_fillrect.c" and "cfb_copyarea.c"
> if it's compiled without CONFIG_FB_3DFX_ACCEL turned on...
>...


Your analysis is correct, but the following patch is a bit better since 
it doesn't add a tdfxfb_lib:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.9-rc1-mm1-full/drivers/video/Makefile.old	2004-08-28 10:41:30.000000000 +0200
+++ linux-2.6.9-rc1-mm1-full/drivers/video/Makefile	2004-08-28 10:46:20.000000000 +0200
@@ -35,6 +35,9 @@
 obj-$(CONFIG_FB_GBE)              += gbefb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o cfbimgblt.o
+ifneq ($(CONFIG_FB_3DFX_ACCEL),y)
+  obj-$(CONFIG_FB_3DFX)           += cfbfillrect.o cfbcopyarea.o
+endif
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o

