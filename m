Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130151AbRAAWDg>; Mon, 1 Jan 2001 17:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbRAAWD0>; Mon, 1 Jan 2001 17:03:26 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:2568 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130151AbRAAWDR>;
	Mon, 1 Jan 2001 17:03:17 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, faith@vmlinux.com,
        dri-devel@lists.sourceforge.net
Subject: Re: Happy new year^H^H^H^Hkernel.. 
In-Reply-To: Your message of "Mon, 01 Jan 2001 09:39:38 -0800."
             <Pine.LNX.4.10.10101010938590.2892-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Jan 2001 08:32:45 +1100
Message-ID: <9103.978384765@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2001 09:39:38 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>On 1 Jan 2001, Adam Sampson wrote:
>> 
>> It appears to work (even with the reiserfs patch with the obvious
>> Makefile tweak), but the drm modules have unresolved symbols:
>
>Does this fix it for you (do a "make clean" before re-building your tree)?
>
>		Linus
>
>----
>--- v2.4.0-prerelease/linux/drivers/char/drm/Makefile	Mon Jan  1 09:38:35 2001
>+++ linux/drivers/char/drm/Makefile	Mon Jan  1 09:38:04 2001
>@@ -44,22 +44,22 @@
> mga-objs   := mga_drv.o   mga_dma.o     mga_context.o  mga_bufs.o  mga_state.o
> i810-objs  := i810_drv.o  i810_dma.o    i810_context.o i810_bufs.o
> 
>-obj-$(CONFIG_DRM_GAMMA) += gamma.o
>-obj-$(CONFIG_DRM_TDFX)  += tdfx.o
>-obj-$(CONFIG_DRM_R128)  += r128.o
>-obj-$(CONFIG_DRM_FFB)   += ffb.o
>-obj-$(CONFIG_DRM_MGA)   += mga.o
>-obj-$(CONFIG_DRM_I810)  += i810.o
>-
>-
> # When linking into the kernel, link the library just once. 
> # If making modules, we include the library into each module
> 
> ifdef MAKING_MODULES
>   lib = drmlib.a
> else
>-  obj-y += drmlib.a
>+  extra-obj = drmlib.a  
> endif
>+
>+obj-$(CONFIG_DRM_GAMMA) += gamma.o $(extra-obj)
>+obj-$(CONFIG_DRM_TDFX)  += tdfx.o $(extra-obj)
>+obj-$(CONFIG_DRM_R128)  += r128.o $(extra-obj)
>+obj-$(CONFIG_DRM_FFB)   += ffb.o $(extra-obj)
>+obj-$(CONFIG_DRM_MGA)   += mga.o $(extra-obj)
>+obj-$(CONFIG_DRM_I810)  += i810.o $(extra-obj)
>+
> 
> include $(TOPDIR)/Rules.make

That will break for anybody compiling a DRM card into the kernel and
compiling a second DRM card as a module.  drmlib.a will get a split
personality, it will be compiled twice, once for kernel and once for
module, which version actually gets linked will depend on the phase of
the moon.  Either that or it only gets compiled for kernel, which is
where we came in.

DRM maintainers: can we remove this restriction on needing multiple
copies of the library?  It makes no sense anyway.  If you build a new
library with the same function names then you cannot have two DRM cards
built into the kernel, the function names will collide within vmlinux.
So you have to use different function names for a new library, but then the
old cards can share the old library and the new cards can share the new
library, i.e. there is no need for each driver to have its own copy of
the library.

I strongly recommend that you remove the restriction on having multiple
copies of the library.  Then Adam J. Richter's patch does the job
nicely, making drmlib.a a helper module.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
