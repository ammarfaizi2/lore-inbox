Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282976AbRLVXtL>; Sat, 22 Dec 2001 18:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbRLVXtB>; Sat, 22 Dec 2001 18:49:01 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:58632 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S282976AbRLVXss>;
	Sat, 22 Dec 2001 18:48:48 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DRM 4.0 support for kernel 2.4.17 
In-Reply-To: Your message of "Sat, 22 Dec 2001 20:36:02 BST."
             <20011222203602.A15825@caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 10:48:36 +1100
Message-ID: <17474.1009064916@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001 20:36:02 +0100, 
Christoph Hellwig <hch@caldera.de> wrote:
>I've placed a patch to allow optional drm 4.0 support in kernel 2.4.17
>at:
>
>ftp.kernel.org/pub/linux/kernel/people/hch/patches/v2.4/2.4.17/linux-2.4.17-drm40.patch.bz2
>
>Please report any fedback to me.  It has been submitted to Marcelo for inclusion
>into 2.4.18.

Only if the new version cleans up the horrible drm 4.0 Makefile.  The
separate copy of drmlib in each object and/or the kernel goes against
the rest of the kbuild design, needs an ugly makefile and AFAICT nobody
needs the separate copy of drmlib.  I will not maintain that crud into
kbuild 2.5.

drivers/char/drm-4.0/Makefile below uses the standard kbuild design.
One copy of drmlib-4.0 which is built into the kernel if any drm 4.0
drivers are built in, otherwise drmlib-4.0 is a module if there are any
drm 4.0 modules.  Totally untested.

Some of the code in $(drmlib-4.0-objs) will need EXPORT_SYMBOLS to work
when drm 4.0 drivers are compiled as modules.

#
# Makefile for the drm device driver.  This driver provides support for
# the Direct Rendering Infrastructure (DRI) in XFree86 4.x.
#

O_TARGET	:= drm.o

export-objs     := gamma_drv.o tdfx_drv.o r128_drv.o ffb_drv.o mga_drv.o \
		   i810_drv.o

list-multi	:= gamma.o tdfx.o r128.o ffb.o mga.o i810.o drmlib-4.0
gamma-objs	:= gamma_drv.o  gamma_dma.o
tdfx-objs	:= tdfx_drv.o                 tdfx_context.o
r128-objs	:= r128_drv.o   r128_cce.o    r128_context.o r128_bufs.o r128_state.o
ffb-objs	:= ffb_drv.o                  ffb_context.o
mga-objs	:= mga_drv.o    mga_dma.o     mga_context.o  mga_bufs.o  mga_state.o
i810-objs	:= i810_drv.o   i810_dma.o    i810_context.o i810_bufs.o
radeon-objs	:= radeon_drv.o radeon_cp.o   radeon_context.o radeon_bufs.o radeon_state.o
drmlib-4.0-objs	:= init.o memory.o proc.o auth.o context.o drawable.o bufs.o \
		   lists.o lock.o ioctl.o fops.o vm.o dma.o ctxbitmap.o

ifneq ($(subst n,,$(CONFIG_AGP)),)
  drmlib-4.0-objs  += agpsupport.o
endif

obj-$(CONFIG_DRM40_GAMMA) += gamma.o	drmlib-4.0.o
obj-$(CONFIG_DRM40_TDFX)  += tdfx.o	drmlib-4.0.o
obj-$(CONFIG_DRM40_R128)  += r128.o	drmlib-4.0.o
obj-$(CONFIG_DRM40_RADEON)+= radeon.o	drmlib-4.0.o
obj-$(CONFIG_DRM40_FFB)   += ffb.o	drmlib-4.0.o
obj-$(CONFIG_DRM40_MGA)   += mga.o	drmlib-4.0.o
obj-$(CONFIG_DRM40_I810)  += i810.o	drmlib-4.0.o

include $(TOPDIR)/Rules.make

drmlib-4.0.o: $(drmlib-4.0-objs)
	$(LD) -r -o $@ $^

gamma.o: $(gamma-objs)
	$(LD) -r -o $@ $^

tdfx.o: $(tdfx-objs)
	$(LD) -r -o $@ $^

mga.o: $(mga-objs)
	$(LD) -r -o $@ $^

i810.o: $(i810-objs)
	$(LD) -r -o $@ $^

r128.o: $(r128-objs)
	$(LD) -r -o $@ $^

radeon.o: $(radeon-objs)
	$(LD) -r -o $@ $^

ffb.o: $(ffb-objs)
	$(LD) -r -o $@ $^

