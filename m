Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbRABVtL>; Tue, 2 Jan 2001 16:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129692AbRABVtB>; Tue, 2 Jan 2001 16:49:01 -0500
Received: from miranda.org ([209.58.150.153]:25867 "HELO miranda.org")
	by vger.kernel.org with SMTP id <S129538AbRABVsn>;
	Tue, 2 Jan 2001 16:48:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14930.17815.720457.433064@light.alephnull.com>
Date: Tue, 2 Jan 2001 16:18:15 -0500 (EST)
From: Rik Faith <faith@valinux.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.sourceforge.net>
Subject: Re: Happy new year^H^H^H^Hkernel.. 
In-Reply-To: [Keith Owens <kaos@ocs.com.au>] Tue  2 Jan 2001 08:32:45 +1100
In-Reply-To: <Pine.LNX.4.10.10101010938590.2892-100000@penguin.transmeta.com>
	<9103.978384765@ocs3.ocs-net>
X-Mailer: VM 6.72; XEmacs 21.1; Linux 2.4.0-test12 (light)
X-Pgp-Key: FB4753BD; 26 A0 3C 88 57 FA 19 D2  90 B3 60 60 97 C0 20 47
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue  2 Jan 2001 08:32:45 +1100,
   Keith Owens <kaos@ocs.com.au> wrote:
> On Mon, 1 Jan 2001 09:39:38 -0800 (PST), 
> Linus Torvalds <torvalds@transmeta.com> wrote:
> >On 1 Jan 2001, Adam Sampson wrote:
> >> 
> >> It appears to work (even with the reiserfs patch with the obvious
> >> Makefile tweak), but the drm modules have unresolved symbols:
> >
> >Does this fix it for you (do a "make clean" before re-building your tree)?
> >
> >		Linus
> >
> >----
> >--- v2.4.0-prerelease/linux/drivers/char/drm/Makefile	Mon Jan  1 09:38:35 2001
> >+++ linux/drivers/char/drm/Makefile	Mon Jan  1 09:38:04 2001
> >@@ -44,22 +44,22 @@
> > mga-objs   := mga_drv.o   mga_dma.o     mga_context.o  mga_bufs.o  mga_state.o
> > i810-objs  := i810_drv.o  i810_dma.o    i810_context.o i810_bufs.o
> > 
> >-obj-$(CONFIG_DRM_GAMMA) += gamma.o
> >-obj-$(CONFIG_DRM_TDFX)  += tdfx.o
> >-obj-$(CONFIG_DRM_R128)  += r128.o
> >-obj-$(CONFIG_DRM_FFB)   += ffb.o
> >-obj-$(CONFIG_DRM_MGA)   += mga.o
> >-obj-$(CONFIG_DRM_I810)  += i810.o
> >-
> >-
> > # When linking into the kernel, link the library just once. 
> > # If making modules, we include the library into each module
> > 
> > ifdef MAKING_MODULES
> >   lib = drmlib.a
> > else
> >-  obj-y += drmlib.a
> >+  extra-obj = drmlib.a  
> > endif
> >+
> >+obj-$(CONFIG_DRM_GAMMA) += gamma.o $(extra-obj)
> >+obj-$(CONFIG_DRM_TDFX)  += tdfx.o $(extra-obj)
> >+obj-$(CONFIG_DRM_R128)  += r128.o $(extra-obj)
> >+obj-$(CONFIG_DRM_FFB)   += ffb.o $(extra-obj)
> >+obj-$(CONFIG_DRM_MGA)   += mga.o $(extra-obj)
> >+obj-$(CONFIG_DRM_I810)  += i810.o $(extra-obj)
> >+
> > 
> > include $(TOPDIR)/Rules.make
> 
> That will break for anybody compiling a DRM card into the kernel and
> compiling a second DRM card as a module.  drmlib.a will get a split
> personality, it will be compiled twice, once for kernel and once for
> module, which version actually gets linked will depend on the phase of
> the moon.  Either that or it only gets compiled for kernel, which is
> where we came in.
> 
> DRM maintainers: can we remove this restriction on needing multiple
> copies of the library?  It makes no sense anyway.  If you build a new
> library with the same function names then you cannot have two DRM cards
> built into the kernel, the function names will collide within vmlinux.
> So you have to use different function names for a new library, but then the
> old cards can share the old library and the new cards can share the new
> library, i.e. there is no need for each driver to have its own copy of
> the library.
> 
> I strongly recommend that you remove the restriction on having multiple
> copies of the library.  Then Adam J. Richter's patch does the job
> nicely, making drmlib.a a helper module.

We plan to remove the need to have multiple copies of drmlib.a and make
the kernel Makefile fully compatible with the 2.4 make system -- but we
haven't finished this work yet.  With this new work, however, the
end-user will still load a single module (e.g., tdfx.o), just like now.
(Loading a single kernel module is a significant win when dealing with
end users: there is no possibility of version skew or of having two
modules that were compiled with different options.)

Linus -- Please use your patch or Keith Owens' patch as a bandaid to
solve this problem until we can do it the right way.  Whatever patch you
select, please do *NOT* make drmlib into a separate helper module --
this will only lead to user confusion (especially since we'll move back
to a single-module solution soon).  From the user's standpoint, I'm not
concerned that you can't mix modules with in-kernel versions, since most
users don't do that [and we could fix the configuration file to prevent
this -- that's another way to bandage this problem that I'll send you a
patch for tomorrow].  I am very concerned that users will see us move
from 1 DRM module to 2 and then back to 1 -- that would be very
confusing for them.

--Rik
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
